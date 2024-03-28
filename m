Return-Path: <linux-kernel+bounces-122572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175C88F9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C461F28C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9E5787B;
	Thu, 28 Mar 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HeAihEza"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FA53E3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613619; cv=none; b=jSjZMLhTjj5SYES/tGMIEVJhCF0kxt9h8HX8C2rZMT7HdtpnjHTf/9qIZiELfOabWD5FRGmnV1moMWWvyCpK6wEGdYULR0T2KMEIX3b6SlmhQjhB3m/QNCknVS7TlDGq3TstynGHgZQsSygjezM/3G9ZWpL7Bw8eHY/C3l/xv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613619; c=relaxed/simple;
	bh=FIsjauAGW7cliVE71BcA/zerW8wcOHae6w70Q03hE4E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qQOSkKKRXphUcxBhedJDCxPALYCRuhcTn4DuhEjDBVK1rvgzGpCgJHFdA0Okr6lS5wl1CY21ysnXnQflH4Knh2XkJNvEdKNTUH/CeY+oF+FvbwysRSAJ1+CJwOsWfUDIb2YHZEtTuLazM3nJs4itkIxAiCC/tczjyhH2bX8yMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HeAihEza; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44665605f3so69184366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711613616; x=1712218416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0J2u/PeSGTbNqHUWrYyWUQE0q4T+iokgxOojZvQvOGM=;
        b=HeAihEzaZdqOGAP92h3Bw10neraHkhLqMvw4QaMHjJYwv1dnYrGpP2XFW/+K6hwreU
         juWyMxPPjkg6s8iqKC1VbA5r9OlyUIKr52qwqYzikrkYVfWJFpLUiww7mOcbqCiPNMm1
         XGCeA4q4q0ktZVJq2nHoppvkWuJlzQYyBCY8WRJOySwOK454tSlZ/H3Pfv/w9PbSLGLM
         si7IwkbRUkGRy39ocNXpawX7DapylQ6xkuiKB5hywpPbmw9jd3NmKvBAgm4/tBlgkR30
         PwCmjPRMB8AkbVhyHgGeY1ueuI4Qsw0Ca6inu9Mnup0DfBR6Gd7hHMfv63ETNpmkiFKe
         Ee4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613616; x=1712218416;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0J2u/PeSGTbNqHUWrYyWUQE0q4T+iokgxOojZvQvOGM=;
        b=wdz5NhUuBbXsPDATPIIsg5mWngCYYELe2o6L349LzU0Lj7UyfX2joKxolxjjP+I5uy
         2TOFfsp2GeU2dzrI3aldsaq+v5kt5uLs9+xwSqheLI+zrXTdbIlrPBharr7JCle5vibx
         GAsM+o1V3d7j2u5YBDhWAwlAJTLGl1wUlNkBw7Na24Fh1QwnEcag0B3p8/QthOGGzai7
         nO+lFfSTT/f6f+lZiUfxlugAvD8wR5gjUW0FnV2WhaVMbbBwq9ksC8BHmJ1s3t/F7eRC
         24PIMlt5KzuNdw3jDGBZXC/g2/AQfHT5+J1kvs2MLZJHvGujQhlGnTfd74sa9sRcXHww
         XzBg==
X-Forwarded-Encrypted: i=1; AJvYcCU0WPptAhpDbWWpd4YDOUPD0Kv6HkRLwPDHeFnhk3FJhzHBT6y+FSy/djgJerTzO8TkfyRVeOOq6zcGvkGacgMLRu6BgXDIuSPbqsKV
X-Gm-Message-State: AOJu0YxmDarV9Rq/B2huacKiV7NTz2T2IlOkhbXR+iFyCfxVLmkzYvmW
	rWDcRjsLEOAciGwaJt8NW4Q/namwYxCJQZxzzMbrH7lSAet8w7xH1oC8nIz9F9KSOOniueUSVhi
	C
X-Google-Smtp-Source: AGHT+IExOtwPjzyqqfM0LuMiuU1yntcqEig5+uve86nziRlRwPWJTOYkvWhJJ+0LmRyg+izP/ZvXUg==
X-Received: by 2002:a17:906:2b90:b0:a4e:def:f88b with SMTP id m16-20020a1709062b9000b00a4e0deff88bmr1088903ejg.31.1711613615940;
        Thu, 28 Mar 2024 01:13:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709063ec600b00a474c3c2f9dsm454585ejj.38.2024.03.28.01.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:13:35 -0700 (PDT)
Message-ID: <3d3a651e-2853-4b5b-bc8a-6f494250d9c7@tuxon.dev>
Date: Thu, 28 Mar 2024 10:13:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/13] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for writing to PFC
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4bd3b33d-564a-45e0-905c-d0deb52e6f38@tuxon.dev>
In-Reply-To: <4bd3b33d-564a-45e0-905c-d0deb52e6f38@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.03.2024 10:02, claudiu beznea wrote:
> Hi, Prabhakar,
> 
> On 27.03.2024 00:28, Prabhakar wrote:
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
>> However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls
>> writing to both PFC and PMC registers. To accommodate these differences
>> across SoC variants, introduce set_pfc_mode() and pm_set_pfc() function
>> pointers.
> 
> I think the overall code can be simplified if you add  1 function that does
> the lock/unlock for PWPR. See patch 13.

I meant to say one function for lock and one for unlock.

> 
>>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> index 705372faaeff..4cdebdbd8a04 100644
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -246,6 +246,8 @@ struct rzg2l_variable_pin_cfg {
>>  	u32 pin:3;
>>  };
>>  
>> +struct rzg2l_pinctrl;
>> +
>>  struct rzg2l_pinctrl_data {
>>  	const char * const *port_pins;
>>  	const u64 *port_pin_configs;
>> @@ -256,6 +258,8 @@ struct rzg2l_pinctrl_data {
>>  	const struct rzg2l_hwcfg *hwcfg;
>>  	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
>>  	unsigned int n_variable_pin_cfg;
>> +	void (*set_pfc_mode)(struct rzg2l_pinctrl *pctrl, u8 pin, u8 off, u8 func);
>> +	void (*pm_set_pfc)(struct rzg2l_pinctrl *pctrl);
>>  };
>>  
>>  /**
>> @@ -526,7 +530,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>>  		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
>>  			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
>>  
>> -		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
>> +		pctrl->data->set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
>>  	}
>>  
>>  	return 0;
>> @@ -2607,7 +2611,7 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
>>  			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
>>  	}
>>  
>> -	rzg2l_pinctrl_pm_setup_pfc(pctrl);
>> +	pctrl->data->pm_set_pfc(pctrl);
>>  	rzg2l_pinctrl_pm_setup_regs(pctrl, false);
>>  	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
>>  	rzg2l_gpio_irq_restore(pctrl);
>> @@ -2672,6 +2676,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
>>  	.variable_pin_cfg = r9a07g043f_variable_pin_cfg,
>>  	.n_variable_pin_cfg = ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
>>  #endif
>> +	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
>> +	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
>>  };
>>  
>>  static struct rzg2l_pinctrl_data r9a07g044_data = {
>> @@ -2683,6 +2689,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
>>  	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
>>  		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
>>  	.hwcfg = &rzg2l_hwcfg,
>> +	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
>> +	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
>>  };
>>  
>>  static struct rzg2l_pinctrl_data r9a08g045_data = {
>> @@ -2693,6 +2701,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
>>  	.n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
>>  	.n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
>>  	.hwcfg = &rzg3s_hwcfg,
>> +	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
>> +	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
>>  };
>>  
>>  static const struct of_device_id rzg2l_pinctrl_of_table[] = {

