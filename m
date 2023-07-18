Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA837575BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGRHwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGRHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8548E;
        Tue, 18 Jul 2023 00:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C90961446;
        Tue, 18 Jul 2023 07:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B45C433C8;
        Tue, 18 Jul 2023 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689666737;
        bh=OBIHH19P1Xzv4nT4f72NuFolXMnRwud9KX0ascqhx6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4ucQaTnl9zSPNxYU4ZSfeUQZA3KFQTrhy3oPIlUui3lm5knFedsm0obdxqSfTKMV
         rxx6V9SJdIZQ0u4eRlkIpZQsev1VLhd3Flvh2LQg+alYJCHvR0ZCSEk0TGYEoEUn1L
         Ak6MAmhd7f2UJvgfecxdLU+0ByY54zS2xd9DVKrK2wi4Zo6QNGvUXFcp85ILLncsiA
         P1QhRWBuUUlcMKN/DsQepSQbOJWeE1Ocou32/3E1dxia/hu+v/dS2/+5blD2l49fAf
         oKXdu5IQ8F3ZZ9HhHMCWAiFq/umoH6e6NzfQoSPamAcYqwMW2JLsA+KXkS0LUy+njb
         tjgF40avqvLXw==
Date:   Tue, 18 Jul 2023 09:52:11 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        catalin.marinas@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZLZEq0QBBW4rcxJM@lpieralisi>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Catalin, Will, Shameer]

On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> According to the ARM IORT specifications DEN 0049 issue E,
> the "Number of IDs" field in the ID mapping format reports
> the number of IDs in the mapping range minus one.
> 
> In iort_node_get_rmr_info(), we erroneously skip ID mappings
> whose "Number of IDs" equal to 0, resulting in valid mapping
> nodes with a single ID to map being skipped, which is wrong.
> 
> Fix iort_node_get_rmr_info() by removing the bogus id_count
> check.
> 
> Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/acpi/arm64/iort.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3631230..56d8873 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
>  	for (i = 0; i < node->mapping_count; i++, map++) {
>  		struct acpi_iort_node *parent;
>  
> -		if (!map->id_count)
> -			continue;
> -
>  		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>  				      map->output_reference);
>  		if (parent != iommu)

Shameer, I know this may look like overkill since the hunk we are
removing is buggy but can you please test this patch on platforms
with RMR to make sure we are not triggering regressions by removing
it (by the specs that's what should be done but current firmware
is always something to reckon with) ?

Thanks,
Lorenzo
