Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290C7F6716
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbjKWT0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjKWT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:26:43 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D2BA;
        Thu, 23 Nov 2023 11:26:50 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 23 Nov
 2023 22:26:42 +0300
Subject: Re: [PATCH 08/13] net: ravb: Rely on PM domain to enable refclk
To:     claudiu beznea <claudiu.beznea@tuxon.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <p.zabel@pengutronix.de>,
        <yoshihiro.shimoda.uh@renesas.com>,
        <wsa+renesas@sang-engineering.com>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <mitsuhiro.kimura.kc@renesas.com>, <masaru.nagai.vx@renesas.com>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV=2_h2PW9K7zT3Hwqjdk6D2m_Dd09bqHtifAvVTM7Lrw@mail.gmail.com>
 <a9760bbb-d06d-4914-b0d1-48a224f74858@tuxon.dev>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6d08cf58-f487-052a-e908-8d1a7579053e@omp.ru>
Date:   Thu, 23 Nov 2023 22:26:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a9760bbb-d06d-4914-b0d1-48a224f74858@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.176.78.136]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/21/2023 23:48:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181514 [Nov 21 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.136 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.136
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/21/2023 23:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/21/2023 8:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 8:10 PM, claudiu beznea wrote:
[...]

>> On Thu, Nov 23, 2023 at 5:35 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]
>>> w/o the need to add clock enable/disable specific calls in runtime PM
>>> ops of ravb driver and interfere with other IP specific implementations,
>>> add a new variable to struct_hw_info and enable the reference clock
>>> based on the value of this variable (the variable states if reference
>>> clock is part of the Ethernet's power domain).
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[...]
>>>  static const struct of_device_id ravb_match_table[] = {
>>> @@ -2749,12 +2750,14 @@ static int ravb_probe(struct platform_device *pdev)
>>>                 goto out_release;
>>>         }
>>>
>>> -       priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>>> -       if (IS_ERR(priv->refclk)) {
>>> -               error = PTR_ERR(priv->refclk);
>>> -               goto out_release;
>>> +       if (!info->refclk_in_pd) {
>>> +               priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>>> +               if (IS_ERR(priv->refclk)) {
>>> +                       error = PTR_ERR(priv->refclk);
>>> +                       goto out_release;
>>> +               }
>>> +               clk_prepare_enable(priv->refclk);
>>>         }
>>> -       clk_prepare_enable(priv->refclk);
>>
>> Is this patch really needed? It doesn't hurt to manually enable a
>> clock that is also under Runtime PM control.  Clock prepare/enable
>> refcounting will take care of that.
> 
> I agree with that. I chose this path to not interfere w/ the comments
> ravb_runtime_nop() which I didn't understand. Also I fail to understand why
> the ravb_runtime_nop() is there...

   Looks like it was blindly copied from the sh_eth driver and doesn't (yet?)
apply to ravb...

[...]

MBR, Sergey
