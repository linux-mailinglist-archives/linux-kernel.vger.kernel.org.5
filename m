Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB0480A304
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjLHMSN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 07:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjLHMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:18:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFBAD;
        Fri,  8 Dec 2023 04:18:14 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Smqss6lqGzsRwD;
        Fri,  8 Dec 2023 20:18:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 20:18:11 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Fri, 8 Dec 2023 20:18:10 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangyangxin <wangyangxin1@huawei.com>,
        "Halil Pasic" <pasic@linux.ibm.com>
Subject: RE: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Thread-Topic: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Thread-Index: AdooOneOWI65hKIST2yjTeZdqptiyQBCQ+6AACMBjtA=
Date:   Fri, 8 Dec 2023 12:18:10 +0000
Message-ID: <70ea58a0776e4ba2a38658047d188688@huawei.com>
References: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>
 <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
In-Reply-To: <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
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



> -----Original Message-----
> From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
> Sent: Friday, December 8, 2023 11:28 AM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: linux-crypto@vger.kernel.org; Michael S. Tsirkin <mst@redhat.com>; Jason
> Wang <jasowang@redhat.com>; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; wangyangxin <wangyangxin1@huawei.com>;
> Halil Pasic <pasic@linux.ibm.com>
> Subject: Re: [PATCH v2] crypto: virtio-crypto: Handle dataq logic with tasklet
> 
> On Wed, Dec 06, 2023 at 11:52:51AM +0000, Gonglei (Arei) wrote:
> > Doing ipsec produces a spinlock recursion warning.
> > This is due to crypto_finalize_request() being called in the upper half.
> > Move virtual data queue processing of virtio-crypto driver to tasklet.
> >
> > Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
> > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  v2: calling tasklet_kill() in virtcrypto_remove(), thanks for MST.
> >
> >  drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
> >  drivers/crypto/virtio/virtio_crypto_core.c   | 26
> ++++++++++++++++----------
> >  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> Your patch has already been merged.  So please send this as an incremental
> patch.
> 

OK. No problem. 

Regards,
-Gonglei

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

