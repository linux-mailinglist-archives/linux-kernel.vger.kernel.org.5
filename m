Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191147E885B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjKKCgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjKKCgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:36:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7633C0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:35:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F08C433C7;
        Sat, 11 Nov 2023 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699670158;
        bh=gY+gv6FuH7IyPZd+GcBbaxMFJ8nyFzbRgSyvPpB8WHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ht9uExB8i5dnk2CmKBU1mVcjqsdrsD2ZgLZevr8N30eX0ZSAYboFGGKykaf+sSld7
         CGIVo25CwHPZiytr+teiiIPuigIDo+JPIkQyvN5n3iPDUMIc9jsF0NZEo7e+fDs8hI
         ztRuR71feWJhW6c3gOy9FbB8al83VwWsa2jI6RDs8vnryE62nP6YASRYhTa1kayr6w
         Da1EO6WGh1FXrOMerj2O/J/S46xnJ+wZhJFsdyYR1y51fhNB5Bz4l+uQ9vxyzm9yki
         rXMDshUoip7ZzimtjecJgZVPpXDWmdS8vodHd4gqw3Sf3ZLjfhV8IAAtpr5Xj5Edg8
         N5/Cmof6uQUjA==
Date:   Fri, 10 Nov 2023 18:35:56 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231110183556.2b7b7502@kernel.org>
In-Reply-To: <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-13-almasrymina@google.com>
        <20231110151335.38a1c6ec@kernel.org>
        <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 18:27:08 -0800 Mina Almasry wrote:
> Thanks for the clear requirement. I clearly had something different in mind.
> 
> Might be dumb suggestions, but instead of creating a new ndo that we
> maybe end up wanting to deprecate once the queue API is ready, how
> about we use either of those existing APIs?
> 
> +void netdev_reset(struct net_device *dev)
> +{
> +       int flags = ETH_RESET_ALL;
> +       int err;
> +
> +#if 1
> +       __dev_close(dev);
> +       err = __dev_open(dev, NULL);
> +#else
> +       err = dev->ethtool_ops->reset(dev, &flags);
> +#endif
> +}
> +
> 
> I've tested both of these to work with GVE on both bind via the
> netlink API and unbind via the netlink socket close, but I'm not
> enough of an expert to tell if there is some bad side effect that can
> happen or something.

We generally don't accept drivers doing device reconfiguration with
full close() + open() because if the open() fails your machine 
may be cut off.

There are drivers which do it, but they are either old... or weren't
reviewed hard enough.

The driver should allocate memory and whether else it can without
stopping the queues first. Once it has all those, stop the queues,
reconfigure with already allocated resources, start queues, free old.

Even without the queue API in place, good drivers do full device
reconfig this way. Hence my mind goes towards a new (temporary?)
ndo. It will be replaced by the queue API, but whoever implements
it for now has to follow this careful reconfig strategy...
