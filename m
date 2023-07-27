Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5206765541
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjG0Njg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjG0Nje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087E2D64;
        Thu, 27 Jul 2023 06:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577E461E8A;
        Thu, 27 Jul 2023 13:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2226BC433C7;
        Thu, 27 Jul 2023 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690465172;
        bh=6hdy3JwNg2XitS/vh4UEJyJy/HRwoPzoH5X3uacaKT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjLFfCqAynxjdNRkS7rjdkXwFZ8VUT65eQGhRxn0YXQPjLqnayngL6pmxJ2l0x2h2
         WXUKexGRQXRVqO/yZMZbm1YAFgKc5vFCYFonNcQJHORMt1+aLqDa7k/lq9vH0dIZtQ
         CZ2ylUXrn2Y+BJQgzIQkHU1RqFjzFDlf21CcmcydTj5lbYidbngPtZe6b2siDxHfpV
         xqrK+FwJ8KBHOZvsX2/g3w9xB+ksW/5av82FNRv1+QlgHyWWsEEfJu3N/AcawG1MYx
         6vbFGotXsBzvn0H3GKVjFGM5naXRy2GMpfffiRPHyA08rAhKAxBnhdH00smO7oAdkm
         ilIqAb1zMuPsg==
Date:   Thu, 27 Jul 2023 15:39:27 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZMJzj2oe0B2Qp8vp@lpieralisi>
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

[+Catalin, Will]

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

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Catalin/Will,

can you pick this up please ?

Thanks,
Lorenzo

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
> -- 
> 1.8.3.1
> 
