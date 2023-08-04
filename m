Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057076FF55
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjHDLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHDLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344EE7;
        Fri,  4 Aug 2023 04:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65AA861F98;
        Fri,  4 Aug 2023 11:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47DC433CC;
        Fri,  4 Aug 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691148021;
        bh=PD0WZl9g+p7buh6X5We6vYyuenWLuZ43sDfUiVyrgh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCURGU8du84F8nuxxbHBGPvyvE6YwYxp3BgLvMmp7Z76Ys7dcQ+VqmYVi/TgIvRZ2
         wHPZYBzgtqc6LN1Iaqx8RNNHATXs4ddIN8ecC9TtHJZHMWJ67QMlm78fstJ0SmlzhS
         kN1yNWVDvueFpiWgcPXiUz3p1Vg51qR90KUVhZSQ=
Date:   Fri, 4 Aug 2023 13:19:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     stable@vger.kernel.org, easwar.hariharan@microsoft.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 6.4 0/4] ARM SMMUv3 errata for 6.4
Message-ID: <2023080452-rewire-ashy-3a7f@gregkh>
References: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:26:16PM +0000, Easwar Hariharan wrote:
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux.dev
> 
> Changelog:
> ==========
> v1 -> v2:
>  - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
>  - v1 link: https://lore.kernel.org/stable/20230724185130.1676140-1-eahariha@linux.microsoft.com/T/#u
> 
> Robin Murphy (4):
>   iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
>   iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
>   iommu/arm-smmu-v3: Add explicit feature for nesting
>   iommu/arm-smmu-v3: Document nesting-related errata
> 
>  Documentation/arm64/silicon-errata.rst      |  4 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
>  3 files changed, 62 insertions(+)
> 
> -- 
> 2.25.1
> 

All now queued up, thanks.

greg k-h
