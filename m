Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC78000EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjLABZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:25:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BB10D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701393917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1ZFq0NlfdeWdEuJZSkE3Ago92W75kyjbKU7jMMT53g=;
        b=DiBoUDdKedQ2MigH6sR+Wa+XpUmKjkNoUDut/ZWmI7gJuh6sx2QD1yRerPCcgN/36XQiac
        xFjELWcvSZeh8XIyQ9lxpeuKorKaJYHrjMAktCS6s/lXAnDPfiNHQWr/0xz/RO4WzIeTxB
        oi4UuI87HCoGZeAEetZ/EQPvCor65dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-adSjr9-AM3-8JEfk5jWJsw-1; Thu, 30 Nov 2023 20:25:14 -0500
X-MC-Unique: adSjr9-AM3-8JEfk5jWJsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3006811E7D;
        Fri,  1 Dec 2023 01:25:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78A4410E46;
        Fri,  1 Dec 2023 01:25:09 +0000 (UTC)
Date:   Thu, 30 Nov 2023 20:25:07 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, hch@lst.de,
        jasowang@redhat.com, pbonzini@redhat.com,
        xuanzhuo@linux.alibaba.com, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
Message-ID: <20231201012507.GA1209828@fedora>
References: <20231130070133.8059-1-kch@nvidia.com>
 <20231130070133.8059-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9TsaGM25MfiGdM/5"
Content-Disposition: inline
In-Reply-To: <20231130070133.8059-2-kch@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9TsaGM25MfiGdM/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:01:33PM -0800, Chaitanya Kulkarni wrote:
> Improve block layer request handling by implementing a timeout handler.
> Current implementation assums that request will never timeout and will
> be completed by underlaying transport. However, this assumption can
> cause issues under heavy load especially when dealing with different
> subsystems and real hardware.
>=20
> To solve this, add a block layer request timeout handler that will
> complete timed-out requests in the same context if the virtio device
> has a VIRTIO_CONFIG_S_DRIVER_OK status. If the device has any other
> status, we'll stop the block layer request queue and proceed with the
> teardown sequence, allowing applications waiting for I/O to exit
> gracefully with appropriate error.
>=20
> Also, add two new module parameters that allows user to specify the
> I/O timeout for the tagset when allocating the disk and a teardown limit
> for the timed out requeets before we initiate device teardown from the
> timeout handler. These changes will improve the stability and
> reliability of our system under request timeout scenario.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c      | 122 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_blk.h |   1 +
>  2 files changed, 123 insertions(+)

Hi,
This looks interesting. There was a discussion about implementing
->timeout() in September:
https://lore.kernel.org/io-uring/20230926145526.GA387951@fedora/

