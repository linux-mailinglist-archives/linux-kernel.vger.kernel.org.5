Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D47F1252
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjKTLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:42:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE439C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:42:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC9EC433C7;
        Mon, 20 Nov 2023 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700480549;
        bh=9EOytdIzHSPX1UrWq2Vnd6Lm8YR0exOx45k9xVk7W/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2Jis3QlXaU0cN9/u0hilLwYwMejoIaYlL1422LpRB1gppQuRCQSadg4tMnMW3mBm
         EXxUq//f+RhHfJuMXTrwYCuQZzlQtG8pMNeGukYCNc0PbUVqS8BETv4rs/2dAA8c0V
         ibm1HQ+ghZPnuoyqE8ovTOGASaG4hLvmEYIyj2FlbA5QDubZXNmr+1BK5z4V8C/92C
         LX7Elxvn5BXeL2mp6fQ83mNgpi3/F3dm9Wt/i08XwkKmIJYx+zOWfWZvICzfr2vB1+
         rFMobNVRWxhnoL5sNjEdKzhS87SnW11hrkiYQ9vArvvPuj4S/WLT+HZtnstdXG89Wy
         MznAYlNk004Pw==
Date:   Mon, 20 Nov 2023 11:42:24 +0000
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
Message-ID: <20231120114224.GB223713@kernel.org>
References: <20231116152114.88515-1-ivecera@redhat.com>
 <20231116152114.88515-4-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116152114.88515-4-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:21:12PM +0100, Ivan Vecera wrote:
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 1e9266de270b..ca8997d29c02 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>  
>  struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>  
> +/**
> + * i40e_pf_get_vsi_by_seid - find VSI by SEID
> + * @pf: pointer to a PF

nit: @seid is missing here

> + **/
> +static inline struct i40e_vsi *
> +i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
> +{
> +	struct i40e_vsi *vsi;
> +	int i;
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->seid == seid)
> +			return vsi;
> +
> +	return NULL;
> +}
> +
> +/**
> + * i40e_pf_get_veb_by_seid - find VEB by SEID
> + * @pf: pointer to a PF

Ditto

...

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c

...

> @@ -14848,23 +14831,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	/* make sure there is such a vsi and uplink */
> -	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> -		if (vsi->seid == vsi_seid)
> -			break;
> -
> -	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
> -		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
> -			 vsi_seid);
> -		return NULL;
> +	if (vsi_seid) {
> +		vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
> +		if (!vsi) {
> +			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
> +				vsi_seid);
> +			return NULL;
> +		}
>  	}
> -
>  	if (uplink_seid && uplink_seid != pf->mac_seid) {
> -		i40e_pf_for_each_veb(pf, veb_idx, veb) {
> -			if (veb->seid == uplink_seid) {
> -				uplink_veb = veb;
> -				break;
> -			}
> -		}
> +		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
>  		if (!uplink_veb) {
>  			dev_info(&pf->pdev->dev,
>  				 "uplink seid %d not found\n", uplink_seid);

The next part of this function looks like this:

		if (!uplink_veb) {
			dev_info(&pf->pdev->dev,
				 "uplink seid %d not found\n", uplink_seid);
			return NULL;
		}
	}
	/* get veb sw struct */
	veb_idx = i40e_veb_mem_alloc(pf);
	if (veb_idx < 0)
		goto err_alloc;
	veb = pf->veb[veb_idx];
	veb->flags = flags;
	veb->uplink_seid = uplink_seid;
	veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);

	/* create the VEB in the switch */
	ret = i40e_add_veb(veb, vsi);

Smatch complains that vsi may be used uninitialised here.
Which does seem possible to me if vsi_seid is 0.

...
