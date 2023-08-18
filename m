Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45695780873
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359170AbjHRJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359187AbjHRJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:30:47 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894E3A8B;
        Fri, 18 Aug 2023 02:30:42 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWvoO-005FSK-Bz; Fri, 18 Aug 2023 17:30:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 17:30:33 +0800
Date:   Fri, 18 Aug 2023 17:30:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam/jr - fix shared IRQ line handling
Message-ID: <ZN86OX2/B/5w4Uxh@gondor.apana.org.au>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
 <20230808105527.1707039-3-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808105527.1707039-3-meenakshi.aggarwal@nxp.com>
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

On Tue, Aug 08, 2023 at 12:55:27PM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: Horia Geantă <horia.geanta@nxp.com>
> 
> There are cases when the interrupt status register (JRINTR) is non-zero,
> even though:
> 1. An interrupt was generated, but it was masked OR
> 2. There was no interrupt generated at all
> for the corresponding job ring.
> 
> 1. The case when interrupt is masked (JRCFGR_LS[IMSK]=1b'1)
> while other events have happened and are being accounted for, e.g.
> -JRINTR[HALT]=2b'10 - input job ring underwent a flush of all on-going
> jobs and processing of still-existing jobs (sitting in the ring) has been
> halted
> -JRINTR[HALT]=2b'01 - input job ring is currently undergoing a flush
> -JRINTR[ENTER_FAIL]=1b'1 - SecMon / SNVS transitioned to FAIL MODE
> It doesn't matter whether these events would assert the interrupt signal
> or not, interrupt is anyhow masked.
> 
> 2. The case when interrupt is not masked (JRCFGR_LS[IMSK]=1b'0), however
> the events accounted for in JRINTR do not generate interrupts, e.g.:
> -JRINTR[HALT]=2b'01
> -JRINTR[ENTER_FAIL]=1b'1 and JRCFGR_MS[FAIL_MODE]=1b'0
> 
> Currently in these cases, when the JR interrupt handler is invoked (as a
> consequence of JR sharing the interrupt line with other devices - e.g.
> the two JRs on i.MX7ULP) it continues execution instead of returning
> IRQ_NONE.
> This could lead to situations like interrupt handler clearing JRINTR (and
> thus also the JRINTR[HALT] field) while corresponding job ring is
> suspended and then that job ring failing on resume path, due to expecting
> JRINTR[HALT]=b'10 and reading instead JRINTR[HALT]=b'00.
> 
> Fix this by checking status of JRINTR[JRI] in the JR interrupt handler.
> If JRINTR[JRI]=1b'0, there was no interrupt generated for this JR and
> handler must return IRQ_NONE.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
