Return-Path: <linux-kernel+bounces-85393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419C86B555
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F019B24432
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C5B3FB85;
	Wed, 28 Feb 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QehyGA8Z"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7376EF0E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139187; cv=none; b=KyngiaUyQMuGumA876bffHNBiA2moNCcKPV31xBHrxiz15iyXrPHLJIzgLhYTUBYXs0TRjDY4V2Di7d0uIfKN7gipYHILUc6icmJPSN4EyXhdbcYvCDD5epAWQw5tx2yu9wR+q+uqjafauzXD3BH7lK5RUVRG1k+U/dJRwmWlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139187; c=relaxed/simple;
	bh=YeysMJrMKJOqZ+ZRJb/n6sEWfzXImIkkf8WwSLVPEyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9530+fbKPCvYK0r45pwUHfHxQFOoWfeMPc+LxguG6kXLZgHZEVZknrgUnTNbh7VuB9SSTOzW1BQiI8Se/4X8h19a4rHR2tAHYhqLJ+X9DRRPcC8zGK+EsgkJ24pQrAnZtgYb25QTeVmrHOQYT3P0WHj8d24GPfl3h6kJeanrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QehyGA8Z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc744f54d0so235105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709139184; x=1709743984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtF5/pdVuibkgPXJcntwpHSGdyt4hc2nkXEyG93pZvI=;
        b=QehyGA8ZTmvzFGxmdp2gHWwZK0DGr+8IgjC50EzLZNNZl7tzyFUwX4jc0WBxfh6HOB
         OO0L+tpdnf8k+5crPabsIEC86d8Uf8HCBLUg11TBKKNEnfrUowCxXeqoLe1M1go027cP
         l5W3ghgfkqeoDkFB3hkKoC2yo79ipCL+BycIl/c6cGE8rApJrEu91MBJ3S24ew1/P+L6
         8aku9MZvD/ZXuzKfa6L6o6ybKjCkEpajaE5rL25FGSR8ITIvawcAwnT7NNyvG8sYXSzW
         gvTJ4QL1boXEuQrgRWZkV33Vl+5zWnE7GKYaFM91q5Nqb/Crq5vXu70QwoxDfdiMvRcc
         54+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139184; x=1709743984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtF5/pdVuibkgPXJcntwpHSGdyt4hc2nkXEyG93pZvI=;
        b=qmAvJW0JUZ3Yb2VApa5OZx4GP3UNUe+5eUBHzlykHc7fPh7nPoc/yNc/IbK0A3cOrv
         7PoTBg/3WCzBoGTQ+VhqwlilS+zYp7KuZmEaBR0ffbni+U+vefFPLFAKJWJb+GQv7dTl
         RK+9ZasGN+dHtpTKwuoJVCYaYaZFlupH4M0Hx18lrJFHDAWFkqA0WOvRfRt0Qp2S3bn8
         xEtP+cgFXpleJ0ihCK1biqozskY/1DRhpewO8E+1VSqgTmxIwVyYHeJHKvLggoE31ZO2
         B+l6UDMAkKTzSuLQPqNJRuMz0yiOxi6OJYuJ580PP1yXWJitW+Cct9cRjST5MDesYrx1
         AZYA==
X-Forwarded-Encrypted: i=1; AJvYcCXsEt9NUiPHoZY5Lr/5eessDVJGGiNFlKXX5oqPRsXwt4INnnk7Ul8MWdwahLotvy9oHIB9uxPAZUOWHtusc7W1srAtG9hScPGZoSBR
X-Gm-Message-State: AOJu0YwDTcMM8UO82gzsbhx2ekFUdIqLcuYnlVBOV/1JwKQOziNorX9J
	GPYy04gQQliXUlrd1CQNUcKtQUX2BI0yftd43kcmS3/WQJFBRqe7vpPIr9kQQLIxsKb9ogKMJJY
	+sy0ZvWL0JBsPpeY+LGAeztseAf8ejWwPuadz
X-Google-Smtp-Source: AGHT+IFtOXSYXU84VVLaknqL+pG680O1sVKAYLkwQ1wwVHSfHbEz51im2N5KPclBVeDBV4X/kh9n+/NWxg+VN9Tdjds=
X-Received: by 2002:a17:903:18a:b0:1db:e5e3:f7ac with SMTP id
 z10-20020a170903018a00b001dbe5e3f7acmr70137plg.7.1709139183758; Wed, 28 Feb
 2024 08:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fe3f46c-4ee5-4597-bf2d-12a5d634a264@rowland.harvard.edu>
 <0000000000008b026406126a4bbe@google.com> <13add23d-af18-4f84-9f1a-043932a9712b@rowland.harvard.edu>
