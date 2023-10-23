Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6D7D2BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjJWHuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjJWHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F610F4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6958BC433C8;
        Mon, 23 Oct 2023 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698047404;
        bh=v2aM/kvq72VOZ3jr1hNqEC20sqhqlJwe771PUm7Sbsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqR3Z07z0GtHMmF5bpI7wwNlVb2Kw418tFJCwKpbhmQ9oLt+gN+d7AEX/g+odrA6N
         J0jCpTO4vl0fzwBJs/g/C+BwTwm9RxDUy+XXqhp/eSfluVTrsRzN/k0sWudpp+mpgc
         Dm3cQ3qetvwvjem3Tai9qFLuj/jnKEwdUECc6+RQpGGvpphxgdQxGU3+YlvJ4HQw1h
         aHvx34K+Utp3QtIiIVPIfHzoReqkF0uG6wIw9gSwMZRtHLkDLt3zbfj0ebfspWyatL
         FmMUOYzBURQlTRP/+Y//2TWhBCKMqGeNyUIbWBM9UnqsjrwTfybLJmpzJ/O29Zvfwk
         yE7tS1GaOO+eA==
Date:   Mon, 23 Oct 2023 08:49:59 +0100
From:   Simon Horman <horms@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
Message-ID: <20231023074959.GV2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-3-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:00:26PM +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
> 
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> So revert that behavior.
> 
> After reverting, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

