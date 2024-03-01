Return-Path: <linux-kernel+bounces-89011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4A86E96F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C741C20AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F43A8ED;
	Fri,  1 Mar 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhSnjYrz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F725623;
	Fri,  1 Mar 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320999; cv=none; b=cJ+72xrK3cyFAcykK/t0LeCqDSt9vEmU1LXObV7iyu1ov+MlAfW0Qn/j+IIQw+GnHLgzvfQNinQ2qU2N6McM/5wkXIkCVOIaFNTjLKFgGNIJK3TI+PsDRrZGFFGvmfwGLWzy1B9Otx1ZMmAvhKCb7aiygZOL1bOJb8G5Ur0tU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320999; c=relaxed/simple;
	bh=fedmCtqshXcFltzlElrwV+Nzl0laZPxmlHkgb4CnZmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eProCCN/42LJgnewNsLMMtm3Jyb6av/uxrYnuJWF3mgWP8jd8MQ6T2LheeD2Uupd0+TSfJhg0JZozJC5FYSznDHad8HvZtj+GyH/SsFeqDB7TgtOKbiNd2+VZsk1E+Q367TwG3YqbWycs0OuH2OBKKBAv4GeKUkXhBMuSgtYrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhSnjYrz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412c34a73aeso11067185e9.0;
        Fri, 01 Mar 2024 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709320996; x=1709925796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvPbKlI2FS1QAj9Zx+UIfisDOqp/cFW/t/+nx7QTohE=;
        b=mhSnjYrzN3UwiEkzs0dzlfaSx+rux0ejyXhez/VISogPZEFy17snPqq+zrPXqj9Hai
         8DgWbrX1p+KGa0zP5mcE51I4ITY2kDq40QIKujO3wBhN4Xx6qeWFHNaucGM7MM3XCTNl
         L4/JxxYp0F2TyawQejNj8WU96Mc0Cdi6HRTMNkg8ntAxb4QrksII39ROoZDBRpRAKkWa
         oBsxKimVYpdloycD4eGgf+F59pgFPtKmdvIQj1wSFZ60x8Y+UA5tlM+wzGoBjW1mruiR
         0soK0dOGHKcj7OKuqjyOftpAmfxoYnRqzuHqnQRXY0Gmorn3r/Az588DWzVyjkyaIMEY
         +PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320996; x=1709925796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvPbKlI2FS1QAj9Zx+UIfisDOqp/cFW/t/+nx7QTohE=;
        b=YsioyBVktBcZ9FD8gavrIFXD9GIQpXfP/nf/Kn/1LBo17tAcWpnTnfKvDyyClRj/cm
         PRXiM6e9g6mUom1yofhy1uddU87qw7oxwwQWdSYgKBC7R26X+ZYmEwGJpOoWdlyzCHOG
         DFMFkQ/YfEAVCUF+E0k91WioeQ6Z6U0N+Xs3L8dYwN/+gUA1zgEgQM007pP3wb6iiei9
         EockyB9yGstoAS7oRDmZ31VgyRRuLaepeMWC4FrmM4INuLYBtTpFqclbMuQSmTyT3INF
         YcMcrVxH5WE/caoE/NgWTDLu44F850AjNKMGifsc4RDtQLGgYP0TryMqPa+vmCF0LSiG
         Dcvg==
X-Forwarded-Encrypted: i=1; AJvYcCXccirgB11+ZqYd8G6kaPxzPpih3gLQ31aIDVUA+56IvbP9jqyLb1DHCziepz59xspiFsGjapue6GcwAL3owNBw/Ab5GnHKpAgH09EtP9RPD+gEu5O5zA4/onUwZmHduyzEg5xiLtX0CfvNhusy
X-Gm-Message-State: AOJu0Ywn7kr15PuJYJG0s5WUDQ62FANAyOYkeVEl/chI5EPL71gxNz7p
	Yhxtk2ldyLn3f+kM4etlwAXWaRZia78/RdIZ+lz3Bo+b5tdeBpDj7p149Wb2plRI8IH4YP9XMzZ
	Egaym8u1fFqCIVRxxleLnaD1hqjk=
X-Google-Smtp-Source: AGHT+IE8aCiEwSy0WTaBx9IqzRPr5g266uVvHShkiB8B1fYwazMOaZ9cBuiyV8EEPt6uc4dYJz30a2kR8VKHGPIE9xc=
X-Received: by 2002:a05:600c:5253:b0:412:c47d:4f3c with SMTP id
 fc19-20020a05600c525300b00412c47d4f3cmr2234856wmb.15.1709320995963; Fri, 01
 Mar 2024 11:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <361ac881-60b7-471f-91e5-5bf8fe8042b2@moroto.mountain>
 <CA+fCnZd_eNHes56x3edzcYWeDKW2WRJYqrz_FyCks5wxtLdFdQ@mail.gmail.com> <5d74dbd9-99e4-4ebe-a9a0-bd8f571d0f56@moroto.mountain>
In-Reply-To: <5d74dbd9-99e4-4ebe-a9a0-bd8f571d0f56@moroto.mountain>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 1 Mar 2024 20:23:05 +0100
Message-ID: <CA+fCnZdubN6xDS2adjX5jEgBOWy5KRBaHrs3COa_CG-ePFHkuQ@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: off by one in depot_fetch_stack()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:22=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> I wrote it on top of that patch...

Ah, right, my bad.

> Backports will need to be adjusted
> to handle it, I guess.  The "lib/stackdepot: fix first entry having a
> 0-handle" commit has this note:
>
>     This bug has been lurking since the very beginning of stackdepot, but=
 no
>     one really cared as it seems.  Because of that I am not adding a Fixe=
s
>     tag.
>
> I don't really know the code very well so I can't respond to that.

Your patch looks good to me, thank you!

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

