Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA554776617
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjHIRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjHIRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:05:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE10C211F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:05:08 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230809170505euoutp02bad2f843f13355a105b7cb15a29e88b9~5xeEX03OA1500015000euoutp02u
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:05:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230809170505euoutp02bad2f843f13355a105b7cb15a29e88b9~5xeEX03OA1500015000euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691600705;
        bh=IZDbQ8Q1V429gI8vhPbcUNnf8M/aTOL8Mg8jw/W1/eU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=O7xQmCXu4pyucKVuWtdnpuZJMmLoRFKAsa7NAZ6JzdMhFiAW7DXyb5mYHV5iRRoP2
         75VymA8uq8lYPU3QGq29ajDox28hGpv1ipjUE0d+nKZLopU75YS6gqhGKIFlzkoJf+
         zmnpGAh8DmWhhnX0vP5eXVTuWnpnde5JpdcKsfuo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230809170505eucas1p1014785957340a98dc3c827c6a4f78c5b~5xeEAcApI3155731557eucas1p1h;
        Wed,  9 Aug 2023 17:05:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.03.11320.147C3D46; Wed,  9
        Aug 2023 18:05:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230809170504eucas1p181fb1b54ff1b30cdcd2fce713da96ce0~5xeDpHv9h3148331483eucas1p1X;
        Wed,  9 Aug 2023 17:05:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230809170504eusmtrp29945a14f9ed088f1179776ed5ff61c62~5xeDohJXs2896928969eusmtrp28;
        Wed,  9 Aug 2023 17:05:04 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-04-64d3c74149e8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.AF.10549.047C3D46; Wed,  9
        Aug 2023 18:05:04 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230809170504eusmtip2f14dc2f159e01304fb96cab5fa980021~5xeDIyxTn1258912589eusmtip2K;
        Wed,  9 Aug 2023 17:05:04 +0000 (GMT)
Message-ID: <ab061a6b-2aeb-fb62-3dd0-a20059ff10ac@samsung.com>
Date:   Wed, 9 Aug 2023 19:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZNEagJ6rVDwBKUdr@casper.infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7qOxy+nGEybwmUxZ/0aNotNj6+x
        WlzeNYfN4tDUvYwWR9ZvZ7L4/WMOmwObx+VrF5k9Nq/Q8ti0qpPN48SM3ywem5fUe3zeJBfA
        FsVlk5Kak1mWWqRvl8CVse7ZU8aCbywVm+f+YW9gfMncxcjJISFgIvG4/wNjFyMXh5DACkaJ
        2d1nmSCcL4wS91v7WSCcz4wSx3e9ZIVpefXhAVTLckaJ6UcuMUM4Hxklvl3/yAhSxStgJ3H2
        awdbFyMHB4uAisS6H3YQYUGJkzOfsIDYogKpEjtuT2AFKREWiJOYtC8KJMwsIC5x68l8JpCw
        iICGxJstRiDTmQX2MEr0P7zJDlLDJmAo0fW2C2w6J9A9jVNTIVrlJba/nQN2jYTAHQ6JxQv/
        Q73pIrFi6yooW1ji1fEt7BC2jMT/nfOZIBraGSUW/L4P5UxglGh4fosRospa4s65X2DbmAU0
        Jdbv0ocIO0qc3XoPLCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrN
        QgqUWUi+n4XknVkIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITD6n/x3/soNx
        +auPeocYmTgYDzFKcDArifDaBl9KEeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsyWUggPbEk
        NTs1tSC1CCbLxMEp1cAkenPxnA97wp+G/NyueDaief/0+/OnddSkJB05pGRft0PcUPvei8em
        D5T51EPezZz6dLbY89AsGx7n/J87J199zSapWsST+7vbt+tG1ll5UWVeybU5e9r6Y9TCJxzc
        ejHB+UicQIU8W9B0xdJz6YLvf0V92K169s6effkXb1fY9tgc3Vv14uVmJ6/Dnh+Kr787muq2
        oHGJTMWV3I59mwyjXnDzy15Pb4rTjW3VC/mxvlfuVPS2hyf6y7rlr796v51TesLPBWs63FKY
        eeX1T92fn2sk27vq8JrMlfcbnq+V/35H+UC/oXvP1L2Kei/f7OHcXHds4YOX4ZuO3D/RdM9Y
        Sel0rrr2en4J99zlxXP7lViKMxINtZiLihMBjEjkm60DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7oOxy+nGJx8pW0xZ/0aNotNj6+x
        WlzeNYfN4tDUvYwWR9ZvZ7L4/WMOmwObx+VrF5k9Nq/Q8ti0qpPN48SM3ywem5fUe3zeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXse7Z
        U8aCbywVm+f+YW9gfMncxcjJISFgIvHqwwPGLkYuDiGBpYwSs092s0MkZCROTmtghbCFJf5c
        62KDKHrPKLF+6SYmkASvgJ3E2a8dQAkODhYBFYl1P+wgwoISJ2c+YQGxRQVSJX417GIFKREW
        iJOYtC8KJMwsIC5x68l8JpCwiICGxJstRiDTmQX2MEpcvdMHdc9eRonWX98ZQRrYBAwlut52
        ga3iBDq6cWoqxBwzia6tXYwQtrzE9rdzmCcwCs1CcsUsJOtmIWmZhaRlASPLKkaR1NLi3PTc
        YkO94sTc4tK8dL3k/NxNjMBo23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmE1zb4UooQb0piZVVq
        UX58UWlOavEhRlNgSExklhJNzgfGe15JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklqdmpq
        QWoRTB8TB6dUA1O7u+smE/45vv/e5CkaB/GfvrT2xRqd3KCFrJ9a+O6rzjgv19YV/WJl2tod
        L3IbBA7YV7bfDp2q2Gu5LLLmW/YXv6NZm58ltS1OvbEkpcWU5RPHHXt9P+eQHvHL1xunak/7
        utJc7MyfluIOpwlpUTv+x3yOKWWSKDf3MsyuEfn1Umjy8cPPFkbebcoo3Dd/+jrW0OvzX8Xu
        mP/92aEJK2Mml31/87pJb7eRbfVFx/uBKlUM/2157wXNCa2I0f2g9Tp5yjEB4avznaeqmuVJ
        mbQv9doQLrygR2jzxWbb2B9X0i5fdInaFrC3arZdy0sumYedTflvNcIOpIh8uPviimLv3aVd
        Am1lk9Lnp4VplCqxFGckGmoxFxUnAgCOU3BtPwMAAA==
X-CMS-MailID: 20230809170504eucas1p181fb1b54ff1b30cdcd2fce713da96ce0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
        <20230807152657.1692414-1-m.szyprowski@samsung.com>
        <ZNEagJ6rVDwBKUdr@casper.infradead.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.08.2023 18:23, Matthew Wilcox wrote:
> On Mon, Aug 07, 2023 at 05:26:57PM +0200, Marek Szyprowski wrote:
>> It is possible that the folio_size() of the next folio returns zero, so
> What?  How can folio_size() return zero?
>
>          return PAGE_SIZE << folio_order(folio);
>
> It is a minimum of PAGE_SIZE.

Well, the folio_order() on that next folio returns 255, so folio_size() 
overflows to zero. However, the main source of this issue is relying on 
the properties of the folio beyond the requested sync region.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

