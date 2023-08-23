Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305278513F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHWHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjHWHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199EF3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB0D464BE9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79648C433C7;
        Wed, 23 Aug 2023 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692774861;
        bh=O0CSLKPWiPjT6f8HB7qUcvjKEmbNq0QtPMkBdTDoUak=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=m7PY2gVi/oTNTQkiuFRqfZst5KkS6WVEftyJXiqfBonMyxTg+r77Rp5qqljP5q/x1
         issCCRPaoqzRL+NniYqSr0oZRXJGm4pWxB6VQxVjaC/C2Ae1GOLkoHRhnm6tms2XoK
         bvQ+/dPj/aCfbMMkkppVQXpzXvPzZxZftW61ZvvQbnbnf6on5AiGhTFzqjx6g8Nukn
         PFCUaTQynSGm8sH2i1EjJA9DUkx4gn0fydn8IoFKpoSzTYdbAS7zGdiLoB5ZWIQpAo
         hyDjXufaX1bpPEeop5MivvKYFOUBv3iZKz9gw3riIKdea0m0SMZ6jgJh19rceLu/dS
         vhseGGdzpgfgQ==
Message-ID: <24f2dd3e-fb00-894b-0cdc-4ad1e4345a06@kernel.org>
Date:   Wed, 23 Aug 2023 09:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823025325.2499289-1-rkannoth@marvell.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230823025325.2499289-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2023 04.53, Ratheesh Kannoth wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> This have been tested on octeontx2 CN10KA hardware.
> TCP and UDP tests using iperf shows no performance regressions.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin<aleksander.lobakin@intel.com>
> Reviewed-by: Sunil Goutham<sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth<rkannoth@marvell.com>

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
