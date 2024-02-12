Return-Path: <linux-kernel+bounces-61906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74085182F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58721F2363A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2323C689;
	Mon, 12 Feb 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HTZvufrO"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA03BB46
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752126; cv=none; b=mWUxzrvQgoC+DNQO+4cQJGzuOvTNzWRUEsWu9kwdIV746E16tYFHqOOgIP7rnj4FD0t7MnNRLPgjqvd+vcYtBgMjZnsSY3SfOqxU77CzPgfWbEfrkZ8PakpJ1yIpfG4HFtge1n3pqvfm9zIxKwIMJOgz2eOO56Osmnrn/LzKEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752126; c=relaxed/simple;
	bh=Zi7JEi6YPgc+JjQ1wS95Usof0AO1kO+ROduLnLywNyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfiELk7p0TTXHuPYUsOY/05BaffRB0+WAeZcgfQUulHA7gLZ4bjSjusYV1pmZesEauKrt0MTy5mSbo/t5CD+L+jeG522+fYqL7cMl5TFDIiuQFUMcwn2giwU0pOq2ghAHFHMOrVfxiYZ9kpy4QIAU7ul8uO1OuP+DO1wR9nX72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HTZvufrO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so2801173e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707752122; x=1708356922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qopyo3g10i5kqlmGmP5yEhAcn5jQx+ngibzauIEWa8s=;
        b=HTZvufrOeMQ2NHCKcQlhOG7CmW0RBs/WKTRNW7KVKva8LVB1yefY1ukoiEPz5f5VaG
         YGhNSesmC4AYmJ8cAUVERy2VmISe1b2tnz++l312Ho+c+xWqW3eVQKYVb/X59A6W/BOH
         Dh3xM9iy8yMgAUrxCqdB4PFEqAjZtJ4MEj092wiqOsd3wuwf47hVQUjMGOKWu8rX61cf
         lPlaiH0IqmtlcFg74Dx+KlDLVoTGVoA+H/ZocC1MjB5ks+YUhoITgm1VtTPIvINRWJnl
         OTUGZLCZgeHV4C2LfMML8YpN7LmWNSKOxfIWVKzBRx41rq+ZTAy87Ik2vNkhDWypW65c
         atuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752122; x=1708356922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qopyo3g10i5kqlmGmP5yEhAcn5jQx+ngibzauIEWa8s=;
        b=DcgStj9QtS+rplpSbXw6zuOa6p8aTd1AuQFv9ipaJJwl4g5mySHmf00muIBcuLBA4B
         P86SlDhXbmNeL5+rG/NXJW3Pfg/6cKhP+wfWwhR8QAa7A/SbQ0+pp4ym7lTTUzCNd21F
         z3fIdww1F7Iwzhb5tnb9SyxzPTJ5odvRrn4lJoDscjlr9Ul6vxSqQ3YtK9ImsLGuZTQD
         lKPD10hjF2HLckXMmG8uGW4tjmKZI8ktVRHD0hDbf/BZe5jXOeD0jozbpIKMGAnjKRFe
         lFwpPbO9vuap8EwYZLFOUyPGQ8+I24ZmYFb4grqqcr+Dwro8KWAaU9zTwnqM4yPmwpRC
         ijmg==
X-Gm-Message-State: AOJu0YxHCFmkNAZJgR4sGb8a6xhWybKZLm+goPktA2bOlEoilT2BQD8a
	ovs8xJ9SN+qO09qTNy0IwQa0SvWdBcrbxOujVqg5w1vG3odAdwEAViZpOO6J/04=
