Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6F78A4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjH1DHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjH1DGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:06:46 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E10119;
        Sun, 27 Aug 2023 20:06:43 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qaSZs-008Na8-4h; Mon, 28 Aug 2023 11:06:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Aug 2023 11:06:09 +0800
Date:   Mon, 28 Aug 2023 11:06:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     mengkanglai <mengkanglai2@huawei.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: ltp testcases failed due to commit cf3128a7aca
Message-ID: <ZOwPIczX73/22a35@gondor.apana.org.au>
References: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:12:12AM +0000, mengkanglai wrote:
>
> This command eventually use setkey -c to add spdadd entry failed:
> spdadd $src_ipaddr $dst_ipaddr any
> 　　-P out ipsec $protocol/tunnel/${src_ipaddr}-${dst_ipaddr}/use ; 
> 
> It returns Invalid argument.
> 
> I found this failed due to commit cf3128a7aca(af_key: Reject optional tunnel/BEET mode templates in outbound policies), is latest ltp testcases are not adapted? 

Correct.  The above specification makes no sense for an outbound
policy as the SA can only be optional for inbound (where IPComp
can be skipped for incompressible plaintext).  So change the word
"use" above to "require" and it should work.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
