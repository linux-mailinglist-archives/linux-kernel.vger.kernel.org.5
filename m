Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FAF7691D7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGaJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGaJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:32:54 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447718E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:32:52 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 36V9WnWF012593
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:32:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1690795964; x=1693387964;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hYrmhTrrV00n+yse0bYXu7c0/zKBC0CeIUzRE0uLZlg=;
        b=YKxeiPnJ67koIgsdTCopqGc/amJ0bseu3UDSU5nSdpRpkcuijU1pq6ZVCDOPlVf6
        wZueesH/esX70fAKmkgkN2ZCK8LbJyg86Z6eWqiPF+HVNvq+ePyeE9hX75kCyzZv
        pjdBjLeAw9iiMg6iyHbBCriSLduq5G6nJDE5Qhul7b8B5/nxOkW3YEzM6gYfpqHl
        t+ebkzx0pEKPDk0z0FSIIgrCbtv58UpHijerTxDkS1BVgh3+YIaLpIxa7lmZ1ZSQ
        PSb0ABzerHksfIFhxTNld/aXodm/JJ1DrHD3boREa0pAnejNUQeWPIDdf+dnjv+f
        +D8pYAm4QT0ERZjNq8dX3Q==;
X-AuditID: 8b5b014d-a23ec70000002178-b5-64c77fbc718e
Received: from enigma.ics.forth.gr (enigma-2.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 83.D4.08568.CBF77C46; Mon, 31 Jul 2023 12:32:44 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr>
Date:   Mon, 31 Jul 2023 12:32:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Zong Li <zong.li@sifive.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
Content-Language: el-GR
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsXSHT1dWXdP/fEUg/lXtSy2/p7FbjHr0nFG
        i19fLCw6Z29gt7i8aw6bxbbPLWwWGy7NYrR4ebmH2aJtFr/FwQ9PWC0+z6+w+LKsndGi5Y6p
        xYe7s9kc+DyeHJzH5LFm3hpGjzcvX7J4HO74wu6xaVUnm8fmJfUeLzbPZPS4MSvC41LzdXaP
        vz+3snh83iQXwB3FZZOSmpNZllqkb5fAlfF2IU/BAt6KvvNXmRsYW7i6GDk5JARMJPreXmTp
        YuTiEBI4zijx8dZ2ZoiEpcTmTy9ZQGxeAXuJvXtusoHYLAKqEu8WzmaCiAtKnJz5BKxGVCBa
        YsOFR2C2sECsxIeOV2D1IgIeEjvnfWMCWcAscJZZYumdh2ALhAQuMkpMvQ9WxCwgLnHk/G+w
        OJuApsT8SwfBBnEKBEq07lnNAlFjJtG1tYsRwpaXaN46m3kCo8AsJHfMQjJqFpKWWUhaFjCy
        rGIUSCwz1stMLtZLyy8qydBLL9rECI40Rt8djLc3v9U7xMjEwXiIUYKDWUmE91TAoRQh3pTE
        yqrUovz4otKc1OJDjNIcLErivCdsFyQLCaQnlqRmp6YWpBbBZJk4OKUamLxSTzWYPrmWOF/h
        lcJ0r9ge0z+9UjNndomGrXotIr9O4Oa8m0Fni27kZtYtNN+osG9RY29H8PPy2wof161+tlEi
        /VrqowXVeyeX/fpsc/3sqp9f7b49q1/2rSNdK3n1kqszzPXM1syseqIxo3TfOuMH23VFDM7v
        L3zZ4CET9DEgZpbqo2l+BbwqMapRSSb/HW2SoxZxFTTyeMz3VZos9vXtiTN/l3H8a21ReS3z
        9ADDi6PnVO42ZoscuDuR6eXNeYu26XV0XeposFvPGmedutK+M6ZNWUZrWmGSZtCa3zYuNav9
        1L4mKNr52k+yOV4+vbk9nylH/TxX6rMPN0OZ5JS0rR+8bQm3cJkhtmnnTyWW4oxEQy3mouJE
        AJtm9pUjAwAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 15:58, Zong Li wrote:
> On Thu, Jul 20, 2023 at 3:34 AM Tomasz Jeznach <tjeznach@rivosinc.com> wrote:
>> +       iommu->cap = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
>> +
>> +       /* For now we only support WSIs until we have AIA support */
> 
> I'm not completely understand AIA support here, because I saw the pci
> case uses the MSI, and kernel seems to have the AIA implementation.
> Could you please elaborate it?
> 

When I wrote this we didn't have AIA in the kernel, and without IMSIC we 
can't have MSIs in the hart (we can still have MSIs in the PCIe controller).

> 
> Should we define the "interrupt-names" in dt-bindings?
> 

Yes we should, along with queue lengths below.

>> +
>> +       /* Make sure fctl.WSI is set */
>> +       fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>> +       fctl |= RISCV_IOMMU_FCTL_WSI;
>> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
>> +
>> +       /* Parse Queue lengts */
>> +       ret = of_property_read_u32(pdev->dev.of_node, "cmdq_len", &iommu->cmdq_len);
>> +       if (!ret)
>> +               dev_info(dev, "command queue length set to %i\n", iommu->cmdq_len);
>> +
>> +       ret = of_property_read_u32(pdev->dev.of_node, "fltq_len", &iommu->fltq_len);
>> +       if (!ret)
>> +               dev_info(dev, "fault/event queue length set to %i\n", iommu->fltq_len);
>> +
>> +       ret = of_property_read_u32(pdev->dev.of_node, "priq_len", &iommu->priq_len);
>> +       if (!ret)
>> +               dev_info(dev, "page request queue length set to %i\n", iommu->priq_len);
>> +
>>          dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>
