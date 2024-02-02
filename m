Return-Path: <linux-kernel+bounces-49694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A4846E35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088601C250FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958613BEAE;
	Fri,  2 Feb 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FM7izAdq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C62E851
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870860; cv=none; b=kOL3eTGbEQaMO5wNPNi9bioBUjDfTzm209rqDWJc6FKTF1hx2TL8Y07kbPF32cRoftfshW3NS88b1MFWiPcLeMF8SuJBWA0B2HwPy2IifaIRUkx8LeniDyP3kuFnaUkYECe9w6gGL2PunoI0Lr4ZTZPCJoFS27qQz0/19GD3wsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870860; c=relaxed/simple;
	bh=LSSsJDqzQXbyB6BfnijGKEwYUfqo7dNLuEWV+jpgIac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie1HdqJW+hOoWralruccBI/YYqY2nUVRfKiBj0Ugxw9zEZCwSC04ZRp+psJ+Lw/LUNPPmGNyS9lZKA77WvSKNDlzTUaJ0uXleWlHpGQQq7TIbqUYtWJAEmp5BfeXVphGDbDXQw1aRlWh/UVTMIjTURFAUFJgLevUmUyVrgO8k7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FM7izAdq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so2886978a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706870857; x=1707475657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fhIuxllpAaxyqxK5T2xhyFG4S1c7SLPpJtq6VlrHtH8=;
        b=FM7izAdqdhgxHbgwGIXXAbNeM1pQt1Ws3PB+ygQ6OfRP9GPu58FGdL+o6VtzXy7eKF
         N28HAe53WQVdyAp/anHTxdp56BzN76EHmy3ZKF2gHP6SQSsNb26kD1NfqXxHjEhY8RZN
         f2bPl0jXjKweo0OUG+BvQNlyeCXwpXuUg4PczHp2h7GExJ6h81axsZVMz7c7wRVdp0kQ
         SXeaLt8pZUW9zIWBp+DwMiUFK70EyNUPteb/puW+8X7C5yAHMjmdo+OOoA5vjV17P1Ow
         H7LZ4u7D3SqIfKCgx4808uDUN31QiIg3rFYY2xeyugEfz2h3rRBPOc1qbkTyHHy4f8rG
         jpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870857; x=1707475657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhIuxllpAaxyqxK5T2xhyFG4S1c7SLPpJtq6VlrHtH8=;
        b=m6XWB1N7ZMwnn2Ev0Cvwu2DAuDhjDpxInFxdFNYWu/tj8UTVjIbdNYrfwcqss10VdB
         tuhseMTYw90XRPCKVZFfE6xtL7Lvp5GQdhfCVP8QL/vub+g8u1SHbdZBwSsUo6kgTYzm
         KUNhOQK4gAdyHjk907pgGyDkkYGvBt82yMXABQ8vVjUZhsufUbnCo5qpqnrUDbCIUDa2
         kHe1xLDrFEXhWTy4pfX7ot5K8ZmXpaB4KaWvgMma6uy7hOSEA17nAYfaroRss1uEliSw
         RcUNn/mWB8HRbrflfZ7tIPY2HRqaMLtiCSj5Gr/KjK4HqkIxWIYux4lIVpzybR931XOu
         Dr0A==
X-Gm-Message-State: AOJu0Yx3DbwoLzSACrCzw6SFLUtfuTz2fZtIgUwNYJPtG9u/FIXZmCQ1
	DJLNlI8k7QnH65P0evggWxnBM3ViLyHJyBfeQJBxX1d7rWomTCmtDFeHcSM70v4=
X-Google-Smtp-Source: AGHT+IEU9qisjkMXFAaV1+eKi3MeP93DELuSBlTnwYmPWLEJ01uycPBfeebRxxWYeIXmT+G2ShhyBQ==
X-Received: by 2002:a17:906:4a52:b0:a2c:1061:b3e9 with SMTP id a18-20020a1709064a5200b00a2c1061b3e9mr6400905ejv.9.1706870856883;
        Fri, 02 Feb 2024 02:47:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQclJYjubbmiNxLYUciz3CX7GpqZ7k4eJSOlG61bpq5++sxwp7ghpbuMKL4p3OjmPBqNVnA6lFQjhMeX/WZaYMFVrOpsKHPvEVBeqGIQg+0Z8enUvHcM4GoC4cVLoE8G1YL9TNXAHMFRKKfISFK5aMN3CtV+CFBoOm1gZlJR6FC7hCP7kuInYjdDNiZhiAbHcnUyZrvnuDBe0N7gw7NKjw/FNKp57irXbtq0/BlzjgcuKjExnkph/kd1pfUNebIDgwT7TlTkXbylECPpkqBk2TU28je0tqSHrofSUKSEJZDVOcuMQCybgpilRufIcf4795PQXkA3e9oovXaOmG/cI2cTE5ohhro5io51gAYOa5IPDaVg1Jo2ko5vdW5zgjQbmCupNja4ATjj6BdPb0be1/KlKvS9xlJC39
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906085b00b00a359c588d31sm750480ejd.100.2024.02.02.02.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 02:47:36 -0800 (PST)
Message-ID: <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
Date: Fri, 2 Feb 2024 11:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
To: Brandon Brnich <b-brnich@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>,
 Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Darren Etheridge <detheridge@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201184238.2542695-1-b-brnich@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 19:42, Brandon Brnich wrote:
> Wave521c has capability to use SRAM carveout to store reference data with
> purpose of reducing memory bandwidth. To properly use this pool, the driver
> expects to have an sram and sram-size node. Without sram-size node, driver
> will default value to zero, making sram node irrelevant.

I am sorry, but what driver expects should not be rationale for new
property. This justification suggests clearly it is not a property for DT.

> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---

This is v2, so where is the changelog?

>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> index 6a11c1d11fb5..ea5469eb38f9 100644
> --- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -43,6 +43,12 @@ properties:
>        storing it on DMA memory. It is mainly used for the purpose of reducing
>        bandwidth.
>  
> +  sram-size:

Does not look like standard property. You would need vendor prefix or is
it documented anywhere already?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      SRAM size reserved for VPU operations. If not specified, size will default
> +      to zero.

Lack of sram property means 0, doesn't it?

> +
>  required:
>    - compatible
>    - reg
> @@ -58,4 +64,5 @@ examples:
>          clocks = <&clks 42>;
>          interrupts = <42>;
>          sram = <&sram>;
> +        sram-size = <0x1234>;

Was this patch tested? Since nothing changed from v1, I assume it also
fails.

>      };

Best regards,
Krzysztof


