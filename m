Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979E80760D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442689AbjLFRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379722AbjLFRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:07:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC3C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:07:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00977C433CA;
        Wed,  6 Dec 2023 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701882469;
        bh=bLTnwDn3Jiu3/drePnXNUKRZRyvC9sryoEXthKuzXU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bu6/zwGlO/moKGVxZVrNljA/XHmVtK61dWS/2Z1JxswaonKZQJhKzurie/D1BFRe0
         kFoQKjy2BxC/cUSDGkNOD+n9F32AUBIHkcDXM7MRHi1VpgvhfFZaTtPCKzg2aCJewR
         Q1sMLOcnmtVcdBIh2k+XgKQHjPm37pc6rXRfWDniE1yxf48O4X6GYnKp4T8mLm1/Le
         IXG+qbxnIJ8wbuNVWYm1eCiVDM3A4x9fh3ch18Yrjyu1emt84t1RwvU4/qFzWqD4sS
         5K8jvQvJKXhYgWa/6ALdjFEEsO2Cd1LbjjAezM22QM25Vk75yqMrYMEE+Ic2aN3FI2
         NjJiR7rpdG+SA==
Date:   Wed, 6 Dec 2023 11:07:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jieyy.yang@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        jian.yang@mediatek.com, jianguo.zhang@mediatek.com
Subject: Re: [PATCH 1/2] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent
Message-ID: <20231206170747.GA718062@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206083753.18186-2-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:37:52PM +0800, Jianjun Wang wrote:
> Use 'dmam_alloc_coherent' to allocate the MSI address, instead of using
> 'virt_to_phys'.

s/'dmam_alloc_coherent'/dmam_alloc_coherent()/
s/'virt_to_phys'/virt_to_phys()/

In subject also.

> @@ -732,8 +740,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	val &= ~INTX_MASK;
>  	writel(val, port->base + PCIE_INT_MASK);
>  
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		mtk_pcie_enable_msi(port);
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		err = mtk_pcie_enable_msi(port);
> +		if (err)
> +			return err;

Is failure to enable MSI a fatal issue?  It looks like this will make
the host controller completely unusable if we can't set up MSI, even
if downstream PCI devices could use INTx and get along without MSI.

Bjorn
