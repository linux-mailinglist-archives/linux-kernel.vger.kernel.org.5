Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA679791239
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbjIDHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbjIDHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:31:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FF1AC;
        Mon,  4 Sep 2023 00:31:14 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 383LHANh011127;
        Mon, 4 Sep 2023 09:30:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=CJ6f+Mj4xw5e5f2nUevdxPupbRu8vHoKZgu1otbVbto=; b=Ct
        Ax+XF23ODo/au8B+ZrDh83sB9V35dL97jfSytDcF7GnaFpEfXua1uO5mNveiF6ZV
        ULJqOWqQ8/CW9vKbt8JtAkZZfIYkfm7ZkuDQCFX97ES4W97cbNjGR/P0MJXvXc8N
        8e6BrOsY3KYAQK9iXSTEvNTBSPfPJSxKVp9Jyw8+c9EA/ysRV2M9ao+ZLpleINMK
        clAX1gMEbcIYZf//j7XFUPD1NM0WPgsp53LtLEID+8n4mcDwAWOFLkA5F6hamyJM
        1olxdiwbjUuF+Oc/BTewcK8FNIPptKC7OL0hw1jO0YVNDeVlJIds9WiKEOde88Nt
        +PNsOLv7+6Zu72uc0V5g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svem0bhah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 09:30:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F187100058;
        Mon,  4 Sep 2023 09:30:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A66C2122EB;
        Mon,  4 Sep 2023 09:30:38 +0200 (CEST)
Received: from [10.201.20.125] (10.201.20.125) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 09:30:37 +0200
Message-ID: <26ca3e45-b89a-705a-5aa2-9c5f1a5e20db@foss.st.com>
Date:   Mon, 4 Sep 2023 09:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
Content-Language: en-US
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
 <CACRpkdaj6bEQTo6a5gOJQne-wKqBLvuxiOe9kE+q-nkYLOU7Pw@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CACRpkdaj6bEQTo6a5gOJQne-wKqBLvuxiOe9kE+q-nkYLOU7Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_04,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 18:43, Linus Walleij wrote:
> Hi Yann/Christophe,
> 
> just a quick note:
> 
> On Fri, Sep 1, 2023 at 2:08 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> 
>> +static void sdmmc_enable_sdio_irq(struct mmci_host *host, int enable)
>> +{
>> +       void __iomem *base = host->base;
>> +       u32 mask = readl_relaxed(base + MMCIMASK0);
>> +
>> +       if (enable)
>> +               writel_relaxed(mask | MCI_ST_SDIOITMASK, base + MMCIMASK0);
>> +       else
>> +               writel_relaxed(mask & ~MCI_ST_SDIOITMASK, base + MMCIMASK0);
>> +}
>> +
>> +static void sdmmc_sdio_irq(struct mmci_host *host, u32 status)
>> +{
>> +       if (status & MCI_ST_SDIOIT) {
>> +               sdmmc_enable_sdio_irq(host, 0);
>> +               sdio_signal_irq(host->mmc);
>> +       }
>> +}
> 
> You need to move these to mmci and rename them since Ux500 will use
> the same callbacks.

Hi Linus,

Yes, that's what I was planning to do.
> 
>>   static struct mmci_host_ops sdmmc_variant_ops = {
>>          .validate_data = sdmmc_idma_validate_data,
> (...)
>> +       .enable_sdio_irq = sdmmc_enable_sdio_irq,
>> +       .sdio_irq = sdmmc_sdio_irq,
>>   };
> 
> What about dropping the per-variant callbacks and just inline
> this into mmci_enable_sdio_irq()/mmci_ack_sdio_irq() since
> so many variants have the same scheme? I haven't looked
> at the Qualcomm variant though, maybe it is completely
> different...

I'm not sure about this. Keeping the ops will make it easier for other 
variants to bring their own code if their scheme is different.

Best regards,
Yann

> 
> Yours,
> Linus Walleij

