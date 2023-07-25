Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6776097F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGYFlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGYFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBB1FCA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01A66153B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12EEC433C7;
        Tue, 25 Jul 2023 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690263651;
        bh=VEjQx7H1H+Mb+AJoPV4BZFXw7TX8zA9RwisdpdkLNwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFXTRYo1hIredh5OpbIa/0sE9HPeA7+c/oG6J17Iqb7+3ofR0Zj0Mj6PmdnelcXVd
         4xbcYRK408jG39EjjZQF+NI1oyAQjemYoD8HN9rk9d4R+CB1LdxuclPhx9oJ8k12xb
         HDpOHt1NG/1aRVJieW+CeGukcrf/9rOv6M9d3LJJP0CmvNrrH7TkQDl27SgmEUqZyr
         4FBNNp6wAJA9VuMpZMysRlqUr3bQ9kGbKvmLVS1om/cD9WOzgxZwjpu1ZxexWyt/zy
         8mIDWKZq57LQHlaxDZUX7F02niWvQMbDKVnnZ/s9IPRucVshhg5NLF027Tdz7nXIpc
         EwUDUWkAfXT6Q==
Date:   Tue, 25 Jul 2023 08:40:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725054046.GK11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal>
 <20230724142155.13c83625@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142155.13c83625@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:21:55PM -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 20:44:35 +0300 Leon Romanovsky wrote:
> > > @@ -13186,6 +13186,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
> > >  		if (nla_type(attr) != IFLA_BRIDGE_MODE)
> > >  			continue;
> > >  
> > > +		if (nla_len(attr) < sizeof(mode))
> > > +			return -EINVAL;
> > > +  
> > 
> > I see that you added this hunk to all users of nla_for_each_nested(), it
> > will be great to make that iterator to skip such empty attributes.
> > 
> > However, i don't know nettlink good enough to say if your change is
> > valid in first place.
> 
> Empty attributes are valid, we can't do that.

Maybe Lin can add special version of nla_for_each_nested() which will
skip these empty NLAs, for code which don't allow empty attributes.

> 
> But there's a loop in rtnl_bridge_setlink() which checks the attributes.
> We can add the check there instead of all users, as Leon points out.
> (Please just double check that all ndo_bridge_setlink implementation
> expect this value to be a u16, they should/)
> -- 
> pw-bot: cr
