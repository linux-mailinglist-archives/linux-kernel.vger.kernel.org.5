Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43075C698
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGUMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGUMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E90172D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC6161961
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B1C433C8;
        Fri, 21 Jul 2023 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689941371;
        bh=WOYMgeLTYhtudrkqkThYSmblybXLug2suDbKhngipgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eo/Pvgfby/LygRdRVZBEg8k07M9qOd9WlBap7SM0rEe43UaqybHHlsZYNhuomEf71
         AK82+RIMVH2F2yNOLepKqy0ITncSghK4pDF33VxysekAMeBee456K0StqUaVjpHaTO
         LClcubUWPgm2grmVMAjGiI+WPbG1HkxyVfUwmyn4=
Date:   Fri, 21 Jul 2023 14:09:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, git@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
Subject: Re: [PATCH v2] cdx: add support for bus mastering
Message-ID: <2023072116-yin-prepaid-ff1a@gregkh>
References: <20230721114622.24313-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721114622.24313-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:16:22PM +0530, Nipun Gupta wrote:
> Introduce cdx_set_master() and cdx_clear_master() APIs to support
> enable and disable of bus mastering. Drivers need to use these APIs to
> enable/disable DMAs from the CDX devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---
> 
> Changes v1->v2:
> - Replace bme with bus_master_enable
> - Added check for dev_configure API callback
> - remove un-necessary error prints
> - changed conditional to if-else
> - updated commit message to use 72 columns
> 
>  drivers/cdx/cdx.c                       | 29 +++++++++++++
>  drivers/cdx/controller/cdx_controller.c |  4 ++
>  drivers/cdx/controller/mcdi_functions.c | 58 +++++++++++++++++++++++++
>  drivers/cdx/controller/mcdi_functions.h | 13 ++++++
>  include/linux/cdx/cdx_bus.h             | 16 +++++++
>  5 files changed, 120 insertions(+)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..71ddb56a5d08 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -182,6 +182,35 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
>  	return NULL;
>  }
>  
> +int cdx_set_master(struct cdx_device *cdx_dev)
> +{
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret = EOPNOTSUPP;

"-EOPNOTSUP"

