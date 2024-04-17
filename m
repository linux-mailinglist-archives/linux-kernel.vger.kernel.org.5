Return-Path: <linux-kernel+bounces-148407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77B8A8227
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC011C21E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1613CAB7;
	Wed, 17 Apr 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KTVXFIAl"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046413C838
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353488; cv=none; b=tYbgEZvJrrDtzHPX7H0898ZvLhJQkDuMcSGTC0o3O0fiMoqpu8YFS4FOKNCLhZxyArj04Cm8UkTHltuOqxwbL1mIN2X0j9YftMKLq04cpC8BT0TIz6qGEA2mq0sLGQl/Uhrb+iMzJpxqCwC5uW2to2M2Gux0k9Ku5u6EPcrubX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353488; c=relaxed/simple;
	bh=ue7HaNfGuMBcd8IELoDZIuc6pkVsgBwETDAcj1Na2BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp59m2Ew+/A1uFJSSPUEZ69Gi/E+aA40Muo2DllyIMS2cU8Nzx+5M1l6EcFLSXJpjwQYBHXVj1XHULr82VHwqsprSoMBipaxFxwDY1a4CvKv5MzgA3O5Gm0j9kb8SJk8jGOcqvOY+Ld5q6y21atZhcfSHoXmn6M6Dw9ONbNl00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KTVXFIAl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d895138ce6so65487991fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713353483; x=1713958283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhbEzpd+5Jvj4DXECIuOb3gligK63xwRNnc0JkL5UaE=;
        b=KTVXFIAlzf4Hyztl9wYtLbg8ZPm8JyV06r0DFkNSV+RccqnIiSCsDI+rsNl8Q7tY8S
         obHgAJoQ+Pjkr1aaGYvP97XHhcFtLK2IRcOi98crym9PHxwn5rZV42V8w741s6S2Zvsc
         3m9xCUUGtCOasZFU2Sd9ArtlvR2QHADMk4daKnOko3tJhU14UP4v4vnTeoB03xzCCYjm
         gvtf2v718Oc0HlcY8yVxK96gLVelZHV5P4LQJ0k4ij7T/aBUu9V6m17Hj90bxLzK83bF
         Ro96x90YI48rcLyUMoQde8HhyJOEhHVpmljx1PTp9vrvJxsPWBds+BE7Ns/QhvlyYhsK
         XOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713353483; x=1713958283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhbEzpd+5Jvj4DXECIuOb3gligK63xwRNnc0JkL5UaE=;
        b=SdAHeQQPxfVaFbI12koCWtKvB5vFEXnPPwONPdIGF+uzsVpl2oa1McTd8MGziD9veG
         7jxYPLRXBugLZgQKm2QMeQWk2PgsXnj8+8XVoe1p02Tc68W75O0LKmQgxRqUQmq+LHJG
         3SPJlwLGHAM45UM0Oit/ytQGJJ9iTfgaHIDEJ/nAnXNzBzLXBIdzTDd8qzbH4o2nMkIE
         lKsj59buqBit/9Q85zevTO8Tt7gPD/DVMdw5oc7VTP5eHAcaA/YmaeEUXQIvmT/f5PDL
         EAqh0/w6inD7P6SP8Qxd7S6cZAVCl4J9rPIDr4/+/4vvQdFQ/bVJlQn1PvVwJi4zgGGI
         XmTA==
X-Forwarded-Encrypted: i=1; AJvYcCU/kFMb2N5s9aaeWLCHQP81d67qUQnJ0x72FxiA1bhD9trDcOFRriOyh+UqAxLKuhwaxh6c/8PEtM0sq404OS8wgrGlf+4XJZIhhgW5
X-Gm-Message-State: AOJu0YxsqYZXQ0mWUQ6HMnzCpYMPzGT9pOSLN1wulCEsWyrvfFm5cXfL
	mSca6raApCYpA62RBGjtjNRQjaydOmwooaVI8TRLTfhjHUVJYZ16HTu9z/iJZ60=
