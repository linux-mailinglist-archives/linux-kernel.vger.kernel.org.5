Return-Path: <linux-kernel+bounces-52529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6684994F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C61C228DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE910199A2;
	Mon,  5 Feb 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSfpQl+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35B18EB9;
	Mon,  5 Feb 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134266; cv=none; b=XmoiF/B7phj5A6M6NM0U0v/2Sbf8NKkz6wSxbGI2JtF8hjKDHs/fqX1t0VEmF+GZr8ruUJgb0kdiYN7Hyj/lRl94ydlMD8xkioOPIsoA+0C/mwvpFpFyai3B4Q8pAJP6qrYB9k+nukOmzkXpGqrbB/SCEGP2fyHp+MUB1Wlm3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134266; c=relaxed/simple;
	bh=GVqGwsZ3oAzNGM6DmqmUlOaiQdppIpSmPlxDVDHqgzY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=dmA3juokE2H4NXgaMdosk241TtcDPZZNpsQ6uotZeYFzspXOnzfvWqiGOgBs1SCKXo3uoEopF3M1FPGayZPXsgG9MvQtaN1ebyuqNevYfV7FNSN891QOOPneBp0SSCqUIDqRZoMkVVjCGk5BY41+4AyLnlDUdJOaAgiFJ+btYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSfpQl+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0669CC433C7;
	Mon,  5 Feb 2024 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134265;
	bh=GVqGwsZ3oAzNGM6DmqmUlOaiQdppIpSmPlxDVDHqgzY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=qSfpQl+VMN9Sym0+Rh/3jeZVEaw7L1pOoKN5Deqz6QmNqS0tdC8OeFEu8f+EQpUpB
	 lL/5KZSiyL8qZkLaQqWLYs6WSosqRS894q2NXDXit7zPo9VK5DorSXDFJ12rSTD1Nc
	 hm7lio8CA9KZPNWgJYDSWY/jHmNGQHL+XvkLNuhQ6aBk1eVitcR59NTplECGqn0Nma
	 WlJ7wQcUt76nNKRLY8RMzCEVQOKG9olavtCaGIBcCP8fpM05nQQt/U2r4rX/kIJqHb
	 3UsgLpr9xnTDplkyigfQ8kPz6Sti78R9Hdt7QozPbypHNLDW8bVdhi0DuE8bJeH2dz
	 XDey3pWDv0dmQ==
References: <87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64>
 <Zb_-LQLY7eRuakfe@slm.duckdns.org>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Subject: Re: [PATCH wq/for-6.9] workqueue: Fix pwq->nr_in_flight corruption
 in try_to_grab_pending()
Date: Mon, 05 Feb 2024 17:25:38 +0530
In-reply-to: <Zb_-LQLY7eRuakfe@slm.duckdns.org>
Message-ID: <877cjji0ne.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 04, 2024 at 11:14:21 AM -1000, Tejun Heo wrote:
> dd6c3c544126 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work
> item handling") relocated pwq_dec_nr_in_flight() after
> set_work_pool_and_keep_pending(). However, the latter destroys information
> contained in work->data that's needed by pwq_dec_nr_in_flight() including
> the flush color. With flush color destroyed, flush_workqueue() can stall
> easily when mixed with cancel_work*() usages.
>
> This is easily triggered by running xfstests generic/001 test on xfs:
>
>      INFO: task umount:6305 blocked for more than 122 seconds.
>      ...
>      task:umount          state:D stack:13008 pid:6305  tgid:6305  ppid:6301   flags:0x00004000
>      Call Trace:
>       <TASK>
>       __schedule+0x2f6/0xa20
>       schedule+0x36/0xb0
>       schedule_timeout+0x20b/0x280
>       wait_for_completion+0x8a/0x140
>       __flush_workqueue+0x11a/0x3b0
>       xfs_inodegc_flush+0x24/0xf0
>       xfs_unmountfs+0x14/0x180
>       xfs_fs_put_super+0x3d/0x90
>       generic_shutdown_super+0x7c/0x160
>       kill_block_super+0x1b/0x40
>       xfs_kill_sb+0x12/0x30
>       deactivate_locked_super+0x35/0x90
>       deactivate_super+0x42/0x50
>       cleanup_mnt+0x109/0x170
>       __cleanup_mnt+0x12/0x20
>       task_work_run+0x60/0x90
>       syscall_exit_to_user_mode+0x146/0x150
>       do_syscall_64+0x5d/0x110
>       entry_SYSCALL_64_after_hwframe+0x6c/0x74
>
> Fix it by stashing work_data before calling set_work_pool_and_keep_pending()
> and using the stashed value for pwq_dec_nr_in_flight().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Link: http://lkml.kernel.org/r/87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64
> Fixes: dd6c3c544126 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling")
> ---
> Hello, Chandan.
>
> Thanks a lot for the report. I could reproduce the problem and verified that
> this patch fixes the issue. I'm applying this to wq/for-6.9 but would really
> appreciate if you could confirm the fix.

fstests executed without any regressions on a next-20240202 kernel with this
patch applied.

-- 
Chandan

