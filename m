Return-Path: <linux-kernel+bounces-79099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DE861D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4BC1C24500
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AA1148311;
	Fri, 23 Feb 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K/9mnzg4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1E1482E7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719827; cv=none; b=bcYbcy3vUEO/EMq4iwSaFJtIpeuKRe096oQNrWXsx9RyDaMlumT5LsJNTrr+sUX2aMYEdOLZg/vH6E0FXfxCHk2bPM87M5APxw+KqeI2A70wDMY8HhJjcZkuHm+ChrP4IKuTz+uemc1b8gGa0JgMS6ZojkG1KG4HzdrIzcYUDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719827; c=relaxed/simple;
	bh=GAPRdDy0weW+cZabohnm2KVovLxRd2YD8tu+op2thxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boUQE//752j25YG+7kNaqMiNKaZX9w7IynjVC7bNEs+Dx3px8xWTbWl9mikhqoRM2ekOgWOpmg5csV7Cr+lkLN7TIqmbSMCsTt+iHgxLIYKNHm8vbAfeyj8qQRC2YGPojZp5vWDl2idjytWT/7brpdpZkKSQVjy3xd5vrxg7J/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K/9mnzg4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso171034066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708719823; x=1709324623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PufCuNIep49lutmoiIwdjVCU3ra1Yep6/fBx1imRwQ0=;
        b=K/9mnzg4bwTjCd51PyvQUycZ4nPc27ZlX8S8Xz4ncQWkR5x9fH9W7xRlBrEHcMjaCv
         6tDVcGzCh3U75JEROEjFy9IY4TwIyztQ7+7eGFc01jloYOtBrptj70JC1rfoIsEkdn/V
         v5+8+2KPvmAzIhHTI2I0eC2ranOd0uUt8jGY4g9HAjnZCC76fTq96iUVUstgDb9O2R8c
         viTzXwqfCldUncoE9jQEJKQjcumz/gXJmaLxqxtN1p7YO3iwBXOX75W3uJCY3iWgSQrg
         hT6ZaCo867s3YXM2rxFL8R0TNHwUP89lbEjlDmfIksiQQT5omtje2qua/kOMcTOinH/g
         HKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719823; x=1709324623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PufCuNIep49lutmoiIwdjVCU3ra1Yep6/fBx1imRwQ0=;
        b=Q4oXfHJHBLyleo1VdC8m/Dwx4aQCijnRpQm+zkxJybl0rHw58VmeidutKI6mbDadNl
         QjRcAOjOIkaT1dMapk5Wyms33pe1hA319+huZ24lBlImn8twwntvwbuP/LT+TmpjpGL8
         X8bWY+nd/fa9Gpe8m6odQic0YPHkluzqf9792H5nErD8jmd2NIFzPnZKqftpqidP4z6M
         MtN14IekW1SpNiHdHL5dLt11Z+pWFSYgJLf95T5pfa7H1Q9SrKmeSJoMm/rb6ZdKQlyE
         mtuN6SXYTxFGzY/8AM1DBnzPIiHuqQPVDJng3Rhnv2US89+Tc/3qfMa4PITOgkhBwxs+
         tpFw==
X-Forwarded-Encrypted: i=1; AJvYcCVapWXuZ6SiHXr/LFgxllnJaUr1VJxDuk91mtvW44Rft3om0LmjMLYpIXtbGe3Cr1qiUQeQIfceXyZ8PnNWx8gZ/EVCImY+kcKo9v7w
X-Gm-Message-State: AOJu0YwSf6w3vuWK6WFjRCOoYR//00uUPIEKziDI+671ZrlX3jTQmldF
	e6BnGxyKalo8zDrP1YCR/mMGCxZbEdEReEAXfNdMEOsuUV7ic7vIMdKl8SgSo2E=
X-Google-Smtp-Source: AGHT+IECc8sKOWy0lbsXnY1v63WC5QWxaJU7ch/XxeG9NHaa36ucJ1wxAgJ4bphyr2IcF0fx99zhVg==
X-Received: by 2002:a17:906:3709:b0:a3e:8223:289a with SMTP id d9-20020a170906370900b00a3e8223289amr595311ejc.31.1708719823195;
        Fri, 23 Feb 2024 12:23:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a3d7bcfb9a1sm7195828ejb.128.2024.02.23.12.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:23:42 -0800 (PST)
Message-ID: <dcce833f-7bad-4db4-bbaa-60b5838aa910@tuxon.dev>
Date: Fri, 23 Feb 2024 22:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ARM: dts: microchip: sama7g5: add sama7g5
 compatible
Content-Language: en-US
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
 <20240223-b4-sama5d2-flexcom-yaml-v2-1-7e96c60c7701@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223-b4-sama5d2-flexcom-yaml-v2-1-7e96c60c7701@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 11:16, Balakrishnan Sambath wrote:
> Add sama7g5 flexcom specific compatible in DT with fallbacks.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>

Applied to at91-dt, thanks!