In-Reply-To: <13add23d-af18-4f84-9f1a-043932a9712b@rowland.harvard.edu>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 28 Feb 2024 17:52:50 +0100
Message-ID: <CANp29Y4DUvL5zsnqQmhPGkbc=EN6UjFrWF9EZGE5U_=0C9+1Nw@mail.gmail.com>
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>, 
	bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com, 
	tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Please try it once more with the full commit hash.

--=20
Aleksandr

On Wed, Feb 28, 2024 at 5:12=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Feb 27, 2024 at 09:20:03PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot tried to test the proposed patch but the build/boot failed:
> >
> > failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git/ on commit f2e367d6ad3b: failed to run ["git" "f=
etch" "--force" "--tags" "7b440d1b40dd93ea98b5af6bba55ffca63425216" "f2e367=
d6ad3b"]: exit status 128
> > fatal: couldn't find remote ref f2e367d6ad3b
>
> I'm going to guess this was a temporary failure and try again.  If that
> wasn't the case, something is seriously wrong somewhere.  I had no
> trouble accessing that commit using the git.kernel.org web interface.
>
> Alan Stern
>
> On Mon, Feb 26, 2024 at 01:42:26AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.=
ker..
> > git tree:       upstream
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
git/ f2e367d6ad3b
>
> Index: usb-devel/drivers/usb/storage/isd200.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/storage/isd200.c
> +++ usb-devel/drivers/usb/storage/isd200.c
> @@ -1105,7 +1105,7 @@ static void isd200_dump_driveid(struct u
>  static int isd200_get_inquiry_data( struct us_data *us )
>  {
>         struct isd200_info *info =3D (struct isd200_info *)us->extra;
> -       int retStatus =3D ISD200_GOOD;
> +       int retStatus;
>         u16 *id =3D info->id;
>
>         usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
> @@ -1137,6 +1137,13 @@ static int isd200_get_inquiry_data( stru
>                                 isd200_fix_driveid(id);
>                                 isd200_dump_driveid(us, id);
>
> +                               /* Prevent division by 0 in isd200_scsi_t=
o_ata() */
> +                               if (id[ATA_ID_HEADS] =3D=3D 0 || id[ATA_I=
D_SECTORS] =3D=3D 0) {
> +                                       usb_stor_dbg(us, "   Invalid ATA =
Identify data\n");
> +                                       retStatus =3D ISD200_ERROR;
> +                                       goto Done;
> +                               }
> +
>                                 memset(&info->InquiryData, 0, sizeof(info=
->InquiryData));
>
>                                 /* Standard IDE interface only supports d=
isks */
> @@ -1202,6 +1209,7 @@ static int isd200_get_inquiry_data( stru
>                 }
>         }
>
> + Done:
>         usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retSta=
tus);
>
>         return(retStatus);
> @@ -1481,22 +1489,27 @@ static int isd200_init_info(struct us_da
>
>  static int isd200_Initialization(struct us_data *us)
>  {
> +       int rc =3D 0;
> +
>         usb_stor_dbg(us, "ISD200 Initialization...\n");
>
>         /* Initialize ISD200 info struct */
>
> -       if (isd200_init_info(us) =3D=3D ISD200_ERROR) {
> +       if (isd200_init_info(us) < 0) {
>                 usb_stor_dbg(us, "ERROR Initializing ISD200 Info struct\n=
");
> +               rc =3D -ENOMEM;
>         } else {
>                 /* Get device specific data */
>
> -               if (isd200_get_inquiry_data(us) !=3D ISD200_GOOD)
> +               if (isd200_get_inquiry_data(us) !=3D ISD200_GOOD) {
>                         usb_stor_dbg(us, "ISD200 Initialization Failure\n=
");
> -               else
> +                       rc =3D -EINVAL;
> +               } else {
>                         usb_stor_dbg(us, "ISD200 Initialization complete\=
n");
> +               }
>         }
>
> -       return 0;
> +       return rc;
>  }
>
>
>

