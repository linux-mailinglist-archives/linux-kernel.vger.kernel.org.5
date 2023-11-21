Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10317F36B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjKUTOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKUTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:14:05 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1675210C;
        Tue, 21 Nov 2023 11:14:01 -0800 (PST)
Received: from [192.168.1.103] (178.176.72.255) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 21 Nov
 2023 22:13:52 +0300
Subject: Re: [PATCH 12/13] net: ravb: Assert/deassert reset on suspend/resume
To:     Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <p.zabel@pengutronix.de>, <yoshihiro.shimoda.uh@renesas.com>,
        <geert+renesas@glider.be>, <wsa+renesas@sang-engineering.com>,
        <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <mitsuhiro.kimura.kc@renesas.com>, <masaru.nagai.vx@renesas.com>
CC:     <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-13-claudiu.beznea.uj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c9f68819-7dc0-3035-4bf4-6bda5dfc621e@omp.ru>
Date:   Tue, 21 Nov 2023 22:13:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231120084606.4083194-13-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.255]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/21/2023 18:58:14
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
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.255
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/21/2023 19:02:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/21/2023 4:18:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 11:46 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> RZ/G3S can go to deep sleep states where power to most of the SoC parts
> is off. When resumming from such state the Ethernet controller needs to be

   Resuming.

> reinitialized. Deasserting the reset signal for it should also be done.
> Thus add reset assert/deassert on suspend/resume functions.

   Firefox' spell checker trips over deassert[ing] and you have |de-assert"
below:

> On resume function the de-assert was not reverted in case of failures to
> give user a chance to restore the interface (e.g. bringing down/up the
> interface) in case suspend/resume fails.

   I'm not seeing us reverting anything on the resume failure...

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
