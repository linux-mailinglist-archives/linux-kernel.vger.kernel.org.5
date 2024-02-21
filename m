Return-Path: <linux-kernel+bounces-74180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F185D0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FBF1C2426B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA573A1DA;
	Wed, 21 Feb 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1gnDHfA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680038F9A;
	Wed, 21 Feb 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498992; cv=none; b=qewpz2VZ4lU5VEDgcTwVKWeCtJk060GMX66nyF2jNGic8x52VE3tlekgOoEbOS214vlsRCbRFySqudCUv0uUJAgbOzS12RMzx9ARaU8wXiEMw2XPJqBqoQ5FUpfKHUX0RZswCMbnNHaVeXHe88GXLothd1ZiQfpXvWYB11Q+vdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498992; c=relaxed/simple;
	bh=Q2XQh+IpmpsWLZpNxz/rVPHihd01yeblp5S9XZqA97s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDG4gPMUGKmMWInBcjtuCwfg/uv4ODRV+Zp0gDEvb2tDgF23mIjr4K2L9PkW4UTm3Q3CenTlgeGDNuxrP9gEiPC7MRrt/bGtBMHcC0AYTCZ9W69lRD+DmoTjLQmS9kPBmCjm2PC/glkGsZJmMWFKBnqe9rwyCQyAMfOw+NE4L8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1gnDHfA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512d5744290so195347e87.2;
        Tue, 20 Feb 2024 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708498989; x=1709103789; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q2XQh+IpmpsWLZpNxz/rVPHihd01yeblp5S9XZqA97s=;
        b=B1gnDHfADu/+NdPM0AmqYyQAWkjhbkw2sKhD5Up/NhT+3nHQu9MDb+KgmRtfnnOUv4
         k97IBjnvhNHzRbSyTA+Zfsyg2jHYFuYC+vtG5IMWLJJYixDBBPjaEExazY/2ToYMU40k
         HxDvUvYHgGncMoo8/ORVJhvoqn9+ExH7+yPqFWqNENS124n1Gf1f88Ep24oiryFidaBG
         MgGiRXatr5jZ632IBFXvCOwIQVD6fBWEt2yR0Me0qanzmbTyHtqpuAv10R6kPBnec4RB
         huFJkhAqDd2Wy8DR+ojkgJd2IfSr02EIeIPyz+EICEec3i1fbhlUQfc2kioWpf1wMhNW
         2QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498989; x=1709103789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2XQh+IpmpsWLZpNxz/rVPHihd01yeblp5S9XZqA97s=;
        b=WT5I7roLP9QkkacGRRFjCt8YWHMxoiJLh7QDEHMkHalX9rUrKtHrgTvlOl2bpKIbir
         Ji7JXx3urVF/WyilwIxZXz5GlT2WfwinLoAl7vaI4PaMLWyzxk4Vy8fA2Xb5PpjBaGjc
         vYNUn2JoFtmQiYxk/Ur1zneciJmFFuR0qYIfiYIwbDYLnBa4J0l65zPzB86qCx/Rdy5q
         fFg4w9PraLInHyAvKX8CXzfLwuFtXFi2hS7b18W7wR0cJEzpQtTb/AcQGobTrzpyDi+J
         +FCLGxucSBKeZ480B15gNe/TkrhFgLsX4i7f+Dtvt0gFwwrZnz3bWk8rZhVjzvGLDyMI
         YT6w==
X-Forwarded-Encrypted: i=1; AJvYcCXrUmchGyk6kdpxp/zfbuWCmqK52ZSGX0l+uv2osVLz9u7cHn1OnJTt/PsSMu+Z8DWEAO+dZBgIGV+qe19ss4rjp3IM4rY1P8NzOWo1AFGwv4A+70VNHTB3OIcbe1UmxNzOKlIraTdkeQ==
X-Gm-Message-State: AOJu0YxnPXbicIxh0gwybPjvw5a5BUSbSM9NWrNynoKfWuBjAAzL4DOw
	TMcrMYaHRqyRfey29pipkyV7P7a613sjC6B7fAmp4z4ejJe9wixt
X-Google-Smtp-Source: AGHT+IHhwKsjUwHTXDNbsB5D0QT118EOREGbSC1oGpMNPCTVepg2koPHmsNwD5bJOq4/QtUzA5NfxA==
X-Received: by 2002:a05:6512:138e:b0:512:b2fb:a726 with SMTP id fc14-20020a056512138e00b00512b2fba726mr8115936lfb.63.1708498988508;
        Tue, 20 Feb 2024 23:03:08 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id ij27-20020a056402159b00b00564f3657a5csm385544edb.75.2024.02.20.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:03:08 -0800 (PST)
Message-ID: <9e6d2007a1007fbe5d262f0a86af43498a278a68.camel@gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, Herve Codina
	 <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Android Kernel Team <kernel-team@android.com>
Date: Wed, 21 Feb 2024 08:03:07 +0100
In-Reply-To: <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-3-herve.codina@bootlin.com>
	 <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 16:37 -0800, Saravana Kannan wrote:
> On Thu, Nov 30, 2023 at 9:41=E2=80=AFAM Herve Codina <herve.codina@bootli=
n.com> wrote:
> >=20
> > In the following sequence:
> > =C2=A0 1) of_platform_depopulate()
> > =C2=A0 2) of_overlay_remove()
> >=20
> > During the step 1, devices are destroyed and devlinks are removed.
> > During the step 2, OF nodes are destroyed but
> > __of_changeset_entry_destroy() can raise warnings related to missing
> > of_node_put():
> > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
> >=20
> > Indeed, during the devlink removals performed at step 1, the removal
> > itself releasing the device (and the attached of_node) is done by a job
> > queued in a workqueue and so, it is done asynchronously with respect to
> > function calls.
> > When the warning is present, of_node_put() will be called but wrongly
> > too late from the workqueue job.
> >=20
> > In order to be sure that any ongoing devlink removals are done before
> > the of_node destruction, synchronize the of_overlay_remove() with the
> > devlink removals.
> >=20
>=20
> Add Fixes tag for this one too to point to the change that added the work=
queue.
>=20
> Please CC Nuno and Luca in your v2 series.
>=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > =C2=A0drivers/of/overlay.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index a9a292d6d59b..5c5f808b163e 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait for any ongoing devi=
ce link removals before removing some of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nodes
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal();
> > +
>=20
> Nuno in his patch[1] had this "wait" happen inside
> __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> the issue that Luca reported[2] in this patch series. Is there any
> problem with doing that?
>=20

In my tests, I did not saw any issue. Logically it also makes sense as you =
wait for
all possible refcount drops just before checking your assumptions. But I mi=
ght be
missing something though...

> Luca for some reason did a unlock/lock(of_mutex) in his test patch and
> I don't think that's necessary.

Yes, I agree. queue_work() and flush_worqueue() should already have all the
synchronization semantics internally.

- Nuno S=C3=A1



