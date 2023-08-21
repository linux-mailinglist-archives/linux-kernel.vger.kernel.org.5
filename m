Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20083783494
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjHUVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHUVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E6D9;
        Mon, 21 Aug 2023 14:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E17863B42;
        Mon, 21 Aug 2023 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB690C433C8;
        Mon, 21 Aug 2023 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692651623;
        bh=rPP1ftZZu8+eeOfNcBx/bQ/TCM65ce1htppkQnp2ueg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLsTWwBIQH8uo+xiYezjrvaWDvIaWBEzzASPBZh+Csz2Khdf06gClRLZPBNGSecDL
         ddgmxumcskg1BiTvsq4QuYrHen7LBR654tt7iooLzvdvAIqgbgRRI3DHtR5l0xAevI
         WM6RhaPyh54QhX+kkLMGdS2NBfLCTWJElEH75s2lwdu5P+iodOVNHKhyjELT9DlJa4
         Z/Ggnk5G5NM4mKz3eCjcm15+I+4o39hqiw9+zIhTLym9XdCorPfu8umkKXmWzLy+mD
         94z0VerqiIw9qmLDqQmwiVY681v8uz8u8nbF9qY8MBnQjlo80/j/kMC8V18q0jX07v
         yOiJ5LFja4O/g==
Received: (nullmailer pid 2284013 invoked by uid 1000);
        Mon, 21 Aug 2023 21:00:20 -0000
Date:   Mon, 21 Aug 2023 16:00:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, isaacmanjarres@google.com,
        conor+dt@kernel.org, rafael@kernel.org, devicetree@vger.kernel.org,
        jeremy.kerr@canonical.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk, arnd@arndb.de,
        hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>,
        ulf.hansson@linaro.org, linus.walleij@linaro.org
Subject: Re: [PATCH V3 2/2] of/platform: increase refcount of fwnode
Message-ID: <169265161637.2283882.6488993918028899667.robh@kernel.org>
References: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
 <20230821023928.3324283-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821023928.3324283-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Aug 2023 10:39:28 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 0f8e5651095b
> ("of/platform: Propagate firmware node by calling device_set_node()")
> use of_fwnode_handle to replace of_node_get, which introduces a side
> effect that the refcount is not increased. Then the out of tree
> jailhouse hypervisor enable/disable test will trigger kernel dump in
> of_overlay_remove, with the following sequence
> "
>    of_changeset_revert(&overlay_changeset);
>    of_changeset_destroy(&overlay_changeset);
>    of_overlay_remove(&overlay_id);
> "
> 
> So increase the refcount to avoid issues.
> 
> This patch also release the refcount when releasing amba device to avoid
> refcount leakage.
> 
> Fixes: 0f8e5651095b ("of/platform: Propagate firmware node by calling device_set_node()")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  - Move amba device changes to patch 1/1
> 
> V2:
>  - Per Andy's comment, use of_fwnode_handle(of_node_get(np))
>  - release amba device of_node refcount when releasing amba device, this is
>    done from code inspection, no test.
> 
>  drivers/of/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

