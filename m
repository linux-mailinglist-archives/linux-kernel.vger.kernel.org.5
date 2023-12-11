Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707CD80C66F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjLKK0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjLKKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:10:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474D5AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:10:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65093C433C7;
        Mon, 11 Dec 2023 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702289443;
        bh=xegFE43EsxyDEc3X4/P6wFMt65swkGo0cmYpTfXFMNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/d66fRvTIHZc+1tPtr4CYU+RquwqoOlqN2HfoxjeD6nhSx7Tr7hAznWzqWfOPFcP
         +VuZz1oSq9AmKmlRe0ZPBOfq/se1RO2d7wKCOmsqjHO5x4hLNXuitHBXfhJYsNdduA
         6v5lfqbLkyCb31oVZr7l936XUXZFQPYlBPDvexlsHpOTzeKtsQLxnF4Kkrk4MAG59x
         u90ynnHr5nQDPeqo9bKNGmReO9cYIL4W9vJLGlPu55BmQA9b9RtCqtrSfA2L2sKG1i
         7di11AS03a/4c7oIoqgbtr3+0B6RsQkgo98fRmItwkJTUgFvt7NlGV8u1366zKLZqr
         sjfDAjQv4J0SA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCdG5-0005bi-0v;
        Mon, 11 Dec 2023 11:11:29 +0100
Date:   Mon, 11 Dec 2023 11:11:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add missing GMU entry to match
 table
Message-ID: <ZXbgUeuf0-dYBOYV@hovoldconsulting.com>
References: <20231210180655.75542-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210180655.75542-1-robdclark@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 10:06:53AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In some cases the firmware expects cbndx 1 to be assigned to the GMU,
> so we also want the default domain for the GMU to be an identy domain.
> This way it does not get a context bank assigned.  Without this, both
> of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
> allocating and configuring a context bank.  So GMU ends up attached to
> both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
> and surprises the firmware if the GPU later triggers a translation
> fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
> getting wedged and the GPU stuck without memory access.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
