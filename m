Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6722B7DCB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJaLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjJaJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:54:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C206D61;
        Tue, 31 Oct 2023 02:53:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FF341F38A;
        Tue, 31 Oct 2023 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698746022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hldBQeVlnzcxJxh6wOmSdWjQZeq5v7flC9grgdCposU=;
        b=jXbhZ5At6n6gg1nSVJhvzsaRTbKUfxTAg6z30byugTH7CgJY4vtLEdIvBPpGF/tP27lR9z
        MoblyO7DrwG11ZV3MX0jQwLEgI05yeFeZQRqga0Vue3SJ5OdlFW/+k42xv1jD+MAM8U1WR
        eLAY64j/+JGgspqmSLOwvHa88ruOnpc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17C2F1391B;
        Tue, 31 Oct 2023 09:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GhjLAqbOQGWDcQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Oct 2023 09:53:42 +0000
Date:   Tue, 31 Oct 2023 10:53:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, hannes@cmpxchg.org,
        tim.c.chen@intel.com, dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
References: <20231031003810.4532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031003810.4532-1-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-10-23 20:38:06, Gregory Price wrote:
> This patchset implements weighted interleave and adds a new sysfs
> entry: /sys/devices/system/node/nodeN/accessM/il_weight.
> 
> The il_weight of a node is used by mempolicy to implement weighted
> interleave when `numactl --interleave=...` is invoked.  By default
> il_weight for a node is always 1, which preserves the default round
> robin interleave behavior.
> 
> Interleave weights may be set from 0-100, and denote the number of
> pages that should be allocated from the node when interleaving
> occurs.
> 
> For example, if a node's interleave weight is set to 5, 5 pages
> will be allocated from that node before the next node is scheduled
> for allocations.

I find this semantic rather weird TBH. First of all why do you think it
makes sense to have those weights global for all users? What if
different applications have different view on how to spred their
interleaved memory?

I do get that you might have a different tiers with largerly different
runtime characteristics but why would you want to interleave them into a
single mapping and have hard to predict runtime behavior?

[...]
> In this way it becomes possible to set an interleaving strategy
> that fits the available bandwidth for the devices available on
> the system. An example system:
> 
> Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
> Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
> Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
> Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex
> 
> In this setup, the effective weights for nodes 0-3 for a task
> running on Node 0 may be [60, 20, 10, 10].
> 
> This spreads memory out across devices which all have different
> latency and bandwidth attributes at a way that can maximize the
> available resources.

OK, so why is this any better than not using any memory policy rely
on demotion to push out cold memory down the tier hierarchy?

What is the actual real life usecase and what kind of benefits you can
present?
-- 
Michal Hocko
SUSE Labs
