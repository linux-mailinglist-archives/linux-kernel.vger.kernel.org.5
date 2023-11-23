Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7127F671F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjKWTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:30:53 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C59A;
        Thu, 23 Nov 2023 11:30:59 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 23 Nov
 2023 22:30:56 +0300
Subject: Re: [PATCH 03/13] net: ravb: Make write access to CXR35 first before
 accessing other EMAC registers
To:     claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
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
 <20231120084606.4083194-4-claudiu.beznea.uj@bp.renesas.com>
 <c27d5dd1-bcdc-a79e-bf0b-a7e93f5d9545@omp.ru>
 <2545ffad-e970-499e-9192-ff89776e1946@tuxon.dev>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2b1caad5-281b-4284-3ffe-3c50395c6d39@omp.ru>
Date:   Thu, 23 Nov 2023 22:30:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2545ffad-e970-499e-9192-ff89776e1946@tuxon.dev>
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 181514 [Nov 21 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.136
X-KSE-AntiSpam-Info: Rate: 0
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

On 11/21/23 9:02 AM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Hardware manual of RZ/G3S (and RZ/G2L) specifies the following on the
>>> description of CXR35 register (chapter "PHY interface select register
>>> (CXR35)"): "After release reset, make write-access to this register before
>>> making write-access to other registers (except MDIOMOD). Even if not need
>>> to change the value of this register, make write-access to this register
>>> at least one time. Because RGMII/MII MODE is recognized by accessing this
>>> register".
>>>
>>> The setup procedure for EMAC module (chapter "Setup procedure" of RZ/G3S,
>>> RZ/G2L manuals) specifies the E-MAC.CXR35 register is the first EMAC
>>> register that is to be configured.
>>>
>>> Note [A] from chapter "PHY interface select register (CXR35)" specifies
>>> the following:
>>> [A] The case which CXR35 SEL_XMII is used for the selection of RGMII/MII
>>> in APB Clock 100 MHz.
>>> (1) To use RGMII interface, Set ‘H’03E8_0000’ to this register.
>>> (2) To use MII interface, Set ‘H’03E8_0002’ to this register.
>>>
>>> Take into account these indication.
>>>
>>> Fixes: 1089877ada8d ("ravb: Add RZ/G2L MII interface support")
>>
>>    The bug fixes should be submitted separately and against the net.git repo...
> 
> OK, thanks for pointing it.

   And I think Linus' repo will do as well...

MBR, Sergey
