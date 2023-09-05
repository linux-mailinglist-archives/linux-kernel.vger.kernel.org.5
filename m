Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52793792B98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbjIEQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353595AbjIEGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:49:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC031B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:49:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94C2E68B05; Tue,  5 Sep 2023 08:49:21 +0200 (CEST)
Date:   Tue, 5 Sep 2023 08:49:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Message-ID: <20230905064921.GB19701@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091350.16156-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:13:47AM +0200, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/target/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> index 6997bd7e45cf..9ba466b49613 100644
> --- a/drivers/nvme/target/trace.h
> +++ b/drivers/nvme/target/trace.h
> @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>  		return;
>  	}
>  
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy(name, req->ns->device_path,
> +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));

I'd just switch to snprintf instead, that the best way to ensure
termination..
