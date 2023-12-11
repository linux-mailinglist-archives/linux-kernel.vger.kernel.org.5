Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A380C38C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjLKIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjLKIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:46:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14660C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:46:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DBC433C7;
        Mon, 11 Dec 2023 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702284417;
        bh=zjlRUhnaZnjsZZughQI/BxjLVo+4gBWoqW3Nl+z5Khw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcDKzfe9rsmIXuu2kqeOHU7yRm2NbwkVuULN0FrjITTjlxqmzO422rRbPkyU8nL4L
         UD+X9olvrhTq7AGWbcm4s9wEwH/am42xmw/Wwhro9OC85ij8IXXU0D7Bf/cDVeBWFN
         STOVjZIn/TIkJ9MLNOBNFRHaGE6ovx32H5ebWrpYvstzSSonepFSKAwzII3+VSZviS
         9SJf/NMBMoajszoJdo7OsdrMw0krOIB/J94WbDMJuryfWNoqMA6JCHouatti3sNbDG
         zXWSvluvyvp/HH7gLjm0K2jsmu5lJPaNQkWX+IoMKXirMi8vqnvf+IKjPV9YL0pG0o
         yO+uop5kGmZMA==
Date:   Mon, 11 Dec 2023 10:46:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        kheib@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox version support
Message-ID: <20231211084652.GC4870@unreal>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211063355.2630028-3-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 10:33:53PM -0800, Shinas Rasheed wrote:
> Add PF-VF mailbox initial version support
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---

<...>

> @@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
>  {
>  	u32 vf_version = (u32)cmd.s_version.version;
>  
> -	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF version:%d\n",
> +		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
> +	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
> +		rsp->s_version.version = vf_version;
>  	else
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +		rsp->s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
> +
> +	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
> +		vf_id, oct->vf_info[vf_id].mbox_version);
> +
> +	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>  }

<...>

> +#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V1

This architecture design is unlikely to work in the real world unless
you control both PF and VF environment. Mostly PF is running some old
legacy distribution while VFs run more modern OS and this check will
prevent to run new driver in VF.

Thanks
