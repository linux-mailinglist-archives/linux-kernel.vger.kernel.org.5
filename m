Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA775CCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGUQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjGUQBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6313AAA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBCBE61D23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDA6C433C7;
        Fri, 21 Jul 2023 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689955290;
        bh=PA8mIgj50fgfgrMmzr5lfjZFBWvQfHEld71JX4l0vVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApAy324Isd9NkMwHiREvXxaFH9gl3vLG53CvMG2D5xH2Qp1tl7DI+Vsm77Y077GXX
         9o4KMZKE5dVK3YEWO0FxBiI971ZmKeEAGuzLxLrbitRq5DjKpfoVQ1p0tfitMnwU3g
         M3kjLl9nwy0tPuDc8NJdUgmdJHBPyi79psylyw+gEvznThbSsxSGD+Ay6nh5ZzGHg+
         pZ9tsTBH7mI8RDI+dTVM9ctjiXsVpdJR26EVxahTnhQcxtpxQe0jt9msdvMUBXnqJZ
         lFLbtOd3ekcSfi4h8NS/Q7VpmnjhDii+aBVkaahbn9jKDIozAa2WfXR1wwbwC5e5a0
         6dYEzHJBaUvrg==
Date:   Fri, 21 Jul 2023 09:01:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230721090129.4a61033b@kernel.org>
In-Reply-To: <ebd284ad-5fa9-2269-c40e-f385420b27c3@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
        <20230718174042.67c02449@kernel.org>
        <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
        <20230719135150.4da2f0ff@kernel.org>
        <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
        <20230720101231.7a5ff6cd@kernel.org>
        <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
        <20230720110027.4bd43ee7@kernel.org>
        <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
        <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
        <20230720122015.1e7efc21@kernel.org>
        <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
        <20230720124647.413363d5@kernel.org>
        <406885ee-8dd0-1654-ec13-914ed8986c24@huawei.com>
        <ebd284ad-5fa9-2269-c40e-f385420b27c3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 17:37:57 +0200 Alexander Lobakin wrote:
> > Does it mean ptr_ring_produce_any() is needed in
> > page_pool_recycle_in_ring() too?
> > 
> > As it is assumed that page pool API can be called in the context with
> > irqs_disabled() || in_hardirq(), and force recylcling happens in the
> > prt_ring.
> > 
> > Isn't it conflit with the below patch? as the below patch assume page
> > pool API can not be called in the context with irqs_disabled() || in_hardirq():
> > [PATCH net-next] page_pool: add a lockdep check for recycling in hardirq
> > 
> > Or am I missing something obvious here?  
> 
> No, Page Pool is *not* intended to be called when IRQs are disabled,
> hence the fix Jakub's posted in the separate thread.

Yeah, it's just a bandaid / compromise, since Olek really wants his
optimization and I really don't want to spend a month debugging
potential production crashes :)

On the ptr ring the use may still be incorrect but there is a spin lock
so things will explode in much more obvious way, if they do.
