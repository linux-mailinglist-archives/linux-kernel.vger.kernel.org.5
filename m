Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B236175918A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGSJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE772107
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689758789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/f0NTUat3Qw0nEGYdWCuhe31jBdzjtLNwY7Efuzq/OI=;
        b=go++CehKmT83fiOz8wAk68w8MJYNBnIjtrit/5HiClnyCz5Ui7AdK9xTTyv7pIG9eN4MJh
        reYZgreoqRoMEXfRNfC8dsw1TzCVVuCDF8szomLhRX/ep5NF/Dp2Nz6lzIHxYQK+0RIkiC
        lgcEAKng4q9QDGW39LaNj0zKIUVVyYw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-L7h32KX3MbSV5tDk-NQLpg-1; Wed, 19 Jul 2023 05:26:24 -0400
X-MC-Unique: L7h32KX3MbSV5tDk-NQLpg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFD8B28EC10C;
        Wed, 19 Jul 2023 09:26:23 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 828DC492B01;
        Wed, 19 Jul 2023 09:26:15 +0000 (UTC)
Date:   Wed, 19 Jul 2023 17:26:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Message-ID: <ZLesM5flOn2aet8p@ovpn-8-17.pek2.redhat.com>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714072510.47770-3-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
> 
> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` to
> communicate ALBA back to the kernel. Therefore ublk must be used with the
> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
> available. Without this feature, ublk will not allow zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---

...

> +/*
> + * Construct a zone report. The report request is carried in `struct
> + * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
> + * and shall indicate the first zone of the report. The `nr_sectors` shall
> + * indicate how many zones should be reported (divide by zone size to get number
> + * of zones in the report) and must be an integer multiple of the zone size. The
> + * report shall be delivered as a `struct blk_zone` array. To report fewer zones
> + * than requested, zero the last entry of the returned array.
> + */
> +#define		UBLK_IO_OP_REPORT_ZONES		18

Actually, I meant the following delta change in V8 comment, then the UAPI
looks more clean & readable wrt. reporting how many zones in UBLK_IO_OP_REPORT_ZONES
and reusing ublksrv_io_cmd->addr.

Otherwise, this patchset looks fine.


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5698f4575e05..454c852ed328 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -70,7 +70,7 @@ struct ublk_rq_data {
 	struct kref ref;
 	__u64 sector;
 	__u32 operation;
-	__u32 nr_sectors;
+	__u32 nr_zones;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -335,7 +335,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		pdu = blk_mq_rq_to_pdu(req);
 		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
 		pdu->sector = sector;
-		pdu->nr_sectors = zones_in_request * zone_size_sectors;
+		pdu->nr_zones = zones_in_request;
 
 		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
 					GFP_KERNEL);
@@ -404,7 +404,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		switch (ublk_op) {
 		case UBLK_IO_OP_REPORT_ZONES:
 			iod->op_flags = ublk_op | ublk_req_build_flags(req);
-			iod->nr_sectors = pdu->nr_sectors;
+			iod->nr_zones = pdu->nr_zones;
 			iod->start_sector = pdu->sector;
 			return BLK_STS_OK;
 		default:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4d97eb0f7d13..602a788a650e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -249,11 +249,13 @@ struct ublksrv_ctrl_dev_info {
 /*
  * Construct a zone report. The report request is carried in `struct
  * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
- * and shall indicate the first zone of the report. The `nr_sectors` shall
- * indicate how many zones should be reported (divide by zone size to get number
- * of zones in the report) and must be an integer multiple of the zone size. The
- * report shall be delivered as a `struct blk_zone` array. To report fewer zones
- * than requested, zero the last entry of the returned array.
+ * and shall indicate the first zone of the report. The `nr_zones` shall
+ * indicate how many zones should be reported at most. The report shall be
+ * delivered as a `struct blk_zone` array. To report fewer zones than
+ * requested, zero the last entry of the returned array.
+ *
+ * So related definitions(blk_zone, blk_zone_cond, blk_zone_type, ...) in
+ * include/uapi/linux/blkzoned.h are part of ublk UAPI.
  */
 #define		UBLK_IO_OP_REPORT_ZONES		18
 
@@ -276,7 +278,10 @@ struct ublksrv_io_desc {
 	/* op: bit 0-7, flags: bit 8-31 */
 	__u32		op_flags;
 
-	__u32		nr_sectors;
+	union {
+		__u32		nr_sectors;
+		__u32		nr_zones; /* for UBLK_IO_OP_REPORT_ZONES only */
+	};
 
 	/* start sector for this io */
 	__u64		start_sector;
@@ -308,6 +313,12 @@ struct ublksrv_io_cmd {
 	/*
 	 * userspace buffer address in ublksrv daemon process, valid for
 	 * FETCH* command only
+	 *
+	 * This field shouldn't be used if UBLK_F_USER_COPY is enabled,
+	 * because userspace deals with data copy by pread()/pwrite() over
+	 * /dev/ublkcN. But in case of UBLK_F_ZONED, 'addr' is re-used to
+	 * pass back the allocated LBA for UBLK_IO_OP_ZONE_APPEND which
+	 * actually depends on UBLK_F_USER_COPY
 	 */
 	__u64	addr;
 };

Thanks,
Ming

