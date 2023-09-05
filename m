Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96D79258F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjIEQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353601AbjIEGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:50:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C0DB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:50:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6703D68B05; Tue,  5 Sep 2023 08:50:32 +0200 (CEST)
Date:   Tue, 5 Sep 2023 08:50:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <20230905065032.GC19701@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091350.16156-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:13:49AM +0200, Daniel Wagner wrote:
> The port entry binding might not be existing and thus the req->port
> pointer is not valid.
> 
> Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/target/discovery.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 668d257fa986..fc113057cb95 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>  		goto out;
>  	}
>  
> +
> +	/* No port assigned, portentrybinding is missing */

Double new line above, and I think a missing white space before
binding.  But I'm still confused how we can get here without req->port
set.  Can you try to do a little more analysis as I suspect we have
a deeper problem somewhere.
