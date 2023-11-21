Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32B77F36E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKUTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:45:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8548191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:45:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A6DC433C8;
        Tue, 21 Nov 2023 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700595909;
        bh=0tE7FUri9NR3r1ltIJTlrq+5XAyUqVTBZs2c+Lm0tcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7klvz5c3eK1Ct/KL2pKu0Aob8mnF4NuPOLshrD7w88j77Zqmdr+BfHVcIHDf9BAM
         BhAdht3THEq54q+9RDSyDLZeuZuYr1I8Ikc3lewRN25Z2UbmxCnUhBIHBZy12liD/c
         IFCfQNtDl8HEpPjinlFOJaNBrbm3VTb6qtdyns/aqsEwAiHa6Jj1ZD/W6dHgfWvsDQ
         Vbs7STtmjAu6C2DBcPgzPK3tUZQ+vKKTMxR167q+Of7kxAYS5KUibJX6z+4ELaYCpC
         Cr2RPffe0AU6TbI0zLABZtbWvqgtZWCNeax0OEBcLYiEIrdZT7iuaY0Cbo56A8kBiA
         TWhRmuSmuY3RA==
Date:   Tue, 21 Nov 2023 19:45:04 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        mschmidt@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Message-ID: <20231121194504.GB16629@kernel.org>
References: <20231116152114.88515-1-ivecera@redhat.com>
 <20231116152114.88515-4-ivecera@redhat.com>
 <20231120114224.GB223713@kernel.org>
 <26b17c32-c9ad-4b4c-8193-3a9757e587db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b17c32-c9ad-4b4c-8193-3a9757e587db@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 06:55:42PM +0100, Ivan Vecera wrote:
> 
> On 20. 11. 23 12:42, Simon Horman wrote:
> > On Thu, Nov 16, 2023 at 04:21:12PM +0100, Ivan Vecera wrote:
> > > Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> > > VEB or VSI by their SEID value and use these helpers to replace
> > > existing open-coded loops.
> > > 
> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > 
> > Hi Ivan,
> > 
> > some minor feedback from my side.
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> > > index 1e9266de270b..ca8997d29c02 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
> > >   struct device *i40e_hw_to_dev(struct i40e_hw *hw);
> > > +/**
> > > + * i40e_pf_get_vsi_by_seid - find VSI by SEID
> > > + * @pf: pointer to a PF
> > 
> > nit: @seid is missing here
> > 
> > > + **/
> > > +static inline struct i40e_vsi *
> > > +i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
> > > +{
> > > +	struct i40e_vsi *vsi;
> > > +	int i;
> > > +
> > > +	i40e_pf_for_each_vsi(pf, i, vsi)
> > > +		if (vsi->seid == seid)
> > > +			return vsi;
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +/**
> > > + * i40e_pf_get_veb_by_seid - find VEB by SEID
> > > + * @pf: pointer to a PF
> > 
> > Ditto
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > 
> > ...
> > 
> > > @@ -14848,23 +14831,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
> > >   	}
> > >   	/* make sure there is such a vsi and uplink */
> > > -	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> > > -		if (vsi->seid == vsi_seid)
> > > -			break;
> > > -
> > > -	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
> > > -		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
> > > -			 vsi_seid);
> > > -		return NULL;
> > > +	if (vsi_seid) {
> > > +		vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
> > > +		if (!vsi) {
> > > +			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
> > > +				vsi_seid);
> > > +			return NULL;
> > > +		}
> > >   	}
> > > -
> > >   	if (uplink_seid && uplink_seid != pf->mac_seid) {
> > > -		i40e_pf_for_each_veb(pf, veb_idx, veb) {
> > > -			if (veb->seid == uplink_seid) {
> > > -				uplink_veb = veb;
> > > -				break;
> > > -			}
> > > -		}
> > > +		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
> > >   		if (!uplink_veb) {
> > >   			dev_info(&pf->pdev->dev,
> > >   				 "uplink seid %d not found\n", uplink_seid);
> > 
> > The next part of this function looks like this:
> > 
> > 		if (!uplink_veb) {
> > 			dev_info(&pf->pdev->dev,
> > 				 "uplink seid %d not found\n", uplink_seid);
> > 			return NULL;
> > 		}
> > 	}
> > 	/* get veb sw struct */
> > 	veb_idx = i40e_veb_mem_alloc(pf);
> > 	if (veb_idx < 0)
> > 		goto err_alloc;
> > 	veb = pf->veb[veb_idx];
> > 	veb->flags = flags;
> > 	veb->uplink_seid = uplink_seid;
> > 	veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
> > 	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
> > 
> > 	/* create the VEB in the switch */
> > 	ret = i40e_add_veb(veb, vsi);
> > 
> > Smatch complains that vsi may be used uninitialised here.
> > Which does seem possible to me if vsi_seid is 0.
> 
> Yes, the support for floating VEBs is and WAS broken prior this patch and it
> is fixed by the following patch.
> 
> Prior this patch... Let's vsi_seid == 0:
> 
> 	/* make sure there is such a vsi and uplink */
> 	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> 		if (vsi->seid == vsi_seid)
> 			break;
> -> here vsi_idx == pf->num_alloc_vsi because there cannot be VSI with SEID
> == 0... and VSI points after the pf->vsi[] array.
> 
> 	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
> 		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
> 			 vsi_seid);
> 		return NULL;
> 	}
> 
> This condition is not met, although vsi_idx == pf->num_alloc_vsi but
> vsi_seid == 0 so the rest of code ended by:
> 
> 	ret = i40e_add_veb(veb, vsi);
> 
> and vsi pointer points to invalid area (item after the last one from
> pf->vsi).
> 
> As I mentioned the broken floating VEB functionality (where vsi_seid == 0
> and uplink_seid == 0) is fixed by the following patch.

Thanks Ivan,

I see that I flagged a false positive, sorry about that.
I understand things quite a bit better after reading your explanation
above.
