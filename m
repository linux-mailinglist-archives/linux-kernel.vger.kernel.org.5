Return-Path: <linux-kernel+bounces-61924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21F85187B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A011F221A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D43CF7D;
	Mon, 12 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBBuBINc"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FB3CF5B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753183; cv=none; b=D0jXQf9SOUGQhzuBkNQqvmajGUGpJdVfuxdCMAVt9c2Srqykcjq05QL5lFrklV+ZJqO9QiLdAIJwU4FK9lAgwqme0dS4LDO4IvIq18cugGrHdIBElmamlEmy9ZA/aQUrnEQO8UbfnEr0wKTJQFEuei7ToorDa/+YJ3iVxsufPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753183; c=relaxed/simple;
	bh=sDj8wpAKnqZJTDtv8CskxWzkhDzZyqf5QDNAuuapONo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXQ7g1G9yPxTsJ0U/BiaIxrG1e1N0StXPajVxpl16PVLDlCxsn6PWO0O51CkaSOBoKRNhBfHB9koMVaeSU6UhqskBmW+QGb2XoqJW1+lSbUREofbfMwZZZDQduuKVlKGFlM4gyJ74UnTDifjP/hvYl2ziIhfkbWDyX/0D5M+gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBBuBINc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bfe5aa702fso135222739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707753180; x=1708357980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ga0BKab3mro7xv/pvLTvYj5RDzbbT2tT8OrhfimfXY=;
        b=hBBuBINcBTXzo0xwsjFPOt6hEE38XATCh3G78M+5aZG9UduhkbjIBUxMdNjVwc/wIB
         gsZ5TNNeisQtwMYDkFURuyaigid7FNm2tQcd769VUT3Yt9ctbN2AjhSTBHAy4DeWZnSN
         FdY3AfYhKb2Ug5SOD0kfhBpho4ltoAvfik7806Onfk5H+W/UOzXv3jxOwquhmVrIOnX6
         3HpWppLdukLfD7YsxsnzndFmglC8TEGnpbIn3NKA43Rm5fmMTWLO+E32NBTZoRxH9oOm
         iEpwAx2rfoFJdAkVWkn7mnuigqaPWxJmYJU0XwHtyZ3eUI0uIzXRPRRMMgf5xc01kJTp
         iZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753180; x=1708357980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ga0BKab3mro7xv/pvLTvYj5RDzbbT2tT8OrhfimfXY=;
        b=a9SmYMvyst9TZPmUyJvdjvwH4ebBk3ODguEKJfVAhGezFoySj2mn/YAfd6cTITYQT3
         kmsvBpJgLW7F0ZR662DvqUIU5vRNHf+CnGNbKSzotKtL4TmhbMFx85b+LRUcxoO9bD/1
         YSd6Tosxc5akx44RuqOG4wBSDXJ70eOF8dZZnZohF+4OumLSQI2ZZO17w8VZ5YbGRhBv
         2ebtk5OuV/EyCQkILmyaEAi9WJmkzDViyTLGDz9cE7WzsLTcUKg1R2apIrxIpv2Jfg7k
         Ll6KpUBcQ67t0P0fzCfrHxRbmzn98PGBCo0Kh0P5jKU6FlttBN6aD7jDJlqNgGFrloI+
         3cag==
X-Gm-Message-State: AOJu0Yy62aHC1Oke8clTUzPCokPXCfxfG7iKzka6k7zqNVVGRA8J9nMH
	bGPmNmU3EQY70G8q+g3SZPVHHUkYiuOLAG9Fa/ZwDlXH4nGd3H0DizMdA0qXadzY/oliNrCfbec
	FaVSMcHrPV2qW7tV8KFHGXKc9tIMRIiox0e7x
X-Google-Smtp-Source: AGHT+IFaG5EUEd3w22+15UIe+fR9vs0Mizvgy4uB3bklxmWtpF0mFVHrOZPdEsANkshqajsm1XKOVsyrbwBB5whufrc=
X-Received: by 2002:a5e:8d0b:0:b0:7c4:3b9e:f766 with SMTP id
 m11-20020a5e8d0b000000b007c43b9ef766mr8640816ioj.20.1707753180672; Mon, 12
 Feb 2024 07:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com> <20240212131323.2162161-9-panikiel@google.com>
 <170774854550.294485.3708612918527188826.robh@kernel.org>
In-Reply-To: <170774854550.294485.3708612918527188826.robh@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 12 Feb 2024 16:52:49 +0100
Message-ID: <CAM5zL5r69im5OENJa0drmZ=Er=uMgJJUC_d3FemZaLgq12in0A@mail.gmail.com>
Subject: Re: [PATCH 8/9] media: dt-bindings: Add Intel Displayport RX IP
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	conor+dt@kernel.org, airlied@gmail.com, mripard@kernel.org, 
	dinguyen@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	robh+dt@kernel.org, hverkuil-cisco@xs4all.nl, devicetree@vger.kernel.org, 
	ribalda@chromium.org, daniel@ffwll.ch, chromeos-krk-upstreaming@google.com, 
	mchehab@kernel.org, akpm@linux-foundation.org, 
	dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Mon, 12 Feb 2024 13:13:22 +0000, Pawe=C5=82 Anikiel wrote:
> > The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> > Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> > capture and Multi-Stream Transport. The user guide can be found here:
> >
> > https://www.intel.com/programmable/technical-pdfs/683273.pdf
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> > ---
> >  .../devicetree/bindings/media/intel,dprx.yaml | 125 ++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.=
yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/media/intel,dprx.example.dts:28.=
27-28 syntax error
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings=
/media/intel,dprx.example.dtb] Error 1
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202402=
12131323.2162161-9-panikiel@google.com
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

As with the previous patch, I was missing a #include in the example. I
will include the fix in v2.

