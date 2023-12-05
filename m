Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B080484B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjLEDry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjLEDrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:47:52 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE2CD3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:47:58 -0800 (PST)
X-ASG-Debug-ID: 1701748075-086e236ff030ad0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id 35nviJm6sEfRPMOJ (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 05 Dec 2023 11:47:55 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 11:47:55 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 11:47:53 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <c4776494-f13a-4268-8fbb-b50e6981f5d1@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Tue, 5 Dec 2023 11:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-ASG-Orig-Subj: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
CC:     <olivia@selenic.com>, <martin@kaiser.cx>,
        <jiajie.ho@starfivetech.com>, <jenny.zhang@starfivetech.com>,
        <mmyangfl@gmail.com>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <x86@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>,
        <LeoLiu@zhaoxin.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
 <ZWmokVNG1ebMVNSM@gondor.apana.org.au>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <ZWmokVNG1ebMVNSM@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1701748075
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 599
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117665
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/1 17:34, Herbert Xu 写道:
> On Tue, Nov 21, 2023 at 11:29:39AM +0800, LeoLiu-oc wrote:
>>
>> +static const struct x86_cpu_id via_rng_cpu_ids[] = {
>> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);
> 
> Rather than moving the whole thing, just add this near the start
> of the file:
> 
> static const struct x86_cpu_id via_rng_cpu_ids[];
> 
> Cheers,

Thank you for your suggestions. Will make modifications in the next 
version as suggested.

Sincerely,
Leoliu-oc




