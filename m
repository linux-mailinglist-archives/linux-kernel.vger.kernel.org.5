Return-Path: <linux-kernel+bounces-87131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E986CFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B663281EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918507827F;
	Thu, 29 Feb 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lo3xB0/m"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1B383B0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225875; cv=none; b=Im8/i9UQX/X65DsCLQY8pii/8EsdIjmwn1XmVWobfau3XqetFvahUFvEvqbDhh7HstFEMiPkC1f1/lVjtty6pCBBUjiu/A7bf1L7lsmu7EP9UP60IT0YVHV8ZUVmM60diWYW2yT1Bmvlp73zfPd0b1CENLPoUb/B1LdoOQ1n4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225875; c=relaxed/simple;
	bh=/iw69Wo9b7FEqCXecpxEQgFw9ugs5Mjc606tFUFxMt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnvmqiQQTpzb/mqQyL4+sIKiPm4RvIS8abYv5S4C1sV75uJQhtEA0aJLNfm+tUg+FuaXLY+4X/wlPn3GOkWU3ZulllovUg5VIcBKgIh+RIoWvGBYnk4cxHQ6oMrR/pAf96sXHk75+Ngt8HhfOihaJgRS7ID23CpyeKH7ra+ezyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lo3xB0/m; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21f70f72fb5so740200fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709225872; x=1709830672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wIQGu3rSrz7XnTQlEMgB0HP/EAY1ehgeyK1F+l2GXOk=;
        b=Lo3xB0/mbu8XwNJlZAE8l1HGN7XzY6I2pDvnw45R8TlXt6daKh5QgOXrq5/OaoImW2
         VRMLHnWVbA9m7rDnbnFnRdC0dbMXMdADCqFEbktBCn62t4d5aqqS9au8ToKpP4mOOJpR
         +j6qF4GcT6XhxoZdLmu27SXm62q80Q+RENhrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225872; x=1709830672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIQGu3rSrz7XnTQlEMgB0HP/EAY1ehgeyK1F+l2GXOk=;
        b=jS9MEUN9v9pjrV4PAGdPfX/3kJQaU0rQhx2eCLpBXhO266ijjmzSsqmMs1ye4EGQJs
         o+71u7sFiNeFWz90/uhOSgNQltVxyNLa8Vpy8siJJaApLyERa5spoxHogK80Zuu3EqRZ
         5sEEQB5QgwmHrw32qXl5FXDKfzRextsgnayKQ6TwSlabPGm7416hEar8r4F129KzPi/0
         vYi84PGK7TUzuOCVdDFTvbWvDVKdcPdwkIkyeXeflDFr5p+b8aA5LZ/HmZaoUl+RW9nV
         EotlFsttZhJjk8w3+gPdA5K3whPzu+4YLLvDCBrEt0iGIeePHJRQMB9ryuYdM1s8ayaD
         B3tw==
X-Forwarded-Encrypted: i=1; AJvYcCXjfcpf2ClIy84Y08f8UHO5plA/kiMBJNnssbDj88m1lbN89g9L9eNI9LghpSDXEjHPmj3pV4Wydmxe3+1m5cvDiIR7WORuaOiqpyzF
X-Gm-Message-State: AOJu0YzJ/pnMfPLHxuS+UUCiRgqQ5JFZyWoEUF3wmopz7PJ2gzQBW3tc
	fvHwFSYxdXIJxh79oDGaO6OKKUtso+FwLJiyStPElVk2fCdKKSY25AJ9DglJVVMATaokNe4By5E
	=
X-Google-Smtp-Source: AGHT+IGtoG6eCWdb0ME4nP9hi74TBkowKp2OcBTqB4fk0pvmFmvWS3DIy1fSHSlpIJ/Ufz8Uz5G1yw==
X-Received: by 2002:a05:6870:9d10:b0:220:8989:2ab9 with SMTP id pp16-20020a0568709d1000b0022089892ab9mr3052588oab.13.1709225872457;
        Thu, 29 Feb 2024 08:57:52 -0800 (PST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id ns7-20020a056870ac8700b00220a0b057f4sm223561oab.10.2024.02.29.08.57.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:57:52 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a05923b689so445932eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7+9LpHCYCK1E090LvTDB7xpdY/h5P7HDkfODI221GduCU5BzJWYomVR5XrpoiE5aMTY7kdRG71+qb2HErQBjWyBVGXCGGEpAChiw+
X-Received: by 2002:a05:6358:441e:b0:17b:5c4b:90a with SMTP id
 z30-20020a056358441e00b0017b5c4b090amr3320345rwc.5.1709225871313; Thu, 29 Feb
 2024 08:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com> <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
 <20240213104725.GC5012@pendragon.ideasonboard.com> <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
In-Reply-To: <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 29 Feb 2024 17:57:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
Message-ID: <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Oliver Neukum <oneukum@suse.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver, friendly ping

On Mon, 19 Feb 2024 at 16:13, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Oliver
>
> Would you prefer a version like this?
>
> https://lore.kernel.org/all/20231222-rallybar-v2-1-5849d62a9514@chromium.org/
>
> If so I can re-submit a version with the 3 vid/pids.  Alan, would you
> be happy with that?
>
> Regards!
>
> On Tue, 13 Feb 2024 at 11:47, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> > > On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > > > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > > > Hi Ricardo,
> > > > >
> > > > > Thank you for the patch.
> > > >
> > > > Hi,
> > > >
> > > > sorry for commenting on this late, but this patch has
> > > > a fundamental issue. In fact this issue is the reason the
> > > > handling for quirks is in usbcore at all.
> > > >
> > > > If you leave the setting/clearing of this flag to a driver you
> > > > are introducing a race condition. The driver may or may not be
> > > > present at the time a device is enumerated. And you have
> > > > no idea how long the autosuspend delay is on a system
> > > > and what its default policy is regarding suspending
> > > > devices.
> > > > That means that a device can have been suspended and
> > > > resumed before it is probed. On a device that needs
> > > > RESET_RESUME, we are in trouble.
> > >
> > > Not necessarily.  If the driver knows that one of these devices may
> > > already have been suspend and resumed, it can issue its own preemptive
> > > reset at probe time.
> > >
> > > > The inverse issue will arise if a device does not react
> > > > well to RESET_RESUME. You cannot rule out that a device
> > > > that must not be reset will be reset.
> > >
> > > That's a separate issue, with its own list of potential problems.
> > >
> > > > I am sorry, but it seems to me that the exceptions need
> > > > to go into usbcore.
> > >
> > > If we do then we may want to come up with a better scheme for seeing
> > > which devices need to have a quirk flag set.  A static listing probably
> > > won't be good enough; the decision may have to be made dynamically.
> >
> > I don't mind either way personally. Oliver, could you try to find a good
> > solution with Ricardo ? I'll merge the outcome.
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

