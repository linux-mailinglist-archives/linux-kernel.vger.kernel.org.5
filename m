Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC4756103
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGQLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FBA1B9;
        Mon, 17 Jul 2023 04:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603F46101B;
        Mon, 17 Jul 2023 11:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F55DC433C8;
        Mon, 17 Jul 2023 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689591660;
        bh=MwFQQiUHWTSIvU9GMqKlkjYFECTDe1lUrP0Zudgxm+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ai5wtIlwCupgpMNHFd8IQe+3WMX0zjtQ6JLxvBF5PiHJQGFcnGpipuuCvZYgsY9tq
         PDVi4hvpj5V2c4vHWMAzmBD3uB6R516oWJxMUei6lHORGRSv6uYNbB0DhTmqPC5EiH
         OkcK6KQj5MSrrlWa1hMbWhTFeZlWEQ8DPwKeX55sjpppnZkeH1CfTKL37IDHqT+xxO
         kyM2MdVi98n3GX2f7Zb+w2zBObUTenQKzyRLgpg3a63yx6OGI+Ci8JBp5WqY4kJBkl
         /YUXoE4C09AVZkbtb1X3upG5CkMWtqNJMLaKUxvNlFz9vgu8ImDGekxLI9IagCy3x+
         em1X4etc18Ehw==
Date:   Mon, 17 Jul 2023 13:00:55 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v1] ACPI/IORT: fix IORT Reserved Memory Range node
 mapping error
Message-ID: <ZLUfZ5n/gKanIims@lpieralisi>
References: <1689589138-58042-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689589138-58042-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2, not v1.

Please update the subject.

"ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()"

On Mon, Jul 17, 2023 at 06:18:58PM +0800, Guanghui Feng wrote:
> In the ARM IORT specifications DEN 0049E.d, the recommended ID mapping format：
> Field		Note Description
> --------------------------------
> Input base	The lowest value in the input range
> Number of IDs	The number of IDs in the range "minus" one
> 
> When there is only one id mapping in the Reserved Memory Range
> (RMR) node, the node filed: "Number of IDs" is zero and
> iort_node_get_rmr_info will not analyse id mapping. This is
> not in compliance with the regulations.

Please replace this commit log with:

"According to the ARM IORT specifications DEN 0049 issue E,
the "Number of IDs" field in the ID mapping format reports
the number of IDs in the mapping range minus one.

In iort_node_get_rmr_info(), we erroneously skip ID mappings
whose "Number of IDs" equal to 0, resulting in valid mapping
nodes with a single ID to map being skipped, which is wrong.

Fix iort_node_get_rmr_info() by removing the bogus id_count
check".

Add a:

Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")

Bump version up to v3 and resend.

Thanks,
Lorenzo

> 
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
> -- 
> 1.8.3.1
> 
