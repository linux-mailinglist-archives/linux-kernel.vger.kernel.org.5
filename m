Return-Path: <linux-kernel+bounces-37719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DF83B45A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DDF1C20DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1513541C;
	Wed, 24 Jan 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOV6X70P"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F11353E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133506; cv=none; b=mZd4aA3PMDTXBC6cOMs8r1fxTZD2mrLbG7S1cPzFH4xfnHuC7wWUTGWCubVgwtU89Vb10w+edkhTqkgrz38u0UVOO7nBfsphbFntZv5LDUi8ydNsevxg0V7IHLCGcQB3rpb8Rjo4ukQyQTtAWjGTGAhfemND6W/NUYqb6v3Rcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133506; c=relaxed/simple;
	bh=K28HTCvqTt6/ul2ODpUtsaMLvIFUxf2hMIz7NKzy+K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pximGbc3a/s+QUiDyV5OJ2d3zE3Ausjt0IAa6AjnCw2m8tPszZIl8tfKy2UY7VL4CdzUkDzT0yWk8ixa+b5gd2AWQi6Qr4I1jPZ/wmeL1MXKL6fwOu+N2pbZfcqb90hxFbOgUkxpCM78GLVrfiQOWkjKNilRcyugydSHUKqsy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOV6X70P; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so5880533b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706133504; x=1706738304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUJUOs+bThK9dGxB+Sx01k3VOX9ACqMj4VBsHio7vIM=;
        b=NOV6X70PgShIxoxS41Aj61a8x+ZZaJslxblDZql9Q4STMS96kWbJK2f/ivwvcENQss
         Ey1ueJWoSmKBXqvbaWaB4pciLCJxJY81JxUXEzwnHDE2aTtpJOKde3D9/5RGBu+7j0FU
         gSlz0dL5u+cHJ89SFRcXTmB1WdXbcoFEgMwRQ8Po68lUdgJFB8CGBrXhSEtc7lmSJSGX
         lEsQG9kuQI63cE6IBO7vR7bZn0xcjxekmozgoBkivDpoMzrLbX3rZgCoLoqIZdQx57Ln
         m+yE0QVqf7gwBdmkBsBCkaC3C1cz8FSQ+mS9Z6vEOi4kNWUUvmhnNdbeIULm61u0TkHV
         lDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133504; x=1706738304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUJUOs+bThK9dGxB+Sx01k3VOX9ACqMj4VBsHio7vIM=;
        b=C0bcEED6LZAweHo+WlJy35vqLwDeYTFCcxKNYqVikwqZ343ZnrbUnKpI2rRxuT8SiN
         Kxl6y2oAEgQ1252Samr5yZT72DJNfxelNQfS1An1E1OCCAdgnbH4g2BTJWDrzBwewSKr
         hlNBLvpXv1HlCC962NLjuwm8N7Vo1SzmzNuibF76El2PYDz5qz1EeECKHBsEXg2mr/yw
         OwK8iXpACkH05c3Suz22kEpwBUFUVFaTTLx8KyTANXAp33Xm3RuZdTcQOcEMbJh4ALf2
         FFnE+orQ5x4fDEwDuzIgVwqBDiIeSR0lH8mR7vh9ViYwoHI/ZiJ+SYUuGdYQx1lb3s4u
         N5ug==
X-Gm-Message-State: AOJu0YyzlFwUvH/ZUjH0t3WLMvtmhXDQ+Nr5FSLdf7odWFLwwQROWpHs
	ggnTBT3379n7d48ZjOWTt+nPC/T9Eu+p/RF7pX5OBmDbR2/01PiX3Tqfu0VNIER35nxMFZDmD/J
	OAUP/T0+HC6wgj/zGUycy6CjEkjQ=
