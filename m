Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B017DF3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbjKBNZo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376414AbjKBNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:25:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C97191;
        Thu,  2 Nov 2023 06:25:35 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLl0h6D4FzrTrP;
        Thu,  2 Nov 2023 21:22:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 21:25:31 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 2 Nov 2023 21:25:31 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Halil Pasic <pasic@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: RE: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Thread-Topic: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Thread-Index: AQHZ7VsjRTMxo/hUEkmU1GjtoDjS1rAp3v1A///cYoCAO3GWgIACEayQ//9+LICAAIbrcA==
Date:   Thu, 2 Nov 2023 13:25:31 +0000
Message-ID: <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
        <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
        <20230924193941.6a02237f.pasic@linux.ibm.com>
        <20231101092521-mutt-send-email-mst@kernel.org>
        <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
 <20231102091548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102091548-mutt-send-email-mst@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Thursday, November 2, 2023 9:17 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>
> Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from irq
> context
> 
> On Thu, Nov 02, 2023 at 01:04:07PM +0000, Gonglei (Arei) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Wednesday, November 1, 2023 9:26 PM
> > > To: Halil Pasic <pasic@linux.ibm.com>
> > > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> > > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > > virtualization@lists.linux-foundation.org;
> > > linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org; Marc
> > > Hartmayer <mhartmay@linux.ibm.com>
> > > Subject: Re: virtcrypto_dataq_callback calls
> > > crypto_finalize_request() from irq context
> > >
> > > On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> > > > On Sun, 24 Sep 2023 11:56:25 +0000 "Gonglei (Arei)"
> > > > <arei.gonglei@huawei.com> wrote:
> > > >
> > > > > Hi Halil,
> > > > >
> > > > > Commit 4058cf08945 introduced a check for detecting crypto
> > > > > completion function called with enable BH, and indeed the
> > > > > virtio-crypto driver didn't disable BH, which needs a patch to fix it.
> > > > >
> > > > > P.S.:
> > > > > https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@bay
> > > > > libr
> > > > > e.com/T/
> > > > >
> > > > > Regards,
> > > > > -Gonglei
> > > >
> > > > Thanks Gonglei!
> > > >
> > > > Thanks! I would be glad to test that fix on s390x. Are you about
> > > > to send one?
> > > >
> > > > Regards,
> > > > Halil
> > >
> > >
> > > Gonglei did you intend to send a fix?
> >
> > Actually I sent a patch a month ago, pls see another thread.
> >
> >
> > Regards,
> > -Gonglei
> 
> And I think there was an issue with that patch that you wanted to fix?
> config changed callback got fixed but this still didn't.
> 
Now my concern is whether or not the judgement (commit 4058cf08945c1) is reasonable.

Regards,
-Gonglei
