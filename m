Return-Path: <linux-kernel+bounces-101503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B070787A7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46791C219E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E53EA91;
	Wed, 13 Mar 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn0yPUVv"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701093F9C7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334807; cv=none; b=Mq2T18kywJOAT/tJ1jCeDcU6c974epZgXqQvh17LneRZkcpzNhxijkPp6MpNvOizI1EGG/YVkrpRXrbE/W99yY3cQQsxGEtlXxnDa6rIayI2KZ1LRLIdQJ3N0s0eyEpdF1jS7Yad/Tl64gujRRLUQ+NggEHHCJRL+CcrJxcwhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334807; c=relaxed/simple;
	bh=NYgyqqFiV39mFAgcSxb0AZI/YObEOq6N1aJEZZIjX4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duJPUSnaZXVMI4fIA/n6/7m/tL7krbhzkNKr9dTvU0q0DGAwFvl11G3d9pg/m/4O2P1gwhowY2F13x/0AkmwyNg6nsfje04YebgfKl/oaEMsTym+5/i8RGjO9iuWv1CZdo0cyzQxsEHKszP2emK7t8p0mxIqIjGG+HIcI8myPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fn0yPUVv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e1878e357so3760267f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710334804; x=1710939604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GadVxHpn23MSnpKoztAih7onSDFgDZNiJYrqDQ9eGuE=;
        b=fn0yPUVvV8zEoDb9VQ3HSEHYytr41IJagWuzYlhLkZRae5B/IZsmxEQr5lOA7XNeum
         Sd9JWTUtd6lqH/MktDCfbSoUFKDTNrs2db/+XFHiGlCypiKMjbV6EqIcNoyxMvugVJs8
         LtSy1CW9gR2+osKwMjeTYx8GYK785GD+nsRitFvBsdb/rN5jwY/LqdsFRsI04qR9eRRK
         uvqZPTbIp+Rkipzy/IgcAdiGo5WLPjRXScABGsCWJt31OzplI4MplZ2looQ9yAlOQhPG
         T4/Mhl49fPy33vjFvYHBLeaV3EtDYew2eUbUR4VC/eV7929t7QHZMvQ5BOuJPS1gOOFy
         +vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334804; x=1710939604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GadVxHpn23MSnpKoztAih7onSDFgDZNiJYrqDQ9eGuE=;
        b=wFYjW4UnRsU8Rtp9U6VtfGozzYla5RDehicW3TXqDLpC3f8gXq0KeZ/8TV24/gTh2g
         isSKqgEiQkZh3TxhnDOu7dN5fGGVM9sEbD6+9LYMQ0ms5ziiacYZsQrhLH+64FHn01dU
         EDcTQsFEwP16JQfhQLUX7C8HFJepTn04fInHcqPFV5/I+aG+Kct3gM9sBalP5Oz5tP8+
         bZjLPe+dJt8VBL+qwPUfA0rxnh7AUSlaC4gKYgEbnKRtCwBgLZDJDLjhoWjm5KUfC1Gx
         A7WZLzmSJ1Xm2cq1K1wldgddx9C8ibjT3XyutfCmq2YsQJGaX/oHEo6wIhKjL2ZW46bd
         NUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQUllzaxTFQ32IuoaV5N/NQ8Yhu4F3GQsGrgfjn4WJATFvazP2BiSaWcLvPtXxq/foCwI7jS12vjEtOYlgVXQgJJxQE254E2VoGgTZ
X-Gm-Message-State: AOJu0YwG+Rxzuz2WP9bJIinuDY2PImyJ1qvb2njAsukezXPgSVitSXWQ
	h8mHy4N2eR0nvI10mINCmF9RLudwxiKjW9Mtp9gJ3FAKMhQkE6XsUaTpYu31GFQ=
X-Google-Smtp-Source: AGHT+IGZbbSR5gFi4nJkbrs537L1carqSuPrAoTCBUBJy0YJthVxuLANev6cpgy2dy1BNqhd6BC59Q==
X-Received: by 2002:adf:ec4a:0:b0:33d:26b1:c460 with SMTP id w10-20020adfec4a000000b0033d26b1c460mr1547096wrn.39.1710334803652;
        Wed, 13 Mar 2024 06:00:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6083000000b0033e75e5f280sm11589696wrt.113.2024.03.13.06.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 06:00:03 -0700 (PDT)
Message-ID: <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
Date: Wed, 13 Mar 2024 14:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
 Jagdish Gediya <jagdish.gediya@linaro.org>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240313123017.362570-4-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 13:30, Sumit Garg wrote:
> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> Box Core board based on the Qualcomm APQ8016E SoC.
> 

..

> +
> +/ {
> +	model = "Schneider Electric HMIBSC Board";
> +	compatible = "schneider,apq8016-hmibsc", "qcom,apq8016";
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* eMMC */
> +		mmc1 = &sdhc_2; /* SD card */
> +		serial0 = &blsp_uart1;
> +		serial1 = &blsp_uart2;
> +		usid0 = &pm8916_0;
> +		i2c1 = &blsp_i2c6;
> +		i2c3 = &blsp_i2c4;
> +		i2c4 = &blsp_i2c3;

The aliases should match schematics of the board, so I assume missing
i2c2 is intentional, right?

> +		spi0 = &blsp_spi5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0 0x80000000 0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		ramoops@bff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xbff00000 0x0 0x100000>;
> +
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +		};
> +	};
> +
> +	usb2513 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
e.g. usb-hub



