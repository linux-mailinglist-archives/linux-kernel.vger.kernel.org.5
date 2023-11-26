Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92C97F95D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKZWgJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Nov 2023 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKZWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:36:06 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075311C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:36:11 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ce627400f6so26910035ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701038171; x=1701642971;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uk6RlcgU3djTkE7dMDEVAusZLaNDjC2rMU1uabPfZg=;
        b=Hg2fzvj6Pcim66uv4GTC6gVkSwycZ6W8+OzD1+itNjkpuNA9Oux4rpgzgvc9TpnNMj
         tB7BOoWFliEdju3N4w22FhlrdZp/9UXDXXJad6g9whdMlDgfPCnlcA8sm34UNeGiVnvK
         FpUfBMSEKmvBCXqG0WV4G5ktRaHv3oYnn+EU46V1oa8pskBmdlPmUyBuqG8bt5xOBJEi
         lV9ip0Sqnt8wgH52zi3jsCmkfI5FJAODE2dWThlHVlYLOlqNigkOZGFJYC4CTqvGsEm5
         ZbegTzw3hu572Eq1bA+DR3perCmFNjPqSMxcj6hbxhz1sO1xMFvL/TKRVdhIfA5s7Ot2
         Imaw==
X-Gm-Message-State: AOJu0Ywg09WjBED9rMIZkSj/rrY2wPXId/BvL+hY9bsBy97RycSZ1jWm
        2ZmvNYPK4W1tGx/uESd2pjlVWA==
X-Google-Smtp-Source: AGHT+IE080+WEh7ZsFMHyjajn01nT5LRVtR2puIQ59I0DQVbOQIYpw1BZIiAxR98fBSoj/96zLMB7g==
X-Received: by 2002:a17:902:64d0:b0:1ca:e4b:148d with SMTP id y16-20020a17090264d000b001ca0e4b148dmr8004394pli.65.1701038171313;
        Sun, 26 Nov 2023 14:36:11 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001c452f827casm6856621plg.257.2023.11.26.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 14:36:10 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Vardhan, Vibhore" <vibhore@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/6] usb: cdns3-ti: add suspend/resume procedures for J7200
In-Reply-To: <CX63KP2UPL1N.J9Q344Q06IGP@tleb-bootlin-xps13-01>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-3-ad1ee714835c@bootlin.com>
 <5080372b-1f48-4cbc-a6c4-8689c28983cb@kernel.org>
 <CWZH66HQZNYM.T623ZOEEE0BK@tleb-bootlin-xps13-01>
 <dad980f3-e032-41e4-a1e4-a16a7f45ff95@kernel.org>
 <CX0GOP07I40N.198G7LJ0HYDBG@tleb-bootlin-xps13-01>
 <bdea68ad-7523-4738-8fa1-b670d81a6b93@kernel.org>
 <CX10D9YX1O1C.30PF317AG065N@tleb-bootlin-xps13-01>
 <3e00b2ad-b58f-4b09-9230-683c58d3bb92@kernel.org>
 <CX15J7B8F8HH.1WZ10OOW31X1H@tleb-bootlin-xps13-01>
 <7h34wxfmwn.fsf@baylibre.com>
 <CX63KP2UPL1N.J9Q344Q06IGP@tleb-bootlin-xps13-01>
Date:   Sun, 26 Nov 2023 14:36:10 -0800
Message-ID: <7hil5odtwl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Théo Lebrun <theo.lebrun@bootlin.com> writes:

> Hello,
>
> On Wed Nov 22, 2023 at 11:23 PM CET, Kevin Hilman wrote:
>> Théo Lebrun <theo.lebrun@bootlin.com> writes:
>> > On Fri Nov 17, 2023 at 12:51 PM CET, Roger Quadros wrote:
>> >> On 17/11/2023 12:17, Théo Lebrun wrote:
>> >> > On Thu Nov 16, 2023 at 10:44 PM CET, Roger Quadros wrote:
>> >> >> On 16/11/2023 20:56, Théo Lebrun wrote:
>> >> >>> On Thu Nov 16, 2023 at 1:40 PM CET, Roger Quadros wrote:
>> >> >>>> On 15/11/2023 17:02, Théo Lebrun wrote:
>> >> >>>>> On Wed Nov 15, 2023 at 12:37 PM CET, Roger Quadros wrote:
>> >> >>>>>> You might want to check suspend/resume ops in cdns3-plat and
>> >> >>>>>> do something similar here.
>> >> >>>>>
>> >> >>>>> I'm unsure what you are referring to specifically in cdns3-plat?
>> >> >>>>
>> >> >>>> What I meant is, calling pm_runtime_get/put() from system suspend/resume
>> >> >>>> hooks doesn't seem right.
>> >> >>>>
>> >> >>>> How about using something like pm_runtime_forbid(dev) on devices which
>> >> >>>> loose USB context on runtime suspend e.g. J7200.
>> >> >>>> So at probe we can get rid of the pm_runtime_get_sync() call.
>> >> >>>
>> >> >>> What is the goal of enabling PM runtime to then block (ie forbid) it in
>> >> >>> its enabled state until system suspend?
>> >> >>
>> >> >> If USB controller retains context on runtime_suspend on some platforms
>> >> >> then we don't want to forbid PM runtime.
>> >> > 
>> >> > What's the point of runtime PM if nothing is done based on it? This is
>> >> > the current behavior of the driver.
>>
>> The point is to signal to the power domain the device is in that it can
>> power on/off.  These IP blocks are (re)used on many different SoCs, so
>> the driver should not make any assumptions about what power domain it is
>> in (if any.)
>
> On my platform, when the device is attached to the PD it gets turned on.
> That feels logical to me: if a driver is not RPM aware it "just works".

It "just works"... until the domain gets turned off.

> Are there platforms where RPM must get enabled for the attached
> power-domains to be turned on?

Yes, but but more importantly, there are platforms where RPM must get
enabled for the power domain to *stay* on.  For example, the power
domain might get turned on due to devices probing etc, but as soon as
all the RPM-enabled drivers drop their refcount, the domain will turn
off.  If there is a device in that domain with a non-RPM enabled driver,
that device will be powered off anc cause a crash.

> The call chain that attaches & enables PD is platform_probe ->
> dev_pm_domain_attach. That function takes a bool power_on which is
> always true. In the genpd case, genpd_dev_pm_attach
> calls __genpd_dev_pm_attach which does a genpd_power_on.
>
> Things I've not accounted for:
>
>  - ACPI looks like it does the same but I've not checked. It gets passed
>    the power_on bool argument.
>
>  - genpd_dev_pm_attach early returns with no error if there are multiple
>    PM domains attached to the device. There are many platforms in the
>    case according to some devicetree grepping. I can imagine a behavior
>    difference where dev_pm_domain callpaths handle that differently in
>    the RPM case. Is that what we are discussing?

You're only looking at the attach, power-on phase.  You need to think
about when the domain powers off and powers back on.

Kevin

