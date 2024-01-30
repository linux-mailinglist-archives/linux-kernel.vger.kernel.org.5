Return-Path: <linux-kernel+bounces-44542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7828384237A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343E0286870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7D6A33F;
	Tue, 30 Jan 2024 11:42:16 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E106A33E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614936; cv=none; b=ODell1fWFydfDlTAk3yr6V9eGgQ3L1d+CapGcBkBgxehMow+FnZG2CTY6S+j/IB0I7ztpXcHhSNRkpzQqCtTCLA6JWdRnTKws1f/HqbORDDhI7jqyuhThe6D52yU3d80xPC0oyirYA/X2YgHbVsHjP1/Bo9FgkCRbgjOmxTAIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614936; c=relaxed/simple;
	bh=8qU0iX9D8Zy7IhYc/n8KPsV00+xSO+pY4a4P4V6tl+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEKzf6vhnR3fVu7hb/1eLHjsB6DwvNqE0h56zaRXTgStA0ixDARN4zkpz+f0ojWGWtTPkTKICv7iKxo0sj9mE9mUfNJmuILx7MMIErFQ7PINRzGVJq/BYFuEefODl3+bHO9ei/YZ1W9CGmdgzNP9cQ8Z8s4x20zAifvQ4Declgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.30])
	by sina.com (10.75.12.45) with ESMTP
	id 65B8E08D00004450; Tue, 30 Jan 2024 19:42:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34480631457639
X-SMAIL-UIID: 36C34DA8129B490F8DE40C2ED4099720-20240130-194208-1
From: Hillf Danton <hdanton@sina.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in percpu_up_write
Date: Tue, 30 Jan 2024 19:41:56 +0800
Message-Id: <20240130114156.1442-1-hdanton@sina.com>
In-Reply-To: <xm26o7d33mij.fsf@google.com>
References: <xm26zfwx7z5p.fsf@google.com> <20240123150541.1508-1-hdanton@sina.com> <20240125110456.783-1-hdanton@sina.com> <20240126122230.838-1-hdanton@sina.com> <20240127112039.896-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 12:36:20 -0800 Benjamin Segall <bsegall@google.com>
> 
> The basic locking issue was due to userspace rapidly spawning threads
> (or processes) more rapidly than the cpus they are running on can
> support, and this causing issues for unrelated threads doing cgroup
> operations on other cpus.
> 
> The contention can be due to a combination of just straight up spawning
> way too many, userspace misconfiguration of cpus allowed, or load
> balancer weaknesses. (If you pick minimum cpu.shares values and have
> large machines, SCHED_LOAD_RESOLUTION isn't really enough for load
> balance to do a good job, and what you're telling the load balancer you
> want isn't really a good idea in the first place).

Sigh, add change to percpu-rwsem's handoff because cgroup has a cough
in chest.