> +		compatible = "smsc,usb3503";
> +		reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
> +		initial-mode = <1>;
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_id_default>;
> +	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&adv7533_out>;
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&msm_key_volp_n_default>;
> +
> +		button {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm8916_mpps_leds>;

First property is always compatible. Please apply DTS coding style rules.

> +
> +		compatible = "gpio-leds";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

That's not a bus.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +
> +		led@5 {
> +			reg = <5>;
> +			label = "apq8016-hmibsc:green:wlan";
> +			function = LED_FUNCTION_WLAN;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		led@6 {
> +			reg = <6>;
> +			label = "apq8016-hmibsc:yellow:bt";
> +			function = LED_FUNCTION_BLUETOOTH;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_i2c4 {
> +	status = "okay";
> +
> +	adv_bridge: bridge@39 {
> +		status = "okay";

Why do you need it? Was it disabled?

And why this is before compatible? If this stays, please use DTS coding
style rules for placement.

> +
> +		compatible = "adi,adv7533";
> +		reg = <0x39>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +
> +		adi,dsi-lanes = <4>;
> +		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
> +		clock-names = "cec";
> +
> +		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> +
> +		avdd-supply = <&pm8916_l6>;
> +		a2vdd-supply = <&pm8916_l6>;
> +		dvdd-supply = <&pm8916_l6>;
> +		pvdd-supply = <&pm8916_l6>;
> +		v1p2-supply = <&pm8916_l6>;
> +		v3p3-supply = <&pm8916_l17>;
> +
> +		pinctrl-names = "default","sleep";
> +		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
> +		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
> +		#sound-dai-cells = <1>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7533_in: endpoint {
> +					remote-endpoint = <&mdss_dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7533_out: endpoint {
> +					remote-endpoint = <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	rtc@30 {
> +		compatible = "sii,s35390a";
> +		reg = <0x30>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_spi5 {
> +	status = "okay";
> +	cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
> +
> +	tpm@0 {
> +		compatible = "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +	};
> +};
> +
> +&blsp_uart1 {
> +	status = "okay";
> +	label = "UART0";
> +};
> +
> +&blsp_uart2 {
> +	status = "okay";
> +	label = "UART1";
> +};
> +
> +&lpass {
> +	status = "okay";
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	data-lanes = <0 1 2 3>;
> +	remote-endpoint = <&adv7533_in>;
> +};
> +
> +&pm8916_codec {
> +	status = "okay";
> +	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> +	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> +};
> +
> +&pm8916_resin {
> +	status = "okay";
> +	linux,code = <KEY_POWER>;
> +};
> +
> +&pm8916_rpm_regulators {
> +	pm8916_l17: l17 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
> +
> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> +};
> +
> +&sound {
> +	status = "okay";

Is thi sneeded?

> +
> +	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
> +	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	model = "DB410c";
> +	audio-routing =
> +		"AMIC2", "MIC BIAS Internal2",
> +		"AMIC3", "MIC BIAS External1";
> +
> +	quaternary-dai-link {
> +		link-name = "ADV7533";
> +		cpu {
> +			sound-dai = <&lpass MI2S_QUATERNARY>;
> +		};
> +		codec {
> +			sound-dai = <&adv_bridge 0>;
> +		};
> +	};
> +
> +	primary-dai-link {
> +		link-name = "WCD";
> +		cpu {
> +			sound-dai = <&lpass MI2S_PRIMARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
> +		};
> +	};
> +
> +	tertiary-dai-link {
> +		link-name = "WCD-Capture";
> +		cpu {
> +			sound-dai = <&lpass MI2S_TERTIARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
> +		};
> +	};
> +};
> +
> +&usb {
> +	status = "okay";
> +	extcon = <&usb_id>, <&usb_id>;
> +
> +	pinctrl-names = "default", "device";
> +	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
> +	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
> +
> +&wcnss {
> +	status = "okay";
> +	firmware-name = "qcom/apq8016/wcnss.mbn";
> +};
> +
> +&wcnss_ctrl {
> +	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
> +};
> +
> +&wcnss_iris {
> +	compatible = "qcom,wcn3620";
> +};
> +
> +&wcnss_mem {
> +	status = "okay";
> +};
> +
> +/* Enable CoreSight */
> +&cti0 { status = "okay"; };
> +&cti1 { status = "okay"; };
> +&cti12 { status = "okay"; };
> +&cti13 { status = "okay"; };
> +&cti14 { status = "okay"; };
> +&cti15 { status = "okay"; };
> +&debug0 { status = "okay"; };
> +&debug1 { status = "okay"; };
> +&debug2 { status = "okay"; };
> +&debug3 { status = "okay"; };
> +&etf { status = "okay"; };
> +&etm0 { status = "okay"; };
> +&etm1 { status = "okay"; };
> +&etm2 { status = "okay"; };
> +&etm3 { status = "okay"; };
> +&etr { status = "okay"; };
> +&funnel0 { status = "okay"; };
> +&funnel1 { status = "okay"; };
> +&replicator { status = "okay"; };
> +&stm { status = "okay"; };
> +&tpiu { status = "okay"; };
> +
> +/*
> + * 2mA drive strength is not enough when connecting multiple
> + * I2C devices with different pull up resistors.
> + */
> +
> +&blsp_i2c4_default {

None of your overrides look like have proper alphabetical order. Please
use alphabetical order.



Best regards,
Krzysztof


