Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C027576F6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHDBVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A9420A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E267261EE2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4599C433C8;
        Fri,  4 Aug 2023 01:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691112083;
        bh=5orjVrOpDSU7lC6XWYb50yRi3CyLxe0uhFWTNPZ+CRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m5xBf9GI8DX3y/fuXlCBtDK7cRcob9oC8Nz1sKXUNYSwMPCiymCrXi011oT3l6X7E
         evYGDzSyATBaYUJ2X5VeLV++MpTgO6qE35b7x/mBrxrnUGI+O7R/Q686iwiDlpOMgO
         auxX8vIb+KjPjtjY2giFU2+uxsPCpkA0kOiCF/fAh7xaG8JLra2ufaFS4AibNzYQch
         XjtUrmJlPIA7lSDaGgxujKvP+C29ywGsY48NePl/yKiCrbI0CtFvZ98AAoFZL/Xpdi
         mDgswrsF5MHBJNFNg3Nnics9Hj4yptqC/tjydyXI0738RIAj9zvBtpEjFmjEzZ95jn
         Z6d4XEpuDHiww==
Date:   Thu, 3 Aug 2023 18:21:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/6] page_pool: a couple of assorted
 optimizations
Message-ID: <20230803182121.1baf4c13@kernel.org>
In-Reply-To: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
References: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
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

On Thu,  3 Aug 2023 20:20:32 +0200 Alexander Lobakin wrote:
> That initially was a spin-off of the IAVF PP series[0], but has grown
> (and shrunk) since then a bunch. In fact, it consists of three
> semi-independent blocks:
> 
> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>   not overbloat the consumers not needing complex inline helpers and
>   then stop including it in skbuff.h at all. The first patch is also
>   prereq for the whole series.
> * #3: Improve cacheline locality for users of the Page Pool frag API.
> * #4-6: Use direct cache recycling more aggressively, when it is safe
>   obviously. In addition, make sure nobody wants to use Page Pool API
>   with disabled interrupts.
> 
> Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
> small modifications from my side as per ML discussions.
> For the perf numbers for #3-6, please see individual commit messages.

Our scheming didn't help much, the series also conflicts
with the net/xdp.h includes which came in via bpf-next :(
-- 
pw-bot: cr
