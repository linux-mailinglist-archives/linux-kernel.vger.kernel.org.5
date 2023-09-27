Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F17AFFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjI0JYR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0JYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:24:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278E97;
        Wed, 27 Sep 2023 02:24:12 -0700 (PDT)
Received: from kwepemd200001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwWKJ6NZGztT57;
        Wed, 27 Sep 2023 17:19:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd200001.china.huawei.com (7.221.188.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Wed, 27 Sep 2023 17:24:09 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Wed, 27 Sep 2023 17:24:09 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAAAEdD4AAMnHjIA==
Date:   Wed, 27 Sep 2023 09:24:09 +0000
Message-ID: <9564c220c8344939880bb805c5b3cac9@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <20230926130521-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926130521-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, September 27, 2023 1:14 AM
> To: Halil Pasic <pasic@linux.ibm.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org; Marc
> Hartmayer <mhartmay@linux.ibm.com>; Jason Wang
> <jasowang@redhat.com>; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; pizhenwei@bytedance.com; Cornelia Huck
> <cohuck@redhat.com>
> Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
> 
> On Tue, Sep 26, 2023 at 06:41:58PM +0200, Halil Pasic wrote:
> > [..]
> > > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
> > >  	vc_akcipher_req->src_buf = NULL;
> > >  	vc_akcipher_req->dst_buf = NULL;
> > >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> > > -
> > > +	local_bh_disable();
> > >
> > > crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine
> > > , req, err);
> > > +	local_bh_enable();
> >
> > Thanks Gonglei!
> >
> > I did this a quick spin, and it does not seem to be sufficient on s390x.
> > Which does not come as a surprise to me, because
> >
> > #define lockdep_assert_in_softirq()
> \
> > do
> {
>      \
> >         WARN_ON_ONCE(__lockdep_enabled                  &&
> \
> >                      (!in_softirq() || in_irq() || in_nmi()));          \
> > } while (0)
> >
> > will still warn because  in_irq() still evaluates to true (your patch
> > addresses the !in_softirq() part).
> >
> > I don't have any results on x86 yet. My current understanding is that
> > the virtio-pci transport code disables interrupts locally somewhere in
> > the call chain (actually in vp_vring_interrupt() via
> > spin_lock_irqsave()) and then x86 would be fine. But I will get that verified.
> >
> > On the other hand virtio_airq_handler() calls vring_interrupt() with
> > interrupts enabled. (While vring_interrupt() is called in a (read)
> > critical section in virtio_airq_handler() we use read_lock() and not
> > read_lock_irqsave() to grab the lock. Whether that is correct in it
> > self (i.e. disregarding the crypto problem) or not I'm not sure right
> > now. Will think some more about it tomorrow.) If the way to go forward
> > is disabling interrupts in virtio-ccw before vring_interrupt() is
> > called, I would be glad to spin a patch for that.
> >
> > Copying Conny, as she may have an opinion on this (if I'm not wrong
> > she authored that code).
> >
> > Regards,
> > Halil
> 
> On a related note, config change callback is also handled incorrectly in this
> driver, it takes a mutex from interrupt context.

Good catch. Will fix it.

Thanks.
-Gonglei