X-Google-Smtp-Source: AGHT+IE4dVqP4Kf8EzGbQKqk9XBmoDdnmoZ41w0mgqYFVH4TvBxXIOqrYoZoLakxjgpUjyCD+aOxiA==
X-Received: by 2002:a2e:9b1a:0:b0:2d8:8e1e:e15d with SMTP id u26-20020a2e9b1a000000b002d88e1ee15dmr9686124lji.32.1713353483334;
        Wed, 17 Apr 2024 04:31:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b004187f537394sm2495837wmq.8.2024.04.17.04.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 04:31:22 -0700 (PDT)
Message-ID: <64fccb3a-882b-444f-87d6-9dc5aff42055@tuxon.dev>
Date: Wed, 17 Apr 2024 14:31:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] clk: renesas: rzg2l-cpg: Add suspend/resume
 support for power domains
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFos=FP3GxX+5qAmBpqrR-8Q7MRhhV3HvPAtu2K6x=7XEw@mail.gmail.com>
 <28508184-96f0-41b7-90bc-506d53cedaf9@tuxon.dev>
 <CAPDyKFpQUdq5Rj+Rk-fyPFTLuz6=vt2ovR3MgH3zPQDeKa1u0A@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAPDyKFpQUdq5Rj+Rk-fyPFTLuz6=vt2ovR3MgH3zPQDeKa1u0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.04.2024 12:39, Ulf Hansson wrote:
> On Wed, 17 Apr 2024 at 10:05, claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Ulf,
>>
>> On 16.04.2024 15:07, Ulf Hansson wrote:
>>> On Thu, 7 Mar 2024 at 15:10, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> RZ/G3S supports deep sleep states that it can reach with the help of the
>>>> TF-A.
>>>>
>>>> RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
>>>> Linux is running. These domains are initialized (and powered on) when
>>>> clock driver is probed.
>>>>
>>>> As the TF-A takes control at the very last(suspend)/first(resume)
>>>> phase of configuring the deep sleep state, it can do it's own settings on
>>>> power domains.
>>>
>>> For my understanding, can you please elaborate on this part a bit.
>>> What does the "last suspend/resume phase" mean, more exactly, here?
>>
>> The RZ/G3S SoC support a power saving mode where most of the SoC parts are
>> turned off and the system RAM is switched to retention mode. This is done
>> with the help of TF-A. The handshake b/w Linux and TF-A is done though the
>> drivers/firmware/psci/psci.c driver.
>>
>> After Linux finishes the execution of suspend code the control is taken by
>> TF-A. TF-A does the final settings on the system (e.g. switching the RAM to
>> retention mode) and power off most of the SoC parts.
>>
>> By the last phase of the suspend I'm referring to the TF-A doing the final
>> adjustments for the system to switch to this power saving mode.
>>
>> When resuming, as the TF-A is the 1st one being executed on the system
>> (this is what I called above the 1st phase of the resume), TF-A moves the
>> DDR out of retention mode, reconfigure basic IPs (like in boot case as most
>> of the SoC parts were powered off) and then give the control to Linux which
>> will execute the resume code.
> 
> Alright, thanks for clarifying! This makes sense to me now!
> 
>>
>>
>>>
>>>>
>>>> Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
>>>> powers on the always-on domains and rzg2l_cpg_complete() which activates
>>>> the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.
>>>>
>>>> Along with it, added the suspend_check member to the RZ/G2L power domain
>>>> data structure whose purpose is to checks if a domain can be powered off
>>>> while the system is going to suspend. This is necessary for the serial
>>>> console domain which needs to be powered on if no_console_suspend is
>>>> available in bootargs.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---

[ ... ]

