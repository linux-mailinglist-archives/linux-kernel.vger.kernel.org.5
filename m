Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAB77C8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjHOHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjHOHwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:52:34 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295821733;
        Tue, 15 Aug 2023 00:52:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qVoq8-003twA-AO; Tue, 15 Aug 2023 15:51:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 15 Aug 2023 15:51:44 +0800
Date:   Tue, 15 Aug 2023 15:51:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Dong Chenchen <dongchenchen2@huawei.com>,
        steffen.klassert@secunet.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <ZNsukMSQmzmXpgbS@gondor.apana.org.au>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
 <20230815073033.GJ22185@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815073033.GJ22185@unreal>
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

On Tue, Aug 15, 2023 at 10:30:33AM +0300, Leon Romanovsky wrote:
>
> But policy has, and we are not interested in validity of it as first
> check in if (...) will be true for policy->walk.dead.
> 
> So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
> for dead policy.

If you dereference policy->index on a walker object it will read memory
before the start of the walker object.  That could do anything, perhaps
even triggering a page fault.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
