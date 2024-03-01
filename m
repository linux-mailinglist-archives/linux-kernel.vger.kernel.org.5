Return-Path: <linux-kernel+bounces-88366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F5586E086
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F8D1C22507
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E746E608;
	Fri,  1 Mar 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZWhiarm"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642176995C;
	Fri,  1 Mar 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293031; cv=none; b=lWLoC5uxzI3XgkdccvWk/wpYiQNFhCXBrThgvM70ieQGIzYC5QR1t1F0i3PRaRRoMEkibf/cjQm1mZ6bEBKqxj+4YpS3jp5nAER+at6CAuQOvZWXtujQi7oCExedU2GGBb0IIdDLeoONZ86f5y0aH9apTOz5Ij39fUAf+JzdJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293031; c=relaxed/simple;
	bh=dnB4Q8puAHqKwTObB+0sGbh0GN5aGq6p1SaZ1iGJjHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEzC/lY6cxFIjqH1LlvylReDeDuKIgN1PmwtjezU7vtiFw7W4ChWm8X2ggj+hRBvxdoeQK76rrtZpEzS5cwCJfTy0x63ZKbPUiowxGmlHehqIKLS6DZeHdZrzLsCmLEAXOqRvxEZYIqkOlVC568/7mVq16b+IsKOqYueiSLQXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZWhiarm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d484a58f6so321140366b.3;
        Fri, 01 Mar 2024 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709293028; x=1709897828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cm0fewRk8by9EwZ8NHHrfR7IDUJrVmcr62BhebkMa2c=;
        b=hZWhiarmmJYOdaJjQj3uJ+4C4RLr5KtKsQeC7//IvrcmyTL+3PlTy7vcW5cjmqfP4j
         yCikAwCTTK2Ybnvc+LKmWHPOa6bRpiEn7KaCr5QJwZpgRSQ9Z28Ug4nu3y8ZKwonewVE
         sbfYc1lSdjvQ4FJAE0XnX+AjVL0Pw7vsEwiRNc0rxL0wRvITWr6eQeoU+baSeTlaYYUM
         D0fKkgrH0ekjGJZDWBqgAfKOR4rpz8+I92UOJWlnxEN2xtX6mQrf63/l3sAqLH3r8M/W
         xW0OGY9Kaqzt7PayKc1W4asheo5Us5C1IYZ+xbFYBLPeaLzm6seLVtAgkxMWe699xq6v
         yuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293028; x=1709897828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm0fewRk8by9EwZ8NHHrfR7IDUJrVmcr62BhebkMa2c=;
        b=ZkVyQD3fO8+SiKNzlEMz+4dnc97+Kh+dbdsw7DJH23dEaxiRp/1kshKJcntNc44AQF
         blsbF+9ubQMiDr+UWpLTvy1ardZtNN7+dKn/gc6hjsqtcJfA1fr/Cm8wtCYWLp9CSfH6
         M2lnjeuCE56En70YTDc5rDd0ZWVZIYkJ8AIo0jm0P2STbFuVYw/7pJk96MOB6Oz5Sau9
         sG1FpOIQs3PyyD3We6e619idBKc65k2wFj7jOMG1HhqWogL241Lkuc+25reCHpCH7KMj
         bfxxRpuMziOWpm0/3ZHsUWpSXQY7U7oyqfM6IcymTzKsWHDrntDtNUWT0wDky+IKxO9d
         qhJw==
X-Forwarded-Encrypted: i=1; AJvYcCWwrBWP0t/6rNv7aqBSQk58NPjWMXsgP/1lnknizRQypr6eoqGArpQMRqptExXzspJ5d8NtNe6+9iRC/uywTbGJcKwvPOEMncwImIKGBDr6zp1Vm2KUQRZuOCxoXxgssbVyWTHOm4uZ
X-Gm-Message-State: AOJu0YyKZIi7F4oLMhkWOGkVAhy/J3YDFpxd+Tn1WxoVE2VzdDmyrdOP
	PfcLtH6JiRTpb0tO16UYHenTCJZGebOPyvzr5vfk3k3jFwqbO/5aabV8Bxg/053bljmXOVtjUtq
	Ro/O7Y796yWqW+sPPrpfJA4HP39dA7tGX5HM=
