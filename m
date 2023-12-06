Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D7806E49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbjLFLrm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377634AbjLFLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:47:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A60C9;
        Wed,  6 Dec 2023 03:47:47 -0800 (PST)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SlbCK2HfszrV0l;
        Wed,  6 Dec 2023 19:43:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 19:47:44 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Wed, 6 Dec 2023 19:47:44 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangyangxin <wangyangxin1@huawei.com>
Subject: RE: [PATCH] crypto: virtio-crypto: Handle dataq logic  with tasklet
Thread-Topic: [PATCH] crypto: virtio-crypto: Handle dataq logic  with tasklet
Thread-Index: Adobp2Ma20NfNCVRS52WT53esc9NTAIVDLQAAQ+I38A=
Date:   Wed, 6 Dec 2023 11:47:44 +0000
Message-ID: <860e8f2285ae4350af3a14a5367c462a@huawei.com>
References: <b2fe5c6a60984a9e91bd9dea419c5154@huawei.com>
 <ZWmxInHyFboXMWZ6@gondor.apana.org.au>
In-Reply-To: <ZWmxInHyFboXMWZ6@gondor.apana.org.au>
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

Hi Herbert,

> -----Original Message-----
> From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
> Sent: Friday, December 1, 2023 6:11 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: linux-crypto@vger.kernel.org; pasic@linux.ibm.com; mst@redhat.com;
> jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; wangyangxin <wangyangxin1@huawei.com>;
> Gonglei (Arei) <arei.gonglei@huawei.com>
> Subject: Re: [PATCH] crypto: virtio-crypto: Handle dataq logic with tasklet
> 
> Gonglei Arei <arei.gonglei@huawei.com> wrote:
> > Doing ipsec produces a spinlock recursion warning.
> > This is due to crypto_finalize_request() being called in the upper half.
> > Move virtual data queue processing of virtio-crypto driver to tasklet.
> >
> > Fixes: dbaf0624ffa57 ("crypto: add virtio-crypto driver")
> > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> > drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
> > drivers/crypto/virtio/virtio_crypto_core.c   | 23 +++++++++++++----------
> > 2 files changed, 15 insertions(+), 10 deletions(-)
> 
> Patch applied.  Thanks.

Sorry, pls apply version 2 if possible.

Regards,
-Gonglei

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
