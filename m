Return-Path: <linux-kernel+bounces-71566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840285A726
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9531C20D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221D39855;
	Mon, 19 Feb 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yh/yv4XL"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87E381C4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355632; cv=none; b=L8tQbxyptuGAgbGolwJlS3IPfof6L/BQjlyqyoPGorkaJ5txv/qiBPlXP41YEnRmidptqnPpJTt/6l/ny9MNHJ548Iz12RbgzotMWEcYza27GU+iICbx0VmR4LeMdwXkl6ZKgCuZ3m9dbh/R9U8R76xFlr9ERcLGo/uz3okc1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355632; c=relaxed/simple;
	bh=KMXslpEu/8HD8HCC5Kf31taCUsV+DerQdmJgOo4z//Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2kfMV/iBiDl0rR5cnAT6vFUCvsJYa944+REdELtLmA6ge3NcPGiQeLdGJXENTA/Eek3GIqAnoBBHXO+X0p7YWkUIpEqd/VySLdPREWuVLdftNOgsxKNipdKYA6CF+208kjlw8x3L8V+69FkU6c5GEU3oiupr1VTihPF7SGXmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yh/yv4XL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c132695f1bso3451666b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708355629; x=1708960429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OOBPJAb082VtuNzjGfp3LwJ+/PnS72KaIK5i7r+LyKQ=;
        b=Yh/yv4XLzMbggMTyTgTreJQk18whWQDeg10QeL/gCzmSw2vuRqHEpD7q58xPR6ujLV
         9LBwIrKRoLp6v6pec/VuV7sDgU/AEQIvz4TBf0NbPeDkzPWo7xycfBwxRBrmJs/johOn
         zz3er/g6WX9lN9MGDhe/Rnq9rHObhQ11ZAQF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355629; x=1708960429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOBPJAb082VtuNzjGfp3LwJ+/PnS72KaIK5i7r+LyKQ=;
        b=Zt/zGv/XLJdz7brY2QAGUCZ5tFb6VyVv4FI7QqlkcktDvSDnlo1NR0celCnbznug3X
         vuk5IP/ejl1fN4fbNXF0B5xENbGPgf1NP9PFzRkkLZ62W0TQuV5DWOXQoiulYvVl1gYb
         32/XJ+BuO7h2Mr86WsQB6C5u4gT/ajPf6jFlmX6iQ/QhgAwmA4ByXN9boYucBivqMT3i
         kXZBq+3k/Fda8hj1h/r+N4KyB4h/YopDSo8vrL3Udm9chD6LLxpQEOEfJu7ykqnfP4/l
         YqHEmwS0t6txNzjRn4f4j/52seGSFse/ekV/X9X6yd3f2nRZjCuTYUJEt8FeZC8nTj5O
         2ZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVSFUrdQwqUsEdocDTXe5n2GnIVvpC5lzGSgKvwtRAyNX1Qd+7CIB5KUxTw/9lOOo0o1StAJAY30GEAYdiFU935txLFIaoBn69BWLiC
X-Gm-Message-State: AOJu0YxFX7lofWAvo8vgkPk9Dg6iLDGQ59kFOzXtBAJDYJdEvXrPIFKQ
	AQEixB9AE1zg5yGP5B3Y/rzC157tQbjjfTv+uJbEpv4uAPuGfsGNFd0vhun+UzCpy1jeIFwU40s
	=
X-Google-Smtp-Source: AGHT+IHxBeML0rJS/zPTKjQnU572YW/FecX+Smrm7HjV4nLQiPCVBDAaXXOSl9d8nShSnwCiXlNyCg==
X-Received: by 2002:a05:6808:2108:b0:3c1:5f16:6c47 with SMTP id r8-20020a056808210800b003c15f166c47mr1806463oiw.11.1708355629665;
        Mon, 19 Feb 2024 07:13:49 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id t11-20020a056214154b00b0068cd399760fsm3276371qvw.61.2024.02.19.07.13.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:13:49 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818aa07d81so33527286d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:13:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMJtxggIJOG2eEBsuhdWhTsSIGB6Paazljg5/TirYQrOLULSbB59kF+fYJPpTDGe+EJyEG/zyKCED5ETOvaxl008x7vbu+ed4Jhj2y
X-Received: by 2002:a0c:e0d2:0:b0:68f:2ac1:99fe with SMTP id
 x18-20020a0ce0d2000000b0068f2ac199femr11694403qvk.45.1708355628695; Mon, 19
 Feb 2024 07:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com> <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu> <20240213104725.GC5012@pendragon.ideasonboard.com>
In-Reply-To: <20240213104725.GC5012@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 19 Feb 2024 16:13:31 +0100
X-Gmail-Original-Message-ID: <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
Message-ID: <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Oliver

Would you prefer a version like this?

https://lore.kernel.org/all/20231222-rallybar-v2-1-5849d62a9514@chromium.org/

If so I can re-submit a version with the 3 vid/pids.  Alan, would you
be happy with that?

Regards!

On Tue, 13 Feb 2024 at 11:47, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> > On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > > Hi Ricardo,
> > > >
> > > > Thank you for the patch.
> > >
> > > Hi,
> > >
> > > sorry for commenting on this late, but this patch has
> > > a fundamental issue. In fact this issue is the reason the
> > > handling for quirks is in usbcore at all.
> > >
> > > If you leave the setting/clearing of this flag to a driver you
> > > are introducing a race condition. The driver may or may not be
> > > present at the time a device is enumerated. And you have
> > > no idea how long the autosuspend delay is on a system
> > > and what its default policy is regarding suspending
> > > devices.
> > > That means that a device can have been suspended and
> > > resumed before it is probed. On a device that needs
> > > RESET_RESUME, we are in trouble.
> >
> > Not necessarily.  If the driver knows that one of these devices may
> > already have been suspend and resumed, it can issue its own preemptive
> > reset at probe time.
> >
> > > The inverse issue will arise if a device does not react
> > > well to RESET_RESUME. You cannot rule out that a device
> > > that must not be reset will be reset.
> >
> > That's a separate issue, with its own list of potential problems.
> >
> > > I am sorry, but it seems to me that the exceptions need
> > > to go into usbcore.
> >
> > If we do then we may want to come up with a better scheme for seeing
> > which devices need to have a quirk flag set.  A static listing probably
> > won't be good enough; the decision may have to be made dynamically.
>
> I don't mind either way personally. Oliver, could you try to find a good
> solution with Ricardo ? I'll merge the outcome.
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

