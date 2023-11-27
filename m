Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D637FA89A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjK0SHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjK0SHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:07:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA005191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:07:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53BDC433C7;
        Mon, 27 Nov 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701108435;
        bh=C3iVJwmeksjG1jAgFK6vw2pYVe/zJA3lIfqMl4WWsac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fx2QF6SBm6idjn5TdulasO2joS/StL0OvmHxjqPckG9XbaDVKVQqLguxJ+olvY9fp
         ACMHcwPPgjcKunryqyL9FtMNaOBb7xdAIRGon4eElaOX8Wxy63hBHFUB59+NXRjUyt
         FL1l8BeDv907J+DzcvkrXFbWYeBc/0r6B4uYGno7EmzHMdX9ID3JJKWWm29+w2L3Ms
         amjd+gzzB1JeYYEHBbzZg2OtWWizp6kalTUrh4Pa1HxKZiiTt/hKcqI3x17EMFBDMY
         PTSVVm5b4at1yVXypqNr584qNxZRzsZaJAIU3u48Slb40iAqbUPch4eLPHGr/JWCPn
         rS4hrjKDnJ7Kw==
Date:   Mon, 27 Nov 2023 11:07:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bitao Hu <yaoma@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kanie@linux.alibaba.com
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Message-ID: <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:00:13PM +0800, Bitao Hu wrote:
> @@ -3631,6 +3631,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  		goto out_unlink_ns;
>  
>  	down_write(&ctrl->namespaces_rwsem);
> +	/* preventing adding ns during resetting */
> +	if (unlikely(ctrl->state != NVME_CTRL_LIVE)) {

We can't rely on ctrl->state for preventing deadlocks. Reading unlocked
ctrl->state is often used, but should be considered advisory-only since
the state could change immediatly after reading it.

> +		up_write(&ctrl->namespaces_rwsem);
> +		goto out_unlink_ns;
> +	}
>  	nvme_ns_add_to_ctrl_list(ns);
>  	up_write(&ctrl->namespaces_rwsem);
>  	nvme_get_ctrl(ctrl);
