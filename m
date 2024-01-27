Return-Path: <linux-kernel+bounces-41172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9383ECDB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01714B230EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91F2031A;
	Sat, 27 Jan 2024 11:21:07 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A738831
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354466; cv=none; b=kUM1agnM/XQdrgcEp8gXqKbVnlnNv0jogL7jSZJAuVbGIMBQb36eR4js3XVUGCr0JxJHCuhhSioXehTr0dpbhM5PtKIrIFSodKrhV/xzAF9r3itilxgp1Mu1LT0+V7i2fGMxMp27oDYjy9RS2qDTGKSfWaw+GxH8beE8Wnitwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354466; c=relaxed/simple;
	bh=VWpQwLJccPYV5arsYWk3dcdPk77FtcCamRJXu4bd2DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6aCyAFvKubJrej3dSnUfktuuLAWUVBnNNcaZGcMI2UmyLVzpPf0aEdvQt81HfwquWQuTrKjk8nkZk0iLhYhmLZXSCU2DpeFM3AXdC0J4PgX3ePN9rWP0ykAfbAOsfuXmhUkOyd60hjFMrB5fT+oYO6Q4B8BIOSV1jFFygPluzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.6])
	by sina.com (172.16.235.24) with ESMTP
	id 65B4E70D0000177C; Sat, 27 Jan 2024 19:20:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 91458845089280
X-SMAIL-UIID: 8F1261EC481142AA8AC7E56975D96DA0-20240127-192048-1
From: Hillf Danton <hdanton@sina.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in percpu_up_write
Date: Sat, 27 Jan 2024 19:20:39 +0800
Message-Id: <20240127112039.896-1-hdanton@sina.com>
In-Reply-To: <xm26sf2j3k1g.fsf@google.com>
References: <xm26zfwx7z5p.fsf@google.com> <20240123150541.1508-1-hdanton@sina.com> <20240125110456.783-1-hdanton@sina.com> <20240126122230.838-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 12:40:43 -0800 Benjamin Segall <bsegall@google.com>
> 
> I'm fine with "no, fairness is more important than these performance
> numbers or mitigating already-sorta-broken situations", but it's not

Fine too because your patch is never able to escape standing ovation.

And feel free to specify the broken situations you saw.

> clear to me you've even understood the patch, because you keep only
> talking about completely different forms of starvation, and suggesting

Given woken writer in your reply and sem->ww is write waiters, there is
only one starvation in this thread.

  |> >> My patch makes the entire #4 available to writers (or new readers), so
  |> >> that the woken writer will instead get to run immediately. This is

> changes that would if anything make the situation worse.

I mitigate the starvation by making use of the known method without
any heuristic added, though, I am happy to see why it no longer works.

