Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1743793AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbjIFLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjIFLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:23:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E0A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 296D121E86;
        Wed,  6 Sep 2023 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693999395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPvKQcU11I1ppKW0Cxmttf5u89JWWvqc2qqFIjOvDCs=;
        b=Clczds3lKdaMEW9LfcujUs16l1nM8d3HLU8ejUWU7gYlPOCSyFbm4cWVzX/L3dYlBWfrQ6
        rBjQ8Ap/bDcgWu1RYRwGiD3rODv57tQPximIDW5coac4FxxTerODAMhjmWWg8XguRLmX44
        ctEVd7Uoas5v9AcdA/tes0zQX5on++Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693999395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPvKQcU11I1ppKW0Cxmttf5u89JWWvqc2qqFIjOvDCs=;
        b=nU0YTpUVY5U53Zd7xksP8dVbYQY61KWqO91FzjFSeoSy/rRPhRjSzRUAJdfYZCkPFj2pUT
        tfU2YxT3gRrVupBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 991351333E;
        Wed,  6 Sep 2023 11:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UItbIyJh+GRXUAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:23:14 +0000
Message-ID: <ba517afc-c99c-4712-9166-bed9958e6124@suse.de>
Date:   Wed, 6 Sep 2023 13:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:13, Daniel Wagner wrote:
> The port entry binding might not be existing and thus the req->port
> pointer is not valid.
> 
> Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/discovery.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 668d257fa986..fc113057cb95 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>   		goto out;
>   	}
>   
> +
> +	/* No port assigned, portentrybinding is missing */

Missing space.

> +	if (!req->port) {
> +		req->error_loc =
> +			offsetof(struct nvme_get_log_page_command, lpo);
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		goto out;
> +	}
> +
>   	/*
>   	 * Make sure we're passing at least a buffer of response header size.
>   	 * If host provided data len is less than the header size, only the
Otherwise looks good.

Cheers,

Hannes

