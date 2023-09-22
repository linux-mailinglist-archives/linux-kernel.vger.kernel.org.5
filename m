Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7A7AA9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjIVHRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:17:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72988C2;
        Fri, 22 Sep 2023 00:17:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M7HV3o050988;
        Fri, 22 Sep 2023 02:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695367051;
        bh=HxfpG9t0R1eVdxnoEnkLwysNmjpwJ68ogyJaA0gjhTw=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=AjbmuU29713dNuA/oBJ50UKgEyryGIpSm0vQFNjcUMHtK3Ot85nwRg2Tu3KllFsST
         cfEC+PdzWIQVqBYu7C88hZMYzCgzwRPePzQyRzUKWEydTy+p9N6KPvSWVatjvL4k8I
         sgIRNjV2p+WbbhDS22/DGqlOgD1jQitByheUn184=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M7HUE0122131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 02:17:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 02:17:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 02:17:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M7HT4H068819;
        Fri, 22 Sep 2023 02:17:30 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Gaurav Jain <gaurav.jain@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXTERNAL] RE: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20
 + Poly1305 self test failure
In-Reply-To: <AM0PR04MB60043F6A9B0BCED6BC1827CDE7FFA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230921124237.2364827-1-gaurav.jain@nxp.com>
 <20230922024100.GA935@sol.localdomain>
 <AM0PR04MB60043F6A9B0BCED6BC1827CDE7FFA@AM0PR04MB6004.eurprd04.prod.outlook.com>
Date:   Fri, 22 Sep 2023 12:47:29 +0530
Message-ID: <875y42he2e.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav Jain <gaurav.jain@nxp.com> writes:

> Hi Eric
>
>> -----Original Message-----
>> From: Eric Biggers <ebiggers@kernel.org>
>> Sent: Friday, September 22, 2023 8:11 AM
>> To: Gaurav Jain <gaurav.jain@nxp.com>
>> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
>> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
>> Aggarwal <meenakshi.aggarwal@nxp.com>; Herbert Xu
>> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
>> Aisheng Dong <aisheng.dong@nxp.com>; Silvano Di Ninno
>> <silvano.dininno@nxp.com>; linux-crypto@vger.kernel.org; linux-
>> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self test
>> failure
>> 
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>> 
>> 
>> On Thu, Sep 21, 2023 at 06:12:37PM +0530, Gaurav Jain wrote:
>> > key buffer is not copied in chachapoly_setkey function, results in
>> > wrong output for encryption/decryption operation.
>> >
>> > fix this by memcpy the key in caam_ctx key arrary
Not sure, but do you mean array*?

>> >
>> > Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 +
>> > Poly1305")
>> > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
>> > ---
>> >  drivers/crypto/caam/caamalg.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/crypto/caam/caamalg.c
>> > b/drivers/crypto/caam/caamalg.c index eba2d750c3b0..066f08a3a040
>> > 100644
>> > --- a/drivers/crypto/caam/caamalg.c
>> > +++ b/drivers/crypto/caam/caamalg.c
>> > @@ -575,7 +575,8 @@ static int chachapoly_setkey(struct crypto_aead *aead,
>> const u8 *key,
>> >       if (keylen != CHACHA_KEY_SIZE + saltlen)
>> >               return -EINVAL;
>> >
>> > -     ctx->cdata.key_virt = key;
>> > +     memcpy(ctx->key, key, keylen);
>> > +     ctx->cdata.key_virt = ctx->key;
>> >       ctx->cdata.keylen = keylen - saltlen;
>> >
>> 
>> Huh, so this driver just ignored the key?  Is anyone using the ChaCha20Poly1305
>> support in this driver?  Based on this bug existing, that seems unlikely.  If that's
>> the case, wouldn't it be better just to remove the ChaCha20Poly1305 support
>> from this driver so that the code doesn't need to be maintained?
>
> This algorithm is used in IPSEC and we are also going to use ChaCha20Poly1305 support for Kernel TLS.
> Gaurav
Does this mean IPSEC doesn't call setkey() or the key value was such
that it didn't affect even after failing to actually set the key?

-Kamlesh
