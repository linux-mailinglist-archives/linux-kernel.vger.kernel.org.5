Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1716C7FC2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjK1OHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjK1OHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA5D64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701180455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQxu/Q+/3YRfoin23/gnMqXUeIr+YHYWByn9KpCUiOo=;
        b=ZzJbNQEktvBMAUTM0CuqT1zVRmyLGGtGhgSwGYJ9lPKw2RBU890RHL7nVL83vM18zExOB6
        ivtKSZvgw1E//qMusjK7Tr2lzPlTolPke5P+rR+CYscoPvpv81or5oJxg8m/IHKHtKeDZt
        6hlw5f/RxHrZNbxUx7gIgr7dGnK7Alk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-iwcpNMSPMTaHQiZc-nN-HA-1; Tue, 28 Nov 2023 09:07:30 -0500
X-MC-Unique: iwcpNMSPMTaHQiZc-nN-HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB44A101A53B;
        Tue, 28 Nov 2023 14:07:29 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A71502A;
        Tue, 28 Nov 2023 14:07:29 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 90D0330C1A8C; Tue, 28 Nov 2023 14:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 8E2303FB76;
        Tue, 28 Nov 2023 15:07:29 +0100 (CET)
Date:   Tue, 28 Nov 2023 15:07:29 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>
cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, dongliang.cui@unisoc.com,
        xiuhong.wang@unisoc.com
Subject: Re: [PATCH] dm: increase the io priority of the kworker-kverityd
 process
In-Reply-To: <20231128094414.583666-1-yunlong.xing@unisoc.com>
Message-ID: <83e8ea6c-1d9-36d5-1c23-da686dbfaf80@redhat.com>
References: <20231128094414.583666-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This isn't correct - the workqueue process is reused by multiple work 
items - from dm-verity as well as from other subsystems - so you would be 
unexpectedly boosting priority of other tasks.

The correct solution would be to set the ioprio field of the outcoming 
bios in dm-bufio explicitely.

Mikulas


On Tue, 28 Nov 2023, Yunlong Xing wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> When obtaining the hash value of a high IO priority data block
> from the disk, the kverity-worker that obtains the hash will
> also have a high IO priority to avoid being blocked by other
> IO with low IO priority.
> 
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> ---
>  drivers/md/dm-verity-target.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index e115fcfe723c..ade9c6734154 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -22,6 +22,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <linux/jump_label.h>
> +#include <linux/ioprio.h>
>  
>  #define DM_MSG_PREFIX			"verity"
>  
> @@ -639,7 +640,9 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
>  static void verity_work(struct work_struct *w)
>  {
>  	struct dm_verity_io *io = container_of(w, struct dm_verity_io, work);
> +	struct bio *bio = dm_bio_from_per_bio_data(io, io->v->ti->per_io_data_size);
>  
> +	set_task_ioprio(current, bio->bi_ioprio);
>  	io->in_tasklet = false;
>  
>  	verity_fec_init_io(io);
> -- 
> 2.25.1
> 
> 

