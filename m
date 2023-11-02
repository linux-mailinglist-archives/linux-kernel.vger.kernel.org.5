Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA707DF31D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376339AbjKBNBR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:01:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D127C112;
        Thu,  2 Nov 2023 06:01:11 -0700 (PDT)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SLkX16wDrzVm1M;
        Thu,  2 Nov 2023 21:01:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 21:01:09 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 2 Nov 2023 21:01:09 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Halil Pasic <pasic@linux.ibm.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAADLTkZAHGvVqsA==
Date:   Thu, 2 Nov 2023 13:01:09 +0000
Message-ID: <adb0c5f790dc408887f9d98548373919@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com> 
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping Herbert.  

Thanks.

> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Wednesday, September 27, 2023 5:18 PM
> To: 'Halil Pasic' <pasic@linux.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org;
> Marc Hartmayer <mhartmay@linux.ibm.com>; Michael S. Tsirkin
> <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> pizhenwei@bytedance.com; Cornelia Huck <cohuck@redhat.com>
> Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
> 
> 
> 
> > -----Original Message-----
> > From: Halil Pasic [mailto:pasic@linux.ibm.com]
> > Sent: Wednesday, September 27, 2023 12:42 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>;
> > linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; pizhenwei@bytedance.com; Halil Pasic
> > <pasic@linux.ibm.com>; Cornelia Huck <cohuck@redhat.com>
> > Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh
> > disabled
> >
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
> > > ,
> > > req, err);
> > > +	local_bh_enable();
> >
> > Thanks Gonglei!
> >
> > I did this a quick spin, and it does not seem to be sufficient on s390x.
> > Which does not come as a surprise to me, because
> >
> > #define lockdep_assert_in_softirq()
> > \
> > do
> > {
> >      \
> >         WARN_ON_ONCE(__lockdep_enabled                  &&
> > \
> >                      (!in_softirq() || in_irq() || in_nmi()));          \
> > } while (0)
> >
> > will still warn because  in_irq() still evaluates to true (your patch
> > addresses the !in_softirq() part).
> >
> You are right.
> 
> So I think the core of this question is: Can we call crypto_finalize_request() in
> the upper half of the interrupt?
> If so, maybe we should introduce a new function, such as
> lockdep_assert_in_interrupt().
> 
> #define lockdep_assert_in_interrupt()                               \
> do {                                                           \
>        WARN_ON_ONCE(__lockdep_enabled && !in_interrupt());        \
> } while (0)
> 
> If not, why?
> 
> Herbert, do you have any suggestions? Thanks.
> 
> 
> Regards,
> -Gonglei
> 

