Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA480C585
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjLKKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D5B7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702289065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcYrBNviJmQqeZj6rGf99udo6YED76FBmbtM04WwxNY=;
        b=bWwaAl/Mpfn0ru9q6LgX2CYDqW0ji3q/GMQfjj6DjX5wbrJYhLRa0/zA9Wh8huYHj3mtRk
        C02TyNgZ9YHewLQFk8+b9wI6gR1YtAJfq9FpbUwKdKlyDbiUUEdhJlnPi5USb9TQRCDNE7
        vyNl1qSxZ5LQxjG9TDYTc6i6Pt2yM/Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-HjOd9NEFNGuLDKXzT6GnpQ-1; Mon, 11 Dec 2023 05:04:23 -0500
X-MC-Unique: HjOd9NEFNGuLDKXzT6GnpQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1f9ab28654so10828966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289062; x=1702893862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcYrBNviJmQqeZj6rGf99udo6YED76FBmbtM04WwxNY=;
        b=ksDVF76jUmfMhzipIWv/f8g1pnyMj3cfVngVXG5HO56xPSfG50JLa2dLNrSj8F7hzh
         kYC9gU7MVw8XKIeIPRlgPnkfwxjyAOCqHPDbIt1iGnmYeg4OyIQrc/AyVaWTB6Eig1sS
         tbbeaGmuOMYyO0fe0moQkOTnP93Mt5JiMQeynR482Edx4lUhWIcVCLczt8kRmaa1xf7j
         /nLp1fvSzDUZadcHYyj9n9GMSy/jrHcVw+3N6VvozvdLBOuUmy0ZaGSoKudE+Va+uG0X
         aWoDEb5nF3Z9hK/CtiurLaQ4QPudw5KpxHFEBFUpGYeCCHKO4NwMSbc8mkpSSeVNUYt0
         rfDQ==
X-Gm-Message-State: AOJu0YxKbnGMyGqsYcaseODF/65TPYLC1FhzYuiIAMTUwHHYtU0CG1I/
        bs95Zhfc6JUdaL5zboF0NMcGiJZ2K38YFwJ9uGp0vjJg7p+JYvCiozUY5XxKB8FIOsFEfv/ipjn
        DyLsGiBzsEH7dj1IL+D1rxfc9
X-Received: by 2002:a17:906:598b:b0:a19:a1ba:8cd3 with SMTP id m11-20020a170906598b00b00a19a1ba8cd3mr1553256ejs.113.1702289062367;
        Mon, 11 Dec 2023 02:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdkVKvaLrI4hS/LMA4k4v2r7sUuKXFEknzV28h/dctl37WCkqs5k6ZH/yvWtOvAOLJQGjUlQ==
X-Received: by 2002:a17:906:598b:b0:a19:a1ba:8cd3 with SMTP id m11-20020a170906598b00b00a19a1ba8cd3mr1553243ejs.113.1702289062098;
        Mon, 11 Dec 2023 02:04:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ss20-20020a170907c01400b00a18850d2240sm4661237ejc.143.2023.12.11.02.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:04:21 -0800 (PST)
Message-ID: <175daa6f-5778-4138-afdf-6475c11bfb3c@redhat.com>
Date:   Mon, 11 Dec 2023 11:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: Convert to platform remove callback
 returning void (part II)
Content-Language: en-US, nl
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jonathan Singer <jes965@nyu.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        SungHwan Jung <onenowy@gmail.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <cover.1701726190.git.u.kleine-koenig@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1701726190.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 22:52, Uwe Kleine-König wrote:
> Hello,
> 
> back when I sent a series to convert all platform drivers below
> drivers/platform to use .remove_new()[1] I missed the two drivers
> converted here.
> 
> The two patches have no dependency, so each can be picked individually
> if needed by the driver maintainers. (But I won't say no if Hans picks
> up both patches together :-)

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> Best regards
> Uwe
> 
> [1] https://lore.kernel.org/r/20230927081040.2198742-1-u.kleine-koenig@pengutronix.de
> 
> 
> Uwe Kleine-König (2):
>   platform/x86: asus-wmi: Convert to platform remove callback returning
>     void
>   platform/x86: hp-wmi: Convert to platform remove callback returning
>     void
> 
>  drivers/platform/x86/asus-wmi.c  | 5 ++---
>  drivers/platform/x86/hp/hp-wmi.c | 6 ++----
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b

