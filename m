Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE87F5A05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbjKWIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:31:37 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC2B9;
        Thu, 23 Nov 2023 00:31:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C720D240003;
        Thu, 23 Nov 2023 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700728301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6UMap/rI2ydYhb+yafCRa1PP8MyOv2Soxy73yxJpLk=;
        b=p3UbL987rz6g+xFTWugAwgcElhdIH12JdApkfMHMDhO/puf08gGx3/MK7RWpzAWv8JwkX5
        ON5Q85womcvX3ncJ0As/2S61P2H9fiiIARaSy1H8lNj4zhWIsX2O1RzgueB7z2t0nBH2Gb
        I+832pY9kRzZghUk4KHiMn23LxiiV9P2Z6SgqshaDZURhyc9TlUs9e2fT1i3bkKOTkJFXK
        77VP1FRWAbWU9zIy75XqxT3HUfgS4gTdgXlXP3KSIZf+xbkTpfU2faE50OAeygVX8sLDi4
        tz7j9KE6H9p9OVXGk9aNMqgv0uCQCQKztX7QzdmHVPes99bExyijPnMRIfjicw==
Date:   Thu, 23 Nov 2023 09:31:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, tobrohl@gmail.com, aalsing@gmail.com,
        Dhaval.Giani@amd.com, xmb8dsv4@gmail.com, x86@kernel.org,
        dhaval.giani@gmail.com
Subject: Re: [PATCH v2 0/4] Extend time to wait for UIP for some callers
Message-ID: <20231123083140e5e75ba2@mail.local>
References: <20231120141555.458-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120141555.458-1-mario.limonciello@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 08:15:51-0600, Mario Limonciello wrote:
> A number of users have reported their system will have a failure reading
> the RTC around s2idle entry or exit.
> 
> This failure manifests as UIP clear taking longer than 10ms.
> 
> By a debugging patch provided by Mateusz Jończyk it is shown that this
> has taken upwards of 300ms in some cases.
> 
> This series adjusts the UIP timeout to be configurable by the caller and
> changes some callers which aren't called in an interrupt context to allow
> longer timeouts.
> 
> Mario Limonciello (4):
>   rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
>   rtc: Adjust failure return code for cmos_set_alarm()
>   rtc: Add support for configuring the UIP timeout for RTC reads
>   rtc: Extend timeout for waiting for UIP to clear to 1s
> 
>  arch/alpha/kernel/rtc.c        |  2 +-
>  arch/x86/kernel/hpet.c         |  2 +-
>  arch/x86/kernel/rtc.c          |  2 +-


Please also copy the x86 maintainers so they know I'm going to carry
patches that may affect them (which I doubt will cause any issues)

>  drivers/base/power/trace.c     |  2 +-
>  drivers/rtc/rtc-cmos.c         | 10 ++++-----
>  drivers/rtc/rtc-mc146818-lib.c | 37 +++++++++++++++++++++++++---------
>  include/linux/mc146818rtc.h    |  3 ++-
>  7 files changed, 39 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
