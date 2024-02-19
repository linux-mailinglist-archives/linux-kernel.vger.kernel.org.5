Return-Path: <linux-kernel+bounces-71257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A838A85A290
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D511F214FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865A2CCD6;
	Mon, 19 Feb 2024 11:56:01 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223A22F00
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343760; cv=none; b=MZrCcxweVZ9M1Ivjlpv67DhJ5BNO6zqK94+m1GvR9yP3L1qP4/I4ycr7fM0txaXr5245xTvgYh9AYGtdWSTT+c2TGHuv84qbJIKsbhAmu+4QYkE/nweCIviF58Q4472sT8eCotMEZbtsEXug0fZ2eAenbsGxYzWNRDl40f1SHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343760; c=relaxed/simple;
	bh=y0UIklNnKZM5nijJtKykqYX+P5z9/aUxva0HnXWRgDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vibpy5ldbmN4HRrwQ6CJKfynxxVFRBfdH0MyO5DFTEN504GbcEVSYF70ShG1v8Cs3DMexovymhaIsJ/QhI3u4CP1+eEYbsRgBKIZC62VOMBvuMVyB7dMHs8GZ898McvuQe92JqhCQZnfGif0ONOrhnuRsRxls/+6g3hACKyr30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.82])
	by sina.com (172.16.235.24) with ESMTP
	id 65D3407F00006019; Mon, 19 Feb 2024 19:50:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 95218145089571
X-SMAIL-UIID: 22E409DE58DC4221B8DB985F39DC424D-20240219-195028-1
From: Hillf Danton <hdanton@sina.com>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in select_idle_cpu()
Date: Mon, 19 Feb 2024 19:50:14 +0800
Message-Id: <20240219115014.1333-1-hdanton@sina.com>
In-Reply-To: <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Nov 2023 15:40:14 +0800 Chen Yu <yu.c.chen@intel.com>
> Problem statement:
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Proposal:
> Introduce the SIS_CACHE. It considers the sleep time of the task for
> better task placement. Based on the task's short sleeping history,
> tag p's previous CPU as cache-hot. Later when p is woken up, it can
> choose its previous CPU in select_idle_sibling(). When other task is
> woken up, skip this cache-hot idle CPU when possible.
> 
> SIS_CACHE still prefers to choose an idle CPU during task wakeup,
> the idea is to optimize the idle CPU scan sequence.

Could you specify why the currently selected cpu fails to work in the
scenario described above?

	/*
	 * If the previous CPU is cache affine and idle, don't be stupid:
	 */
	if (prev != target && cpus_share_cache(prev, target) &&
	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
	    asym_fits_cpu(task_util, util_min, util_max, prev))
		return prev;

