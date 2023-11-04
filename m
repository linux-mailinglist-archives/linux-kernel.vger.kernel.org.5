Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20747E0FB1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKDNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:44:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00412112
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:44:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC64C433C7;
        Sat,  4 Nov 2023 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699105454;
        bh=Exi3Dp1tHjuY5WnbbDcF0Tl0B0MvUo53adtNSeJJKiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhFgqocTgMzh5//2O+R55xZID+VNPjBzSnYZ/XGKMTlO7Doys6mAyTQHVofCaS/is
         qnJLPB+wfjaaCN5qqpJfUL+CR5PI+UO28EQuV1Fu9bRe7jAGjkZ16abpO4iS4sadHC
         NrYBN5lnlwogjWRq7yw1FZK7mG11MJIGKypBYA2e7Qu57NW/2YtulryB5kqD3kyhIe
         BaxJ6+9OIUWKiqlYZwSawB/t4X78Qml4sVQkBdt7w7lbtYMeqeqV3xYy1JG1ntEi1b
         Qud8eaNS1hN2U5OtjVfS003g/lSh/V0K7vD6By6RpgdTd6hMf49x1DGl79UjrFEgjy
         ksEgIUwkFKwnQ==
Date:   Sat, 4 Nov 2023 09:43:54 -0400
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Avinash Dayanand <avinash.dayanand@intel.com>
Subject: Re: [PATCH net] i40e: Fix adding unsupported cloud filters
Message-ID: <20231104134354.GD891380@kernel.org>
References: <20231103204216.1072251-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103204216.1072251-1-ivecera@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Avinash Dayanand

On Fri, Nov 03, 2023 at 09:42:16PM +0100, Ivan Vecera wrote:
> If a VF tries to add unsupported cloud filter through virchnl
> then i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but
> this error code is stored in 'ret' instead of 'aq_ret' that
> is used as error code sent back to VF. In this scenario where
> one of the mentioned functions fails the value of 'aq_ret'
> is zero so the VF will incorrectly receive a 'success'.
> 
> Use 'aq_ret' to store return value and remove 'ret' local
> variable. Additionally fix the issue when filter allocation
> fails, in this case no notification is sent back to the VF.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

as a fix targeted at 'net' this probably warrants a fixes tag.
Perhaps the following is appropriate?

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")

The above not withstanding, this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 08d7edccfb8ddb..3f99eb19824527 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3844,7 +3844,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = NULL;
>  	int aq_ret = 0;
> -	int i, ret;
> +	int i;
>  
>  	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
>  		aq_ret = -EINVAL;
> @@ -3868,8 +3868,10 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  	}
>  
>  	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
> -	if (!cfilter)
> -		return -ENOMEM;
> +	if (!cfilter) {
> +		aq_ret = -ENOMEM;
> +		goto err_out;
> +	}
>  
>  	/* parse destination mac address */
>  	for (i = 0; i < ETH_ALEN; i++)
> @@ -3917,13 +3919,13 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  
>  	/* Adding cloud filter programmed as TC filter */
>  	if (tcf.dst_port)
> -		ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
> +		aq_ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
>  	else
> -		ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
> -	if (ret) {
> +		aq_ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
> +	if (aq_ret) {
>  		dev_err(&pf->pdev->dev,
>  			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
> -			vf->vf_id, ERR_PTR(ret),
> +			vf->vf_id, ERR_PTR(aq_ret),
>  			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
>  		goto err_free;
>  	}
> -- 
> 2.41.0
> 
> 
