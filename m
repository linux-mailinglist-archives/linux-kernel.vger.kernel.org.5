Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AA785C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjHWP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjHWP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4F019A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D524A62739
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBDC433C8;
        Wed, 23 Aug 2023 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692804393;
        bh=mKd/HsM9CgrNwIqwTu7sxZhwSfKPBXrjTmhcYrAzpYw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xn+o1kwJdSq0vwWxx6/FNh0GkKg4HlBAsuRxQQ0v4xGljhuU2b15XMMYOpqcQm4nm
         BJPHrbcg92x5H8sRVipDkm0bzj+Q9R0g1FX/7qR6Lu2DagWOqEyCLQawsaYsULF3yK
         iHe2P5CkxdebRIr76kYKc9nuBTDphH9tFZh4Zo21zu/ZfgX5cczUU9RdawH357qmSc
         BYWi+rC7ysWy82asDcTdvLtDvA81vbPV91m2LMNxTbdUJx84PJko6e6EX62rYIuatq
         yri3+np1Qst+KSyU8iTPL3sehe5QX8MkHXfJd5pObgWthb8bLfj09WwxpaBRS7IK0u
         JNWmq4OHN7RJg==
Message-ID: <0dd3c1a7-5f17-2490-775f-ea08c407313d@kernel.org>
Date:   Wed, 23 Aug 2023 23:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: release ztailpacking pclusters properly
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/22 19:05, Jingbo Xu wrote:
> Currently ztailpacking pclusters are chained with FOLLOWED_NOINPLACE and
> not recorded into the managed_pslots XArray.
> 
> After commit 7674a42f35ea ("erofs: use struct lockref to replace
> handcrafted approach"), ztailpacking pclusters won't be freed with
> erofs_workgroup_put() anymore, which will cause the following issue:
> 
> BUG erofs_pcluster-1 (Tainted: G           OE     ): Objects remaining in erofs_pcluster-1 on __kmem_cache_shutdown()
> 
> Use z_erofs_free_pcluster() directly to free ztailpacking pclusters.
> 
> Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
