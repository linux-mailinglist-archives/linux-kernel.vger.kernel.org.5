Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0871F781315
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379517AbjHRStp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379555AbjHRSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9DA422B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176A8662E5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534A2C433C7;
        Fri, 18 Aug 2023 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692384560;
        bh=+mR7R0ZzaKnsUsiawM87wkOBcnR1vZCEr7AESk3cGvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk2gwfZ6E+ElhnGgDPCiBtS7W75P9LjF8LisSNLxZJfVha98kiwa7sou8Hsi5p5Bm
         NQ+lFAiDDLqeFwrXgt72m5CfrlBuJKJtPGztySVVkmuMqZZSvidpOwdnF+jJcpqRqH
         vsS/bFBFg/VkZyTD0ftJWO792HBCDMPz0S2y8CvDMEdnGtk7SV0Csy93Vb9TIVJhId
         tEybJBjKkBI9W01pz8oAmxabHFqSmDgpJYt1byhvREm3ingPyiYWLmwbXARShCEptA
         RuWqTQGLs6HKEgOeceyJHDJsoegkkFuedp3ViQn3MHODhD6y+AOh5DDhsrujtrVo20
         9Jx90Nudgjnow==
Date:   Fri, 18 Aug 2023 21:49:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        richardcochran@gmail.com, kalesh-anakkur.purayil@broadcom.com,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v3] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230818184901.GC22185@unreal>
References: <20230817174351.3480292-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817174351.3480292-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:13:51PM +0530, Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Fixed re-ordering of headers in alphabetical order
>         2. Refactored SoC revision identification logic
>         3. CN10K errata revisions can be different from atomic update
>            supported revision devices.
>         4. Removed ptp device check.
> v2:
>     - Addressed review comments given by Simon Horman, Kalesh Anakkur Purayil
> 	1. Removed inline keyword for function in .c file
>         2. Modified/optimized conditions related boolean
> 
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  12 ++
>  .../net/ethernet/marvell/octeontx2/af/ptp.c   | 155 ++++++++++++++--
>  .../net/ethernet/marvell/octeontx2/af/ptp.h   |   3 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
>  .../marvell/octeontx2/nic/otx2_common.h       |   1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 174 ++++++++++++++----
>  7 files changed, 304 insertions(+), 55 deletions(-)

<...>

> +static bool is_tstmp_atomic_update_supported(struct otx2_ptp *ptp)
> +{
> +	struct ptp_get_cap_rsp *rsp;
> +	struct msg_req *req;
> +	int err;
> +
> +	if (!ptp->nic)
> +		return false;
> +
> +	mutex_lock(&ptp->nic->mbox.lock);
> +	req = otx2_mbox_alloc_msg_ptp_get_cap(&ptp->nic->mbox);
> +	if (!req)
> +		return false;
> +
> +	err = otx2_sync_mbox_msg(&ptp->nic->mbox);
> +	if (err)
> +		return false;

Shouldn't you call to mutex_unlock() in two returns above?

Thanks

> +
> +	rsp = (struct ptp_get_cap_rsp *)otx2_mbox_get_rsp(&ptp->nic->mbox.mbox, 0,
> +							  &req->hdr);
> +	mutex_unlock(&ptp->nic->mbox.lock);
> +
> +	if (IS_ERR(rsp))
> +		return false;
> +
> +	if (rsp->cap & PTP_CAP_HW_ATOMIC_UPDATE)
> +		return true;
> +
> +	return false;
> +}
