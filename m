Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A2762B63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGZG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGZG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69713E;
        Tue, 25 Jul 2023 23:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC2D4615D5;
        Wed, 26 Jul 2023 06:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C10C433C8;
        Wed, 26 Jul 2023 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690352824;
        bh=upPRTBdQI2wH9eTqLVZgmtXfPMny6sYV8ZuTbavkfn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fv9q5ZqVJ36qpYD6nJaBTYoyKJANH6Uyjo+MX8d/7K8LKhRtiqX0v3zl0vegmmJ5U
         gr8L7WicKs/RvyOdAnD/4dadB6QNKZHo9BE0A2RO+PUgUBFZXIckrNlR41HhMu96AA
         D2wGEhHUISY/MMi3YWVyRINWUCMh96+iWMcqS2nYEbeJho9fUa4u0rrUfxF05etIrT
         6eJcqIxMKlJNfYT7jy3WwFUSJ19gp3qPvIvj1kAJxYETY8hCaFK/Nt5iuPenSU+w4d
         XGCyAKj3M9ZeA6LPV1cdybuZvrnpXhGuzCf6y513lVjH4QKO9pqu2WubOX9f4WyWN4
         2RWMIk59eHf8w==
Date:   Tue, 25 Jul 2023 23:30:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH v2] misc: fastrpc: Fix incorrect DMA mapping unmap request
Message-ID: <zo6wjmqolvnla7x24qguh6rbjpf7l62vmckxhy3nps7hhaljdr@kyoh6xedhxaq>
References: <1690182571-7348-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690182571-7348-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:39:31PM +0530, Ekansh Gupta wrote:
> Scatterlist table is obtained during map create request and the same

I'm guessing that this all happens in fastrpc_map_create() where:

  map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);

fails, we jump to map_err, and then call fastrpc_map_put(map), which
then ends up in the code below?

> table is used for DMA mapping unmap. In case there is any failure
> while getting the sg_table, ERR_PTR is returned instead of sg_table.

The problem isn't that ERR_PTR() is being returned, the problem is that
this is being assigned to map->table and you keep running.

> 
> When the map is getting freed, there is only a non-NULL check of
> sg_table which will also be true in case failure was returned instead
> of sg_table. This would result in improper unmap request. Add proper
> check to avoid bad unmap request.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

You always test your own patches, so no need to declare this.

> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v2:
>   - Added fixes information to commit text
> 
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9666d28..75da69a 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -313,7 +313,7 @@ static void fastrpc_free_map(struct kref *ref)
>  
>  	map = container_of(ref, struct fastrpc_map, refcount);
>  
> -	if (map->table) {
> +	if (map->table && !IS_ERR(map->table)) {

Rather than carrying around an IS_ERR(map->table), I think you should
address this at the originating place. E.g. assign the return value of
the dma_buf_map_attachment_unlocked() to a local variable and only if it
is valid you assign map->table. Or perhaps make it NULL in the error
path.

Regards,
Bjorn

>  		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
>  			struct qcom_scm_vmperm perm;
>  			int vmid = map->fl->cctx->vmperms[0].vmid;
> -- 
> 2.7.4
> 
