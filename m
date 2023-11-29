Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D47FD962
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjK2O3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjK2O3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:29:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30004D50
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:29:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C7C433C9;
        Wed, 29 Nov 2023 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701268155;
        bh=TeXzHb7rxKXQGXucrw/Ty/eqYEy5dqm0uu/JKO7RDCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i3O7voHEX9nwvQnJXx+x/l0uWqkVQvdAG5q4p3bznL6GqphqcrWs3xFHrQ8QI/oPi
         lNmWjgwa9JSdXyIuoBuXqerZJuECGpkCKl+ZH+M4+4WdrDS6HtsTg176EV4ShNUCW5
         74vO/32ri773Hg8T1+F7X62xkD1hHHTvOHaVEMEz+B5Pu2Lc94AamDXFejMn5DgGVK
         74kTTH2DyszHJFugM9TQ9/a5NIFzY+8wnrbrtwAXkgCspTtViqeF+Mf1HxL2Bs4rzi
         K1XKEAxa6HRKtIqP31DRapZ0z0qUqTCdIRHAVe/eJoY6N8ZxHzb/zX810zld/zkWC3
         feN0/SCLMbyRw==
Date:   Wed, 29 Nov 2023 06:29:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Message-ID: <20231129062914.0f895d1c@kernel.org>
In-Reply-To: <e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
        <20231124154732.1623518-14-aleksander.lobakin@intel.com>
        <e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
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

On Wed, 29 Nov 2023 14:40:33 +0100 Alexander Lobakin wrote:
> > Expand the libie generic per-queue stats with the generic Page Pool
> > stats provided by the API itself, when CONFIG_PAGE_POOL_STATS is
> > enabled. When it's not, there'll be no such fields in the stats
> > structure, so no space wasted.  
> 
> Do I get it correctly that after Page Pool Netlink introspection was
> merged, this commit makes no sense and we shouln't add PP stats to the
> drivers private ones?

Yes, 100%.

FWIW I am aware that better tooling would be good so non-developers
could access to the PP Netlink :(  I'm thinking we should clean up 
YNL lib packaging a little and try to convince iproute2 maintainers 
to accept simple CLI built on top of it.
