Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A0780F76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378284AbjHRPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378332AbjHRPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:42:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCA3C3E;
        Fri, 18 Aug 2023 08:42:05 -0700 (PDT)
Received: from localhost.localdomain (93-41-0-106.ip79.fastwebnet.it [93.41.0.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EFE4660724F;
        Fri, 18 Aug 2023 16:42:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692373324;
        bh=+Hv9exfgv7xX14b0KoI7ObSiwdSECkno/LP+jJg9ooQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vmy/G2bKH6FeAMy35lKKk+oJcCxYOwNm/Cc4IC4K6DsOHDkjd+uKO4DqSXP8hHHOf
         asenBDMHlh5j5geVgJnQ8l9gvaeMzNtXX2ks/7NyRtw1L8iCmG8KRil8yuNn85nsdb
         2MgurU6RtpMgmi9yI56xUZLiyuKnzj6uQ786C8q/KlwxEi7OHVwt/R1eSOFkiSe+Zr
         tXv8bcM39/h6KnzFTvaQkmJw0TDIPoge4RufR2qawErNKRLa72Gyu9UN3jhy5pRku2
         DOeFJZ3r160AJORKKMB0jcMFAfcMh2hmBsKGA/Ro0W3wOsBldOUN3OAYIzqC0wl/lI
         H7uBezxrCMkwA==
From:   Laura Nao <laura.nao@collabora.com>
To:     yong.wu@mediatek.com
Cc:     angelogioacchino.delregno@collabora.com, chengci.xu@mediatek.com,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        jianjiao.zeng@mediatek.com, joro@8bytes.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mingyuan.ma@mediatek.com, robh+dt@kernel.org, robin.murphy@arm.com,
        will@kernel.org, yf.wang@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH v12 2/7] iommu/mediatek: Fix two IOMMU share pagetable issue
Date:   Fri, 18 Aug 2023 17:41:56 +0200
Message-Id: <20230818154156.314742-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602090227.7264-3-yong.wu@mediatek.com>
References: <20230602090227.7264-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is causing fluster tests to fail on MT8192, IOMMU read and write faults are reported in the log. Here's an extract is from the VP9 tests:

mtk-iommu 1401d000.m4u: fault type=0x280 iova=0x1ff7c0000 pa=0x0 master=0x5000480(larb=5 port=0) layer=0 read
mtk-iommu 1401d000.m4u: fault type=0x280 iova=0x1fe3ee000 pa=0x0 master=0x5000492(larb=5 port=4) layer=0 write

Tests are failing for H264, VP8 and VP9 decoding on next-20230817 with fluster in the same way, complete logs can be found here: 
- H264: https://storage.kernelci.org/next/master/next-20230817/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/v4l2-decoder-conformance-h264-mt8192-asurada-spherion-r0.html
- VP8: https://storage.kernelci.org/next/master/next-20230817/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/v4l2-decoder-conformance-vp8-mt8192-asurada-spherion-r0.html
- VP9: https://storage.kernelci.org/next/master/next-20230817/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/v4l2-decoder-conformance-vp9-mt8192-asurada-spherion-r0.html

Reverting this patch fixes the issue. 

From my understanding, on MT8192 the 16GB iova space is partitioned between display, vcodec and camera. The iommu domain configuration for vcodec was loaded from frstdata->bank[0]->m4u_dom (vcodec is preassigned to a specific iova range), while after this patch a new pagetable is created instead. 

Do you have any insight on how to fix this while keeping compatibility with MT8188 and MT8195?

Best,

Laura
