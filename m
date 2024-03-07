Return-Path: <linux-kernel+bounces-95423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB0874D78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A42F281383
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01A1292DC;
	Thu,  7 Mar 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBnm/04i"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85411292C9;
	Thu,  7 Mar 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811243; cv=none; b=tWtUCgZWjqZVAuCGkT5nlAyVMdDNbmG5A+BMVJjxS+BVf/edjjHiddSZhkOI1PV2EoeYeG/xjaewoV1BXravy/8OIObFHCYkWA+2ku3mB9TqYPGcr8DXZGb5so7yLVY7JhJAQMn5EvqqCOC57/nQKbQ6Q6IFvwndpK6j3aCk2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811243; c=relaxed/simple;
	bh=hAnNVuxng4LSmgB7omath/lwpxcgnFxLwdyzrf/Vxuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=he6XSWhqwDjLMi3rEXWfK2kd3C/yFfC6FJxqRZDBQ0KJMFum2343SuwUsqPQb8lGacw0HXQyQmapnjz+9dmSAjHrC7p4BeCIrnVPkAkbS/ft1jeVSITElzqW55yHkgz0bKD1EgKhpF0MBKVkHosW90cLIG9LfKBL/Jy4fznUlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBnm/04i; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-595b3644acbso1058600eaf.1;
        Thu, 07 Mar 2024 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709811240; x=1710416040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfiN71yjEq06kQnKXoFCj8BeAGC6FOe9WVX5nTE06dw=;
        b=bBnm/04iRN4trJXsroWW6HcJ3rndAQ/0jl6J+JKl3tjR2erD+aINzTSOh/WOARVbeJ
         frcFwgUxiDmo04dA03Wl2Nuxx+XFZw+o6nziLUj5oxIDaTfYi1wQBUfdEaDfINQfCpgZ
         4mcNIE/4pwTKavaRh4hzYTJ8bWCDkTyTE6vbjvn9jfm0XFBQCU5bgTU50Uj8N+UrSeCH
         CdEa1RR1KhzTNLdPNFxFZe6HvL+OGJiez2spH1KoPhxRxobxU9YqrW4Q1vGXtO9EVoWm
         Xxpoe2c4ctiGcSwqDwXTEHNtMS9/q611mM8HwrBMmpuQpL4q5oGV7oRVkLJM652ScWF5
         jM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811240; x=1710416040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfiN71yjEq06kQnKXoFCj8BeAGC6FOe9WVX5nTE06dw=;
        b=dSs6LUAON0PViMnUTx1Z/miaxNBhZGsYmKcKu6wVJKWJjV9/Oz15TMRRJCmF00qvfM
         52lV4ln+bpI9cxtKjvrHItxeJptmDvsRYstmRDsFSvCzvkalAN00o0ZPZEBl0GnP4cca
         jZSj3TOPuNm1FfvTOp7xWpG/z4qywQ/aE+HM8RGuV+0u1aezMxSp+O6PTJUKQyimUprh
         viLqmFfmEw8MibQazG65L8oCNhnAIMLZRmSNY5Vm9FPMIiVDTlBawUv85c0kwRJMSjvt
         2Kh4syJhsG5G+Uryuj1v3IJBRWXqC6BFOwEMbFWXTJEOMeJD0YA6zGKSWWm1YPI6TvXl
         Op6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi3zGz+oeDxwuP8JjnqzE6BU9N5eJNfZGKLrc4PaY/0hETjEGp6N7Bm6J3hO19+gcmpIK0QGCLUo80UpwruE1LsEfZzBEQIYPRNN8aFpS7V7VL15X50DE8orugnMAln6tM6S3CFZiPdAzSL2sgKPfoiX3sCZ3wsI4s2NeIc+dieeU7CuQ=
X-Gm-Message-State: AOJu0YwVOzOVAfo/DWv/cPEcEjPqm0OnysyNah3ZSZ0k/CvueKRHKG/w
	Vt3zbu9WqsL6K4fib/gFoRKX92c03bkOGucgVO5k4tT2FiCtOaoBvGEAcjDtLup0adQ5zoLZ5Y6
	i9MawE0RnL12CozHmhZX6VNzbVys=
X-Google-Smtp-Source: AGHT+IF9nU7Bw5OL1UXfJ/VIJjzxqtaiFExqbxtku03iI/6LOpc+8ghFzU/DzqruvQCOJMPRfluToZmoiQqEG5Q3XkM=
X-Received: by 2002:a05:6870:1715:b0:221:3ba2:ffef with SMTP id
 h21-20020a056870171500b002213ba2ffefmr399867oae.14.1709811240638; Thu, 07 Mar
 2024 03:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306201045.1475-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240306201045.1475-1-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 7 Mar 2024 12:33:48 +0100
Message-ID: <CAMhs-H9nFA_HKb=8vj+ZESoNKDM8D9UFQmngX+T0Ntamc=5x0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: dts: ralink: mt7621: associate uart1_pins with serial0
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

On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Add pinctrl-name and pinctrl-0 properties to declare
> that the uart1_pins group is associated with serial0.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

