Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD07DC89F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjJaIsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJaIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:48:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110EDE;
        Tue, 31 Oct 2023 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698742078; x=1730278078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXkV3vl3hug9NMYxNH3bPgLYMhjDGNYVTPifMu6ZOfk=;
  b=LnXaAQV3IAiYOa4BKNU3b60spvR1ujDl/N8eUbOpDHGoHZpJnyVIrTG5
   xiWRCBoHGurl5i+YCFnAG7C7Tm+fVB9t4GucrQYjhPXI6fCd5WN6EQgo1
   x3kSpoOrtVJFuTmr1E7GfCI6CMdqrQnAiT9vqi42UTtR2W5cB3KbP96lX
   rgmbhangmlVUnXwQCstdx8BDkSerYW8t16dSGB7qExfOJV6Bl3tGymdwI
   LzZwnPQ1dL7XsK8MikNXVyp4QulhDUDjbxOpzG+nR42RXv/EAOYrfZ1Px
   8J10jl9INg7qgzCE5bUuY7WLFtp2TNw2Pzz+ggXxDukKG0tTT0StRxBDp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388061239"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388061239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754068685"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754068685"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:47:56 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id C627011F894;
        Tue, 31 Oct 2023 10:47:53 +0200 (EET)
Date:   Tue, 31 Oct 2023 08:47:53 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] ACPI: scan: Extract CSI-2 connection graph from
 _CRS
Message-ID: <ZUC_OQwk_dwNYU_N@kekkonen.localdomain>
References: <2187487.irdbgypaU6@kreacher>
 <3288922.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3288922.44csPzL39Z@kreacher>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Fri, Oct 20, 2023 at 04:36:28PM +0200, Rafael J. Wysocki wrote:
> +#define NO_CSI2_PORT (UINT_MAX - 1)
> +
> +static void alloc_crs_csi2_swnodes(struct crs_csi2 *csi2)
> +{
> +	size_t port_count = csi2->port_count;
> +	struct acpi_device_software_nodes *swnodes;
> +	size_t alloc_size;
> +	unsigned int i;
> +
> +	/*
> +	 * Allocate memory for ports, node pointers (number of nodes +
> +	 * 1 (guardian), nodes (root + number of ports * 2 (because for
> +	 * every port there is an endpoint)).
> +	 */
> +	if (check_mul_overflow(sizeof(*swnodes->ports) +
> +			       sizeof(*swnodes->nodes) * 2 +
> +			       sizeof(*swnodes->nodeptrs) * 2,
> +			       port_count, &alloc_size))
> +		goto overflow;
> +
> +	if (check_add_overflow(sizeof(*swnodes) +
> +			       sizeof(*swnodes->nodes) +
> +			       sizeof(*swnodes->nodeptrs) * 2,
> +			       alloc_size, &alloc_size))
> +		goto overflow;
> +
> +	swnodes = kmalloc(alloc_size, GFP_KERNEL);
> +	if (!swnodes)
> +		return;
> +
> +	swnodes->ports = (struct acpi_device_software_node_port *)(swnodes + 1);
> +	swnodes->nodes = (struct software_node *)(swnodes->ports + port_count);
> +	swnodes->nodeptrs = (const struct software_node **)(swnodes->nodes + 1 +
> +				2 * port_count);
> +	swnodes->num_ports = port_count;
> +
> +	for (i = 0; i < 2 * port_count + 1; i++)
> +		swnodes->nodeptrs[i] = &swnodes->nodes[i];
> +
> +	swnodes->nodeptrs[i] = NULL;
> +
> +	for (i = 0; i < port_count; i++)
> +		swnodes->ports[i].port_nr = NO_CSI2_PORT;
> +
> +	csi2->swnodes = swnodes;
> +	return;
> +
> +overflow:
> +	acpi_handle_info(csi2->handle, "too many _CRS CSI-2 resource handles (%zu)",
> +			 port_count);

I'd move this to where the conditions are, they can be merged.

-- 
Regards,

Sakari Ailus