>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4689ac2e0c0e..da26c2bf933b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -16,6 +16,7 @@
>  #include <linux/blk-mq-virtio.h>
>  #include <linux/numa.h>
>  #include <linux/vmalloc.h>
> +#include <linux/xarray.h>
>  #include <uapi/linux/virtio_ring.h>
> =20
>  #define PART_BITS 4
> @@ -31,6 +32,15 @@
>  #define VIRTIO_BLK_INLINE_SG_CNT	2
>  #endif
> =20
> +static unsigned int io_timeout =3D 20;
> +module_param(io_timeout, uint, 0644);
> +MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O requests. Defau=
lt:20");
> +
> +static unsigned int timeout_teardown_limit =3D 2;
> +module_param(timeout_teardown_limit, uint, 0644);
> +MODULE_PARM_DESC(timeout_teardown_limit,
> +		"request timeout teardown limit for stable dev. Default:2");
> +
>  static unsigned int num_request_queues;
>  module_param(num_request_queues, uint, 0644);
>  MODULE_PARM_DESC(num_request_queues,
> @@ -84,6 +94,20 @@ struct virtio_blk {
> =20
>  	/* For zoned device */
>  	unsigned int zone_sectors;
> +
> +	/*
> +	 * Block layer Request timeout teardown limit when device is in the
> +	 * stable state, i.e. it has VIRTIO_CONFIG_S_DRIVER_OK value for its
> +	 * config status. Once this limit is reached issue
> +	 * virtblk_teardown_work to teardown the device in the block lyaer
> +	 * request timeout callback.
> +	 */
> +	atomic_t rq_timeout_count;
> +	/* avoid tear down race between remove and teardown work */
> +	struct mutex teardown_mutex;
> +	/* tear down work to be scheduled from block layer request handler */
> +	struct work_struct teardown_work;
> +
>  };
> =20
>  struct virtblk_req {
> @@ -117,6 +141,8 @@ static inline blk_status_t virtblk_result(u8 status)
>  	case VIRTIO_BLK_S_OK:
>  		return BLK_STS_OK;
>  	case VIRTIO_BLK_S_UNSUPP:
> +	case VIRTIO_BLK_S_TIMEOUT:
> +		return BLK_STS_TIMEOUT;
>  		return BLK_STS_NOTSUPP;
>  	case VIRTIO_BLK_S_ZONE_OPEN_RESOURCE:
>  		return BLK_STS_ZONE_OPEN_RESOURCE;
> @@ -926,6 +952,7 @@ static void virtblk_free_disk(struct gendisk *disk)
>  	struct virtio_blk *vblk =3D disk->private_data;
> =20
>  	ida_free(&vd_index_ida, vblk->index);
> +	mutex_destroy(&vblk->teardown_mutex);
>  	mutex_destroy(&vblk->vdev_mutex);
>  	kfree(vblk);
>  }
> @@ -1287,6 +1314,86 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx=
, struct io_comp_batch *iob)
>  	return found;
>  }
> =20
> +static bool virtblk_cancel_request(struct request *rq, void *data)
> +{
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> +
> +	vbr->in_hdr.status =3D VIRTIO_BLK_S_TIMEOUT;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	return true;
> +}
> +
> +static void virtblk_teardown_work(struct work_struct *w)
> +{
> +	struct virtio_blk *vblk =3D
> +		container_of(w, struct virtio_blk, teardown_work);
> +	struct request_queue *q =3D vblk->disk->queue;
> +	struct virtio_device *vdev =3D vblk->vdev;
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long idx;
> +
> +	mutex_lock(&vblk->teardown_mutex);
> +	if (!vblk->vdev)
> +		goto unlock;
> +
> +	blk_mq_quiesce_queue(q);
> +
> +	/* Process any outstanding request from device. */
> +	xa_for_each(&q->hctx_table, idx, hctx)
> +		virtblk_poll(hctx, NULL);
> +
> +	blk_sync_queue(q);
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request, vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/*
> +	 * Unblock any pending dispatch I/Os before we destroy device. From
> +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD flag,
> +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +	del_gendisk(vblk->disk);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +	flush_work(&vblk->config_work);
> +
> +	virtio_reset_device(vdev);
> +
> +	vblk->vdev =3D NULL;
> +
> +	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
> +
> +	mutex_unlock(&vblk->vdev_mutex);
> +
> +	put_disk(vblk->disk);
> +
> +unlock:
> +	mutex_unlock(&vblk->teardown_mutex);
> +}
> +
> +static enum blk_eh_timer_return virtblk_timeout(struct request *req)
> +{
> +	struct virtio_blk *vblk =3D req->mq_hctx->queue->queuedata;
> +	struct virtio_device *vdev =3D vblk->vdev;
> +	bool ok =3D vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK;

Please check VIRTIO_CONFIG_S_NEEDS_RESET first. When
VIRTIO_CONFIG_S_NEEDS_RESET is set the device is not ok, regardless of
whether DRIVER_OK is set. See 2.1.1 Driver Requirements: Device Status
Field in the VIRTIO specification.

> +
> +	if ((atomic_dec_return(&vblk->rq_timeout_count) !=3D 0) && ok) {
> +		virtblk_cancel_request(req, NULL);

The driver cannot abandon the request here because the device still owns
the request:

1. I/O buffer memory is corrupted for READ requests and disk contents
   are corrupted for WRITE requests when the device does finally process
   the request.

2. After virtblk_timeout() -> virtblk_cancel_request() ->
   blk_mq_complete_request(), a freed address is returned from
   virtblk_done() -> virtqueue_get_buf() -> blk_mq_rq_from_pdu() when
   the device finally completes the request.

I suggest the following:

(Optional) Add an ABORT/CANCEL request type to the VIRTIO specification
and use it to safely cancel requests when the device supports it.

Otherwise reset the device so that all pending requests are canceled.

> +		return BLK_EH_DONE;
> +	}
> +
> +	dev_err(&vdev->dev, "%s:%s initiating teardown\n", __func__,
> +		vblk->disk->disk_name);
> +
> +	queue_work(virtblk_wq, &vblk->teardown_work);
> +
> +	return BLK_EH_RESET_TIMER;
> +}
> +
>  static const struct blk_mq_ops virtio_mq_ops =3D {
>  	.queue_rq	=3D virtio_queue_rq,
>  	.queue_rqs	=3D virtio_queue_rqs,
> @@ -1294,6 +1401,7 @@ static const struct blk_mq_ops virtio_mq_ops =3D {
>  	.complete	=3D virtblk_request_done,
>  	.map_queues	=3D virtblk_map_queues,
>  	.poll		=3D virtblk_poll,
> +	.timeout	=3D virtblk_timeout,
>  };
> =20
>  static unsigned int virtblk_queue_depth;
> @@ -1365,6 +1473,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>  	vblk->tag_set.ops =3D &virtio_mq_ops;
>  	vblk->tag_set.queue_depth =3D queue_depth;
> +	vblk->tag_set.timeout =3D io_timeout * HZ;
>  	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
>  	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
>  	vblk->tag_set.cmd_size =3D
> @@ -1387,6 +1496,10 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	}
>  	q =3D vblk->disk->queue;
> =20
> +	mutex_init(&vblk->teardown_mutex);
> +	INIT_WORK(&vblk->teardown_work, virtblk_teardown_work);
> +	atomic_set(&vblk->rq_timeout_count, timeout_teardown_limit);
> +
>  	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
> =20
>  	vblk->disk->major =3D major;
> @@ -1598,6 +1711,12 @@ static void virtblk_remove(struct virtio_device *v=
dev)
>  {
>  	struct virtio_blk *vblk =3D vdev->priv;
> =20
> +	mutex_lock(&vblk->teardown_mutex);
> +
> +	/* we did the cleanup in the timeout handler */
> +	if (!vblk->vdev)
> +		goto unlock;
> +
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> =20
> @@ -1618,6 +1737,9 @@ static void virtblk_remove(struct virtio_device *vd=
ev)
>  	mutex_unlock(&vblk->vdev_mutex);
> =20
>  	put_disk(vblk->disk);
> +
> +unlock:
> +	mutex_unlock(&vblk->teardown_mutex);
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index 3744e4da1b2a..ed864195ab26 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -317,6 +317,7 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +#define VIRTIO_BLK_S_TIMEOUT	3

The structs and constants in this header file come from the VIRTIO
specification. Anything changed in this file must first be accepted into
the VIRTIO spec because this is the hardware interface definition.

VIRTIO_BLK_S_TIMEOUT seems to be synthetic value that is purely used by
software, not the device. Maybe there is no need to update the spec.
Just avoid using in_hdr.status to signal timeouts and use a separate
flag/field instead in a block layer or virtio_blk driver request struct.

> =20
>  /* Error codes that are specific to zoned block devices */
>  #define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
> --=20
> 2.40.0
>=20

--9TsaGM25MfiGdM/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVpNfMACgkQnKSrs4Gr
c8h6NAgAj2pLf2/2oLRX7Pu/gnRQSPLUcX3wG87nzI6uo4wUaSBqVHTZhrPaywk1
oCbp1t0SniyNifmBfEcE/yHm2ljl6qdo/axe6RvNTOsFplG7d1h/5PqaPcrikTS2
ZW2w8Snh2fFPSFSSZNNght030sjiGm4WB524NM3sDuzXn5MINL/tigogKjIiFzkN
RmRVknanv/GhN32zXfdFtTUnACuSleZ/75VXFChBgblop0oSEZN0jGm/ryUYzYHu
0cvLYFzkQQvm3vJLLisYzgOo3VG3OdtGMX/rwhtLaXjr8I8Hrl98VXvBrKBL4HmU
7EU4YWZASujJNekDUJKtCRK0a5td2g==
=xFMS
-----END PGP SIGNATURE-----

--9TsaGM25MfiGdM/5--

