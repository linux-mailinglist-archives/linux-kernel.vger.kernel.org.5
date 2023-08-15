Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10E77C948
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHOIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjHOIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A710C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692087581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UF3lqFgAWM3woBisT/XHF1hR2APGwzy9dAgACkIkoRk=;
        b=HhytXsip1GGNWp7SLG7WCkMGZRdZEZ/PzLsLF6Rj/WG6bVDvEhf2nfD8tPy00ipkbBIO3M
        Y6JyKwZIkAQwzlnHMRdo2I2iDOQAP4YutHi4Dw1XdnHnRcI5T1DahFTCFO/QCVg/5/Le0F
        FTHw7ttc0m67vO6oA8drDvJ40OHk4A4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-p6Ist1xPNauhruad7BGL3w-1; Tue, 15 Aug 2023 04:19:38 -0400
X-MC-Unique: p6Ist1xPNauhruad7BGL3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBCCB38008A2;
        Tue, 15 Aug 2023 08:19:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C720C492C13;
        Tue, 15 Aug 2023 08:19:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230815060443.660263-1-chengming.zhou@linux.dev>
References: <20230815060443.660263-1-chengming.zhou@linux.dev>
To:     chengming.zhou@linux.dev
Cc:     dhowells@redhat.com, axboe@kernel.dk, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
        nj.shetty@samsung.com, kbusch@kernel.org,
        zhouchengming@bytedance.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] null_blk: fix poll request timeout handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23382.1692087575.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 15 Aug 2023 09:19:35 +0100
Message-ID: <23383.1692087575@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chengming.zhou@linux.dev wrote:

> From: Chengming Zhou <zhouchengming@bytedance.com>
> =

> When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
> kernel if poll requests timeout triggered, as reported by David. [1]
> =

> BUG: kernel NULL pointer dereference, address: 0000000000000008
> Workqueue: kblockd blk_mq_timeout_work
> RIP: 0010:null_timeout_rq+0x4e/0x91
> Call Trace:
>  ? __die_body+0x1a/0x5c
>  ? page_fault_oops+0x6f/0x9c
>  ? kernelmode_fixup_or_oops+0xc6/0xd6
>  ? __bad_area_nosemaphore+0x44/0x1eb
>  ? exc_page_fault+0xe2/0xf4
>  ? asm_exc_page_fault+0x22/0x30
>  ? null_timeout_rq+0x4e/0x91
>  blk_mq_handle_expired+0x31/0x4b
>  bt_iter+0x68/0x84
>  ? bt_tags_iter+0x81/0x81
>  __sbitmap_for_each_set.constprop.0+0xb0/0xf2
>  ? __blk_mq_complete_request_remote+0xf/0xf
>  bt_for_each+0x46/0x64
>  ? __blk_mq_complete_request_remote+0xf/0xf
>  ? percpu_ref_get_many+0xc/0x2a
>  blk_mq_queue_tag_busy_iter+0x14d/0x18e
>  blk_mq_timeout_work+0x95/0x127
>  process_one_work+0x185/0x263
>  worker_thread+0x1b5/0x227
>  ? rescuer_thread+0x287/0x287
>  kthread+0xfa/0x102
>  ? kthread_complete_and_exit+0x1b/0x1b
>  ret_from_fork+0x22/0x30
> =

> This is indeed a race problem between null_timeout_rq() and null_poll().
> =

> null_poll()				null_timeout_rq()
>   spin_lock(&nq->poll_lock)
>   list_splice_init(&nq->poll_list, &list)
>   spin_unlock(&nq->poll_lock)
> =

>   while (!list_empty(&list))
>     req =3D list_first_entry()
>     list_del_init()
>     ...
>     blk_mq_add_to_batch()
>     // req->rq_next =3D NULL
> 					spin_lock(&nq->poll_lock)
> =

> 					// rq->queuelist->next =3D=3D NULL
> 					list_del_init(&rq->queuelist)
> =

> 					spin_unlock(&nq->poll_lock)
> =

> What's worse is that we don't call blk_mq_complete_request_remote()
> before blk_mq_add_to_batch(), so these completed requests have wrong
> rq->state =3D=3D MQ_RQ_IN_FLIGHT. We can easily check this using bpftrac=
e:
> =

> ```
> bpftrace -e 'kretfunc:null_blk:null_poll {
>   $iob=3D(struct io_comp_batch *)args->iob;
>   @[$iob->req_list->state]=3Dcount();
> }'
> =

> @[1]: 51708
> ```
> =

> Fix these problems by setting requests state to MQ_RQ_COMPLETE under
> nq->poll_lock protection, in which null_timeout_rq() can safely detect
> this race and early return.
> =

> [1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.u=
k/
> =

> Fixes: 0a593fbbc245 ("null_blk: poll queue support")
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Okay, the oops no longer seems to happen, so on that basis:

Tested-by: David Howells <dhowells@redhat.com>


However, running:

	./fio/t/io_uring -n4 /dev/nullb0

and then interrupting it with ctrl-C after a while dumps a whole load of
messages into the dmesg log (excerpt attached).  It seems wrong that the u=
ser
should be able to generate a dump like this just by interrupting - but I g=
uess
as it's null_blk it probably doesn't matter.

David
---
null_blk: rq 00000000bb2d3264 timed out
timeout error, dev nullb0, sector 328372624 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000abcc1075 timed out
timeout error, dev nullb0, sector 378610072 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000d4bdc71f timed out
timeout error, dev nullb0, sector 185005312 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000f4ffddee timed out
timeout error, dev nullb0, sector 206118608 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 000000001e68b709 timed out
timeout error, dev nullb0, sector 310381160 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000bfeafe97 timed out
timeout error, dev nullb0, sector 52036480 op 0x0:(READ) flags 0xe00000 ph=
ys_seg 1 prio class 2
null_blk: rq 00000000aa67d21c timed out
timeout error, dev nullb0, sector 22746448 op 0x0:(READ) flags 0xe00000 ph=
ys_seg 1 prio class 2
null_blk: rq 00000000faec1291 timed out
timeout error, dev nullb0, sector 391201440 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000c634428c timed out
timeout error, dev nullb0, sector 237216136 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 0000000077f91a5d timed out
timeout error, dev nullb0, sector 453778912 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 000000003076467c timed out
null_blk: rq 000000009c172678 timed out
null_blk: rq 000000002df50b48 timed out
null_blk: rq 00000000e4c66900 timed out
null_blk: rq 0000000082606e31 timed out
null_blk: rq 00000000fe21ffdc timed out
null_blk: rq 000000005e5c5173 timed out
null_blk: rq 00000000b0a0d20c timed out
null_blk: rq 000000008c729e47 timed out
null_blk: rq 00000000970f75a0 timed out
null_blk: rq 000000002ad3c45a timed out

