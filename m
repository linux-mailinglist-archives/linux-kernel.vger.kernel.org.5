Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3113784B08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjHVUGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjHVUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007CCE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F29F62971
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952E1C433C7;
        Tue, 22 Aug 2023 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692734792;
        bh=9uNpH3LrQCEQiJgqF9s6CrJbC1J/+shcuh8QcZh7LL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f84u/Ig5YbCvPQ42JwmU+nDvc7DqfIokmzNHB6USEswJPxnbIaSWOw6NconMGHJzW
         FZ8WI+5oLYVhfYeUtJKdruniXAV/0nbrxDV17TiugrvkiyYL5cMvh8KMr5fq2Aakcd
         moVaUk9aR8fgxd8qojqdjWDiCsxHPy0yoyNwxI50fzO6Sm/BhGV2gF075hGQ93I5m4
         BFdnL7h5TWtqJufNuYGSL9DY5dep4u20TnkHVFzIwkENdRvNP0ysml1XX/WQhVbx6D
         mSNjpLUs/wKG7xOi8F8xS24asek5xsoNbUqbNPPgBjWLB0GHh7aKvQ59FMJ22f48O4
         djckyngFsgFLw==
Date:   Tue, 22 Aug 2023 22:06:27 +0200
From:   Simon Horman <horms@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        lcherian@marvell.com, jerinj@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 2/3] octeontx2-af: CN10KB: fix PFC configuration
Message-ID: <20230822200627.GB3523530@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-3-sumang@marvell.com>
 <20230822071607.GJ2711035@kernel.org>
 <f922ac8896974b3823d238894498c8e135f862b6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f922ac8896974b3823d238894498c8e135f862b6.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 01:12:26PM +0200, Paolo Abeni wrote:
> On Tue, 2023-08-22 at 09:16 +0200, Simon Horman wrote:
> > On Mon, Aug 21, 2023 at 10:55:15AM +0530, Suman Ghosh wrote:
> > > From: Hariprasad Kelam <hkelam@marvell.com>
> > > 
> > > The previous patch which added new CN10KB RPM block support,
> > > has a bug due to which PFC is not getting configured properly.
> > > This patch fixes the same.
> > 
> > Hi Suman,
> > 
> > I think it would be useful to describe what the bug is - it seems like an
> > incorrect mask in some cases - and how that might affect users. Better
> > still would be commands for an example usage where the problem previously
> > manifested.
> 
> Suman, please address Simon's feedback above in the new iteration.
> 
> > > 
> > > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > > ---
> > >  drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 17 +++++++++--------
> > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> > > index b4fcb20c3f4f..af21e2030cff 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> > > @@ -355,8 +355,8 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
> > >  
> > >  void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
> > >  {
> > > +	u64 cfg, pfc_class_mask_cfg;
> > >  	rpm_t *rpm = rpmd;
> > > -	u64 cfg;
> > >  
> > >  	/* ALL pause frames received are completely ignored */
> > >  	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
> > > @@ -380,9 +380,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
> > >  		rpm_write(rpm, 0, RPMX_CMR_CHAN_MSK_OR, ~0ULL);
> > >  
> > >  	/* Disable all PFC classes */
> > > -	cfg = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
> > > +	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
> > > +						RPMX_CMRX_PRT_CBFC_CTL;
> > 
> > Maybe it is overkill, but as this appears at least twice,
> > perhaps a helper would be appropriate.
> 
> I think this is a matter of personal preferences (there is another
> similar chunk with will not fit an helper, short of implementing it
> with a somewhat ugly macro. So the overall code would be asymmetric), 
> 
> I'm fine either way.

Likewise, I don't feel strongly either way.
