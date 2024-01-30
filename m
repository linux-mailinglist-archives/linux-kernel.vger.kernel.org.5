Return-Path: <linux-kernel+bounces-45166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B153842C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA91C2474D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E827AE7C;
	Tue, 30 Jan 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMh2DS97"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D97AE71;
	Tue, 30 Jan 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641590; cv=none; b=SgbFjvH4L8i9QkDn5FpzT1ofVIbryx4hcCv/coeoP09bE7iOLxRWWOKIOuCZbTh6rwhw2nXGc07pi9EXtn9vVsNa73/flAS6VFra2bbSGZ2VXwzzRkHEtIIrrclqDBytRNHm+0Zk8w4YamC2xgBMMFueIEPayY10wVDsdZg19kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641590; c=relaxed/simple;
	bh=VksIfXIm5eursDB7QN4BdU+LKTo1rpEED6YZzJNhrl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNvISC6ogYgJYubonVn9u0Ld7EVK3THEssIcWA4QqwSJ5ARPmp/5RUaT1IKVdpj8zEBU1HqfJutxN5u/XRPj2YgeAx9/Ww6vfrCQyJRkU8y3NntYTqWG26p/ze/yO71y8Ro3hgdkP4BXO0xrkgumPGBdODMkHojLq66ekOyNkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMh2DS97; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0600551ebso8541301fa.2;
        Tue, 30 Jan 2024 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706641586; x=1707246386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz5R8751++TIGV14CPH1BLDMs2sQzf7EuaPw8ShjZjA=;
        b=EMh2DS97//CiG1KD19JajsI7D7a3QGjCioQYJiNq/Xwj6pENiz+SoyesqfL2+4kIUN
         seDkGzwR7de7DBjMB4J35Gp2eUqZLIAR3qzsrzG46HxUgMGkryUXHAaqQ6VJV/TJQOVi
         I99TYc/i1dYRVx4scl48ttj/+dREX7UiCOR0QYert/Mr82lM6z1lzU+rf5V00p++6XCc
         kLQYeQRaALueGdgxGwyes/HevEpb8kdEimt3mvspqD6yWyEDCc6iZEGlDwX5tGOhtnJK
         WKo8QijNdH6x2IsXB0fu8I7h6mR0CBYQHKNNym9izV51d43yG7pPujyebruubrY6RuzZ
         siYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641586; x=1707246386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz5R8751++TIGV14CPH1BLDMs2sQzf7EuaPw8ShjZjA=;
        b=TGKhA/xOpC8X0sOmssaACE7cZRS/qml3GduEh6ltFD1/c+t/2RSGk34ewoZKNpEj9z
         2B169M14lI8+y+TZKoPmlTlg4tfFLUBOh+sW6u8ZTbHrQ+HSNc2jgSaePad3zzMYVpUB
         auCRo2Ko9sx1k/8UYDHQgrW06gWJx3jM8BSRHi/nYy7BsgPPFKFEKQX2can0pB/SJw4+
         GhGUeGQ7SmFk0iVaA3HHV6cCcW5SLrnU4AM2b+zNZYpxyhOmjtI2THER14unDoy2IDH+
         815AvrGKbL2Hy88GPj75Sa9De//qAVZJm5PoxCgOZt6ITjdyyn5BLoCCdniD3f/0CEkD
         uRXg==
X-Gm-Message-State: AOJu0YxKmPqseggLujk6qVfd93i7PEpsr9P3EYMld2IXOCahpxKp8Ivr
	2TA13Fdvffi4JLXd7vVODi1oG82uCUHLpWvIvHKlmV9ta3OP83OLV4VJ+84/
X-Google-Smtp-Source: AGHT+IGq/0kkkMjJWaJGc/t19XDj/mXpEbDzhvS8RC7I4fDvALCvvgcCU8OYgpxN47xLUWQCljOBdA==
X-Received: by 2002:a2e:5c88:0:b0:2d0:5925:7e with SMTP id q130-20020a2e5c88000000b002d05925007emr1970000ljb.32.1706641585969;
        Tue, 30 Jan 2024 11:06:25 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402320600b0055eec69a5cbsm2979933eda.71.2024.01.30.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:06:25 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Miles Alan <m@milesalan.com>, Ondrej Jirman <megi@xff.cz>,
 Aren Moynihan <aren@peacevolution.org>, Chen-Yu Tsai <wens@csie.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH 2/4] arm64: dts: sun50i-a64-pinephone: Retain leds state in
 suspend
Date: Tue, 30 Jan 2024 20:06:24 +0100
Message-ID: <4892315.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20240128204740.2355092-2-aren@peacevolution.org>
References:
 <20240128204740.2355092-1-aren@peacevolution.org>
 <20240128204740.2355092-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 28. januar 2024 ob 21:45:08 CET je Aren Moynihan napisal(a):
> From: Miles Alan <m@milesalan.com>
> 
> Allows user to set a led before entering suspend to know that
> the phone is still on (or could be used for notifications etc.)
> 
> Signed-off-by: Miles Alan <m@milesalan.com>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Where is patch 1 and possibly cover letter? Please resend with all patches.

However, this particular patch is:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 87847116ab6d..ad2476ee01e4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -43,18 +43,21 @@ led-0 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_BLUE>;
>  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> +			retain-state-suspended;
>  		};
>  
>  		led-1 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> +			retain-state-suspended;
>  		};
>  
>  		led-2 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_RED>;
>  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> +			retain-state-suspended;
>  		};
>  	};
>  
> 





