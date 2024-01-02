Return-Path: <linux-kernel+bounces-14294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DE821AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9F71F213EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD27EAD3;
	Tue,  2 Jan 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XryoqP6M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E6E56B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-427eabbaf25so35676701cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704195128; x=1704799928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CTXYQjDTx9MjNeWmQMbnj/JJ7KlKNb5ez8YnAlEmuU=;
        b=XryoqP6MDCAM1W1boSMn8ZBw8f+60nmm1oSpqP0kth0iGwh8i5ExfZgjnH1O9A1dqO
         H8jD6zUY6iOUe7pEuMt0M4MXSgAxbABixjJs5ByoVpRifB5O6qsiN9nHRQYMVDXhszCs
         aRJoUzFow+6QMg6R0KTpKWw+ZIxKWfPPBW1OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195128; x=1704799928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CTXYQjDTx9MjNeWmQMbnj/JJ7KlKNb5ez8YnAlEmuU=;
        b=SsEoAjtLkmxa19IslDec89klwsuTl7h994pmrsKW9Expad2Kd2NPh+Ow7MmjQ0Brtb
         7tRqTbhPtww4Qi8mrBY2F0mg8Ei5hGJW1qnnVQZV6EPQD748+HZSOyrmcBVTcrS3JL9D
         8Kn8qHv+ceF1FDdY/AjesZz1uDETahFWJBf2lmngpGVJ4YHK/9lG48U7BjjCB+LCVrbi
         SKgCd4Xjw5ilO/KUIUggvR/bZ02BJxK1F0gCCRM5X1xQW7wukDv4o0wRozrGU4o59b0Q
         IRXlviYFz91DRTAHoTSL6WpMIQxzkK2pQzPqmibKMVRHfZCF6ePJ5t9ZU70Vt3VlCYHJ
         tDGQ==
X-Gm-Message-State: AOJu0Yw64P8TytD3ux9qMYrHmxfGfX3yTKrkUrW6H8BVc3pgYubJfEtC
	LNyK4iv19DtqhcwTTXav1FRyBGaMlrw8PVRaiS4lJM+trw==
X-Google-Smtp-Source: AGHT+IGl8gkYnbJVfwh0+84KWgrjG9yKZkYUZ0ULe+WjvwW6W8LZFxMW1T6sIu8w5NXBTKHOFj9ARQ==
X-Received: by 2002:ac8:7dc1:0:b0:428:24c0:92cc with SMTP id c1-20020ac87dc1000000b0042824c092ccmr3210382qte.38.1704195128096;
        Tue, 02 Jan 2024 03:32:08 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id cc17-20020a05622a411100b00427f3b9e60dsm5763219qtb.60.2024.01.02.03.32.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 03:32:07 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-680861506afso25006946d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:32:07 -0800 (PST)
X-Received: by 2002:a05:6214:2a85:b0:67f:67de:5d32 with SMTP id
 jr5-20020a0562142a8500b0067f67de5d32mr26610741qvb.41.1704195126792; Tue, 02
 Jan 2024 03:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222-rallybar-v2-1-5849d62a9514@chromium.org> <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
In-Reply-To: <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 2 Jan 2024 12:31:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>
Message-ID: <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Add quirk for Logitech Rallybar
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan

On Sat, 23 Dec 2023 at 21:01, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Dec 22, 2023 at 10:55:49PM +0000, Ricardo Ribalda wrote:
> > Logitech Rallybar devices, despite behaving as UVC camera, they have a
> > different power management system than the rest of the other Logitech
> > cameras.
> >
> > USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
> > device unusable.
> >
> > These are the only two devices that have this behavior, and we do not
> > have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
> > create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
> > quirk.
> >
> > Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
>
> Would it make more sense to do this inside the uvc driver instead of
> creating a new single-purpose list in the core?

I can try to move it to the uvc driver. But maybe it is better to keep it here:

The same vid:pid also has other functionality, not only uvc: Sync
agent interface, UPD Interface, ADB interface.
If we apply the quirk to the uvc driver, and the uvc driver is not
loaded, the other functionality will still be broken....

I expect to see more devices from Logitech not needing the
RESET_RESUME quirk... so this list will eventually grow.

Setting/useting RESET_RESUME in two different locations, can make the
code difficult to follow.

What do you think?

Regards!

