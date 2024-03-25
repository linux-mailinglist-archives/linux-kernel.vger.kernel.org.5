Return-Path: <linux-kernel+bounces-117823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4088AFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3208E1F663E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE081B963;
	Mon, 25 Mar 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB628KU8"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A181B96B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395022; cv=none; b=SbPnpssDTL4f99f+qREZ+G3uWQaqdw3PI6u84Mtk6XMU23BLytbLiouUVfVCWCkHgvvOgEz08Y0uXzQZIz8SgZrQ3ynm2uOFdG8RQ+HSeJe5xOkuIyy50Y93DwcckLPxnwqXD+D7M/amdxgEqZO7uD2pGU2Kf8iIZgM1k+pmERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395022; c=relaxed/simple;
	bh=uPe8oNZuRjkr6igJ6+uXw4kV5e62kfNMyQsl4UJy4wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKMh+FM7XfLuU/umMQJ0J1TpbhRDecYxS+o5pWPBtxEd2bkMykm8ZFnzqP+s2dc9+Ncr2J1f9veoXCCSH6cRzvc1evOhOoQ/Js2wnjzZ7yp6MiQIzJigQ4gIJVYe/HOe6aKbzun3CAsOYoEPMZRe0hIv9qpJ9VpRkmwdEQwAXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DB628KU8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466a27d30aso586616066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711395019; x=1711999819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jv/1xmcEvOlqaR46UzZJ7st3YBn+EpjWb15LuamGQxQ=;
        b=DB628KU8Ehu9ggev0qLWeo8pkUCof/0j3QCfQQlITdYClelQC6EQz9Vynx+VpDbM1L
         XxtmGpks9ZhImymnFXlkFdTwF/DAezjxscBl4d6SWZnefHrinwnvokflNMM6iSqfeEGe
         RZ/+Es2mNluXUIlpHbSx/3uII1IwuHThjYbxvx8PTjaWyNEMpVX3nuVk7HEip2mEgydk
         TrmiUMplFEfh+QGAK6lhx3zuxM6BHg6padPbF+zpTGo0GYltJdEjPK7ALHkrcL4VeNfh
         pmdB5F9LcIcSYqwsO7pa12r2Gr3PZRp9Fo1m8+Th9LUtOwDN9EuDMYTxPxwCYfRco/5K
         2QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395019; x=1711999819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv/1xmcEvOlqaR46UzZJ7st3YBn+EpjWb15LuamGQxQ=;
        b=p4gt85Bp+6Wj7HsILkTxtpuJ5A2To3M8BkYCzjsfCm37wtDwQXMGOMDJz9ktNkzmn7
         900n48SZt/86Qx9bkt87YVy8Ynk41Te4Vv44MDTpiz2lmEjEX7qzPHJQ7pxu3VcEVJis
         R2cclbG+zr/C3v+d13s97wUwBHO6Sb+Gh2umTtGCc40DBb3owKDQhp/J5XCbcYAJjQcg
         vkwJhDkO5kD4D8Cr9EqG+aRCwTBN3XfcVugAHoDn16Y6KMyeRJ0ottJxEQLXCBwjZJzx
         BQyI+engjB4FZTeXZGRzX8mqETjxFXNHHnwPBWQHeDsKZw5aev8a9YD0Sx6UryqaXX6r
         H/FA==
X-Forwarded-Encrypted: i=1; AJvYcCU95hBRrBhZ9PdKRbBPuHocxdYBm2AXkNLwnIAY35wxthCSCwatMV0ENow7Lta5Fz1ofVRlna/cGiTBFg/bOsgOjuYzwluMfx2DNsRU
X-Gm-Message-State: AOJu0Yyy0T/cy6KYOBviK8fWRBvrF+0zalB12mKkVVR1BWoc2sKw1QjT
	84dXhLQH4NX+1L/dBsuxCTbTyCXO3vlJVABz3FcPjoGw96kg58S2BT5cF5naNTQ=
X-Google-Smtp-Source: AGHT+IGX4/HFcgffUtYMyhp+T40RL1ILiQHYgjsp+MVTbpKOKdEt5DSqzufsE6rQjsLkAFDBctdkkQ==
X-Received: by 2002:a17:907:11cb:b0:a47:35e5:7da0 with SMTP id va11-20020a17090711cb00b00a4735e57da0mr5224303ejb.41.1711395019094;
        Mon, 25 Mar 2024 12:30:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id ao11-20020a170907358b00b00a4a377ee13asm1233822ejc.218.2024.03.25.12.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:30:18 -0700 (PDT)
Message-ID: <02fc496c-caac-4434-8e18-229074733b1c@linaro.org>
Date: Mon, 25 Mar 2024 20:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: wm8974: Convert to dtschema
To: Kartik Agarwala <agarwala.kartik@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 javier.carrasco.cruz@gmail.com
References: <20240325181943.116733-1-agarwala.kartik@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325181943.116733-1-agarwala.kartik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 19:19, Kartik Agarwala wrote:
> Convert WM8974 audio CODEC bindings from text to dtschema.
> 
> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>

Thank you for your patch. There are no DTS users of this binding, so
while such conversions are useful, they have significantly smaller
impact. In the future, please consider converting bindings from active
platforms (arm64 defconfig, arm multi_v7). This would have significantly
bigger impact.

See also:
https://lore.kernel.org/all/6552bcb8-e046-4882-91da-1094fff3d239@linaro.org/

> ---
>  .../devicetree/bindings/sound/wlf,wm8974.txt  | 15 -------
>  .../devicetree/bindings/sound/wlf,wm8974.yaml | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
> 

..

> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        codec@1a {
> +            compatible = "wlf,wm8974";
> +            reg = <0x1a>;

In the future for other patches like this, make example complete, so add
a dai-cells also here.

No need to resend just for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