>>>>
>>>> +static int rzg2l_cpg_resume(struct device *dev)
>>>> +{
>>>> +       struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
>>>> +       const struct rzg2l_cpg_info *info = priv->info;
>>>> +
>>>> +       /* Power on always ON domains. */
>>>> +       for (unsigned int i = 0; i < info->num_pm_domains; i++) {
>>>> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
>>>> +                       int ret = rzg2l_cpg_power_on(priv->domains[i]);
>>>> +
>>>> +                       if (ret)
>>>> +                               return ret;
>>>> +               }
>>>> +       }
>>>
>>> I don't quite understand why this is needed? Is always-on PM domains
>>> being powered-off during system wide suspend, so you need to power
>>> them on again?
>>
>> Yes, as power to most of the system parts is cut off during sytem suspend
>> (and DDR is kept in retention mode) and the resume is almost like a cold
>> boot where the TF-A does basic re-initialization and then pass execution to
>>  Linux resume code.
> 
> Hmm. If these are really always-on PM domains, why isn't the FW
> powering them on again then before returning to Linux after a system
> resume?

I'll try to explain it better.

The power domain implementation in this series tries to abstract the
control of bus clock (though MSTOP registers) for individual modules
available in RZ/G3S SoC.

From hardware manual [1]: "The Module Standby Mode is a mode that requests
the clock stop of the module specified by the master. The purpose of this
mode is to reduce power consumption by stopping unnecessary functions."

MSTOP is connected to individual modules as described in this picture:
https://paste.pics/726c963c33a506651a4be5f327e2a46d

There is also the PWRDN functionality for the modules that are part of the
PD_ISOVCC domain. At the time of writing this series there was not much
information in hardware manual about PWRDN functionality. The design team
has been asked but there is no clear answer ATM if the sequence of using
PWRDN in Linux (as proposed in this series) is good or not. I encountered
no issues with it while experimenting thus I have kept it. If you prefer I
can drop it and return with something afterwards, if any.

As I said in the current implementation I also used the PWRDN. The PWRDN is
IP specific but takes effect (as of my experiments) when this is executed:

+       /* Prepare for power down the BUSes in power down mode. */
+       if (info->pm_domain_pwrdn_mstop)
+               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);

As of my experiments having CPG_PWRDN_MSTOP.CPG_PWRDN_MSTOP_ENABLE set
applies the PWRDN to all the IPs for which PWRDN bit has been set in
CPG_PWRDN_IP1 and CPG_PWRD_IP2 registers.

This settings are applied in probe after domains are powered (thus PWRDN
bits are properly set up for IP supporting it by calling ->power_on()) and
at the end of resume (after PWRDN bits are properly setup for IPs
supporting it by calling ->power_on())

From my experiments, when returning from suspend (thus after firmware has
been executed) the CPG_PWRDN_MSTOP_ENABLE bit at register CPG_PWRDN_MSTOP
is zero. We power on the domains in Linux after resuming because of PWRDN
functionality and CPG_PWRDN_MSTOP_ENABLE bit at register CPG_PWRDN_MSTOP.

> 
> In a way it sounds to me that they aren't really always-on PM domains,
> as Linux seems to be capable of turning them on/off too, right?

Yes, Linux has the ability of controlling them by setting MSTOP and PWRDN
bits. This is because the IP specific PWRDN functionality takes effect when
CPG_PWRDN_MSTOP_ENABLE bit at register CPG_PWRDN_MSTOP is set (as of my
experiments).

> 
> That said, perhaps using GENPD_FLAG_RPM_ALWAYS_ON instead of
> GENPD_FLAG_ALWAYS_ON for some PM domains can be another way forward?

All this is becuase PWRD functionality. Explaining it to you made me
consider that it would be better to just drop the PWRDN functionality at
the moment until it is fully understood. With it I think we should be able
to drop the rzg2l_cpg_power_on() in resume(), at least. What do you think?

> In this way, the ->power_on|off() callbacks can be used to turn on/off
> the PM domains, but only during system suspend/resume. Would that
> work?

I need to check it.

Thank you for you review,
Claudiu Beznea

[1]
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzg3s-general-purpose-microprocessors-single-core-arm-cortex-a55-11-ghz-cpu-and-dual-core-cortex-m33-250

> 
> [...]
> 
> Kind regards
> Uffe