X-Google-Smtp-Source: AGHT+IFS8OnYe/kdTuuc/r51cDQZoMJ66CNFtnW1grppwVuSlq7ouq9zzRmTg7Lg6fCVCce6JM9z/uXvqOy1GcaYpVI=
X-Received: by 2002:a05:6a20:a889:b0:19c:62d5:32d4 with SMTP id
 ca9-20020a056a20a88900b0019c62d532d4mr75685pzb.99.1706133504389; Wed, 24 Jan
 2024 13:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADBGO79JycAycKXm9A46pLrGZHTsySV4NH+yvV7VFU-8reMF=Q@mail.gmail.com>
 <CADBGO78cNfZZFA_iDbjatiyvSwF3G7DjbddqTpQyw4zMoyC5ZQ@mail.gmail.com>
In-Reply-To: <CADBGO78cNfZZFA_iDbjatiyvSwF3G7DjbddqTpQyw4zMoyC5ZQ@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 24 Jan 2024 14:57:57 -0700
Message-ID: <CADBGO7-V40=pw+UjAptYu4fAQiDoGequbZLmpO=HoAyXs3hYaQ@mail.gmail.com>
Subject: Re: [REGRESSION BISECTED] 6.8-rc1 - Wayland hangs when connecting via
 VNC or RDP
To: Luben Tuikov <ltuikov89@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I see that Mario already posted a patch for a "frozen desktop" problem =
here:

https://lore.kernel.org/lkml/CAOVeLGSczkyhj61T8SZc2cK1Cjy2izV6URVa2422kcfy8=
ONYFw@mail.gmail.com/T/#t

and I can confirm that patch fixes my problem as well. Sorry for the noise.

Thanks,
Paul

On Wed, Jan 24, 2024 at 1:21=E2=80=AFPM Paul Zimmerman <pauldzim@gmail.com>=
 wrote:
>
> I forgot to say what graphics driver I'm using. It is amdgpu.
>
> p.s. Sorry for the bad formatting in my previous email, it has been a whi=
le
> since I posted to LKML.
>
> Thanks,
> Paul
>
> On Wed, Jan 24, 2024 at 12:47=E2=80=AFPM Paul Zimmerman <pauldzim@gmail.c=
om> wrote:
> >
> > When I attempt to connect via VNC or RDP to my Ubuntu desktop, the Wayl=
and
> > server seems to hang. The desktop GUI no longer works either locally or
> > remotely. I can still log in via ssh, so the system is still alive,
> > but the GUI is
> > frozen. If I boot into Xorg instead, everything works fine. Kernel 6.7
> > works fine
> > also.
> >
> > I bisected this to commit f7fe64ad0f22 "drm/sched: Split free_job into
> > own work item".
> > That commit does not revert cleanly however.
> >
> > I don't see anything in dmesg when this happens. Here is a snippet from
> > journalctl when it happens:
> > Jan 23 16:14:30 paulz-Precision-5820-Tower systemd[2826]: Started
> > Tracker metadata extractor.
> > Jan 23 16:14:55 paulz-Precision-5820-Tower systemd[2826]: Started
> > Application launched by gnome-session-binary.
> > Jan 23 16:16:47 paulz-Precision-5820-Tower
> > gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> > [ERROR][com.freerdp.core.peer] - Incorrect RDP header.
> > Jan 23 16:16:47 paulz-Precision-5820-Tower
> > gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> > [ERROR][com.freerdp.core.peer] - peer_recv_callback:
> > CONNECTION_STATE_ACTIVE - peer_recv_pdu() fail
> > Jan 23 16:16:47 paulz-Precision-5820-Tower
> > gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> > [ERROR][com.freerdp.core.transport] - transport_check_fds:
> > transport->ReceiveCallback() - -1
> > Jan 23 16:16:47 paulz-Precision-5820-Tower gnome-remote-de[4158]:
> > Unable to check file descriptor, closing connection
> > Jan 23 16:16:47 paulz-Precision-5820-Tower systemd[1]:
> > run-user-1001-gnome\x2dremote\x2ddesktop-cliprdr\x2d9Tp4LD.mount:
> > Deactivated successfully.
> >
> > This is on an x86_64 Xeon system running Ubuntu 22.04.3.  Any hints on =
how to
> > debug this further? Is there a way to turn on additional debug prints f=
or this?
> >
> > Thanks,
> > Paul

