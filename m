Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A77BE38A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbjJIOvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJIOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:51:11 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73D8F;
        Mon,  9 Oct 2023 07:51:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23070FF809;
        Mon,  9 Oct 2023 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696863069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jOgIroi+iceWUGJkzAJZdhaJt8sxoVXfGAQv9kuVdk=;
        b=NLU6pUeGGxtOdPdzShVeqEzjjzNJSfum1NtTamhihBpEndp18MGOP6Mxen2fcjy16Xumuq
        2oTcbY0cKKfK5SvP2qabncSayezcFI1bdb84rTeT22ANBjBcSPdDYij+5ZwlrRfGjAoRdU
        2se371nUGJCwoYzrVSWO8aYMbRhGAe0cE1Z+Sy0XkWP0N1FBPQGN3kdWF0Ee+PwYTKNeqH
        4zgTuNJV6gLEE1m4civlQGLZoXg79YTcgrEGPgXmE55snhQUq1X2ZE6uI9fkJ8+ko51JY/
        d0knW2deRZdvXFSjS0grBf8qMLFOU0xS24CkJl+iSch3i57PSWFSnmyS7MPIGg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/11] MIPS: mobileye: Add EPM5 device tree
In-Reply-To: <37d3c19a-4106-45f9-ae2a-99bf41a8bab0@app.fastmail.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-10-gregory.clement@bootlin.com>
 <37d3c19a-4106-45f9-ae2a-99bf41a8bab0@app.fastmail.com>
Date:   Mon, 09 Oct 2023 16:51:06 +0200
Message-ID: <87sf6jc0it.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Oct 4, 2023, at 18:10, Gregory CLEMENT wrote:
>> +
>> +	chosen {
>> +		bootargs = "cca=5 earlycon console=ttyAMA2 ddr32_alias=0x40000000";
>> +		stdout-path = "serial2:115200n8";
>> +	};
>> +
>
> The bootargs should not be needed here, at least most of them:
>
> - no need to set both console= and the stdout-path if you have
>   earlycon support

OK I keep stdout-path.

>
> - ddr32_alias=0x40000000 sounds like something that should be
>   part of the dtb elsewhere and not require a command line argument.
>   I assume this is needed to even build?

I will answer on the other email but in short I agree.
>
> - For cca=, it looks like this is intended to be autodetected from
>   the c0_config register. Does that not work for you for some reason?

Indeed I checked and it it nost needed anymore, it is already set in
cps_smp_setup. I remove it.

Thanks,

Gregory

>
>      Arnd

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
