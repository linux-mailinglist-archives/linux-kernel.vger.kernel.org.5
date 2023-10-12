Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED387C75AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441980AbjJLSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbjJLSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:07:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEE4DE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:07:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A2C433C8;
        Thu, 12 Oct 2023 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697134029;
        bh=axeVVnMAKN1esWZVbwxpsfj2uA1BnBo59XNlWHwYp+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGK+NAKP7Hs+dxFy5KnpClI/nmlc5PAETgqJfH3a/JTvQ6vi6TfiSv7043+wxfYxR
         cl9wEYQT+p152C96xLjjS2QFlBzp6C02YuHJSkJDmHhsqsoGJ/X8tF4IxzrGnSD1SU
         oJIp7oB15nfO+A0Iyp23SUN9aZfH27E32sqJqmToaNjs9andT1RXjJRQbB+/BV2QYP
         aobgj64ERN+DSkiqKyUASTbb1yR6HbFUjNSpOxSWTzm4GIrPORAZjywgtP2JQRmXq3
         rlENlmcqI7cBdfF9aq14Om8oYrabMRfKh9r7pysqqxY1JNPNvuV5g5vgScKf6DHelb
         FL7KomIQxNpag==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Michael Shavit <mshavit@google.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        nicolinc@nvidia.com, tina.zhang@intel.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, jgg@nvidia.com,
        Tomas Krcka <krckatom@amazon.de>, jean-philippe@linaro.org,
        Kevin Tian <kevin.tian@intel.com>,
        Mark Brown <broonie@kernel.org>, robin.murphy@arm.com
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
Date:   Thu, 12 Oct 2023 19:06:47 +0100
Message-Id: <169713222742.3248815.8112629001762142966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
References: <20230905115013.1572240-1-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 19:49:11 +0800, Michael Shavit wrote:
> This small series was originally part of a larger effort to support
> set_dev_pasid in arm-smmu-v3.c and a related SVA refactoring. But it can
> also stand on its own as an initial and prepatory clean-up.
> 
> The crux of this series relies on the observation that SVA won't
> allocate multiple SVA domains for the same device and mm pair. There's
> therefore no reason for the driver to try to normalize data allocated
> for a device/mm pair across set_dev_pasid calls. This simplification
> then allows set_dev_pasid to use the SVA iommu_domain to hold
> information instead of allocating a "bond" to represent the attachement.
> Note that long term, we'll likely want to represent the SVA domain using
> the same arm_smmu_domain struct used in arm-smmu-v3. This series serves
> as an interim step to make those later refactors easier to reason about.
> 
> [...]

Applied first two patches to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
      https://git.kernel.org/will/c/d912aed14fe4
[2/3] iommu/arm-smmu-v3-sva: Remove bond refcount
      https://git.kernel.org/will/c/37ed36448fcd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
