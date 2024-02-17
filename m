Return-Path: <linux-kernel+bounces-70022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB18591DE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E009F1C21C57
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00A7E119;
	Sat, 17 Feb 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1VYDbebE"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EE7CF1E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195927; cv=none; b=LJZC4hB8Zdj3JOiBo/PCXB8K/WrOKeaIaTdQC0PBYkfCsGfPGytb4BSrUcC/z+kK9DXODJ6wmFk4uPQGqFQgBkch8RE10Ih/bGULxik4DwglFw6uc4+1D+eCeKi3J4wLumVJAYVrk6KybJEb6hgABBEmlLZx8XEHV+XbTYgMZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195927; c=relaxed/simple;
	bh=oJedTDb3+/hvVH63BBODR7NGGsOu2PAhc5Hkn+nhfwM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAmiCDz/H0rxcYrsWzsriKHpDnsqdv+1OAzlp/T11VxusZKOGww04MFxemxhfGHSL5vLYemFYfnbcNml9ZjjbQRT2I0CBb5zGEMrTYgDRVUh+fOXmgqOPwC98FVmefsAZFel1GJCJwM6LxGGC2RjH4MaPyx6043GTJufp6IsMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1VYDbebE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso1136407241.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708195924; x=1708800724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeDu5yJY59DOeFlIx12ihHDw/KhDTuHYF4mzkEdHe4I=;
        b=1VYDbebEkpWKPzd1e10u2R7W4peRc/vvzLJzeUFqmjTBe9LKtSXaJSnLWSyKg10pwp
         /kLZrVPcr0IltwTUdzROmlyrPvoPGu1h8lqFa4SnFgKaoBvi5KBPpGsdpKW1IM1XzRLl
         SMgOywlfHsemq5+x/jI9syVh3rNaBFs0lFTOnlHgTOtq/OgWLjZre2Aizdb7kqvz6YOE
         B0aVUcFz9lPueURDHoNWrPyNtYrmB7urVghgXIyffHcQOaUMmuG3/fFr36ihQPKskqiV
         kind0021Z0F1FKKItiAjvHt3NFilafjeLbMaWtRA5uycnLjDTf8S+vnleEyckQtuQGA3
         PSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708195924; x=1708800724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IeDu5yJY59DOeFlIx12ihHDw/KhDTuHYF4mzkEdHe4I=;
        b=IVMgbo+EcqL9G5ghXRKFOIJgZfOxK/0QOdzx1aEh6XrEwgauCI2pp37F/LNvfZcEGa
         rNJ+ZtdA8dhEB5No3Hzd+s/k1s6fHeuT6ftqNWdUyfj5UBPFTFw9rguCb+Gvdu7iGt7h
         kW9arDFNesDfO+Vfd6ZQMSEa4hsN8wNVabDQM0rvNWf5goV3nlqmVgAlf16LrSWrvMDb
         VhrMnzQXIJutFVaPFo0ss3rwcJ7pb2Ny09tVk2DK18oS+HNBRnXEv2pDANTNqMF02sxP
         FDLLZ8UrW0iQpJf6hA5ljfwZrqrM5lS6xk7Mi0+Nm7YYhJXgq4XSDkvRMj4lV5chLmrI
         xmig==
X-Forwarded-Encrypted: i=1; AJvYcCU3Rm0QQOGZfeCD7P/STiKWKXT/bPUphAHkYKg/HD2xTmM3VU5eqgil2CtFrvocQvUm3Zp8O9eS8fY1B9j1CHwIKNjvAwdIY+vtMRg6
X-Gm-Message-State: AOJu0Yz3tj92eZHg2Snr+7hNcmvhYVXwn/AkW56EiVdK6x4aq43kuu8G
	8I2+ZCUdRR7hMD6A/GAj30h7akA9TlsnbV5DaXZA7MC+a4UytG/qMhpFe9bk32Z4Hjpth5pY+H1
	fE8tTvVKBTe5/bTy/DrXddo0WZdX/KweWr96Naw==
X-Google-Smtp-Source: AGHT+IGnTuog3CPcn+WXg/fSUZ9OKy/w79jNxC6wDF7CMdmjRU+GNpXRmpaxn+299tGb/eAH9OFsSW9FIv7UywkmYVU=
X-Received: by 2002:a05:6102:290e:b0:470:4e40:b14 with SMTP id
 cz14-20020a056102290e00b004704e400b14mr265578vsb.8.1708195924498; Sat, 17 Feb
 2024 10:52:04 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Feb 2024 10:52:03 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CAMRc=MdGhfHSWPB0FCHbK+uA0MAZNFstupgm7-Zkw9dbuTmyVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217135255.1128716-1-xiaolei.wang@windriver.com> <CAMRc=MdGhfHSWPB0FCHbK+uA0MAZNFstupgm7-Zkw9dbuTmyVQ@mail.gmail.com>
