Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1547BDE50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377020AbjJINSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377011AbjJINSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:18:12 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA218F;
        Mon,  9 Oct 2023 06:18:10 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 9D7E6120006;
        Mon,  9 Oct 2023 16:18:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9D7E6120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696857488;
        bh=Z7Yqvbh39APR5mYXNo8r7N+vYf3l8uCj6bRMobcDPzI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=i/dMHpZXsmvN7Oh59eybkuyDIcv7X7/PU4M2aV1AIfWekitcETXLgS17tJXX9A3Hw
         iLGwV9wiwWFHnjHmUnqMzGBST6DpeBPuhoZS0LEK+Xk8O7G85AacUC6FYavmZss3cm
         IQDyOERJ3P6K2cF7GwIbPR8m4qd3zl3ZW6cjyNCMW8GCGnQaiypJym5w3JxB527Ol0
         VD+QOuitIprQz1wD3iv3EWpDi1gDxtvGzHxItpk0n0CG/BJ2F39IiNejGRi225gfQW
         ovWjOK3TB+CI6OnYJvCXe9W2wvrMfEEcqXld+kNnFCCOH3rgw/52itoeV6vNDpmvUd
         EFmOiRIx1QJ7Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  9 Oct 2023 16:18:08 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 16:18:08 +0300
Date:   Mon, 9 Oct 2023 16:18:08 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v1 09/11] leds: aw200xx: improve autodim calculation
 method
Message-ID: <20231009131808.lzri7z2nvcmkfuu3@CAB-WSD-L081021>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-10-ddrokosov@salutedevices.com>
 <CAHp75VcntHXe31H8C9GcGhc+HRA-gZjtD=uibMMYN-FS254RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcntHXe31H8C9GcGhc+HRA-gZjtD=uibMMYN-FS254RJw@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180475 [Oct 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/08 23:24:00 #22096719
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:03:47PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 6, 2023 at 7:05 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > From: George Stark <gnstark@salutedevices.com>
> >
> > use DIV_ROUND_UP instead of coarse div
> 
> Please, respect English grammar and punctuation.
> Refer to macros and functions as func() (note the parentheses).
> 
> ...
> 
> >  #define AW200XX_REG_DIM2FADE(x) ((x) + 1)
> > +#define AW200XX_REG_FADE2DIM(fade) \
> > +       DIV_ROUND_UP((fade) * AW200XX_DIM_MAX, AW200XX_FADE_MAX)
> 
> Have you checked if the overflow is _now_ possible (compiling on
> 32-bit platforms as well)?

I suppose we shouldn't carry on about overflow here because the value of
fade cannot exceed 255, and DIM_MAX is set at 63

You can find maximum values of fade and dim in the aw200xx driver
header:

#define AW200XX_DIM_MAX                  (BIT(6) - 1)
#define AW200XX_FADE_MAX                 (BIT(8) - 1)

-- 
Thank you,
Dmitry
