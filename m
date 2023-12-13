Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49797811AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjLMROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjLMROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA91109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:14:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991ADC433C8;
        Wed, 13 Dec 2023 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702487683;
        bh=svCcv04oY4pPhaP+PSf8jygjO7luSLUDKs0GTRKp+Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlRBHqgMa0oO92ov5WJduQRlrUcruMUHUti+EQXht5DU6hsCeDs4z7oTsO4CNbcWY
         +UwIcHpj/mUePiokaJV/x1QYB+HBw2mUJIoow7/PWjs/ZrhGVbwSDydK/zHJPUXzMM
         OQChXs3G89WUVY4M+9PE/JtvvQw6f1KKPkbnQ/PsoKABbW6Qx4lOZfgZIYWgdggLKT
         DHCvANtI0UaRvZvjFzfsyZ7U685lsz+b4URNIYi1rS5RsBzg2A+2tfhVgnkuyEnLoe
         w2oykk6gRAZQPzmoJIcW+McUhc2NnvLbukhCEFK0NHdq6TafGLymxJlLUP0GywYncx
         c9BNrNegUScHA==
Date:   Wed, 13 Dec 2023 17:14:37 +0000
From:   Simon Horman <horms@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Kunwu Chan <chentao@kylinos.cn>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, jacob.e.keller@intel.com,
        karol.kolacinski@intel.com, michal.michalik@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v2 iwl-next] ice: Fix some null pointer dereference
 issues in ice_ptp.c
Message-ID: <20231213171437.GI5817@kernel.org>
References: <20231212024015.11595-1-chentao@kylinos.cn>
 <1abd6bcb-6f6c-10a7-9b6f-e5e038233af8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abd6bcb-6f6c-10a7-9b6f-e5e038233af8@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:49:10AM +0100, Przemek Kitszel wrote:
> On 12/12/23 03:40, Kunwu Chan wrote:
> > devm_kasprintf() returns a pointer to dynamically allocated memory
> > which can be NULL upon failure.
> > 
> > Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> > Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> > Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> You found the bug (or some some static analysis tool in that case);
> there is no need to add Suggested-by for every person that suggests
> something during review - the tag is for "person/s that suggested
> making such change in the repo".
> 
> Subject line would be better if less generic, eg:
> ice: avoid null deref of ptp auxbus name
> 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index e9e59f4b5580..848e3e063e64 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2743,6 +2743,8 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
> >   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
> >   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
> >   			      ice_get_ptp_src_clock_index(&pf->hw));
> > +	if (!name)
> > +		return -ENOMEM;
> >   	aux_driver->name = name;
> >   	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
> > @@ -2989,6 +2991,8 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
> >   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
> >   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
> >   			      ice_get_ptp_src_clock_index(&pf->hw));
> > +	if (!name)
> > +		return -ENOMEM;
> >   	aux_dev->name = name;
> >   	aux_dev->id = id;
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Regarding iwl-next vs iwl-net: this bug is really unlikely to manifest,
> as we take care of both earlier and future mem allocs for ptp auxbus,
> and auxiliary_device_init() checks for null name, so no big deal,
> so: -next is fine

Thanks. FWIIW, this looks good to me too.

Reviewed-by: Simon Horman <horms@kernel.org>

