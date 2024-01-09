Return-Path: <linux-kernel+bounces-21381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90752828E65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02811C23D30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C91E3D962;
	Tue,  9 Jan 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXyArfN9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DC3A8E5;
	Tue,  9 Jan 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso27638515e9.3;
        Tue, 09 Jan 2024 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704831213; x=1705436013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri1A4PylPs61GP02N60LyoFg+L+Yu7M2YLplX+7G6Qk=;
        b=hXyArfN9XRb3TpG+A62w8bVZYJLGVNzx0mKBp5JWS42BIFNRgy5bzCjGsET9gpimMP
         bxplGRH/L7bjbIvl4Rxl+PGDzvVo1v0qdEH2VTO1dMd3B3occ4twh6qX2ScMVV/yfjvL
         3xjw4z/JotBwRwrM1CVOX79bBbYe8/Lof5ID4j1cMxP1Mj+6lOCzKb7MreyzUOHMoGXk
         a3wKtegzaN/+OAzFWsucV0mjJLTo1jyaFo3SaSaezuVEF+edLwMAcUnHBH5MnvbadBnq
         pB7v8MFOU7guPfGaSdo9kM50AQbGCvlegTOiRR5gdWmVlTPfd+29X03dRlOXzpvqmBBz
         s/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831213; x=1705436013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri1A4PylPs61GP02N60LyoFg+L+Yu7M2YLplX+7G6Qk=;
        b=B9q/jHofoWHZ0jjKOSHkFmc0Q0Fx+fmIeiUDlJx3vWiT2Punanxzmmt+QO88xYuXAG
         dIcQfS2oD1gQMeLqlDNXaxrINMeLa73Uh83cRMtRKhNIEs8LMe5uFNjuF9OiSfhjKAwn
         L3uWztV3najy1NsafRwiLmfgxVHTewHewq/Ja38Zvz2I8Z+FDRDP50qa+IydAbttMXuv
         1zYwC33TWTa36HR6CtI+xrWS30MrKHmvYQGceFb1kzGzyRYE+Ztk+Yv0Vf2sUl22Ja/p
         6LuEt9+kG5zdnWPAUi0GEpW/wy32uPF8NbuZUcHBW3EIKZlPNwEj8uA1tN7XFf8RMPdl
         V7IQ==
X-Gm-Message-State: AOJu0YxNCm5FR5mC12FVU+vklLXth0BkBU718nddoL6WCkmCFb/+HpcX
	aLbLrd84CAaY7TIPg4hOeuAKY2yI1ZY=
X-Google-Smtp-Source: AGHT+IFWeqJH8v4d6+tnLLqV4BNVKn2y5I5WhwFYoAeVK8N9t53Q9defYknIcJu4v4RiYmRY0DHgYA==
X-Received: by 2002:a05:600c:34cd:b0:40e:44eb:c3a with SMTP id d13-20020a05600c34cd00b0040e44eb0c3amr2112091wmq.31.1704831212907;
        Tue, 09 Jan 2024 12:13:32 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b0040e395cd20bsm15857094wmo.7.2024.01.09.12.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:13:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: anarsoul@gmail.com, tiny.windzz@gmail.com, linux-sunxi@lists.linux.dev,
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: rafael@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 wens@csie.org, samuel@sholland.org, daniel.lezcano@linaro.org,
 peter.griffin@linaro.org, klimov.linux@gmail.com
Subject:
 Re: [PATCH RESEND] arm64: dts: allwinner: a64: Add thermal trip points for
 GPU
Date: Tue, 09 Jan 2024 21:13:02 +0100
Message-ID: <2252115.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20240101000008.65747-1-alexey.klimov@linaro.org>
References: <20240101000008.65747-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alexey!

Dne ponedeljek, 01. januar 2024 ob 01:00:08 CET je Alexey Klimov napisal(a):
> Without trip points for GPU, the following errors are printed in the
> dmesg log and the sun8i-thermal driver fails to load:
> 
> thermal_sys: Failed to find 'trips' node
> thermal_sys: Failed to find trip points for thermal-sensor id=1
> sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

Please no Linux specific talk. Since DT is OS neutral let just talk about HW.

> 
> When thermal zones are defined, trip points definitions are mandatory.
> Trip values for the GPU are assumed to be the same values as the CPU
> ones. The available specs do not provide any hints about thermal regimes
> for the GPU and it seems GPU is implemented on the same die as the CPU.
> 
> Tested on Pine a64+.
> 
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 62f45f71ec65..07963eea1bf0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -243,6 +243,29 @@ gpu0_thermal: gpu0-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				gpu0_alert0: gpu0_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

Since GPU has OPP, can you add cooling maps with at least first trip point?

Best regards,
Jernej

> +
> +				gpu0_alert1: gpu0_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu0_crit: gpu0_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  
>  		gpu1_thermal: gpu1-thermal {
> @@ -250,6 +273,29 @@ gpu1_thermal: gpu1-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 2>;
> +
> +			trips {
> +				gpu1_alert0: gpu1_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_alert1: gpu1_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu1_crit: gpu1_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  	};
>  
> 





