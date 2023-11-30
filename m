Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E07FE976
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjK3HCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbjK3HCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:02:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6710F1;
        Wed, 29 Nov 2023 23:02:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR+2x4cgGy9JrHzc7m+qHBg2EW6ed/UjNJpf9BxQ4WFega6ffMTDt5WrNYCsy9+e1KiipG8lk/TVGAX8oG8RahmNDZjWlh3s13NZay041DlcfdnKdLYkYpJCCziPG6aUqm5fY+GHKzjy97WvdZ4DTTme4odiSg7cXAd37JWMBrW+bTzFQCqmAtjP0kfFsffK4qXW4ulZ5ZYxhZSE17H0dCVJSXnw4HsrdZifGE+rlWWoXejGjN2R/TXaabsCtOvZgYWsG/iQXbWP+YKQymYuBhkD91gV3+Xhsgi9ruwVDLa1EBJBCYp0T+JPt48YQCXFOiy4rzxvoa0ncZ+FOcy5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK3IwY+tYpt0nNR7jQ/wuEds0lfJ9yxkjpomecQ5hIA=;
 b=l0+0PgRe37SOhkPFngJAcsJajJZoGOwL9YU0mPXcZOCVKYbmsKDmhWEVEsKpjT1u3asBiwvaNPAb+xv65hVzOO50y9JHkiCyebg7UZKJ9MDCpBt5PD+CE2l5hW0pCK/cKPjUW60TXq960yOAYf1goXFQSiwhpIZcgZL2kMR95tIe7St2q6vrPfT1lmiCXU/iLrYwWJxXH4N/ME/j544aHHQHEAnDhnXmUF1yJ7Fpt6JGHYdaV4UgxOBbY64JmLVuglrbObh1BII9SGyI0ivNana8RLFYDbKAtUhyQM0TOkTYASBtzZL0EvLnS3Vu4AgjmHRMrEQgBQnb0cmmPiaEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK3IwY+tYpt0nNR7jQ/wuEds0lfJ9yxkjpomecQ5hIA=;
 b=KCnvIpPhqLxZ6cxoKQnWASadi+dwoBJhHqqubg+fYTqGzENw/JQI2nE3WYaWELm8xWC1CW3waF2Ds9HEBLjEZZPY7soy+LeCNb4yAaWY84cEiS4sGKT0nzKfYCGQKypoOJkuNk2Tr5w6kP7U/fsDCrP6YGROD2wVv6QZUahwpDdacUzHKKqUD4PK536CbYpzAhyBzfmuE547OOPYB4BugRVmSVFf7QvM1l/ytx5PYrbTsayzmy1H7/0xiByUtazDmF8553V8DSXh8GI+8HOkKiOjP87urqYRiXT/x5tj05DHgTFO4qnrrXxKLOg73dVHxQsxym/fqqomqc7L8uMX5Q==
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 07:02:05 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::7e) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Thu, 30 Nov 2023 07:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 07:02:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 23:01:52 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 23:01:51 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mst@redhat.com>, <hch@lst.de>, <jasowang@redhat.com>,
        <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
