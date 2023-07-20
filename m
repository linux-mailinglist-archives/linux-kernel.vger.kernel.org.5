Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031875A4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGTDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGTDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:36:11 -0400
X-Greylist: delayed 1433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 20:36:09 PDT
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106EF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:36:09 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 36K3CBBO026281
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:12:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1689822726; x=1692414726;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zPjihqajCHYso2SYLygY80dfwyyJAXwUJ5bsc+egrmg=;
        b=HoBvEI/eMiSilZXfZB6lzV1KKu9/yBE2zEk+Ou5yUNXOgugqprpDcNW58LLObfa+
        MHGbasKVuf29H6iCCVipyi801yXAQZnIfrlAgsXigc5tRpJ6S72kYLXjoLieM9Qu
        JRkIu1Omb6MXt4Gu0qRmztcu37kYgrodXfoWkUzn4ospda75K9BvgYHrU3nWjcfO
        AYQlSx9O45PC89q+Kwyppg9LBHH2hlHfhsRGalBrqPIOELsbfkIXEMKIb/aNWCOY
        +dCiKBPajwdgjIOl8pD7qSu7LInMJx/e6kxxUuQRHE/BaPmOBhXtEtdbWKa9vJlQ
        Ba1bMQz9dYRzjsftr8dO6Q==;
X-AuditID: 8b5b014d-a17eb70000002178-ba-64b8a606a7bd
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 6C.42.08568.606A8B46; Thu, 20 Jul 2023 06:12:06 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr>
Date:   Thu, 20 Jul 2023 06:11:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
Content-Language: el-GR
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXSHT1dWZdt2Y4Ug8V9ChZbf89it5h16Tij
        xa8vFhadszewW1zeNYfNYtvnFjaLDZdmMVq8vNzDbNE2i9/i4IcnrBaf51dYTF/1gtniy7J2
        RouWO6YOfB5PDs5j8lgzbw2jx5uXL1k8Dnd8YffYtKqTzWPzknqPF5tnMnrcmBXhcan5OrvH
        359bWTw+b5IL4I7isklJzcksSy3St0vgyrh1rYulYLtAxa31n1gaGGfydjFyckgImEhM+nyE
        uYuRi0NI4CijxKM1c5khEpYSmz+9ZAGxeQXsJQ49mAwWZxFQlVj0YwMrRFxQ4uTMJ2A1ogLR
        EtPuXQOzhQViJT50vGIDsZkFxCWOnP8NtkBE4BSjxK+JP8EcZoGLTBJrDq9jAqkSEuhilNh4
        sRjEZhPQlJh/6SDYJE6BGInDf0+yQ0wyk+ja2sUIYctLbH87h3kCo8AsJIfMQrJwFpKWWUha
        FjCyrGIUSCwz1stMLtZLyy8qydBLL9rECI42Rt8djLc3v9U7xMjEwXiIUYKDWUmE99HlbSlC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeU/YLkgWEkhPLEnNTk0tSC2CyTJxcEo1MDnVGJcJZHJu
        i9zY3pqz90Kr9EPmXX32D3bG/j+itPvqnpCjSvnmn7+s5xa78tDoR+RjzUsn7n/IYnKpzkmu
        Le99vuXwXMdVkTHyUv9ezd/BVXUhJETOeH/p6oeX7FxPVvi8aW0KUyv33XqO50C46AOhTzef
        qe25ValRtHN9y1tta3WRft/HgV9sW57s69uw4PxH+YjJHl80ulzUipwiP+kcdN+/RdarJeZX
        /p3ZNl+ncH3bfGzKajfDh/MyZaaw/nCP1gyzntWTbtn1foel8SeBplu//p1r04spFLniorDZ
        zK/7htyMHDXRj1P3HMitspd/PZ1BdLLrh7drvA1cp54RMBTXVLzzYr26xofCY0osxRmJhlrM
        RcWJAHKI+wclAwAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tomasz,

On 7/19/23 22:33, Tomasz Jeznach wrote:
> Enables message or wire signal interrupts for PCIe and platforms devices.
> 

The description doesn't match the subject nor the patch content (we 
don't jus enable interrupts, we also init the queues).

> +	/* Parse Queue lengts */
> +	ret = of_property_read_u32(pdev->dev.of_node, "cmdq_len", &iommu->cmdq_len);
> +	if (!ret)
> +		dev_info(dev, "command queue length set to %i\n", iommu->cmdq_len);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "fltq_len", &iommu->fltq_len);
> +	if (!ret)
> +		dev_info(dev, "fault/event queue length set to %i\n", iommu->fltq_len);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "priq_len", &iommu->priq_len);
> +	if (!ret)
> +		dev_info(dev, "page request queue length set to %i\n", iommu->priq_len);
> +
>   	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   

We need to add those to the device tree binding doc (or throw them away, 
I thought it would be better to have them as part of the device 
desciption than a module parameter).


> +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> +

> +	case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> +		q = &iommu->priq;
> +		q->len = sizeof(struct riscv_iommu_pq_record);
> +		count = iommu->priq_len;
> +		irq = iommu->irq_priq;
> +		irq_check = riscv_iommu_priq_irq_check;
> +		irq_process = riscv_iommu_priq_process;
> +		q->qbr = RISCV_IOMMU_REG_PQB;
> +		q->qcr = RISCV_IOMMU_REG_PQCSR;
> +		name = "priq";
> +		break;


It makes more sense to add the code for the page request queue in the 
patch that adds ATS/PRI support IMHO. This comment also applies to its 
interrupt handlers below.


> +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
> +						  u64 addr)
> +{
> +	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
> +	cmd->dword1 = addr;
> +}
> +

This needs to be (addr >> 2) to match the spec, same as in the iofence 
command.

Regards,
Nick

