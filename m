Return-Path: <linux-kernel+bounces-109786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9E8855AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669AB283153
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4E6997E;
	Thu, 21 Mar 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3PLOttA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87E6994D;
	Thu, 21 Mar 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009763; cv=none; b=Uahta9xDGZDTXOroliyVeFMtxmrlZM1cFE2+FRhNkozGqV1FPy6Nx4+Z/XGtKWDFpv9HJs7wrX92AlO79uDj4eYSYuzID/azHj6RjJLBQzCzQ8FMR/ttGXaYjNWsR2/G2kd/PYC11o9WNoYyvZQsPieS5IVJmmgVZOAyWRuvXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009763; c=relaxed/simple;
	bh=7kCuWcguJfXb+C5s5vznrmpMKt2aumVRMMbZ27GwQRI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Tn6tPdeIMWlzv+iDYBWF7av1ygEI6GnjVUEb/DDZ1I+gFqZb0vmYwNyZlIVWyK7nPA74HlXtnSP84GTeYwbmfYR5MtFUE95k/+hp7RqatF1fnchsZLpBFN/rCR9xQ9a14Ho4q4bUwfWKGpporTaDPcK82ndu4LQW5Jvr/nfFpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3PLOttA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFA4C433C7;
	Thu, 21 Mar 2024 08:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711009762;
	bh=7kCuWcguJfXb+C5s5vznrmpMKt2aumVRMMbZ27GwQRI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=S3PLOttAxQVJs5+U1SxWEPd1adUzlZKsRvspPFtIee7I+PkW7lYi5w01c5dKOfR8K
	 qvGRCZ2YCxx6++ElMesCX5CyH73jUNLxtPE4cKM6a9wo8lzNe1tcRBIbYxoKXdojFh
	 rzGySzbifLgGxwVRBD7BKLGlx+Pu7nln3i78b/welbNKlYgUrQKOln7QJV/aHj/TNw
	 ZtVAjCUxOLAvyXT/5kGJzi/Xys4ZhypuKbrShGMAcbNkruLovn5Auw/TV4+Skul6uF
	 zShoCG2AovfLVmh8Odh0g7HqKFPD92U/d8sBpZ5hcpg41eNmllphYZ4nSfmO0OrINj
	 rT9nl9deErSgA==
From: Kalle Valo <kvalo@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com,
  linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  syzkaller-bugs@googlegroups.com,  toke@toke.dk
Subject: Re: [PATCH usb] wifi: ath9k: fix oob in htc_issue_send
References: <0000000000004e41110614187d35@google.com>
	<tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>
Date: Thu, 21 Mar 2024 10:29:18 +0200
In-Reply-To: <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com> (Edward
	Adam Davis's message of "Thu, 21 Mar 2024 15:31:33 +0800")
Message-ID: <87bk789ee9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> [syzbot reported]
> usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> ath9k_htc 1-1:1.0: ath9k_htc: HTC initialized with 33 credits
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
> index 255 is out of range for type 'htc_endpoint [22]'
> CPU: 1 PID: 2494 Comm: kworker/1:2 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: events request_firmware_work_func
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:347
>  htc_issue_send.constprop.0+0x209/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:26
>  ath9k_wmi_cmd_issue drivers/net/wireless/ath/ath9k/wmi.c:305 [inline]
>  ath9k_wmi_cmd+0x424/0x630 drivers/net/wireless/ath/ath9k/wmi.c:342
>  ath9k_regread+0xdb/0x160 drivers/net/wireless/ath/ath9k/htc_drv_init.c:242
>  ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
>  __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
>  ath9k_hw_init+0xf02/0x2b30 drivers/net/wireless/ath/ath9k/hw.c:700
>  ath9k_init_priv drivers/net/wireless/ath/ath9k/htc_drv_init.c:662 [inline]
>  ath9k_init_device drivers/net/wireless/ath/ath9k/htc_drv_init.c:839 [inline]
>  ath9k_htc_probe_device+0xb37/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:963
>  ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:529
>  ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
>  request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
>  </TASK>
> ---[ end trace ]---
> [Fix]
> If the target does not return a valid end point id during the device connection
> process, returns a failure.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

This should go to ath tree, not usb. No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

