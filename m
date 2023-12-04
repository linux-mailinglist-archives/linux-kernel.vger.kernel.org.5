Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA6802E25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjLDJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBD85
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701680536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klUlZafuD5fySdh0flPq8If8aOTjdsGX9L5Pty3/G5Y=;
        b=H4pzYKgC9B07lBfcz5w+5CcqcI2Ijf6XSOsmt852pBGarHUJs5E1V7+TWwH90OkP4gq1Yn
        9SNNRrA9cf4UgBLmEaCQeNfGrBTz3aY4pWW+YdnXbJLZ/iIj6tC5NADarabOmUiAEPLDZY
        cDibSEm6l0Qfizccm+8EVOM8DoThfgA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-NMjSjgO6PYG3fc1J8qOj5A-1; Mon, 04 Dec 2023 04:02:14 -0500
X-MC-Unique: NMjSjgO6PYG3fc1J8qOj5A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33349915d3cso585169f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680532; x=1702285332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klUlZafuD5fySdh0flPq8If8aOTjdsGX9L5Pty3/G5Y=;
        b=HneLtzaFILhSHsQoldJFgWzmE5rdkiNDZYxKt/HmAl4UcptyF70xxCJICB9dd9oapW
         7ufwMbSpE3sawPssZMfB9wSgYhI9+RyCRzODTAzIm5OezPynmtmjwERxtVWonBVsa4jG
         PyWot4G7GRu8N3sgHWwueuwPKDZMw8+07SjbGi5xNzhu5G238WsC9DLfeSJNzKUpfQ2B
         ol2PQVu9sk7qSBdBQE7DKYaYMpneKcj453RLddbwdQVDxh3VuUQsbKAMnQKinbizqq+I
         HZrOUC5/c6HNcyh7XnLIlFqh4RndJOg1vGUlQUpFtLRR/PcRi9atwB9dIn7rH9+hRIPO
         IFFg==
X-Gm-Message-State: AOJu0YzrRqnitTEUpKo91euxskZtgH1TqtXoT68zvcQWLZud7Ehdo5o3
        8Effggx0URSLkDmyRrW278rkbXupqfC4iR+YBwlrmXFQ8VsiTgYAGxgHA23I2thTkmoqGUfBhaH
        vt4D5qmK+QWn1bJPNl+l2I5cu
X-Received: by 2002:a5d:570c:0:b0:333:2fd2:68de with SMTP id a12-20020a5d570c000000b003332fd268demr2993309wrv.113.1701680532076;
        Mon, 04 Dec 2023 01:02:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0ZQVyyx/zbTsZL1jvUz7Lg2aDNjkx9I4PA83zE9UwNtmP49rfhCh0xG6pgtoc8yUb5PljQw==
X-Received: by 2002:a5d:570c:0:b0:333:2fd2:68de with SMTP id a12-20020a5d570c000000b003332fd268demr2993302wrv.113.1701680531755;
        Mon, 04 Dec 2023 01:02:11 -0800 (PST)
Received: from redhat.com ([2.55.11.133])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d6843000000b0033340d2b127sm4131457wrw.89.2023.12.04.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:02:11 -0800 (PST)
Date:   Mon, 4 Dec 2023 04:02:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, pbonzini@redhat.com
Subject: Re: drivers/block/virtio_blk.c:570:68: warning: '%d' directive
 output may be truncated writing between 1 and 11 bytes into a region of size
 7
Message-ID: <20231204040038-mutt-send-email-mst@kernel.org>
References: <202312041509.DIyvEt9h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312041509.DIyvEt9h-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 04:56:35PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> commit: 4e0400525691d0e676dbe002641f9a61261f1e1b virtio-blk: support polling I/O
> date:   1 year, 6 months ago
> config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231204/202312041509.DIyvEt9h-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041509.DIyvEt9h-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/block/virtio_blk.c: In function 'init_vq':
> >> drivers/block/virtio_blk.c:570:68: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
>      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
>          |                                                                    ^~
>    drivers/block/virtio_blk.c:570:58: note: directive argument in the range [-2147483648, 65534]
>      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
>          |                                                          ^~~~~~~~~~~~~
>    drivers/block/virtio_blk.c:570:17: note: 'snprintf' output between 11 and 21 bytes into a destination of size 16
>      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +570 drivers/block/virtio_blk.c
> 
>    511	
>    512	static int init_vq(struct virtio_blk *vblk)
>    513	{
>    514		int err;
>    515		int i;
>    516		vq_callback_t **callbacks;
>    517		const char **names;
>    518		struct virtqueue **vqs;
>    519		unsigned short num_vqs;
>    520		unsigned int num_poll_vqs;
>    521		struct virtio_device *vdev = vblk->vdev;
>    522		struct irq_affinity desc = { 0, };
>    523	
>    524		err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
>    525					   struct virtio_blk_config, num_queues,
>    526					   &num_vqs);
>    527		if (err)
>    528			num_vqs = 1;
>    529	
>    530		if (!err && !num_vqs) {
>    531			dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>    532			return -EINVAL;
>    533		}
>    534	
>    535		num_vqs = min_t(unsigned int,
>    536				min_not_zero(num_request_queues, nr_cpu_ids),
>    537				num_vqs);
>    538	
>    539		num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>    540	
>    541		vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
>    542		vblk->io_queues[HCTX_TYPE_READ] = 0;
>    543		vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
>    544	
>    545		dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
>    546					vblk->io_queues[HCTX_TYPE_DEFAULT],
>    547					vblk->io_queues[HCTX_TYPE_READ],
>    548					vblk->io_queues[HCTX_TYPE_POLL]);
>    549	
>    550		vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>    551		if (!vblk->vqs)
>    552			return -ENOMEM;
>    553	
>    554		names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
>    555		callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
>    556		vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
>    557		if (!names || !callbacks || !vqs) {
>    558			err = -ENOMEM;
>    559			goto out;
>    560		}
>    561	
>    562		for (i = 0; i < num_vqs - num_poll_vqs; i++) {
>    563			callbacks[i] = virtblk_done;
>    564			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
>    565			names[i] = vblk->vqs[i].name;
>    566		}
>    567	
>    568		for (; i < num_vqs; i++) {
>    569			callbacks[i] = NULL;
>  > 570			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
>    571			names[i] = vblk->vqs[i].name;
>    572		}
>    573	
>    574		/* Discover virtqueues and write information to configuration.  */
>    575		err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
>    576		if (err)
>    577			goto out;
>    578	
>    579		for (i = 0; i < num_vqs; i++) {
>    580			spin_lock_init(&vblk->vqs[i].lock);
>    581			vblk->vqs[i].vq = vqs[i];
>    582		}
>    583		vblk->num_vqs = num_vqs;
>    584	
>    585	out:
>    586		kfree(vqs);
>    587		kfree(callbacks);
>    588		kfree(names);
>    589		if (err)
>    590			kfree(vblk->vqs);
>    591		return err;
>    592	}
>    593	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Stefan, Paolo,
It's a false positive but do we want to fix it? Make i unsigned?

-- 
MST

