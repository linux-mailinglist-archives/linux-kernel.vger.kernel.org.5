Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4F76A4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGaXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGaXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:35:39 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1009F1AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:35:36 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 36VNZYTV034600
        for <linux-kernel@vger.kernel.org>; Tue, 1 Aug 2023 02:35:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1690846529; x=1693438529;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LSI+78CfW+QT4JpYLaB75hH9TQH+aW5vj75UYJKOLcQ=;
        b=kTKV5jqGVcwFgVBaQYJU+AxlBxqtDo+7Eeq8nndszmR0URMZVNHdVyyKaFZVHuT8
        cfbCzuy/IQvxu8Yx7RYodznI0SVDETLWTb+3dyZ6NOGNsyacWb74Ik60lLqr0Iyg
        956fID9oI3NzQjjJbmWeufKFmpYMaGrkKXBXP4b9sLo3u7b0E1oY6F2CwkgxugWe
        9DKYVi66ffit6dW3+owNkh4S/N/eZtG8wdNhWIc/gGnAl/9L6GGEAU/FOYU5b5oK
        pcCgliA2bG6zgRHqWpmf96Wdhwgv205Op7gR3JK2vXV5KnggQc3v/1GepkgDgrns
        bEPZ9Ow75g9IGxGKyetq4g==;
X-AuditID: 8b5b014d-a17eb70000002178-1b-64c845417c82
Received: from enigma.ics.forth.gr (enigma-2.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 6E.28.08568.14548C46; Tue,  1 Aug 2023 02:35:29 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <dc3974f0-500c-b7d3-c8ca-df069dbd02a8@ics.forth.gr>
Date:   Tue, 1 Aug 2023 02:35:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Zong Li <zong.li@sifive.com>
Cc:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
 <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr>
 <CANXhq0puxuHA2cEyb2+TobkoFTc=7MQqtv7DYbuZdvf0T8+iUQ@mail.gmail.com>
Content-Language: el-GR, en-US
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <CANXhq0puxuHA2cEyb2+TobkoFTc=7MQqtv7DYbuZdvf0T8+iUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXSHT1dWdfR9USKQcNpBYutv2exW8y6dJzR
        4tcXC4vO2RvYLS7vmsNmse1zC5vFhkuzGC1eXu5htmibxW9x8MMTVovP8yssvixrZ7RouWNq
        8eHubDYHPo8nB+cxeayZt4bR483Llywehzu+sHtsWtXJ5rF5Sb3Hi80zGT1uzIrwuNR8nd3j
        78+tLB6fN8kFcEdx2aSk5mSWpRbp2yVwZUz40cRccJaj4uzsVtYGxodsXYycHBICJhIz325m
        7GLk4hASOM4ocf77L6iEpcTmTy9Zuhg5OHgF7CXmbbQHCbMIqEhMm7yLBcTmFRCUODnzCZgt
        KhAtseHCIzBbWCBW4kPHK7AxIgIKEleWbGQBmc8s8JlZ4sqmL6wQy84xSdzeuBmsillATuL9
        s+2sIDabgKbE/EsHwSZxCgRKfL67nB2ixkyia2sXI4QtL9G8dTbzBEaBWUgOmYVk1CwkLbOQ
        tCxgZFnFKJBYZqyXmVysl5ZfVJKhl160iREca4y+Oxhvb36rd4iRiYPxEKMEB7OSCK/07+Mp
        QrwpiZVVqUX58UWlOanFhxilOViUxHlP2C5IFhJITyxJzU5NLUgtgskycXBKNTCJngib83lr
        2BsHXqfwF6bKc2bydk6L7PfZYmBXK8USOEP1WuorTvZbV7dFzvPfaMsVliu6LTzoXdbeC2+r
        fe865fFFWJTNzNy+8LYm69VFG/Lio1o+S990uydYccTr7N4ZuzbWs3xW7E4VmLJowa8VM7eY
        /m9RYgk8t+mCxOWse8wHVQ8ePCPd9q/+XcufDaZvdeU/K653jJP9G3TzKYdUaegyw7yAoNWX
        H9nry1Rd/3trw5Vnn8/2OP7eUfNTIGVtywLWWs+e9wxnJc9VPKgQ2994lcOydMkxzQZuyw7L
        4BmJvY0Ot71lPv9U0VpT+s6XQVKbN/PCz5k3Q57LB3GZvc3MEdqqVfdKqL2npkKJpTgj0VCL
        uag4EQB9QMtvJAMAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 16:15, Zong Li wrote:
> On Mon, Jul 31, 2023 at 5:32 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>>
>> On 7/29/23 15:58, Zong Li wrote:
>>> On Thu, Jul 20, 2023 at 3:34 AM Tomasz Jeznach <tjeznach@rivosinc.com> wrote:
>>>> +       iommu->cap = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
>>>> +
>>>> +       /* For now we only support WSIs until we have AIA support */
>>>
>>> I'm not completely understand AIA support here, because I saw the pci
>>> case uses the MSI, and kernel seems to have the AIA implementation.
>>> Could you please elaborate it?
>>>
>>
>> When I wrote this we didn't have AIA in the kernel, and without IMSIC we
>> can't have MSIs in the hart (we can still have MSIs in the PCIe controller).
> 
> Thanks for your clarification, do we support the MSI in next version?
> 

I don't think there is an IOMMU implementation out there (emulated or in 
hw) that can do MSIs and is not a pcie device (the QEMU implementation 
is a pcie device). If we have something to test this against, and we 
also have an IMSIC etc, we can work on that.
