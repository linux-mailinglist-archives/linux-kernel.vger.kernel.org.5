Return-Path: <linux-kernel+bounces-155641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47288AF51E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C08D1F21D67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C013E055;
	Tue, 23 Apr 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fW2PF3qo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE413DDAC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892068; cv=none; b=Wzk+DtT5BG1ArGfXL7CcV977LYSWBWnICp3E4oCxD5iHKwvgiL32M36kHedMoRwdzPfe8Kllg+X/v1C83d3N9rp5KGYbJe9W+p7jLaaecLT+a/10mltoQ9WGIDG0NbpblJw2RidrLvJAPNSV20KwiPKZ1FgFfJrc4HAy4u2p1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892068; c=relaxed/simple;
	bh=OAHaHyyh2fhBZH5xqokk86R7KZUiwv6CRGGIa0SBRtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWQWqYdhgpHTUP/svPjN9oNQHlaQSJrgvsleP+2TWHIB25XG+a+kF1QRKmrHR1gkuoGf0tVEnqmGW9r444mDb5xnlyvBU9nZWkNuhO9FnGEH9C9lBf96BHryUht5Qz6sDp5U08fvOYyR3av9wSjhdQlgbOH9XE/hEY5Kr7/Qcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fW2PF3qo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a5b68ed0aso16839685e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713892063; x=1714496863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HfFEhDy7wrc1JJ4JwN66dtF2lU/7GHQL5ceh8i2rCk=;
        b=fW2PF3qoa74jX0ldC2Gm5OVz9ubizI4xKHnylwgv8n8oUrA6mB21P/5OBguxjXAUfv
         SQ8T1oymQZFkwEs+I+Gia1EMjgOBH7VArmIFq6GSVg8qis0Bh/M8zGTi7SRL8tDYsizU
         4aPa7bireHxPPbKzsVqMcOqV0pK061jnU/OAbdksMm/h+S+ZtvE5MsJoXZB3V/Ty38Fi
         vHJalUlmFZ/IeQW2Js8nDPFsBoRLQoEoOGQCMyULZDiPzWx/+URU1OqHUmhVontQFO6L
         ZjrxEdtAoeUTG6C/LOtFxh6ALiqegIuS82pdMGSdE9HRtAR4BijhP2jT9TnIQZ7pT59L
         rCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713892063; x=1714496863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HfFEhDy7wrc1JJ4JwN66dtF2lU/7GHQL5ceh8i2rCk=;
        b=Xlnk1hXohjVjV0FsmzqhgKZ5ZPBj7C+APD9gLgYSioDqsI497ivGRVhsJQWCwwcwJg
         LJNX+4C/AHA+M1X0RJjuX5zBSjjwWO1ZBhDMA+1J+fZOELG/vQZA9GQiBsYnDmyXo+oC
         IP7m7ysTwqIe+eIJFwpXivUjEJCGo82Z1eFCdU8TwqVwJItTHYjpf0TO32uh7+3KN9g7
         bvUUrT2OcCqMpvLSNnIH1w2rcCM07xEDyKeFbyMRGPZQ6yreM+FnFl9D48UiSNz6ykMj
         fCm1TueeotRIAGZLno7oLn1Oq1wBSgUqMDjjavXIEZVfZX/9ZYnoKE3CID/nzxSNBIu1
         Snow==
X-Forwarded-Encrypted: i=1; AJvYcCU/obxM/DpbjNoYBrdFmnpoUvngHtEz6BaKCaPrhreO9B5DpM1TMkqKrFwikAyOZmajFiau1yN9C1Myx8c5pBcnjhaKPpCniV3mIAZI
X-Gm-Message-State: AOJu0YwElrcb1kjzTbpnbCYJ4DM6+cEiP71KnkpHGdJ3fEVbU8xqekQm
	V415TFdicA3rhp7VYkkucgGiBDFyCu9t2pp8LNC60Kb5C5WAYO1dJXeK+f3k/x0=
X-Google-Smtp-Source: AGHT+IEeml7xlDPvKVEJlBPjkyqYO1K/a3UWyW6pbqsDEH7Dp3zHkT8MMXjVjKAP5avnRrImiMosWg==
X-Received: by 2002:a05:600c:a001:b0:418:a7a7:9bd7 with SMTP id jg1-20020a05600ca00100b00418a7a79bd7mr8084322wmb.24.1713892063377;
        Tue, 23 Apr 2024 10:07:43 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b00414659ba8c2sm20996935wmq.37.2024.04.23.10.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:07:42 -0700 (PDT)
Message-ID: <a8730bb5-4f51-4c75-b049-6f00e3de5855@baylibre.com>
Date: Tue, 23 Apr 2024 19:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/18] ASoC: dt-bindings: mt6357: Add audio codec
 document
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
 <20240226-audio-i350-v3-3-16bb2c974c55@baylibre.com>
 <481abafd-33af-44a6-8460-068b4a85d764@linaro.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <481abafd-33af-44a6-8460-068b4a85d764@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 17:55, Krzysztof Kozlowski wrote:
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    codec {
>> +        mediatek,micbias0-microvolt = <1900000>;
>> +        mediatek,micbias1-microvolt = <1700000>;
>> +        mediatek,vaud28-supply = <&mt6357_vaud28_reg>;
> Sorry, this does not work. Change voltage to 1111111 and check the results.

Actually it's worst ! I've removed the required property (vaud28-supply) but the dt check pass.
Same behavior for some other docs like mt6359.yaml

The at24.yaml doc works as expected, then I tried compare an find the issue, without success...

I've replaced "codec" by "audio-codec", according to [1].
I've tried multiple manner to implement the example code, without success. I'm wondering if what I 
try to do is the correct way or parse-able by the dt_check.

If I drop this file and implement all these new properties into the MFD PMIC documentation directly, 
I've the expected dt_check result (function to good or wrong parameters)


+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -37,9 +37,32 @@ properties:
    "#interrupt-cells":
      const: 2

-  codec:
+  audio-codec:
      type: object
-    $ref: /schemas/sound/mt6357.yaml
+    properties:
+      vaud28-supply:
+        description: 2.8 volt supply phandle for the audio codec
+
+      mediatek,hp-pull-down:
+        description:
+          Earphone driver positive output stage short to
+          the audio reference ground.
+        type: boolean
+
+      mediatek,micbias0-microvolt:
+        description: Selects MIC Bias 0 output voltage.
+        enum: [1700000, 1800000, 1900000, 2000000,
+               2100000, 2500000, 2600000, 2700000]
+        default: 1700000
+
+      mediatek,micbias1-microvolt:
+        description: Selects MIC Bias 1 output voltage.
+        enum: [1700000, 1800000, 1900000, 2000000,
+               2100000, 2500000, 2600000, 2700000]
+        default: 1700000
+
+    required:
+      - vaud28-supply
      unevaluatedProperties: false

    regulators:
@@ -88,6 +111,12 @@ examples:
              interrupt-controller;
              #interrupt-cells = <2>;

+            audio-codec {
+                mediatek,micbias0-microvolt = <1700000>;
+                mediatek,micbias1-microvolt = <1700000>;
+                vaud28-supply = <&mt6357_vaud28_reg>;
+            };
+
              regulators {


Is the implementation above looks good for you ?


[1] 
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

-- 
Regards,
Alexandre

