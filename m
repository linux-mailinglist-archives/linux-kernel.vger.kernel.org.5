Return-Path: <linux-kernel+bounces-61923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67980851872
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E692852F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5443CF45;
	Mon, 12 Feb 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD3hCq/0"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F63CF57
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753087; cv=none; b=s3LEKGNoU/Fr9Z5WSVsXW3MErrPQvsJ53pi758C5JlHmb6NJuv4JUsgyTzhr6qWn85D6/c7ZSktQw6vkvwS+YRUmIlVOR/1Y0076rjwjGpr/qwDIk6XgMvDBBphuI0HAloD3a1cEDHct0TkzqvxmZ3GLEDg1NAYfvzqmnpzOubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753087; c=relaxed/simple;
	bh=p/i3DYXuovTO2KHj+h+HpOiAq4PPRIUi0cp236MGa30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1g82qvk5+UgxPN1XUYbvTfMTo42YuRVweF858Cmy7FGv6i4j2nIHhVcR9/apIt6EBgbqqWaRD0LymIYRlZALpt/unwGK92sdnoLXpXP70WP6tVDhLXezj3igsF+81pTt2riCXVH3bpNnBRvzvd4dc2ds3zyzZtgGUjHqV3FpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD3hCq/0; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7baa8097064so220830339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707753085; x=1708357885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CrURRj1kgeVHOJ09dw9bNpmlpnJTIS71/+YJ9slDyw=;
        b=OD3hCq/0dm1tsYAdjIE3tn2GK14nr9Dc+cnIRYdJAk5YLAZgK/pwB7RW29Zd5/FkXE
         FyN0sMLwX7+OomMRBCaVnlSDsIzzul0mJXS3lxVaT/LjnkFOCy9wko9SFCayV5r+oBUE
         ysnbpKdgES7+vHTjfIHUKLtEu1w1ag5QPIh+5ZCTICOplF1iyy5LHcZF+X0As3gagLIo
         tOCRc7FwKwCDW2TQh3yNLSIW+itGjB+g5bt1M4aDP92vKsteb9+m6nQnWav0vjd0yikY
         4x+HHmMv8qL+FU27GLVxfOrozEDsxxsTtx423GGkFirWaXzXRxaREXaoaNUPy4C/Ac1m
         3qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753085; x=1708357885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CrURRj1kgeVHOJ09dw9bNpmlpnJTIS71/+YJ9slDyw=;
        b=U+uKFkLuxDEh/RHSZHU+Q79u5hhvDDPo77tkUaaeRsiIAu9zJH9qMCWi2qJz+rxuN+
         ZOuAPX2gN/9LAWd9MbMImEZaHIPk5wdXckdpqYeAOfl6hpGLQ9jFnv+pvI6+e77S0J1l
         aVZMNW3JhiS7ngIWituriLhsXc9ibZuMQlcY3U3flLiecuC8r2uJwAdAdIH3u1y5HVdE
         YyHuRKkzEiRkCDllUrPb+ZRpIaTw8oWqd39Np9qfohDUPD97snVkhWtbwD9TxeinebGF
         h5EcdizKrd9ZOSWw1nJEnsJxWmxJTxECVGunqCJcQsl5me//ZlkVE1bZGvyLJhfJcETf
         lHQg==
X-Gm-Message-State: AOJu0YykfGLAIUR9qBu8V61Igl7CCZIwIvZ7s7yOPSa0iyKabeMnxic4
	4M+LWkdCkjn27P/CLHmF0kerKYkXdal1noEYip8P6rhVojxWXXtYPeHqpBCcvaqwlLE/f67KdrM
	86jDN1mYwl15rruVDJOjJDR+ghlxspLPOe6ji
X-Google-Smtp-Source: AGHT+IF4XWpo6trnD/hLTaZqecOY8VBPzcdUAPevFQVBcwQrHB7XjKhGtpeRKxncyFpZQb70F6+pazsovg8kIEz3Ijs=
X-Received: by 2002:a05:6602:179b:b0:7c4:3510:92f with SMTP id
 y27-20020a056602179b00b007c43510092fmr7761730iox.12.1707753085037; Mon, 12
 Feb 2024 07:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com> <20240212131323.2162161-8-panikiel@google.com>
 <170774854498.294434.14234480400138512065.robh@kernel.org>
In-Reply-To: <170774854498.294434.14234480400138512065.robh@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 12 Feb 2024 16:51:14 +0100
Message-ID: <CAM5zL5qx1sw=NSWE7gv3E80MCMJ4=tvc44WDAnBrfsJ2qQB3iw@mail.gmail.com>
Subject: Re: [PATCH 7/9] media: dt-bindings: Add Chameleon v3 framebuffer
To: Rob Herring <robh@kernel.org>
Cc: chromeos-krk-upstreaming@google.com, tzimmermann@suse.de, 
	maarten.lankhorst@linux.intel.com, hverkuil-cisco@xs4all.nl, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	mchehab@kernel.org, ribalda@chromium.org, robh+dt@kernel.org, 
	mripard@kernel.org, airlied@gmail.com, linux-media@vger.kernel.org, 
	akpm@linux-foundation.org, dinguyen@kernel.org, devicetree@vger.kernel.org, 
	daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Mon, 12 Feb 2024 13:13:21 +0000, Pawe=C5=82 Anikiel wrote:
> > The Chameleon v3 uses the framebuffer IP core to take the video signal
> > from different sources and directly write frames into memory.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> > ---
> >  .../bindings/media/google,chv3-fb.yaml        | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/google,chv3=
-fb.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/media/google,chv3-fb.example.dts=
:28.27-28 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings=
/media/google,chv3-fb.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_bin=
ding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202402=
12131323.2162161-8-panikiel@google.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

I was missing a '#include
<dt-bindings/interrupt-controller/arm-gic.h>' in the dt binding
example. I ran dt_binding_check after adding it and it reports no
errors. I will include the fix in v2.

