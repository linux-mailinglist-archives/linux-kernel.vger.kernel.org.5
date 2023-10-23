Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6017D2FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJWK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:27:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E857DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:26:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EBDC433C7;
        Mon, 23 Oct 2023 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698056819;
        bh=afivWCmIm1aktOqOx8GKzP/u0SdUkx/ZPjFi3uQ5QoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5sQ6uUhKHt4AYjqto1zWQILEcwCkGiLbptQaRMMzu/7tzIoKD+Z3M/ca4zqpJzSL
         Zph2LGqA7OQF8LJeTKOMGWG3G0Xc98fupJMalJj4OC2kRjtlklJOj53Qrz7R6RRLWK
         wEGi9xp2kF0KjMcvlcEtaln+sXTxck1lFZv+Pivu33FTDYKeuvp2wrZwlYXyWDZOuv
         nzdAcYskrTAiDhgWyJ32HC+UKSrWv4ucncVva67vpwIxFsgXRsjCcKIwipTgF9PnQJ
         RNnmFeI98M/Vi7b5lc7AGDSaIB0NyoNxZzI28Zt8qvVOsGdkoo1wdlCjb6F0jSHXzv
         AYsx0GinABaWQ==
Date:   Mon, 23 Oct 2023 11:26:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
Message-ID: <20231023102653.GA3282@willie-the-truck>
References: <cover.1697824215.git.robin.murphy@arm.com>
 <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:51:26PM +0100, Robin Murphy wrote:
> The bitmap-based scheme for tracking DTC counter usage turns out to be a
> complete dead-end for its imagined purpose, since by the time we have to
> keep track of a per-DTC counter index anyway, we already have enough
> information to make the bitmap itself redundant. Revert the remains of
> it back to almost the original scheme, but now expanded to track per-DTC
> indices, in preparation for making use of them in anger.
> 
> Note that since cycle count events always use a dedicated counter on a
> single DTC, we reuse the field to encode their DTC index directly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 126 +++++++++++++++++++++--------------------
>  1 file changed, 64 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f1ac8d0cdb3b..675f1638013e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -281,16 +281,13 @@ struct arm_cmn_node {
>  	u16 id, logid;
>  	enum cmn_node_type type;
>  
> -	int dtm;
> -	union {
> -		/* DN/HN-F/CXHA */
> -		struct {
> -			u8 val : 4;
> -			u8 count : 4;
> -		} occupid[SEL_MAX];
> -		/* XP */
> -		u8 dtc;
> -	};
> +	u8 dtm;
> +	s8 dtc;
> +	/* DN/HN-F/CXHA */
> +	struct {
> +		u8 val : 4;
> +		u8 count : 4;
> +	} occupid[SEL_MAX];
>  	union {
>  		u8 event[4];
>  		__le32 event_sel;
> @@ -540,12 +537,12 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
>  
>  		seq_puts(s, "\n     |");
>  		for (x = 0; x < cmn->mesh_x; x++) {
> -			u8 dtc = cmn->xps[xp_base + x].dtc;
> +			s8 dtc = cmn->xps[xp_base + x].dtc;
>  
> -			if (dtc & (dtc - 1))
> +			if (dtc < 0)
>  				seq_puts(s, " DTC ?? |");
>  			else
> -				seq_printf(s, " DTC %ld  |", __ffs(dtc));
> +				seq_printf(s, " DTC %d  |", dtc);
>  		}
>  		seq_puts(s, "\n     |");
>  		for (x = 0; x < cmn->mesh_x; x++)
> @@ -589,8 +586,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>  struct arm_cmn_hw_event {
>  	struct arm_cmn_node *dn;
>  	u64 dtm_idx[4];
> -	unsigned int dtc_idx;
> -	u8 dtcs_used;
> +	s8 dtc_idx[CMN_MAX_DTCS];
>  	u8 num_dns;
>  	u8 dtm_offset;
>  	bool wide_sel;
> @@ -600,6 +596,10 @@ struct arm_cmn_hw_event {
>  #define for_each_hw_dn(hw, dn, i) \
>  	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
>  
> +/* @i is the DTC number, @idx is the counter index on that DTC */
> +#define for_each_hw_dtc_idx(hw, i, idx) \
> +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)

This macro is pretty hideous ;) The kbuild robot complained as well, but
given that it's internal to the driver and it does make the callsites
quite a bit simpler, I'm inclined to stick with it for now. At least, I
couldn't come up with something else which was just as succinct.

Will