X-Google-Smtp-Source: AGHT+IGiATYtA051/0Q3ES2HahUhdXn98xDmfb9yfTipekUmPfLe9n/FxToQjsjgzi7WFYSzVbfEQ97TkrFmdVzNoDE=
X-Received: by 2002:a17:906:135b:b0:a44:74f6:a004 with SMTP id
 x27-20020a170906135b00b00a4474f6a004mr1057238ejb.26.1709293027326; Fri, 01
 Mar 2024 03:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
 <000000000000102fe606127a67f6@google.com> <b1e605ea-333f-4ac0-9511-da04f411763e@rowland.harvard.edu>
In-Reply-To: <b1e605ea-333f-4ac0-9511-da04f411763e@rowland.harvard.edu>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Fri, 1 Mar 2024 17:06:56 +0530
Message-ID: <CANc+2y6FAoUR7R_N-3aLB72DBN98gx82vLMAKXRSCtCQ8PoJEQ@mail.gmail.com>
Subject: Re: [PATCH] USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>, bvanassche@acm.org, 
	emilne@redhat.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com, tasos@tasossah.com, 
	usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 01:00, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> The isd200 sub-driver in usb-storage uses the HEADS and SECTORS values
> in the ATA ID information to calculate cylinder and head values when
> creating a CDB for READ or WRITE commands.  The calculation involves
> division and modulus operations, which will cause a crash if either of
> these values is 0.  While this never happens with a genuine device, it
> could happen with a flawed or subversive emulation, as reported by the
> syzbot fuzzer.
>
> Protect against this possibility by refusing to bind to the device if
> either the ATA_ID_HEADS or ATA_ID_SECTORS value in the device's ID
> information is 0.  This requires isd200_Initialization() to return a
> negative error code when initialization fails; currently it always
> returns 0 (even when there is an error).
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-and-tested-by: syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-usb/0000000000003eb868061245ba7f@google.com/
> Fixes: 1da177e4c3f4 ("v2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
>
> ---
>
>  drivers/usb/storage/isd200.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> Index: usb-devel/drivers/usb/storage/isd200.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/storage/isd200.c
> +++ usb-devel/drivers/usb/storage/isd200.c
> @@ -1105,7 +1105,7 @@ static void isd200_dump_driveid(struct u
>  static int isd200_get_inquiry_data( struct us_data *us )
>  {
>         struct isd200_info *info = (struct isd200_info *)us->extra;
> -       int retStatus = ISD200_GOOD;
> +       int retStatus;
>         u16 *id = info->id;
>
>         usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
> @@ -1137,6 +1137,13 @@ static int isd200_get_inquiry_data( stru
>                                 isd200_fix_driveid(id);
>                                 isd200_dump_driveid(us, id);
>
> +                               /* Prevent division by 0 in isd200_scsi_to_ata() */
> +                               if (id[ATA_ID_HEADS] == 0 || id[ATA_ID_SECTORS] == 0) {
> +                                       usb_stor_dbg(us, "   Invalid ATA Identify data\n");
> +                                       retStatus = ISD200_ERROR;
> +                                       goto Done;
> +                               }
> +
>                                 memset(&info->InquiryData, 0, sizeof(info->InquiryData));
>
>                                 /* Standard IDE interface only supports disks */
> @@ -1202,6 +1209,7 @@ static int isd200_get_inquiry_data( stru
>                 }
>         }
>
> + Done:
>         usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retStatus);
>
>         return(retStatus);
> @@ -1481,22 +1489,27 @@ static int isd200_init_info(struct us_da
>
>  static int isd200_Initialization(struct us_data *us)
>  {
> +       int rc = 0;
> +
>         usb_stor_dbg(us, "ISD200 Initialization...\n");
>
>         /* Initialize ISD200 info struct */
>
> -       if (isd200_init_info(us) == ISD200_ERROR) {
> +       if (isd200_init_info(us) < 0) {
>                 usb_stor_dbg(us, "ERROR Initializing ISD200 Info struct\n");
> +               rc = -ENOMEM;
>         } else {
>                 /* Get device specific data */
>
> -               if (isd200_get_inquiry_data(us) != ISD200_GOOD)
> +               if (isd200_get_inquiry_data(us) != ISD200_GOOD) {
>                         usb_stor_dbg(us, "ISD200 Initialization Failure\n");
> -               else
> +                       rc = -EINVAL;
> +               } else {
>                         usb_stor_dbg(us, "ISD200 Initialization complete\n");
> +               }
>         }
>
> -       return 0;
> +       return rc;
>  }
>
>
>

Looks good to me.

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar

