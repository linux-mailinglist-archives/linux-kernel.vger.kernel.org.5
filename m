Return-Path: <linux-kernel+bounces-96579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F8875E74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD59D1C21C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC594EB5C;
	Fri,  8 Mar 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRdPkaZv"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A52E3E4;
	Fri,  8 Mar 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882866; cv=none; b=si0sEIoYDTxEtsZbaMZY8k2cUSjMcMuTVqOB83iE8pFdIS8BMPildNKictQnMZ6rWP6s61fjuCg1Cs/OpEXUFo/BijGmkHoaFgoecd80qvkXEvm7Mj5Y89rdIrIMBkzrXNkaZ6f9FYWha+75cwooq6y4Og9Jhc/qEDZQNaRIm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882866; c=relaxed/simple;
	bh=5vhvvw4wsccvVvq81YIufdmwfAhppRedWI5++0XVcHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8mMobmK08ispp+focY3LDv6rlYBjSRbkpD4Yt7R1UUwmJ2QOU3Ypb+of7Z0KSicNMmA9E1jIbws3cRTLMzfh2dKxv9G8y8PtCMIcFPHCZi8IE8nGYE+EF/TSSvuJEOmgoCVrQCmh4YvR5+8DHU+TdTugO6Fz3u6qmUMIcaJRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRdPkaZv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22008177fbeso867357fac.2;
        Thu, 07 Mar 2024 23:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709882863; x=1710487663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG+xQGmZjeb7VMZJeCb/pkjMl5CuSkW5IR7fRNg07Ho=;
        b=XRdPkaZvarSXmfLBB50OPYmsa6O34eRx3HfgqG7VS6WGMnXHFTYeixfRG64NZXRjZb
         rEJzEBZEwKXZx7MKc5hJ2DfL7vl+TLqkKkMadZDwCv1IytmwaoqOWhujPdxFONnU4f4o
         75aTQDlLJbFA8f9952Rvh/sSGckiPBlXjBoY+kdER0ElSEj03j944/fxcSNd6NxHxiC3
         G9zxmVXAj0ELqEeDXOtjRRc3jVgUOW2bFo03Zaf4tV+9hOcxhXqq3kvdXeQAPtul8K/I
         RDB+tc6CusT0AgQsItg5ojJ+MnKETv0m69ldqR1WxeAlgFCTRS72VQnabrEYJnWjpBpN
         FqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882863; x=1710487663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG+xQGmZjeb7VMZJeCb/pkjMl5CuSkW5IR7fRNg07Ho=;
        b=YfVRpPtFV20+f6UKPqxYOq8uxMByXUsuX+fnhhL+HGNT6AG7CzuYItRlZNT+9KaSZ7
         7WVGTJKmYeekhx1zncTEQqY+782vVcUgqchpo5Qpwl3mTOFxdHV0wSoCkL+X/VPSivCc
         hnQYlGEOL7FAefc0hsIRLZPTRlzAnQczC1ZGwI0r0zQIm1fJVb8jhgp6UXEGfoKNO5Rl
         LoDLnmIxeUUIy+r5FVBlwY/G/7FnlSspsGWWfjZZ9C+mEnQMy+VcFnu4c9uLV9cpsTh2
         vHm7ubRD2f76IQEeYNFNWWNFHeqDNvihwz11gpmyvDspSRwg3A2SgeINRtEVg6gxiPtU
         CbLg==
X-Forwarded-Encrypted: i=1; AJvYcCVic0ZB7eKP/Wt5gMvzUZhpEeCe6XfdLAv4yeb3foFYb2hw+my9/TyeikRkKO7CsAf/K5zD8i2fpOVJvQOcFGcmQOEkNVmvKuSnr0IBMfMvvMmotzsQ6wtnLWkxdbkIwqnp2JNu17bj2pjwXq/UQErhKzWdHVMwTgDN7m/0xxUTwr8GNXg=
X-Gm-Message-State: AOJu0YzUJ4XCSXw3VcTlT7CsddNd85UnJ3TNCJfC18hcSTqgpgsAf/yc
	QHe13xzcNPE9h2JI78ohbKTlKUAU9elH0Mh+40o5qxf540uig8gamfpU1mqVt0YJLMV6YU37GV+
	bjrZgIugbIj/4qP1JFeWuQtE46K8=
X-Google-Smtp-Source: AGHT+IHpDW+Mjc9hOrkKCdTn6Fn9WDpnVluwyApXOAVMal2VWHjOAcRX9Awal8j3U/IOsrvPoIGUIvda6AP8ayCtYbo=
X-Received: by 2002:a05:6870:d620:b0:221:85fb:cc0c with SMTP id
 a32-20020a056870d62000b0022185fbcc0cmr2414620oaq.34.1709882863630; Thu, 07
 Mar 2024 23:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240307190408.23443-1-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 8 Mar 2024 08:27:31 +0100
Message-ID: <CAMhs-H-qHGEpjJqMu4J2SxBo1Sq3+yy74v-j=oH=P9sSt-19zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
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

On Thu, Mar 7, 2024 at 8:05=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Add missing pinctrl-name and pinctrl-0 properties to declare
> that the uart1_pins group is associated with serial0.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/r=
alink/mt7621.dtsi
> index 35a10258f..dca415fdd 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -123,6 +123,9 @@ serial0: serial@c00 {
>                         reg-shift =3D <2>;
>                         reg-io-width =3D <4>;
>                         no-loopback-test;
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart1_pins>;
>                 };
>
>                 spi0: spi@b00 {
> --
>

 Please add Acked-by/Reviewed-by tags when posting new versions.

Thanks,
    Sergio Paracuellos

