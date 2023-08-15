Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECF77C892
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjHOHbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjHOHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD25199A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA13C60C74
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D60EC433C7;
        Tue, 15 Aug 2023 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692084638;
        bh=SbIDQHXt/hhs9F57hfAmfS0Ie2IAVVlXFLiLxVti/74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NO/RpVZfB/c/U8hCBZBj9r6JDwYMBBSo/hMEvrGfVEC+/5zTAKi3ribpuuiLZkFhZ
         42V+Ij5BR3IFxLTbvZyBMjnah5YSYeYD7xzDDr8diiI8st2pB1nl3VM/EZ818m76Tr
         aswmIrDKv6l9RxnDnGQTj8JnSPQazgEfl2tj5hps8UBRNNri5Vq4IdyU8kP2xjqK9q
         yZvvoO46/rwSPfwAbTNgZb5HRf8W8m5Y+7P5loozts1vOj70tlHRk/ERei5lOT1E2k
         j6Hd0FP4EuhdH4u61/1NTYVgiL2xY6Tw4m1/af4emGCmlUWVvWkfIiBWelITh86Rl2
         UY5/9rtp7LXFQ==
Date:   Tue, 15 Aug 2023 10:30:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Dong Chenchen <dongchenchen2@huawei.com>,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, timo.teras@iki.fi, yuehaibing@huawei.com,
        weiyongjun1@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815073033.GJ22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060454.GA2833@breakpoint.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:04:54AM +0200, Florian Westphal wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> > >  		dir = xfrm_policy_id2dir(policy->index);
> > > -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> > > +		if (dir >= XFRM_POLICY_MAX)
> > 
> > This change is unnecessary, previous code was perfectly fine.
> 
> Are you sure? AFAICS walker struct has no 'index' member.

But policy has, and we are not interested in validity of it as first
check in if (...) will be true for policy->walk.dead.

So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
for dead policy.

Thanks
