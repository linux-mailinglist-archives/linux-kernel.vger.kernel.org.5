Return-Path: <linux-kernel+bounces-84618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF586A911
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74741F25632
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E89250EC;
	Wed, 28 Feb 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVMGQqm+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE22377D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105932; cv=none; b=XDTck+Iuy5jsZOnbYqUWpXQB0npSRBvwhThXpcp4PjYXutPljiv39QuuhgZvOL4exr0byQqgXb7HYXGSAGOs0p0q21jaYJU8MMI6AZqHnngEs7IwV/v3IajVCZN4DUjKszeTiFYseksI2OYZL78UTsubZDK3ufnyIg7zlc+OR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105932; c=relaxed/simple;
	bh=MN3H4hcpIMAhfIiof9A5/DPHibtp2BQcEwHg0xeiexU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj1NGy4oo8k/yi1iLfbZUdPD7QnY7o7PkBZnDXepnt84ZblVdiZX6meNIEfzFx0OIFFxDWEZI4CQg1by5ta9L/ACbtJ9NJ3sbQC+/YM9eBBj+ztQ2DLHz4URM3Pq0ONDQ/K3H/Xv8ezbBDB5POBggEQOMDMwDIuL2Ud/s0WIVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVMGQqm+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so712073766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709105928; x=1709710728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFDFmfRdGSmLKClcFnQLjTuBL81odH/d8qA/QW3EdPg=;
        b=hVMGQqm+MLzjD+GuLJqJ1pfnAf8KWdjyPjj5d5eLhCHhvQcDQydR7QgWf/SnALl/cG
         qKVDv2MzTjJA6zJ3C8Dx5/ITGv1mxroJDvY/rHkuLXJtKEEKmQRw3paA5U4IwwPeXiNG
         CBHQC+30O68d2qszEdAaIb5y5ra+awEdcRnR7jzaSmJ9IO4WOmJ6msrzaS4e4ULIPadm
         haCQIPkt7MId/3FIYzSqKd0swzbIzVkg2K4dnQHq94TmAO/oIS5UWAEgOq7B52kg2NfW
         z7K/W87fBtrCXKfzb5axFemd39bDQEn1CuCgX9x5xBqcpy0Bjl/yZp4y8CGSjmSmWT6d
         nM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105928; x=1709710728;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFDFmfRdGSmLKClcFnQLjTuBL81odH/d8qA/QW3EdPg=;
        b=ZnZ62zNv8I/liUKiqeiGJ/TugaeTdGvKWlSEKrDMZ3V5nhb7gkNSo8UFa9Ls3d/IDm
         PuzZQ58liXmB/19vxR0z27e3dPgKsDQwbzMSJzBWtzNT/V1twKGTzc8/lR2JwzixKaXO
         9ChUtxKOJf2XqwZprddqNRNbncJXaD4mPuzbxNL+Ai+vqufb7E0Ar8K69FIRyR8Vw8sv
         E1R2wLt8fyFOzuHbV7s2asaYzCZ0QTSzPUnf/jz3lXeSUJOObnQ+Mka4lVHeVLmUpsSk
         Z256nVk8ND4lNjdhsamM/Bf4iGKfonfOP5xSQ+bE9TGgtx3Jr54ZYEEZyjPP1/VMP0at
         lzog==
X-Forwarded-Encrypted: i=1; AJvYcCUV050IKTMdlhf0dLcdEMv5M2TUGGJEnvunxzzM67RX8t2+Dl1z9+L2wkSP9Ub6tOlJbyeCIpllGOXFhAiKBLhEHGp9095nR+LH0TcE
X-Gm-Message-State: AOJu0Yy/fnwUtc6nEobWSAy+8FmHNjF7WqLxfQ+uYAoNPkHNgSDPqIJQ
	9z+LGIRzTUHPEnKFOt/veH4y4iwBdQZ1K7AkSzT3o4ogXyLR54lRPW3+tbtZT4g=
X-Google-Smtp-Source: AGHT+IGH9qH/FzadbI3MHDZ8b7TlWQx/BAXJ7f8u4dx3pEPI8ZdC59n+ZKgj8r26lDLsvjiE+B5s8A==
X-Received: by 2002:a17:906:c196:b0:a40:a615:a9c4 with SMTP id g22-20020a170906c19600b00a40a615a9c4mr8442965ejz.65.1709105928534;
        Tue, 27 Feb 2024 23:38:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a3edde33e7esm1549493ejc.99.2024.02.27.23.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:38:47 -0800 (PST)
Message-ID: <b0ece5ac-14fe-4831-a413-71225debb1e4@linaro.org>
Date: Wed, 28 Feb 2024 08:38:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
Content-Language: en-US
To: =?UTF-8?Q?Javier_Garc=C3=ADa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, daniel.baluta@gmail.com, broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
 <20240227170400.705862-1-javier.garcia.ta@udima.es>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240227170400.705862-1-javier.garcia.ta@udima.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 18:03, Javier García wrote:
> Convert the Imagination Technologies SPDIF Input Controllerto DT schema.
> 
> Signed-off-by: Javier García <javier.garcia.ta@udima.es>

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> ---
> Changes since v1 and v2:
>   - re-written the subject inline to include relevant prefix
> 
>   - Node name changed to spdif@18100e00 to be more generic

..

> diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.yaml b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
> new file mode 100644
> index 000000000000..ab8f96cc37cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination Technologies SPDIF Input Controller
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>

That's still not good choice... that's the problem with converting
bindings for very old, unmaintained hardware. No one cares. If you care
about MIPS and Pistachio platform, then put your name there. If you do
not care and we cannot find anyone responsible, then your effort has
little impact. Better focus on bindings for actively used hardware.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


