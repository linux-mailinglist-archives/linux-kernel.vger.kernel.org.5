Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5A776EFC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjHCQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjHCQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ED5E4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4A561E1D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D4AC433C9;
        Thu,  3 Aug 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080845;
        bh=NI7M5nVqns/TurmJFFwI2aLoffncxbg++s5EmED6FKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n950stocTOkG/lu8Iqr01otzxmPUTEOAgv64Sn+oeSUMtsX3XOdIEa6AyHwLjj+jT
         az3VJpROPtBv+8OfVefo6HqNM+rr0276yPcLuCx5TWrha6G83e0lvrhR9yq452qQzC
         jtXOPYugCqLwEvYnJFAEqkoF1io04AQFTRrGv67vJCXHWZh9eOrDQ8hql5b7oMZ+pK
         JWjTWxgl9GycYlB9TVcFC2hcS5snq2HtPUPeXYkSygC6Bh7QF0S+x4JrF+Td0zyjQf
         wJDV2bRnXKB5u7kDfLEKlBopJvvyQm2ffCjGto30uFlGxwFLhB/jKsM4nKHNCgQMZi
         9eBzDYfaUUkZQ==
Date:   Thu, 3 Aug 2023 09:40:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230803094043.31d27cb5@kernel.org>
In-Reply-To: <7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
        <20230727144336.1646454-6-aleksander.lobakin@intel.com>
        <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
        <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
        <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
        <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
        <20230802142920.4a777079@kernel.org>
        <7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
        <20230803090029.16a6798d@kernel.org>
        <7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 18:07:23 +0200 Alexander Lobakin wrote:
> >> I would propose to include it in the series, but it has grown a bunch
> >> already and it's better to do that later separately :s  
> > 
> > Yeah.. I'd be trying to split your series up a little to make progress
> > rather than add more things :( I was going to suggest that you post
> > just the first 3 patches for instance. Should be an easy merge.  
> 
> One minute before I was going to post v2 :>
> Sounds good. AFACS only #4-6 are still under question (not for me tho
> :D), let me move that piece out.

FWIW I'll apply my doc changes in the next 5min if nobody objects.
Can you rebase on top of that?
