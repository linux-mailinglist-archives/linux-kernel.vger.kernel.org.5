Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E917CC728
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbjJQPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjJQPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A739B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED79C433C8;
        Tue, 17 Oct 2023 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697555584;
        bh=JJc9uTY6VESHKtR5Rwh2zpqzChvYnI7TdKWdn6WPs14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXlNQibyA6fZX59FsDqAImWdfJ2ih+TXCnscodf3g8+R9omBLcX/s62+o+7WAuzU/
         FICPLw0vFyVsL3tAaDzuf5HsyiBSc9j6Q5YgaDcyLt0VKOzF51lZpt5DnQOrIutWdA
         eotRndq9Lp3W+l0OUaWmHbOzcqWuZYUfNBBsQ05hbxUsYEwnKAzvQP0/2NDTc+k695
         xShDcSzo2Bp+t8bIfyYhUxBLd4lbsbIuT1RTmCcDkVO6A++OL4IPUZ6q97npihxVXq
         4kDcI2SMPSH6qdwZkopC/EGxghJNwo8hoUZ5vG4JfANfyvey4SUcj/kHOSxIPOLSUj
         Wt2lTDHetvlrA==
Date:   Tue, 17 Oct 2023 08:13:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231017081303.769e4fbe@kernel.org>
In-Reply-To: <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
        <20231016182725.6aa5544f@kernel.org>
        <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 15:56:48 +0800 Yunsheng Lin wrote:
> > And I can't figure out now what the "cache" in the name is referring to.
> > Looks like these are just convenience wrappers which return VA instead
> > of struct page..  
> 
> Yes, it is corresponding to some API like napi_alloc_frag() returning va
> instead of 'struct page' mentioned in patch 5.
> 
> Anyway, naming is hard, any suggestion for a better naming is always
> welcomed:)

I'd just throw a _va (for virtual address) at the end. And not really
mention it in the documentation. Plus the kdoc of the function should
say that this is just a thin wrapper around other page pool APIs, and
it's safe to mix it with other page pool APIs?
