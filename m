Return-Path: <linux-kernel+bounces-116775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A745588AC50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E41B4754E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBD16193E;
	Mon, 25 Mar 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMKOMEoi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6116F298
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360210; cv=none; b=hnx/JwmMm9gBYUrMr3TXApwJOJ5rvjtzQNIJue5fg+ijwbi3/cWpfd99xcsbjIcMngmaT6piKyXOL/kXHb+3HvE1xIiKmLgF+nIFdmt4THQg9sgrRLnhdfULy0LDXD+Dtt7uOWd3Jdk8N1hse8Imr6tDEPTU1dD4UbTCxLeu0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360210; c=relaxed/simple;
	bh=RguhNyq8VKCcqdMobDZ5d8KWbokBDnm4sDXkSJhbkaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hTGxegXj9/fFEOQPtqgyVBFoIHVkt3pCtkOnOzcbGiUWBw5JGo2QI5ESHqLtW1lfbOJDo9p1cWZG4Wdfal4M/HWWIIFFlidZ3oIzFsNOYj1UXQr8U7vjeuvKulGeau5nh0oJ/uZLLRQBMJBI+A2NY2xsMMTD1d9TO3njskUOB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMKOMEoi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a472f8c6a55so328301666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711360207; x=1711965007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAVXzsVvl26kQg1gDZQrqcIA6gVD8tK0rGgKzqQmaOA=;
        b=pMKOMEoivbp9/FKScjJ72xNj4UuqjyHwykaVRHq5z9tJsXuF4KFqopKf0IdT+XtvNV
         cppvkxhnVcdHtqGQA3CRkvVyaBY5ZWRWuJ42dU5nQSZputR0q41iDhGlozzSe+1OcRRh
         wmUeJVGbe35pzVXZ0RqIXCZ+gyUanFO59NACX9siLc9WM3FuDbAsC3FxogbZiW9v8JrN
         CwN/PwgQDoF3tKNTQWrAYcqx/a/p37nBGh1IGIiwhU65VSS2A1FFWkNxPgWiLDJzBAuV
         iMElz3NO3eSZ6q9NF7bct3TriHPLVh/nBYu8Hl7kSYG7BE/V6IfbrNty7l8kPf8iYVQ/
         MqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711360207; x=1711965007;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAVXzsVvl26kQg1gDZQrqcIA6gVD8tK0rGgKzqQmaOA=;
        b=DI5bNdBWggXlb9ayUgDxBwrTWBLkZxpxx8s8n9xMoG3AC/6dTHqaTsEZnq2DZBQk+o
         YJ4c47OB5Zq5lU6c7mnOs8R2zUmQHwvSdNRi7Zd4HSSWTY3eKxFnOcZH1DYaRrXAJZQz
         mfavGbDu1JWteeKbonrepbSPiSKiDi4keRWAe0J1BdGJ1XTc6p0PCP7eGejfaInIF/qZ
         AT9VvHd0GE+DlaESthkIG+LLZa2zpsnzhttMATr0pcNcFFnZzvZ1rS7RsJk5rwT1SZE0
         FtoPEngDTWER0tvTcJfmlIU4LLNbO1diM2ZKpI9fQ2IsFkdoRC0p4imyaRiwhir65pCy
         N1ow==
X-Forwarded-Encrypted: i=1; AJvYcCVDBpKCNRGBMErvrWvHRYa3h4D6G2AZTpX5wEO+oLFHRtjhIvRMShX615n60QKJ8LJV2FpA6YO71EcHitXw3LZOtPH1Ysmg/dZeBQuy
X-Gm-Message-State: AOJu0YzsReXVEVF42LF6IFMxDDoYJBY5PS3PEfmuH3n45tqGcthhsF/v
	PuSb+2skKhg8+tobMre60+vE3NdD+WJwJUso568I152N0Gt9J68t3c3GmdXPR38=
X-Google-Smtp-Source: AGHT+IFdHnqwTXF7AWbNNmY2g7WJshW/L6qIT7jU5SUKjSfolEmDSj+P9BTccpZWBEOh+YFvHtm2Uw==
X-Received: by 2002:a17:906:7154:b0:a4a:33e4:bcae with SMTP id z20-20020a170906715400b00a4a33e4bcaemr1509262ejj.30.1711360207053;
        Mon, 25 Mar 2024 02:50:07 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id qy34-20020a17090768a200b00a4623030893sm2854174ejc.126.2024.03.25.02.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:50:06 -0700 (PDT)
Message-ID: <d55f1809-3977-4942-8137-d1fa1895ddf1@linaro.org>
Date: Mon, 25 Mar 2024 09:50:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt-bindings: add missing address/size-cells to
 example
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325091139.18602-1-krzysztof.kozlowski@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240325091139.18602-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,


On 3/25/24 09:11, Krzysztof Kozlowski wrote:
> Complete the example of recommended order of properties by adding
> missing address/size-cells.  They are not necessary to illustrate the
> style, but lack of them us bit really correct DTS code which might

some typo here

> confuse readers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/devicetree/bindings/dts-coding-style.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
> index a9bdd2b59dca..8a68331075a0 100644
> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -144,6 +144,8 @@ Example::
>  		#dma-cells = <1>;
>  		clocks = <&clock_controller 0>, <&clock_controller 1>;
>  		clock-names = "bus", "host";
> +		#address-cells = <1>;
> +		#size-cells = <1>;

I propose having #address-cells and #size-cells after ranges, because
they are related:
https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#ranges

Looking good:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

>  		vendor,custom-property = <2>;
>  		status = "disabled";
>  

