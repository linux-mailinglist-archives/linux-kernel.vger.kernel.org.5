Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B178FFFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbjIAPdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjIAPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:33:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A010D2;
        Fri,  1 Sep 2023 08:33:49 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381C2pZb024661;
        Fri, 1 Sep 2023 17:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=bi3VYNViQtJCdjL7dyg53UF58C/uOQWQ7xolLTOM3Vc=; b=dy
        na2h6N0tXT2dNWEVshdFvkivlGm5yguKrqAa/Wlione68+uhdIjBCIGadoHpSAiu
        VO2jmtriOl70sTfaToMBUw1nWmalzq4HlIG0WtJt7XMcoNsJApu9tgAFhVJRTqzH
        ELJU0Zda/5YHFsxoXi8mK6v4k4xHRnjMlclH+F342FHct2K9tpQtPEvQ6itB/PCt
        91AhO/HqtQpmbhGju+IQnO1twFV7dBy0dVDSDAKQc3cbh6i+/dgct2/fMfegV0XL
        f2nD1j0FX9Jwqs+E7Qjl/NH5IhHgSo3PgpcJvaKiKVDu7tHI5srrU5JEdqAXV4/x
        amxE1E5R7+4pxpaZXfcQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6h4kp3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 17:33:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B57A100056;
        Fri,  1 Sep 2023 17:33:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 503C423D3F2;
        Fri,  1 Sep 2023 17:33:07 +0200 (CEST)
Received: from [10.201.20.125] (10.201.20.125) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 17:33:04 +0200
Message-ID: <3eed1865-d70d-c89a-fcaf-7b0e2bb6da98@foss.st.com>
Date:   Fri, 1 Sep 2023 17:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
 <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 16:10, Linus Walleij wrote:
> Hi Yann/Christophe,
> 
> thanks for your patch!

Hi Linus

Thanks for the review, I agree with the proposed changes.
I'll prepare a new version and send it next week!

Best regards,
Yann
> 
> On Fri, Sep 1, 2023 at 2:08 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> 
>> From: Christophe Kerello <christophe.kerello@foss.st.com>
>>
>> Add the support of SDIO in-band interrupt mode for STM32 variant.
>> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> (...)
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -332,6 +332,7 @@ enum mmci_busy_state {
>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>>    * @dma_lli: true if variant has dma link list feature.
>>    * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>> + * @use_sdio_irq: allow SD I/O card to interrupt the host
> 
> The documentation tag should be one line up (compare to the members...)
> 
>> @@ -376,6 +377,7 @@ struct variant_data {
>>          u32                     start_err;
>>          u32                     opendrain;
>>          u8                      dma_lli:1;
>> +       u8                      use_sdio_irq:1;
> 
> 1. bool use_sdio_irq;
> 
> 2. supports_sdio_irq is more to the point don't you think?
>      Especially since it activates these two callbacks:
> 
>> +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
>> +       void (*sdio_irq)(struct mmci_host *host, u32 status);
> 
> Further: all the Ux500 variants support this (bit 22) as well, so enable those
> too in their vendor data. All I have is out-of-band signaling with an GPIO IRQ
> on my Broadcom chips but I think it works (maybe Ulf has tested it in the
> far past).
> 
> Yours,
> Linus Walleij

