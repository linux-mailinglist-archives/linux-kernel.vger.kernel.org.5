Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3176AA74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjHAIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjHAIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD2D1729;
        Tue,  1 Aug 2023 01:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2502D614A3;
        Tue,  1 Aug 2023 08:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0807CC433C8;
        Tue,  1 Aug 2023 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690876882;
        bh=6kqSeh2s0QB7HJFRWEDE8TrFNli7QfT0Sf6nWD+OGBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocSGhdOxgh299LUX3x6cTP6JfL027dGb7y/LAteyR33a/QMjbrP+HYy20vwe0tZI5
         P7hfNVKofhN2UApJ5qftcGpXWbOroCmq0R7PkneiBi536ESAgwiTA6qUN8KihmSpaW
         809GOzwyhc9Rjo8VHZM3OFIQ35yrghhdMR0fa8rE=
Date:   Tue, 1 Aug 2023 10:01:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     stable@vger.kernel.org, easwar.hariharan@microsoft.com,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>,
        Sasha Levin <sashal@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH 6.4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Message-ID: <2023080102-rake-twisty-746d@gregkh>
References: <20230724185130.1676140-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724185130.1676140-1-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:51:28PM +0000, Easwar Hariharan wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream
> 
> To work around MMU-700 erratum 2812531 we need to ensure that certain
> sequences of commands cannot be issued without an intervening sync. In
> practice this falls out of our current command-batching machinery
> anyway - each batch only contains a single type of invalidation command,
> and ends with a sync. The only exception is when a batch is sufficiently
> large to need issuing across multiple command queue slots, wherein the
> earlier slots will not contain a sync and thus may in theory interleave
> with another batch being issued in parallel to create an affected
> sequence across the slot boundary.
> 
> Since MMU-700 supports range invalidate commands and thus we will prefer
> to use them (which also happens to avoid conditions for other errata),
> I'm not entirely sure it's even possible for a single high-level
> invalidate call to generate a batch of more than 63 commands, but for
> the sake of robustness and documentation, wire up an option to enforce
> that a sync is always inserted for every slot issued.
> 
> The other aspect is that the relative order of DVM commands cannot be
> controlled, so DVM cannot be used. Again that is already the status quo,
> but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
> disable it for documentation purposes even if it's not wired up anywhere
> yet.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/r/330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  Documentation/arm64/silicon-errata.rst      |  4 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 39 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  3 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index cd46e2b20a81..b0346968765d 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -143,6 +143,10 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | MMU-600         | #1076982        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | MMU-700         | #2812531        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+

But you didn't backport the MMU-600 change here, so why does the diff
here show you did?

And what about commit 0bfbfc526c70 ("iommu/arm-smmu-v3: Document
nesting-related errata") after this?

Can you send a properly backported series for this and the needed fixes
after this, for all relevant kernels you wish to have the errata applied
to?  This single backport isn't enough, sorry.

I've dropped all the patches you submitted for stable backports now.

thanks,

greg k-h
