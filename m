Return-Path: <linux-kernel+bounces-96463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366A875C82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DCC1C21492
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FD29403;
	Fri,  8 Mar 2024 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBoRIyuQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD928DD2;
	Fri,  8 Mar 2024 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866102; cv=none; b=W7gaZG78ijY+VrR9Q5lQRhh1FY+gD/JxH4OodDjiApeBegG39ozsMoGEceXOOARF2OSVu4dsa19iW9kHOXXVVNcS+GGy9CTg98ePcfqK67uYRCUUwoJKJbotWnElJ8dlx9M3HBofVwWkmZP9ID1JQKkLxs11mj/6APFwL24v3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866102; c=relaxed/simple;
	bh=GV3x8ph8o43QbnvvSgF1vTygkijVNhb+oyLjHelVE2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjdkA6b4ysPzAkHKP6Yi3dhsoU4PiTKouA01iSJXHBRn4Qf9iOeMjT593XxoGJ8ns+uN5kgMCIxf+qNnJQu+iH0QEgGj7uwtoeG09CJbszd8igVabNhcP/koyCCSFKYJfo9SC5/n0FQXlQ3ZouqNbRKwxrcZqky28rGv8fLXWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBoRIyuQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso390912a12.2;
        Thu, 07 Mar 2024 18:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709866099; x=1710470899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIzaq0N3AupWmJvzVIWB2kN6NWiKpcHdIVgvFMAhPUs=;
        b=YBoRIyuQTqNrI9BELvGlYiyoyjPwu+lH9vhiRpd+Rnk+HAj4oSerOtMPMBV4C8Oexm
         f62vRRJaLRtoe0ShSjjCy8qQ6xKyJKXCkwc6rXMxkpzme5K2mlBLlgsAuPzAG0gn8clY
         wikeDy678Q9Cl559IDhSkkPZwOu95u9nGKr3SaHuDnBlku3TGcrJ2ubiif4gp1ISJ7zk
         HjNmDsUHuqZXJrc6Jnj4S5EijvGoXMNqTLPAYleaYWE7bsR3NAF0Io+XlMVaGAEyqCSd
         lRYvekkXLDBCNNDiKeCOBs3sQ4If+3JsaC+DtH95Ry+PIkUn3eZuFe4lLN987zYYCrNV
         hbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709866099; x=1710470899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIzaq0N3AupWmJvzVIWB2kN6NWiKpcHdIVgvFMAhPUs=;
        b=UC5+qiNEGOwwhT/CKjf32b0+/esTmh/qGqlkpTg40mLmNkmtzTyYNZGud6/21l3UjR
         0T07JubS0qBi8E4fXjnr2h7C4CURNz5CmSSyqPWK7GlrvlbcIKZj0k//kllrevEaZwoX
         blNcBmkYK0v56OMIXN36Syz1oBoSGToluK9VWp9c1AmdGS4cGf771UxG90Tcj+Nzt4GF
         tshSjk9N1rlQxP+PGnYxmYLv1OgDQT3oFC1ViwMujnArWOJrEZsVDuWqf6JNBMqxkALz
         YUsQnA71Iv1YG4NiWoMAuhe13+i65pLe3Pw1ZMR+FORmdDOVOjvsMdwGxaqyG9eE/tiG
         dfkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ueGsBMRhDT43vSFVzpArgYK8/y8m8UXvDLZFnxfELrn3AyGxBpZqtNkATgLAW+2yISkVrIWmslI1w+jdN5u8+gycKdnoZUdN
X-Gm-Message-State: AOJu0Yx/fcammI27rGF7giUkP1O4kLo+ofV+L/PKjdM9FF3vdw6OH9hp
	QTVKmYGzOC/jt0EzqBCF5LUrgkRWsISRYZCHvBtXHnY0luvPf0RuWbcgGgGCU+e/5hX1/fU53sV
	kRkG+A2KVcMZp5VwJGh3IIzjElFE=
X-Google-Smtp-Source: AGHT+IEKbPMz94KnRf5RLU+Q3EagMHxZFycjy6trH9grkccSPQJ2QndWaZHjyRhCdk/S+VBI0TinAhU5LyeRMuToiro=
X-Received: by 2002:a17:906:d0d6:b0:a45:ad59:cbc0 with SMTP id
 bq22-20020a170906d0d600b00a45ad59cbc0mr5968816ejb.13.1709866099124; Thu, 07
 Mar 2024 18:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <0afd0885-1650-47db-b2b3-43b597352e6b@rowland.harvard.edu>
In-Reply-To: <0afd0885-1650-47db-b2b3-43b597352e6b@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 8 Mar 2024 10:48:07 +0800
Message-ID: <CAEkJfYPAvVbN5qzAWZchaF25WehCWU4FEYH8VJBkBadLgY-rFQ@mail.gmail.com>
Subject: Re: [Bug] INFO: task hung in hub_activate
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	hgajjar@de.adit-jv.com, quic_ugoswami@quicinc.com, stanley_chang@realtek.com, 
	heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:35=E2=80=AFAM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Mon, Mar 04, 2024 at 08:10:02PM +0800, Sam Sun wrote:
> > Dear developers and maintainers,
> >
> > We encountered a task hung in function hub_activate(). It was reported
> > before by Syzbot several years ago
> > (https://groups.google.com/g/syzkaller-lts-bugs/c/_komEgHj03Y/m/rbcVKyL=
XBwAJ),
> > but no repro at that time. We have a C repro this time and kernel
> > config is attached to this email. The bug report is listed below.
>
> > If you have any questions, please contact us.
> >
> > Reported by Yue Sun <samsun1006219@gmail.com>
> > Reported by xingwei lee <xrivendell7@gmail.com>
>
> Yue:
>
> Can you try testing the patch below?  Thanks.
>
> Alan Stern
>
>
>
> Index: usb-devel/drivers/usb/core/sysfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/sysfs.c
> +++ usb-devel/drivers/usb/core/sysfs.c
> @@ -1168,14 +1168,24 @@ static ssize_t interface_authorized_stor
>  {
>         struct usb_interface *intf =3D to_usb_interface(dev);
>         bool val;
> +       struct kernfs_node *kn;
>
>         if (kstrtobool(buf, &val) !=3D 0)
>                 return -EINVAL;
>
> -       if (val)
> +       if (val) {
>                 usb_authorize_interface(intf);
> -       else
> -               usb_deauthorize_interface(intf);
> +       } else {
> +               /*
> +                * Prevent deadlock if another process is concurrently
> +                * trying to unregister intf or its parent device.
> +                */
> +               kn =3D sysfs_break_active_protection(&dev->kobj, &attr->a=
ttr);
> +               if (kn) {
> +                       usb_deauthorize_interface(intf);
> +                       sysfs_unbreak_active_protection(kn);
> +               }
> +       }
>
>         return count;
>  }

Hi Alan,

I applied this patch on the latest linux git commit and tested several
times. There is no more task hung report, so I think it works. Should
I try this on usb-dev branch?

Best,
Yue

