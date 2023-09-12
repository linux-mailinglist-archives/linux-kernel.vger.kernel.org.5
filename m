Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF979C84F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjILHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjILHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:37:35 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DC10CA;
        Tue, 12 Sep 2023 00:37:31 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C3LwsM015420;
        Tue, 12 Sep 2023 09:37:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=HqbaF5o1SFYteMShhADVnqO2ykmpSHq+NUsm7vDvMjw=; b=UA
        VWktBUSVoWOMkewhc/t2KW0oyNHSGb1NjrqChWrmoejwoivtrnMHIGVlEe/3RJdz
        qXv+2mJj9xYLCALx5shCbNnSZjAULf8Nt7KLgxE0JosCuDfB6auAkHKnLjyhZgdN
        0W/8pj+1u8Hoh1ga+gVF9nap5TMw1hWlN9Szf93mec8aczvIe5RnX63l3hasyHNi
        diYZTtKWNh9sS9WePf/3mzUzKlq6UbzB2EXt6CMLePwfMY3LBNxvuz4fI28EUlq1
        4np1BGVN6x2TVVdJ0SUMKVGlZcSN2MbFi3MOKaZk3Z3khnOjJezAzzB3iEuMq8rn
        1aOTGFGJqsik3ZTQwNPQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0fkcmfh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:37:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0472100058;
        Tue, 12 Sep 2023 09:37:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C6C4721ED32;
        Tue, 12 Sep 2023 09:37:01 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:37:01 +0200
Message-ID: <f8445beb-52a0-bcb8-f4fa-3decdfde09fc@foss.st.com>
Date:   Tue, 12 Sep 2023 09:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/10] hwrng: stm32 - rework error handling in
 stm32_rng_read()
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
 <20230908165120.730867-6-gatien.chevallier@foss.st.com>
 <ZP/iw6jvHrlBavdK@gondor.apana.org.au>
Content-Language: en-US
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <ZP/iw6jvHrlBavdK@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert,

On 9/12/23 06:02, Herbert Xu wrote:
> On Fri, Sep 08, 2023 at 06:51:15PM +0200, Gatien Chevallier wrote:
>>
>> +			if (WARN_ON(sr & RNG_SR_CEIS), "RNG clock too slow - %x\n", sr)
> 
> Introducing an unconditional WARN_ON is not acceptable.  If you
> really need it, make it WARN_ON_ONCE.  But why does this need
> to be a WARN instead of dev_err?
> 
> Cheers,

It was my mistake and not my intention to change the WARN_ON_ONCE to a
WARN_ON. I've already sent a V2 correcting this.

It was already a WARN_ON_ONCE on the first implementation of the driver.
This is not an unrecoverable error as it doesn't affect the quality of
the entropy delivered by the RNG. The output is just too slow. It's here
to warn the developer of an incorrect clock source setting.

Best regards,
Gatien
