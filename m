Return-Path: <linux-kernel+bounces-159149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B38B29FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E5B21D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA824152520;
	Thu, 25 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VChaDI06"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF302E642;
	Thu, 25 Apr 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077429; cv=none; b=hFNwmy0DiRmLNvFfAdSY8mn/J89SqYzw5+oVsBtXgIm8e2mJ3HyxPomlOjWKobNM5XLzVSnTrWxNYipivquWuToXvQUPAuVxZOyKqifel0QI75rLIO7N9CBuqioL/7XZpUhX5lk4zAk/J1BbsC8cA4h8AglLTi8G2YW7CWRUWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077429; c=relaxed/simple;
	bh=YecKqtJMP7AosvSIo5cED5f6N7cFAUCGgYmIUe+m8Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkyXzHCFIEZ8W8tEmFIeNMHvyzsfTRu0zxYWo/G2P6h8NRs598k2jynQAA/C6++f+fMCDej34ezcAYcCYVgmsJpR0rjVcIvadeW5eAcJzSS6yXlQ/tET8HXMRT/9eQsaRrOtKs1p9TXQKPTNfuUM8Buu3ncczgQaB7qKPXXx3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VChaDI06; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57225322312so1961286a12.1;
        Thu, 25 Apr 2024 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077425; x=1714682225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFmqcwlTZuq4ElwxSpZYnR7QPvNFvmkxhCtFp8RZA+E=;
        b=VChaDI065Dy53ZptZD/Ov9k4ilB55zHbJApIlVXhIFJ9sEC73o4GXLzyZ1QNqfC48y
         t8nqapdUFiGbgAq+fBRBT8+uX26GtEV440tIQc7oOacR+Q8kagOc48hgMtEzoCwJBMvM
         qGcWeLP/7KpuhcniujJUshAtU4gPVp8lUyFWDJwtQYlCTCPBC1sF0zoB+07T54M6slvK
         6BvgS4tDq6+ivadtNeRfgqhou8Zhd7nX1ZX0ON3HCOwUc/BMWLPGIlH5psFr8AdrSYr6
         gbquYJFR5IaWSwKKi3N0ldIzzdvUI1KEb5clQggriG1OukeoVpAiPtcr4GvbrCCsmQ4j
         UZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077425; x=1714682225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFmqcwlTZuq4ElwxSpZYnR7QPvNFvmkxhCtFp8RZA+E=;
        b=MlK6n5RDc+ZbU6v97dPERQyyQUxYu1pdOzGp88V25NaYRsm3xaHvRzgGTKaPqqf8LK
         LP2bAo0h4KWQ++IV1roZxC1oVGM4ja2d4mold12Olfi0ncXqC6AncOnNZVnTtmqn6Sae
         waelTJhqQa7RfPw9Pgd9lIHshs7kbm25COhg3E5XofQD6dGCT5V/nmffQ+hV9MuWO0hj
         K2XJ5xyIjhnbAPkodgPWkEq0Nrhrku4oGtmSjtqzDeIJoQqJCHxiRxzOo79svs9UKYST
         2QwdeA+5nYk6PS7prmv3isK4Oc5NFZtiuumvpEQV2dn4gRpf2ej84YVQYADbFLCxhdJz
         jD7A==
X-Forwarded-Encrypted: i=1; AJvYcCXYvjaTVgXtFy0yU4ltvG2kvThdJeGplxBLftmXqlgoksK2VRKWTOUfiiFz9YHPyQg5r8h5jGDMqvBedlGyQqB5E7oI1YEI8k22DOkT
X-Gm-Message-State: AOJu0Yz6XLQSNfD9h9xHPxW9nqMFFTEwg3uGAZ6kx91078cIwACyfW1E
	yIozwGBYrsV8H6JHOBJqNZa7YYljM720VuLhHCXQ+22ul828hUit
X-Google-Smtp-Source: AGHT+IEbwTwGqG+o3+CgwDbuEZbFLCNj3Jyc6qEkgJXE1JSzZhib8WEmAqzvelyWYh3J1gtaqIW58A==
X-Received: by 2002:a50:f68c:0:b0:56e:246b:2896 with SMTP id d12-20020a50f68c000000b0056e246b2896mr430750edn.3.1714077425462;
        Thu, 25 Apr 2024 13:37:05 -0700 (PDT)
