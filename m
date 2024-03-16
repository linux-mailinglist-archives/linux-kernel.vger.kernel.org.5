Return-Path: <linux-kernel+bounces-105216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BF87DAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF466282876
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D41B977;
	Sat, 16 Mar 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK26k/yY"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDD4C9F;
	Sat, 16 Mar 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604201; cv=none; b=ZlZMrx5wbUJ6uHFNBjmMt3Dzq4FirA/CQCkOOJbRW74Wlve1piRd6DMl3lZu9CAKEgjpOhr2xAdJ/WauMh28BJnDzfSwXXV2St/PZzf221lLnpVnKF9nA9HSoaHzzCtFXBD10on3d7UyKvzBEM+CHVHxFN5stHHQUp/e2nwvPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604201; c=relaxed/simple;
	bh=NUPIU7o9/2aqlselg3L51xw7oS8oy1AVYT1rykyPKdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJICIujMjw4Az/ENKeTb9K7HTSa6G4VEGbAqlq9sKnAbo6o+wBNGR8jKsMrk8Mh44Yvvr7alvwn3J+U4nnfZTnoZJfTGvzs7XoCWMMi6WXwxU8/AJlMZTraFTOES91plGIrJ4jYvpAKlUNdznlAousENL9IAnrAQIeRJiIl2c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK26k/yY; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-221ce6cac3aso1761746fac.2;
        Sat, 16 Mar 2024 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710604199; x=1711208999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cck3p2bHkYZmQVnYplpxpScYPbxksZ8gwr6LYvSKs4g=;
        b=CK26k/yYR5rVp5oBxC4QDE4EMOpa6uEH80JFe3YZ/HZk3IFt+Wj2tAk/40iaUFllRt
         V57ZLZ6iOsQwLqbz0CSbdzDCj39fMbjMFHFa8C4BnUOiYAVuZVZlf+49REhnxk8rPfm0
         b7TYsnFlcG7+5lIZcdb5Bz1siPb2Eri5oSPr/tHkIcBgHlLhQRccuiXaNAAzxGSyWWtC
         Ls1aFsLHOoX4YjRSfOFbU4URmXQBwWKXpm2pEONEyT3a9no9UuvjKIwXxfnInmiNVKIK
         GgALD7I9c6uuvcKpLgegw0cYSt4VX4U1e+1NxfTnAT2vyiLvB5gq6uDTFfBOOXCck7BA
         htFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604199; x=1711208999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cck3p2bHkYZmQVnYplpxpScYPbxksZ8gwr6LYvSKs4g=;
        b=GXyES0BD9J3w2C7RfvxeY1+5t52jOoMaNcnAjzG/XLII9xukcHrVImCPILcksHkeyG
         /L6iUYYcCrKi73Ko33AdfNUjD1kaFQKxbfaFap6QauL63AZJw+3RBMyXUIokmGi4uOer
         H6GMLJcpTeRNcwOuzV6ZbaoyBuX3+CGtzDSycnFzW2Ccpno0herXu8rOmY6LPdBT4PGn
         A1rnshhkXraqNzmaUe6QsWLFR246kF1TJxI+a8yv18IJdAfItWP15Ts8VEo/BI4UwIIe
         /D1c5nhVsAnCXQx2n3K24pd3OtpwGb958gsWRzfllHdVj/ALp2C5YHRepyemn/stt9OR
         Rm4w==
X-Forwarded-Encrypted: i=1; AJvYcCXhFg4IxeAQcQfEH7pOHESewQ4IJexLISvLp6LRe3N90CmRIxZv5kENjTvtlwBy+U0k6FskCuYwUw8xlvaCX4rcYaQHlIEKPpiAd1AW/ZdkJNMn8iRkY7Isgp99dE4uHmpgb+l2sWXDsFaTDCFenTaqnJ8sYgMhCvlTpmCCZaYxAaTI9To=
X-Gm-Message-State: AOJu0YymtYwvY7+eu9iyZ7l4TgoNR2eYJAv7sBT0Ky+HvW6pyatQt4sR
	dpdUNEuOdv1xXEY8GdQyyMYakc8spTSDEpEiSGcqWAyo1O32ESe3Ybj3/1VdMCyrKYRTUXxjyDh
	jgDh00Ng4iTn1B07riQSJm0u3nmadh0qb
X-Google-Smtp-Source: AGHT+IGpuhlnnJG0YoQhTHmJ9vL6fGs8Zhjj2Yr1tRmgqae2WvFGnduJnmBncXhg+nKSqKXwsiveXkjy4WkuRSKmNuo=
X-Received: by 2002:a05:6870:e0c6:b0:220:8b6c:80a5 with SMTP id
 a6-20020a056870e0c600b002208b6c80a5mr9500717oab.24.1710604199037; Sat, 16 Mar
 2024 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Sat, 16 Mar 2024 16:49:48 +0100
Message-ID: <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 5:54=E2=80=AFAM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> This set of patches was created with the intention of cleaning up
> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>
> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>
> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>
> Justin Swartz (14):
>   mips: dts: ralink: mt7621: reorder cpu node attributes
>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>   mips: dts: ralink: mt7621: reorder sysc node attributes
>   mips: dts: ralink: mt7621: reorder gpio node attributes
>   mips: dts: ralink: mt7621: reorder i2c node attributes
>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>   mips: dts: ralink: mt7621: reorder mmc node attributes
>   mips: dts: ralink: mt7621: reorder gic node attributes
>   mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
>   mips: dts: ralink: mt7621: reorder pcie node attributes and children
>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
>   mips: dts: ralink: mt7621: reorder the attributes of the root node
>
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 430 ++++++++++++++------------
>  1 file changed, 239 insertions(+), 191 deletions(-)

For the whole series:
     Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks for doing this.

Best regards,
    Sergio Paracuellos

