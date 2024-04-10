Return-Path: <linux-kernel+bounces-138331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1C89EFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA991C20825
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98B159211;
	Wed, 10 Apr 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aNDYDSLL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47D13D60C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745157; cv=none; b=QPahsETzb/8MLQBcpnO36Aelm9r67O7UruXDCE2dAkmzlH3+z+unJNhaNy57xH8jG3JbID9QMBTqff/W/NF991MNA3C9HkWo+7RzlDhexLWYrc3bAzzxJwugpDUwZiBw5sCJ68ZLb1HV1CBFcSTS5wn4hj2HedyjL0O0Y4gKmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745157; c=relaxed/simple;
	bh=m3Nofq8nnTcdPA9w3dqHCTAf3BKyCsncf1j3teeV6vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py2BQtKpyyl39617fBW3U1uAldSfq0iJcdi4vKX8hIMJ/x/taYQ3HMyTxlNh9m7UoiYAju9ovZadICE2e0ZGtCnmdfH2NfwaLKiCeDDir0M1EAjJbH8G13bXYa0pK0UmuDpRyAdyZpq2FBW1a2vKL5x6c4EqsNjkv1mZAj1WyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aNDYDSLL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5213f0f85dso33308866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712745153; x=1713349953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MEcCmEoW0htF0gEeNXuNZYs1zBV/uinaZ06hXC1M6g=;
        b=aNDYDSLLfCTAgvaHBy944SZdfJJ/oK5nG2BfGvAFYVx9e0rqoiF8y3q8A7/mPD/U7h
         4aZm29P6seTzqGwoptdyM4hqELLkAid61QvfauafhWwwR4Dn/cx2LFdk/69v+kndN6VX
         j0E6iGeLS3NOmRUrCuex+MTuwSmFEToV5/JLUipSm5cXhxNFI/NeViATN+7/U0vaoqvI
         1Lea5H2wXGAUcZHva8+R8tZ714Q/rv7u5TUjL1HAM0G4K8YILXaRIkMuZ8HsPoJE3rO7
         SPY3pdaiClgHdzGSmdGvoqBr/VCVbl+c7JgFSB8yt8oNY2b6MSHZ9M0liUSZIb3oO9ec
         NCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745153; x=1713349953;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MEcCmEoW0htF0gEeNXuNZYs1zBV/uinaZ06hXC1M6g=;
        b=glYNXl3e6pI4NBK/QrzuP9oESvBHx8+s+A/9CkCGIrohPu/dvco0mPlYeCrV09lr05
         xZCen79SDvARWz7PQDpoHT4199PwYLV0qtThpenykMtEhSynZU/eDYhmtWmwtTPThRHl
         CgUV2c3PGxduR0DWSwLbMevJTr+AWjDTMOtG3a999v7QPKYPsvPw5pnt9FPhGEcI7jiP
         wxhH7xZimRpQ5vWhumRJBzLZMs+StSR2AiBldEjRO8QdJTQ3CSZfrVYBm/BDrVcxwifY
         bM3ydFT1v0EO8AAYOyra2d86/ACiKZW89VyAWZa8XcdzSIGijC2sbouv3CS197/mAJW6
         aWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU55oeuM/kUxH7ikj41wimjybiDaN3y8XY7U3yJSmgfwBFS2WMVPsavmQJV59KhN5FXT5F8PBk60Pqec9FJJErnyhrv/h2enbMbNNAL
X-Gm-Message-State: AOJu0YyGNIiSi2j7jO/RVstU4S9HC/Wd6Py03yDbdSxpbfrFK+SJevvV
	1BAHOavKBH4ASUcg0/TgnSqo389Ow/1xhgoAMXByxijzB5sMOy4deHdobSQA1wM=
X-Google-Smtp-Source: AGHT+IEu+HLG7Hf7fv03wqRzissU4p/7W8RIcsudExySNDSbRbaHSDj+oW8GDZ5KlSNJJ8JMviQLRg==
X-Received: by 2002:a17:907:7e8e:b0:a46:3ce4:5acb with SMTP id qb14-20020a1709077e8e00b00a463ce45acbmr1479637ejc.75.1712745153037;
        Wed, 10 Apr 2024 03:32:33 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id ml16-20020a170906cc1000b00a4e670414ffsm6811000ejb.109.2024.04.10.03.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:32:32 -0700 (PDT)
Message-ID: <58d90c1c-0c3c-4818-9d5c-d0c7661d0cf4@tuxon.dev>
Date: Wed, 10 Apr 2024 13:32:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] clk: renesas: r9a08g045: Add support for power
 domains
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-8-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXQ=m2BJ3Tjt0m8Q_H6dLh62sXjd2EMBTc+kuAwtc5B7A@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXQ=m2BJ3Tjt0m8Q_H6dLh62sXjd2EMBTc+kuAwtc5B7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 14.03.2024 18:01, Geert Uytterhoeven wrote:
> On Thu, Mar 7, 2024 at 3:07 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Change in v2:
>> - used DEF_REG_CONF() to describe register offests and bits
>> - updated MSTOP bitmask for ddr domain
>> - updated MSTOP config for oftde_ddr
>> - kept the same description for gic as the CPG_BUS_ACPU_MSTOP register
>>   documentation in the latest HW manual version is wrong and it will be
>>   fixed; proper description for GIC is located in "Registers for Module
>>   Standby Mode" table
>> - haven't added watchdog domain (was missing in v1, too, by mistake) as
>>   the watchdog restart handler will fail w/o patch [1]; with this pm domain
>>   support the watchdog will fail to probe; not sure what is the best
>>   option until [1] will be integrated
>>
>> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240228083253.2640997-10-claudiu.beznea.uj@bp.renesas.com
> 
> I guess we'll have to wait until that dependency is integrated,

I opt for this option to not break the reset support currently integrated.
I don't have any feedback from maintainers yet on [1], though. I don't know
how long it will take.

Thank you,
Claudiu Beznea


> or use an immutable branch?
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

