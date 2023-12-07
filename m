Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710CE808DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjLGQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:44:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BB10DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:45:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FEDC433C7;
        Thu,  7 Dec 2023 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701967501;
        bh=r+2jjC0f0ebNBy1BCSaTbfdEHy6BgmMv/wALzLuGFfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O56R/5dxnNuijI23Fdx2eClph/7XUdaH7+xQVKceIHKqtHIUa8zQ3HuzXiQxzW/Cn
         l+66bW9N17S2w5Tx9CeE8OfpgcfehGmlSYAtcF1/NNoEvCQ2ErSUDrJGPsxiQZ/XDv
         i+kSR00V0rPvGaZqdv5iy9d4a9xTQFEb2I56bxvg4POZz2R9ZvVLeoApwmqgE0Fb5X
         BvZXqy9c2cF5A9I1R0UBVSeqZWiuzyxnRHpWChxNzv9A+5nuzQeUYtnU5W1yyDy0Mc
         5NEZFKc0baTll7ZqT8PgeEoGoP1X1EWkwREJswtHCIdMn7PqIhvhdMymJppy0wKYQo
         zgFY37u9FLN/Q==
Date:   Thu, 7 Dec 2023 09:44:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZXH2is7F56nRlGqd@kbusch-mbp>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-4-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:36:23PM +0100, Daniel Wagner wrote:
> @@ -3418,6 +3419,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	head->ns_id = info->nsid;
>  	head->ids = info->ids;
>  	head->shared = info->is_shared;
> +	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>  	kref_init(&head->ref);

I think we need to add:

	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);	

So that we don't get periodic messages like:

	[   60.469730] ns_head_update_nuse: 39 callbacks suppressed
	[  159.532901] ns_head_update_nuse: 1999 callbacks suppressed
