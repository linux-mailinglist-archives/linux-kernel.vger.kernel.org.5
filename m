Return-Path: <linux-kernel+bounces-162723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18D8B5FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D5D1F2479D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9FC8663A;
	Mon, 29 Apr 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZY2kFOf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76986260;
	Mon, 29 Apr 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410423; cv=none; b=hPIZ0eYYlqWDF6KZ8ZEY9ui/IY2zX9l1DMbwu0B41q+c29cd1jvgikjPgFZcHGqllTFvLNadw29vOpY49JR5rZLbOExE7eCaX2m7/4JwzXBOZXYfpKzS3a7kpD7xgxW1EANFpdLJjqVkcYqO6E8SjQtWFMCFMOCGKJNzSAMc0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410423; c=relaxed/simple;
	bh=EIzrA7raKowYk/Gh9aT2i443/RBNMTyOgVQ4r1yOGGY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=XpivBR7k76JSmYpLt2hvklnFphxDtbP1Qk1O/6vrXC02y8Tz6eQy1gwvaXOas5VP4+KbUS4X+xjJpYByeRPHIH1InVlWzpgxAR8eGAynAZeB18QQAhAwDJOruzRpjBviQ22AdOqRVeYbRbVCSuK9xiAs9MNa5CP8DU0MPgGr0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZY2kFOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF84C113CD;
	Mon, 29 Apr 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410422;
	bh=EIzrA7raKowYk/Gh9aT2i443/RBNMTyOgVQ4r1yOGGY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FZY2kFOfhjpqCaYkpX4F3j3DWpENVTxwpF2fweIEBEGdECKV+SwgweTbII6b57mlq
	 zmbZbgiTbB6eHq0sslxTBxjVgwhN3+E937qzytwB/vv7FQbIwo81CjcjjNp867sEJ4
	 ltIA7dtbDTw2tBnuyuXBFPvmg3oU7xU8hyJTiKVoo5FmfIbPK1LV9PjlAbkLzUVZ//
	 ChMNv3U+cx1YMbAqDwIGFvVFsae0sqNmgT9IqKf5NutWum7FPHW1ilSpWw48uzIM8o
	 lkIQnE14lp0KnKtbpl3qfdTcPEk1vWuIO2jPoEos9qQ4Wg8QTpukBnXramsi80UbGD
	 OMbBRvY26A6tQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: carl9170: add a proper sanity check for
 endpoints
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
References: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzkaller-bugs@googlegroups.com>, <lvc-project@linuxtesting.org>,
 <syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171441041857.3988917.8424866883496462665.kvalo@kernel.org>
Date: Mon, 29 Apr 2024 17:07:00 +0000 (UTC)

Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:

> Syzkaller reports [1] hitting a warning which is caused by presence
> of a wrong endpoint type at the URB sumbitting stage. While there
> was a check for a specific 4th endpoint, since it can switch types
> between bulk and interrupt, other endpoints are trusted implicitly.
> Similar warning is triggered in a couple of other syzbot issues [2].
> 
> Fix the issue by doing a comprehensive check of all endpoints
> taking into account difference between high- and full-speed
> configuration.
> 
> [1] Syzkaller report:
> ...
> WARNING: CPU: 0 PID: 4721 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> ...
> Call Trace:
>  <TASK>
>  carl9170_usb_send_rx_irq_urb+0x273/0x340 drivers/net/wireless/ath/carl9170/usb.c:504
>  carl9170_usb_init_device drivers/net/wireless/ath/carl9170/usb.c:939 [inline]
>  carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
>  carl9170_usb_firmware_step2+0x175/0x240 drivers/net/wireless/ath/carl9170/usb.c:1028
>  request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> 
> [2] Related syzkaller crashes:
> Link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
> Link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
> 
> Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> Acked-By: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b6dd09b3dac8 wifi: carl9170: add a proper sanity check for endpoints

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240422183355.3785-1-n.zhandarovich@fintech.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


