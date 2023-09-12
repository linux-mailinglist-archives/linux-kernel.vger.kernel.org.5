Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702C79CE00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjILKSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjILKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:18:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB491726;
        Tue, 12 Sep 2023 03:18:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C03C433B9;
        Tue, 12 Sep 2023 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694513909;
        bh=uKvPIfnxCoZtHrrIPaG9nNRcDJHXgQGDDHfQe/MWQZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQYFILSsh4WNbTikyKtzLokfkY+RYdnG+CMwUDOF4KBxYbpQhedujXf88J52hQ7aF
         LXdcFlB8e4yXzo/E1ZbP7gDQtTpVc9e3uNGD5t5AtILSNFV+dbdpLboAIf/QHuBeLz
         JiQraaMpvFZr2mErtyQgWb9r0muXGjyqtOz2zoGnOThZlJw2epVIxJHTSlwPl03P17
         NromokDPjkkgDl0Js/Aeksn6886MU//9WG5coE3g1sT9569WQKU4lMr4OPhtEOviKI
         LMcRZ9OWgtXWG3+vpdMNGDuSb4bV6yKGvsYlTSKdz8lMnVUrEpt5WmB5XqBVdrcUSq
         zcq5/G+WvKQDw==
Date:   Tue, 12 Sep 2023 11:18:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        vigneshr@ti.com, nm@ti.com, matthias.bgg@gmail.com,
        kgene@kernel.org, alim.akhtar@samsung.com, bmasney@redhat.com,
        quic_tsoni@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Subject: Re: [REBASE PATCH v5 08/17] arm64: mm: Add dynamic ramoops region
 support through command line
Message-ID: <20230912101820.GA10884@willie-the-truck>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-9-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694429639-21484-9-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:23:50PM +0530, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This may not be
> required for something like Qualcomm's minidump which is interested
> in knowing addresses of ramoops region but it does not put hard
> requirement of address being fixed as most of it's SoC does not
> support warm reset and does not use pstorefs at all instead it has
> firmware way of collecting ramoops region if it gets to know the
> address and register it with apss minidump table which is sitting
> in shared memory region in DDR and firmware will have access to
> these table during reset and collects it on crash of SoC.
> 
> So, add the support of reserving ramoops region to be dynamically
> allocated early during boot if it is request through command line
> via 'dyn_ramoops_size=' and fill up reserved resource structure and
> export the structure, so that it can be read by ramoops driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/mm/init.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++

Why does this need to be in the arch code? There's absolutely nothing
arm64-specific here.

Will