Date: Sat, 17 Feb 2024 10:52:03 -0800
Message-ID: <CAMRc=Mfb1Vg1qnwE7c95PBroDFySZ6c0b0HgUhyrHFFpCz0Diw@mail.gmail.com>
Subject: Re: [linux-next][PATCH 1/1] gpio: Delete excess allocated label memory
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Feb 2024 19:35:43 +0100, Bartosz Golaszewski <brgl@bgdev.pl> sai=
d:
> On Sat, Feb 17, 2024 at 2:53=E2=80=AFPM Xiaolei Wang <xiaolei.wang@windri=
ver.com> wrote:
>>
>> The changes in commit 1f2bcb8c8ccd ("gpio: protect the
>> descriptor label with SRCU"), desc_set_label has already
>> allocated memory space for the label, so there is no need
>> to allocate it again. otherwise memory leaks will be
>> introduced.
>>
>
> No, we *want* to copy it if it's not in .rodata for the same reason we
> introduced SRCU. This may be a valid report but the fix is wrong.
>
>> unreferenced object 0xffff0000c3e4d0c0 (size 32):
>>   comm "kworker/u16:4", pid 60, jiffies 4294894555
>>   hex dump (first 32 bytes):
>>     72 65 67 75 6c 61 74 6f 72 2d 63 61 6e 32 2d 73  regulator-can2-s
>>     74 62 79 00 00 00 ff ff ff ff ff ff eb db ff ff  tby.............
>>   backtrace (crc 2c3a0350):
>>     [<00000000e93c5cf4>] kmemleak_alloc+0x34/0x40
>>     [<0000000097a2657f>] __kmalloc_node_track_caller+0x2c4/0x524
>>     [<000000000dd1c057>] kstrdup+0x4c/0x98
>>     [<00000000b513a96a>] kstrdup_const+0x34/0x40
>>     [<000000008a7f0feb>] gpiod_request_commit+0xdc/0x358
>>     [<00000000fc71ad64>] gpiod_request+0xd8/0x204
>>     [<00000000fa24b091>] gpiod_find_and_request+0x170/0x780
>>     [<0000000086ecf92d>] gpiod_get_index+0x70/0xe0
>>     [<000000004aef97f9>] gpiod_get_optional+0x18/0x30
>>     [<00000000312f1b25>] reg_fixed_voltage_probe+0x58c/0xad8
>>     [<00000000e6f47635>] platform_probe+0xc4/0x198
>>     [<00000000cf78fbdb>] really_probe+0x204/0x5a8
>>     [<00000000e28d05ec>] __driver_probe_device+0x158/0x2c4
>>     [<00000000e4fe452b>] driver_probe_device+0x60/0x18c
>>     [<00000000479fcf5d>] __device_attach_driver+0x168/0x208
>>     [<000000007d389f38>] bus_for_each_drv+0x104/0x190
>>
>
> Can you post the full kmemleak report for this, please?
>
> Bart
>

Ah, I think I see the problem. Can you test the following diff:

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 02be0ba1a402..0fdd4ad242bd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -695,10 +695,15 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev =3D to_gpio_device(dev);
+	struct gpio_desc *desc;
 	unsigned int i;

-	for (i =3D 0; i < gdev->ngpio; i++)
-		cleanup_srcu_struct(&gdev->descs[i].srcu);
+	for (i =3D 0; i < gdev->ngpio; i++) {
+		desc =3D &gdev->descs[i];
+
+		kfree_const(desc->label);
+		cleanup_srcu_struct(&desc->srcu);
+	}

 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);

and let me know if it fixes the issue?

Bart

>> Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>  drivers/gpio/gpiolib.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 02be0ba1a402..32191547dece 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc =
*desc, const char *label)
>>         if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
>>                 return -EBUSY;
>>
>> -       if (label) {
>> -               label =3D kstrdup_const(label, GFP_KERNEL);
>> -               if (!label)
>> -                       return -ENOMEM;
>> -       }
>> -
>>         /* NOTE:  gpio_request() can be called in early boot,
>>          * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
>>          */
>> --
>> 2.25.1
>>
>

