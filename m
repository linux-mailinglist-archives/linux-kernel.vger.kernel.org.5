Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1D808BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443510AbjLGPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443516AbjLGPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:31:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9C10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:31:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CF6A227A87; Thu,  7 Dec 2023 16:31:38 +0100 (CET)
Date:   Thu, 7 Dec 2023 16:31:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 0/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <20231207153138.GA20644@lst.de>
References: <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-4-dwagner@suse.de> <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-4-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-3-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-2-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

this looks generally good to me.  A few comments, all but one are
cosmetic.

> @@ -1676,9 +1678,9 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,

This an now take the ns_head instead of the ns.

> @@ -1776,11 +1778,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)

This can take a ctrl and ns_head instead of the ns.

> @@ -1835,8 +1837,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)

This as well after updating nvme_ns_has_pi to take the ns_head.

> @@ -1898,7 +1900,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  		struct nvme_ns *ns, struct nvme_id_ns *id)

This as well after fixing up nvme_lba_to_sect to take the ns_head.

> @@ -2052,7 +2055,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,

This one as well.

> @@ -128,7 +129,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->head->disk) >> ilog2(ns->head->zsze));

This doesn't work, as the head disk doesn't exist for !multipath setups.

> @@ -162,7 +163,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,

This could do with ctrl + ns_head now
