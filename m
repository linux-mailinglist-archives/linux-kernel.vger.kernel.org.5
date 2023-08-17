Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14EB77FBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbjHQQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353586AbjHQQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39094
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E344E63330
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB8C433C7;
        Thu, 17 Aug 2023 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692288955;
        bh=wpB7s0BF7i2OV8MyqoB+YeaFdQRuC0uvNlxwgDY03ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U1gL9SuP01FjuS909LIqqQAHr+SG562qyJb2E46PZ5cCj9a0DY2Teag4z21HaWVPT
         qLwyaE9YLhHJ8QQrY7sAvPrJ64TipjUKUxaey6T0DFeIeL0ext/sdJFTkBqaDLcWtb
         0XKnSYuJ2vjRMmgWtQGV18dfPW+cEjNrxToDctFgBNh/GxqONtp/PLHS3HP2nxV9fQ
         fMPG5rlBWtPhioOQAocRZaaNLDFohYfDnVYB/DRfv6pNEuXfG+EMWlEJwE4x9eHdUi
         bkZrPAaUao0TP+QOeKbngU/wF/gZ4uwinHYAAq9Dg9eHqLKLfOoqSN3xRNQvrnsbiT
         6LZbE0/PdvW+Q==
Date:   Thu, 17 Aug 2023 09:15:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230817091554.31bb3600@kernel.org>
In-Reply-To: <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
        <20230816100113.41034-2-linyunsheng@huawei.com>
        <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:57:16 +0300 Ilias Apalodimas wrote:
> Why should we care about this?  Even an architecture that's 32-bit and
> has a 64bit DMA should be allowed to split the pages internally if it
> decides to do so.  The trick that drivers usually do is elevate the
> page refcnt and deal with that internally.

Can we assume the DMA mapping of page pool is page aligned? We should
be, right? That means we're storing 12 bits of 0 at the lower end.
So even with 32b of space we can easily store addresses for 32b+12b =>
16TB of memory. "Ought to be enough" to paraphrase Bill G, and the
problem is only in our heads?

Before we go that way - Mina, are the dma-buf "chunks" you're working
with going to be fragment-able? Or rather can driver and/or core take
multiple references on a single buffer?
