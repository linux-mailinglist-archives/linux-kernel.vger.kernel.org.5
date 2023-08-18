Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02D780FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357685AbjHRP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378419AbjHRP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778322D57
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D763630A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB29C433C7;
        Fri, 18 Aug 2023 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374299;
        bh=HPX1jLHX4ON6VlyL/GBvHpUzxySBROUCaipWI2UOZwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tspQuu8Pd09F7olmQVFCWeIUv0Xc7Jpa7xbgBx5xvw7TEn9QBTKKLb++w3bahMa2f
         Lg/OdBpqS7avR+Um56xAWIUuty0+wmU2uTeCF3/5El+JYJZRSQhyekOqNvseeOExCw
         fd8T0wc1lFQxKn07seLOtETsyTd3s9LKRT+2+sRmqDx2ljnqDIg2Jvtc1mdACmp6Vt
         4zsmW6pDfc5erBg3NoEio5heEA0AKb7dO5eD2HS8oLzNfjlQrGwtU8I54ENE/9doI0
         7Lu4SU4PcgPUwbMQI9YEJaGH+l7xR5ZRE9B03CS6FNi3cHhxqHRGy/s45Be8o70pB+
         VSnSa8YhYoP1A==
Date:   Fri, 18 Aug 2023 16:58:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
Message-ID: <20230818155815.GY986605@google.com>
References: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023, Michał Mirosław wrote:

> of_reg is the only constant member of struct mfd_cell. It seems to be

Sorry, what?

struct mfd_cell {
        const char              *name;
[...]
        const struct mfd_cell_acpi_match        *acpi_match;
[...]
        const struct software_node *swnode;
[...]
        const char              *of_compatible;
[...]
        const u64 of_reg;
[...]
        const struct resource   *resources;
[...]
        const char * const      *parent_supplies;
[...]
};

> accidental and prevents dynamically filling in mfd_cells that use of_reg.
> Remove the `const`.

Dynamically filling mfd_cells is generally frowned upon.

Please submit this with the code that will be using it.

> Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  include/linux/mfd/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index 47e7a3a61ce6..e8bcad641d8c 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -92,7 +92,7 @@ struct mfd_cell {
>  	 * (above) when matching OF nodes with devices that have identical
>  	 * compatible strings
>  	 */
> -	const u64 of_reg;
> +	u64 of_reg;
>  
>  	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
>  	bool use_of_reg;
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