Date:   Wed, 29 Nov 2023 23:01:33 -0800
Message-ID: <20231130070133.8059-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231130070133.8059-1-kch@nvidia.com>
References: <20231130070133.8059-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acd1a97-1971-4327-17af-08dbf17242d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfffZ2tnn6+xMIDR5l9MVHTzhjt6Vp9ApSO+wvXiR0AcvEUd9Nt8wxMRcmUEaGGOTL+MkDn9P80hbrU9Ay2GKJUF1LKwz8zXsoWb5XrofZeCrg53VLoQ2HIJWCknHvuzK5AHxwUTZpq9vsD/cnqXgtM99iN+aCho64erqpUTI1ze0wvSCc84um8u3UvTpyCqGAsU/wCczGhdLgeR6qzPWe5M6sz5QJIFpu0Q85ZiEjclUrOhdOAMnc6PUafL5iE/0wbV1JMgT6RCJ0FYb4J0PJWJaw3/fRnlXolpa/8HNcXKaI0xKORfGq6rGylEHJkM0cNtJ1vcRMOaEqfp0egldx4SKeo/N7RMTLHBP7GOqT2IHkYPZmyV6RDMKc4RCOd/tB3uzk0fljmc90Uxd1+3mY2VJIQ4tC0v8AzT/7zl8Wr2BEohdyAClnbvMOaJ74rkFBT8/kMg18qLshUIwTFcQWrnxG/HoBLeiY6Y6AAcZHahwWiPf+oNctkWQBBNedpMwJi5rXk5i17nL1e0+iSELtAXd69LpgLBAcN27Z0HR+hxkRfbabE91gzRyY+1FfUUgwX8N5F8JoO8xL4PaqGM64Tvq1qwh6LOrlpBuug2HLmXa/H+vxJrq001+j7+sacOLFMYd0dTccEtTIvq0Wo5O+jFBncQpGDLQbFCo3C+ZM2OXj4umt+WA4UiuIm6JyztjHmCwMTgHZm9Ll93BklFUTyWgSe6avVsDyH28cFJ0My5XFOgqXz+nPxHXBIDeDFRrLuXL2JK8b+ur8FgL6HmRf3i3+zElDursN9N6HRQ+S0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(66899024)(40460700003)(202311291699003)(70586007)(70206006)(54906003)(7636003)(356005)(82740400003)(36756003)(36860700001)(47076005)(426003)(83380400001)(107886003)(1076003)(336012)(26005)(2616005)(6666004)(7696005)(2906002)(110136005)(316002)(16526019)(478600001)(5660300002)(8676002)(4326008)(41300700001)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 07:02:05.1478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acd1a97-1971-4327-17af-08dbf17242d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve block layer request handling by implementing a timeout handler.
Current implementation assums that request will never timeout and will
be completed by underlaying transport. However, this assumption can
cause issues under heavy load especially when dealing with different
subsystems and real hardware.

To solve this, add a block layer request timeout handler that will
complete timed-out requests in the same context if the virtio device
has a VIRTIO_CONFIG_S_DRIVER_OK status. If the device has any other
status, we'll stop the block layer request queue and proceed with the
teardown sequence, allowing applications waiting for I/O to exit
gracefully with appropriate error.

Also, add two new module parameters that allows user to specify the
I/O timeout for the tagset when allocating the disk and a teardown limit
for the timed out requeets before we initiate device teardown from the
timeout handler. These changes will improve the stability and
reliability of our system under request timeout scenario.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c      | 122 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_blk.h |   1 +
 2 files changed, 123 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4689ac2e0c0e..da26c2bf933b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -16,6 +16,7 @@
 #include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
+#include <linux/xarray.h>
 #include <uapi/linux/virtio_ring.h>
 
 #define PART_BITS 4
@@ -31,6 +32,15 @@
 #define VIRTIO_BLK_INLINE_SG_CNT	2
 #endif
 
