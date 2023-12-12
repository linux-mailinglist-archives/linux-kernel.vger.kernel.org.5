Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69D80F574
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjLLS0F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 13:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:26:03 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA8CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:26:07 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so3055420a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405566; x=1703010366;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lX++N5VCWclr3d1h9X3xvVDF9stHF9vZ8hPgWWAfgI=;
        b=HvPC32mnb+MdbR4UEP1U5fnWQsNgvDpbH8YjQao5KPNh0pDT2Xt/OAU6nSmBcuhTp6
         zX9Td4eaawg72dUGYUKHDx0abaQWgNReYP4M/qB7ULaZb5XCWFlAdeLwjcUmiks9yG+x
         wMIUOrkpCZJHPxhhYfRBWpJFmSd/HyPGibYxIUTiib904sS6p+NWwh2c75XqQjDAVOtl
         uxcsd81EC/iAmFdSASU5xl5SNx58VVj/7WQl+W6suOSxU/Mkld75dUkRuCA7UcPCMCx1
         OoNijlXwB6Xb/iFoppwInW0sjg+Eubbj0c69pRw1r0y+ESsYpYl5hQxz0g6b9gin5OfW
         CdBQ==
X-Gm-Message-State: AOJu0YwxdY3QRds8uLK15syt5/pAlvRzAfiRwH+Th1ozAlqp1Qv0sdEh
        9QVlFW6ZgQrCaSZGT60P3S/wIA==
X-Google-Smtp-Source: AGHT+IHXCRJ5ZJEeDDrwJnt6AcXXLGoPeX/dvnSsoC0qb9tX2LLEt4DQy55A5U2kLu55LSGfolR+qA==
X-Received: by 2002:a17:90a:f30e:b0:286:a2a3:1e4f with SMTP id ca14-20020a17090af30e00b00286a2a31e4fmr3120316pjb.64.1702405566516;
        Tue, 12 Dec 2023 10:26:06 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id q30-20020a17090a17a100b0028ac663af16sm1585825pja.23.2023.12.12.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:26:05 -0800 (PST)
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
In-Reply-To: <CX9MMPFL7HAY.NGULD1FN5WPN@tleb-bootlin-xps13-01>
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
 <7hil5odtwl.fsf@baylibre.com>
 <CX9MMPFL7HAY.NGULD1FN5WPN@tleb-bootlin-xps13-01>
Date:   Tue, 12 Dec 2023 10:26:05 -0800
Message-ID: <7h7cljcm6a.fsf@baylibre.com>
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
> On Sun Nov 26, 2023 at 11:36 PM CET, Kevin Hilman wrote:
>> Théo Lebrun <theo.lebrun@bootlin.com> writes:
>> > On Wed Nov 22, 2023 at 11:23 PM CET, Kevin Hilman wrote:
>> >> Théo Lebrun <theo.lebrun@bootlin.com> writes:
>> >> The point is to signal to the power domain the device is in that it can
>> >> power on/off.  These IP blocks are (re)used on many different SoCs, so
>> >> the driver should not make any assumptions about what power domain it is
>> >> in (if any.)
>> >
>> > On my platform, when the device is attached to the PD it gets turned on.
>> > That feels logical to me: if a driver is not RPM aware it "just works".
>>
>> It "just works"... until the domain gets turned off.
>>
>> > Are there platforms where RPM must get enabled for the attached
>> > power-domains to be turned on?
>>
>> Yes, but but more importantly, there are platforms where RPM must get
>> enabled for the power domain to *stay* on.  For example, the power
>> domain might get turned on due to devices probing etc, but as soon as
>> all the RPM-enabled drivers drop their refcount, the domain will turn
>> off.  If there is a device in that domain with a non-RPM enabled driver,
>> that device will be powered off anc cause a crash.
>
> OK, that makes sense, thanks for taking the time to explain. This topic
> makes me see two things that I feel are close to being bugs. I'd be
> curious to get your view on both.

TL;DR; they are features, not bugs.  ;)

>  - If a device does not use RPM but its children do, it might get its
>    associated power-domain turned off. That forces every single driver
>    that want to stay alive to enable & increment RPM.
>
>    What I naively expect: a genpd with a device attached to it that is
>    not using RPM should mean that it should not be powered off at
>    runtime_suspend. Benefit: no RPM calls in drivers that do not use
>    it, and the behavior is that the genpd associated stays alive "as
>    expected".

Your expectation makes sense, but unfortunately, that's not how RPM was
designed.

Also remember that we don't really want specific device drivers to know
which PM domain they are in, or whether they are in a PM domain at
all. The same IP block can be integrated in different ways across
different SoCs, even within the same SoC family, and we want the device
driver to just work.  

For that to work well, any driver that might be in any PM domain should
add RPM calls.

>  - If a device uses RPM & has a refcount strictly positive, its
>    associated power-domain gets turned off either way at suspend_noirq.
>    That feels non-intuitive as well.
>
>    What I naively expect: check for RPM refcounts of attached devices
>    when doing suspend_noirq of power-domains. Benefit: control of what
>    power-domains do from attached devices is done through the RPM API.

I agree that this is non-intuitive from an RPM PoV, but remember that
RPM was added on top of existing system-wide suspend support.  And from
a system-wide suspend PoV, it might be non-intuitive that a driver
thinks it should be active (non-zero refcount) when user just requested
a system-wide suspend.  Traditionally, when a user requests a
system-wide suspend, they expect the whole system to shut down.

On real SoCs in real products, power management is not so black and
white, and I fully understand that, and personally, I'm definitely open
to not forcing RPM-active devices off in suspend, but that would require
changes to core code, and remove some assumptions of core code that
would need to be validated/tested.

Kevin
