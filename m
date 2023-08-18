Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92187805C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357799AbjHRFr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbjHRFrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:47:23 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45D272D;
        Thu, 17 Aug 2023 22:47:21 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWsKJ-005Bwi-6V; Fri, 18 Aug 2023 13:47:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 13:47:15 +0800
Date:   Fri, 18 Aug 2023 13:47:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        George Cherian <gcherian@marvell.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] crypto: caam - increase the domain of write memory
 barrier to full system
Message-ID: <ZN8F4/qSgjNvjG8h@gondor.apana.org.au>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
 <20230808105527.1707039-2-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808105527.1707039-2-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:55:26PM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> In caam_jr_enqueue, under heavy DDR load, smp_wmb() or dma_wmb()
> fail to make the input ring be updated before the CAAM starts
> reading it. So, CAAM will process, again, an old descriptor address
> and will put it in the output ring. This will make caam_jr_dequeue()
> to fail, since this old descriptor is not in the software ring.
> To fix this, use wmb() which works on the full system instead of
> inner/outer shareable domains.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Indeed, smp_wmb is always wrong for barriers separating DMA writes.

I wonder if these should be changed to:

$ git grep smp_wmb drivers/crypto/
drivers/crypto/caam/jr.c:       smp_wmb();
drivers/crypto/cavium/cpt/cptvf_reqmanager.c:   smp_wmb();
drivers/crypto/hisilicon/qm.c:  smp_wmb();
drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:     smp_wmb();
drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c:             smp_wmb();
drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c:     smp_wmb();
drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c:             smp_wmb();
drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c:     smp_wmb();
drivers/crypto/talitos.c:       smp_wmb();
drivers/crypto/talitos.c:               smp_wmb();
$ 

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