Received: from shift.daheim (p200300d5ff33c50050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff33:c500:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7dd4c000000b005704419f56csm9297161edw.86.2024.04.25.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:37:05 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1s05q4-000000005kO-2y5X;
	Thu, 25 Apr 2024 22:37:04 +0200
Message-ID: <ccbdc170-149d-442c-8167-2b05c8cf93b2@gmail.com>
Date: Thu, 25 Apr 2024 22:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: carl9170: add a proper sanity check for
 endpoints
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, lvc-project@linuxtesting.org,
 syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
References: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 8:33 PM, Nikita Zhandarovich wrote:
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
> This patch has not been tested on real hardware.

Oh, I've tested the original patch on real hardware ;). You can remove that line.

USB: 0846:9010 NetGear, Inc. WNDA3100v1 802.11abgn [Atheros AR9170+AR9104]
USB: 0CF3:1002 Atheros Communications, Inc. TP-Link TL-WN821N v2 / TL-WN822N v1 802.11n [Atheros AR9170]

With both high- and full-speed configuration on two different hcds.
In both cases the driver works the same as before and the interface comes up.

I can retest this patch tomorrow/saturday in case you want to wait around.

But I don't "see" how this can go wrong.

Acked-By: Christian Lamparter <chunkeey@gmail.com>

I assume the "Reported-and-tested" means that syzbot has verified that with
this patch, it can no longer get the USB-core to throw a warning, right?
<https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d> says under
"Last patch testing requests) that it tested on the 2024/04/17 and the result
was "error OK"? )

Cheers,
Christian

> 
> [1] Syzkaller report:
> ...
> WARNING: CPU: 0 PID: 4721 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> ...
> Call Trace:
>   <TASK>
>   carl9170_usb_send_rx_irq_urb+0x273/0x340 drivers/net/wireless/ath/carl9170/usb.c:504
>   carl9170_usb_init_device drivers/net/wireless/ath/carl9170/usb.c:939 [inline]
>   carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
>   carl9170_usb_firmware_step2+0x175/0x240 drivers/net/wireless/ath/carl9170/usb.c:1028
>   request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
>   process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>   worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>   kthread+0x2e8/0x3a0 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>   </TASK>
> 
> [2] Related syzkaller crashes:
> Link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
> Link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
> 
> Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v2: as Christian Lamparter <chunkeey@gmail.com> was kind to point out,
> before returning with error, make sure to free previously allocated
> 'ar' with carl9170_free(ar).
> 
>   drivers/net/wireless/ath/carl9170/usb.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index c4edf8355941..a3e03580cd9f 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -1069,6 +1069,38 @@ static int carl9170_usb_probe(struct usb_interface *intf,
>   			ar->usb_ep_cmd_is_bulk = true;
>   	}
>   
> +	/* Verify that all expected endpoints are present */
> +	if (ar->usb_ep_cmd_is_bulk) {
> +		u8 bulk_ep_addr[] = {
> +			AR9170_USB_EP_RX | USB_DIR_IN,
> +			AR9170_USB_EP_TX | USB_DIR_OUT,
> +			AR9170_USB_EP_CMD | USB_DIR_OUT,
> +			0};
> +		u8 int_ep_addr[] = {
> +			AR9170_USB_EP_IRQ | USB_DIR_IN,
> +			0};
> +		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +		    !usb_check_int_endpoints(intf, int_ep_addr))
> +			err = -ENODEV;
> +	} else {
> +		u8 bulk_ep_addr[] = {
> +			AR9170_USB_EP_RX | USB_DIR_IN,
> +			AR9170_USB_EP_TX | USB_DIR_OUT,
> +			0};
> +		u8 int_ep_addr[] = {
> +			AR9170_USB_EP_IRQ | USB_DIR_IN,
> +			AR9170_USB_EP_CMD | USB_DIR_OUT,
> +			0};
> +		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +		    !usb_check_int_endpoints(intf, int_ep_addr))
> +			err = -ENODEV;
> +	}
> +
> +	if (err) {
> +		carl9170_free(ar);
> +		return err;
> +	}
> +
>   	usb_set_intfdata(intf, ar);
>   	SET_IEEE80211_DEV(ar->hw, &intf->dev);
>   