X-Google-Smtp-Source: AGHT+IGYPLbRxjQYQAEy0cR8B7ts9DH2FHbCPQq+MYtBDCF+JI08fz5SYSihtI4W9WJQvPVMQOBowA==
X-Received: by 2002:ac2:46e8:0:b0:511:54e5:491d with SMTP id q8-20020ac246e8000000b0051154e5491dmr5042168lfo.15.1707752121706;
        Mon, 12 Feb 2024 07:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7kYaKMxfMtF+/BEoSwjoRFYEs3PRBZKjKbLGWDDu4ahfEvW5c2l4pLotLeHE+L1D6dIrzrg90GxCN6w+jvkwtejCQt9ek9Hc4mAvMj/HlkTK8WhBOX2+gw3K/fydMsNUeSeWZQxcUyJTYZoZnqlO5VB6j54pcO6IZKcYdaJBAJTSZD0QtNqVuXxFumFnf6gKUusU/3WX/xIAsHwXenCZNjYZKFOlsX0YiOs1tEUVFNUf9WibMDdmgsuW0z8gqfk5HXZgnvBQkAou0FdNHm/YYDW11ieV8YEQGtYVN7GTw0w537+FR0UlCkzjWYoR2bUA0WKSObIW7N3ApyoJc7z05SXZwTh1kV4Q67GZB3U1LGw4tobURIr1s8yLYDxBAEVS2AEBunqeGW2oB68V0iQGqVpjqi3ngvagqasCTfUapapa03sDxbw==
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b004110e8d605bsm1560755wmn.44.2024.02.12.07.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:35:21 -0800 (PST)
Message-ID: <2dab40a5-1e9b-4396-ad97-b2a810ff703d@tuxon.dev>
Date: Mon, 12 Feb 2024 17:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: renesas: rzg2l: Add suspend/resume support
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208135629.2840932-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUG595o8u1kgqW6DxfvBuzKuOPv7XkJhg_GQmnbRui8Tw@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUG595o8u1kgqW6DxfvBuzKuOPv7XkJhg_GQmnbRui8Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 12.02.2024 17:06, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Feb 8, 2024 at 6:59 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> pinctrl-rzg2l driver is used on RZ/G3S which support deep sleep states
>> where power to most of the SoC components is turned off.
>>
>> For this add suspend/resume support. This involves saving and restoring
>> configured registers along with disabling clock in case there is no pin
>> configured as wakeup sources.
>>
>> To save/restore registers 2 caches were allocated: one for GPIO pins and
>> one for dedicated pins.
>>
>> On suspend path the pin controller registers are saved and if none of the
>> pins are configured as wakeup sources the pinctrl clock is disabled.
>> Otherwise it remains on.
>>
>> On resume path the configuration is done as follows:
>> 1/ setup PFCs by writing to registers on pin based accesses
>> 2/ setup GPIOs by writing to registers on port based accesses and
>>    following configuration steps specified in hardware manual
>> 3/ setup dedicated pins by writing to registers on port based accesses
>> 4/ setup interrupts.
>>
>> Because interrupt signals are routed to IA55 interrupt controller and
>> IA55 interrupt controller resumes before pin controller, patch restores
>> also the configured interrupts just after pin settings are restored to
>> avoid invalid interrupts while resuming.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
> In my review below, I am focussing on the wake-up part, as that is
> usually the hardest part to get right.
> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -260,6 +315,9 @@ struct rzg2l_pinctrl {
>>         struct mutex                    mutex; /* serialize adding groups and functions */
>>
>>         struct rzg2l_pinctrl_pin_settings *settings;
>> +       struct rzg2l_pinctrl_reg_cache  *cache;
>> +       struct rzg2l_pinctrl_reg_cache  *dedicated_cache;
>> +       atomic_t                        wakeup_source;
> 
> I'd call this wakeup_path, as the wake-up source is the ultimate device
> that triggers the GPIO.

OK!

> 
>>  };
>>
>>  static const u16 available_ps[] = { 1800, 2500, 3300 };
>> @@ -1880,6 +1938,19 @@ static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
>>         seq_printf(p, dev_name(gc->parent));
>>  }
>>
>> +static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
>> +{
>> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
>> +       struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
>> +
> 
> I think you also have to call irq_set_irq_wake(pctrl->hwirq[...]) here.
> Cfr. drivers/gpio/gpio-rcar.c (which is simpler, as it has a single interrupt
> parent, instead of a parent irq_domain with multiple interrupts).

I had it in my initial implementation (done long time ago) but I don't
remember why I removed it. I'll re-add it anyway.

> 
>> +       if (on)
>> +               atomic_inc(&pctrl->wakeup_source);
>> +       else
>> +               atomic_dec(&pctrl->wakeup_source);
>> +
>> +       return 0;
>> +}
>> +
>>  static const struct irq_chip rzg2l_gpio_irqchip = {
>>         .name = "rzg2l-gpio",
>>         .irq_disable = rzg2l_gpio_irq_disable,
> 
> 
>> +static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
>> +{
>> +       struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
>> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>> +       const struct rzg2l_register_offsets *regs = &hwcfg->regs;
>> +       struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
>> +
>> +       rzg2l_pinctrl_pm_setup_regs(pctrl, true);
>> +       rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
>> +
>> +       for (u8 i = 0; i < 2; i++) {
>> +               cache->sd_ch[i] = readl(pctrl->base + SD_CH(regs->sd_ch, i));
>> +               cache->eth_poc[i] = readl(pctrl->base + ETH_POC(regs->eth_poc, i));
>> +       }
>> +
>> +       cache->qspi = readl(pctrl->base + QSPI);
>> +       cache->eth_mode = readl(pctrl->base + ETH_MODE);
>> +
>> +       if (!atomic_read(&pctrl->wakeup_source))
>> +               clk_disable_unprepare(pctrl->clk);
> 
> While you handle the module clock yourself, I think there is still merit
> in calling device_set_wakeup_path(dev) when the clock is kept enabled.

Ok, I'll explore it.

> 
> BTW, is there any need to save the registers when pinctrl is part of
> the wake-up path, and its module clock is not disabled?

Yes, for scenarios where the pinctrl is part of the wake-up path but the
system is going a deep sleep state where pinctrl registers will be lost anyway.

Same for the resume path.

Thank you for your review,
Claudiu Beznea

> 
>> +
>> +       return 0;
>> +}
>> +
>> +static int rzg2l_pinctrl_resume_noirq(struct device *dev)
>> +{
>> +       struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
>> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>> +       const struct rzg2l_register_offsets *regs = &hwcfg->regs;
>> +       struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
>> +       int ret;
>> +
>> +       if (!atomic_read(&pctrl->wakeup_source)) {
>> +               ret = clk_prepare_enable(pctrl->clk);
>> +               if (ret)
>> +                       return ret;
>> +       }
> 
> Is there any need to restore the registers when pinctrl is part of
> the wake-up path, and its module clock was not disabled?
> 
>> +
>> +       writel(cache->qspi, pctrl->base + QSPI);
>> +       writel(cache->eth_mode, pctrl->base + ETH_MODE);
>> +       for (u8 i = 0; i < 2; i++) {
>> +               writel(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
>> +               writel(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
>> +       }
>> +
>> +       rzg2l_pinctrl_pm_setup_pfc(pctrl);
>> +       rzg2l_pinctrl_pm_setup_regs(pctrl, false);
>> +       rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
>> +       rzg2l_gpio_irq_restore(pctrl);
>> +
>> +       return 0;
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