+static unsigned int io_timeout = 20;
+module_param(io_timeout, uint, 0644);
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O requests. Default:20");
+
+static unsigned int timeout_teardown_limit = 2;
+module_param(timeout_teardown_limit, uint, 0644);
+MODULE_PARM_DESC(timeout_teardown_limit,
+		"request timeout teardown limit for stable dev. Default:2");
+
 static unsigned int num_request_queues;
 module_param(num_request_queues, uint, 0644);
 MODULE_PARM_DESC(num_request_queues,
@@ -84,6 +94,20 @@ struct virtio_blk {
 
 	/* For zoned device */
 	unsigned int zone_sectors;
+
+	/*
+	 * Block layer Request timeout teardown limit when device is in the
+	 * stable state, i.e. it has VIRTIO_CONFIG_S_DRIVER_OK value for its
+	 * config status. Once this limit is reached issue
+	 * virtblk_teardown_work to teardown the device in the block lyaer
+	 * request timeout callback.
+	 */
+	atomic_t rq_timeout_count;
+	/* avoid tear down race between remove and teardown work */
+	struct mutex teardown_mutex;
+	/* tear down work to be scheduled from block layer request handler */
+	struct work_struct teardown_work;
+
 };
 
 struct virtblk_req {
@@ -117,6 +141,8 @@ static inline blk_status_t virtblk_result(u8 status)
 	case VIRTIO_BLK_S_OK:
 		return BLK_STS_OK;
 	case VIRTIO_BLK_S_UNSUPP:
+	case VIRTIO_BLK_S_TIMEOUT:
+		return BLK_STS_TIMEOUT;
 		return BLK_STS_NOTSUPP;
 	case VIRTIO_BLK_S_ZONE_OPEN_RESOURCE:
 		return BLK_STS_ZONE_OPEN_RESOURCE;
@@ -926,6 +952,7 @@ static void virtblk_free_disk(struct gendisk *disk)
 	struct virtio_blk *vblk = disk->private_data;
 
 	ida_free(&vd_index_ida, vblk->index);
+	mutex_destroy(&vblk->teardown_mutex);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -1287,6 +1314,86 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return found;
 }
 
+static bool virtblk_cancel_request(struct request *rq, void *data)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
+
+	vbr->in_hdr.status = VIRTIO_BLK_S_TIMEOUT;
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		blk_mq_complete_request(rq);
+
+	return true;
+}
+
+static void virtblk_teardown_work(struct work_struct *w)
+{
+	struct virtio_blk *vblk =
+		container_of(w, struct virtio_blk, teardown_work);
+	struct request_queue *q = vblk->disk->queue;
+	struct virtio_device *vdev = vblk->vdev;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long idx;
+
+	mutex_lock(&vblk->teardown_mutex);
+	if (!vblk->vdev)
+		goto unlock;
+
+	blk_mq_quiesce_queue(q);
+
+	/* Process any outstanding request from device. */
+	xa_for_each(&q->hctx_table, idx, hctx)
+		virtblk_poll(hctx, NULL);
+
+	blk_sync_queue(q);
+	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request, vblk);
+	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
+
+	/*
+	 * Unblock any pending dispatch I/Os before we destroy device. From
+	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD flag,
+	 * that will make sure any new I/O from bio_queue_enter() to fail.
+	 */
+	blk_mq_unquiesce_queue(q);
+	del_gendisk(vblk->disk);
+	blk_mq_free_tag_set(&vblk->tag_set);
+
+	mutex_lock(&vblk->vdev_mutex);
+	flush_work(&vblk->config_work);
+
+	virtio_reset_device(vdev);
+
+	vblk->vdev = NULL;
+
+	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
+
+	mutex_unlock(&vblk->vdev_mutex);
+
+	put_disk(vblk->disk);
+
+unlock:
+	mutex_unlock(&vblk->teardown_mutex);
+}
+
+static enum blk_eh_timer_return virtblk_timeout(struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtio_device *vdev = vblk->vdev;
+	bool ok = vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK;
+
+	if ((atomic_dec_return(&vblk->rq_timeout_count) != 0) && ok) {
+		virtblk_cancel_request(req, NULL);
+		return BLK_EH_DONE;
+	}
+
+	dev_err(&vdev->dev, "%s:%s initiating teardown\n", __func__,
+		vblk->disk->disk_name);
+
+	queue_work(virtblk_wq, &vblk->teardown_work);
+
+	return BLK_EH_RESET_TIMER;
+}
+
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.queue_rqs	= virtio_queue_rqs,
@@ -1294,6 +1401,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.complete	= virtblk_request_done,
 	.map_queues	= virtblk_map_queues,
 	.poll		= virtblk_poll,
+	.timeout	= virtblk_timeout,
 };
 
 static unsigned int virtblk_queue_depth;
@@ -1365,6 +1473,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = queue_depth;
+	vblk->tag_set.timeout = io_timeout * HZ;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
 	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	vblk->tag_set.cmd_size =
@@ -1387,6 +1496,10 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 	q = vblk->disk->queue;
 
+	mutex_init(&vblk->teardown_mutex);
+	INIT_WORK(&vblk->teardown_work, virtblk_teardown_work);
+	atomic_set(&vblk->rq_timeout_count, timeout_teardown_limit);
+
 	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
 
 	vblk->disk->major = major;
@@ -1598,6 +1711,12 @@ static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	mutex_lock(&vblk->teardown_mutex);
+
+	/* we did the cleanup in the timeout handler */
+	if (!vblk->vdev)
+		goto unlock;
+
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
@@ -1618,6 +1737,9 @@ static void virtblk_remove(struct virtio_device *vdev)
 	mutex_unlock(&vblk->vdev_mutex);
 
 	put_disk(vblk->disk);
+
+unlock:
+	mutex_unlock(&vblk->teardown_mutex);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a..ed864195ab26 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -317,6 +317,7 @@ struct virtio_scsi_inhdr {
 #define VIRTIO_BLK_S_OK		0
 #define VIRTIO_BLK_S_IOERR	1
 #define VIRTIO_BLK_S_UNSUPP	2
+#define VIRTIO_BLK_S_TIMEOUT	3
 
 /* Error codes that are specific to zoned block devices */
 #define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
-- 
2.40.0

