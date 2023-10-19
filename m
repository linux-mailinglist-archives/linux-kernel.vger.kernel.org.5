Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3B7CF205
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjJSIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF0A124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697702865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=e3FX2v8R+Xzt4HwraMAAMPlibIWKS/ZeRUabd2yVffc=;
        b=PKmwBprU1Afo67VPBjBHn4UEwjwk+FYoAgEZJJg4Ao5q2xl6+/Sz+n+sFcUXs1yP4CNRm7
        LhvE4eIxXVsfzAwMKJ5nG7kjHjahCCE1CScGoHcp64qQF/UGVwSPWuGby729pNqbG3l92Z
        I9i42JdlnLb5h7HTvw3tx9MyJtLHXRc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-p_X0yODQNTaPvH9EIJpnVg-1; Thu, 19 Oct 2023 04:07:43 -0400
X-MC-Unique: p_X0yODQNTaPvH9EIJpnVg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32db43129c6so2486993f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702862; x=1698307662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3FX2v8R+Xzt4HwraMAAMPlibIWKS/ZeRUabd2yVffc=;
        b=PG6m0KscNyxiYCXELiaA2tLFdUSirAkCCKwliiqMgLYpf/fTjs9fvErT5QfM6gPsLN
         EwDMW0qOQ4LALT1uUyyDAsMdyuXdwB+2eUmozYPnorkPDZaUBtlLO6uLdLkHfOCAq07F
         6aQEqluNzj/KQGgqEJ8Sy9QJYhqvytn39Co/THUN++VGft/mDmUhkNFa6kUz1bp71EKP
         HH7B/3JYmJuibZxTRhOxx+JrLT5BQ1gJ4AqYBDw+J97wW50c237MoYGh7I0JGgyp+6tf
         dVsHxz/Rrgk+5RxVn5FLGyPnsbfR2vEEC+puRfoAsEkR8vRZqkJ3qQhgMgE26nTUBzZc
         btXQ==
X-Gm-Message-State: AOJu0Yx1rcexPCljCVyRqdkVD+osH85KOLwp+SrstPRvZ23Fc9KXFwxY
        ZFdiv/Ue0DsssKQaUlULSTPRL5j/etAftNO2RlcbunWapMKqAEBMTGvx/JMQ2yxlCos4IUwFpgx
        qXNX8/78npETb4clBppEUJzgg
X-Received: by 2002:a05:600c:5254:b0:402:906:1e87 with SMTP id fc20-20020a05600c525400b0040209061e87mr1196183wmb.31.1697702861887;
        Thu, 19 Oct 2023 01:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcGiLjw36YcvoSVeaAAYuWTO0u/iVYoNAQxT8GqYeD+K5ZVu+kotnYMnd0CWgi8at1wpdh7Q==
X-Received: by 2002:a05:600c:5254:b0:402:906:1e87 with SMTP id fc20-20020a05600c525400b0040209061e87mr1196158wmb.31.1697702861456;
        Thu, 19 Oct 2023 01:07:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:500:6a06:17fc:810b:b054? (p200300cbc70b05006a0617fc810bb054.dip0.t-ipconnect.de. [2003:cb:c70b:500:6a06:17fc:810b:b054])
        by smtp.gmail.com with ESMTPSA id f13-20020a1c6a0d000000b003fe23b10fdfsm3681753wmc.36.2023.10.19.01.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 01:07:41 -0700 (PDT)
Message-ID: <cd210991-5038-4ad3-ac03-abb6761c67bd@redhat.com>
Date:   Thu, 19 Oct 2023 10:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: page_alloc: skip memoryless nodes entirely
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        rppt@kernel.org, vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
 <7928768f2658cd563978f5e5bf8109be1d559320.1697687357.git.zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7928768f2658cd563978f5e5bf8109be1d559320.1697687357.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.23 09:36, Qi Zheng wrote:
> In find_next_best_node(), We skipped the memoryless nodes
> when building the zonelists of other normal nodes (N_NORMAL),
> but did not skip the memoryless node itself when building
> the zonelist. This will cause it to be traversed at runtime.
> 
> For example, say we have node0 and node1, node0 is memoryless
> node, then the fallback order of node0 and node1 as follows:
> 
> [    0.153005] Fallback order for Node 0: 0 1
> [    0.153564] Fallback order for Node 1: 1
> 
> After this patch, we skip memoryless node0 entirely, then
> the fallback order of node0 and node1 as follows:
> 
> [    0.155236] Fallback order for Node 0: 1
> [    0.155806] Fallback order for Node 1: 1
> 
> So it becomes completely invisible, which will reduce runtime
> overhead.
> 
> And in this way, we will not try to allocate pages from memoryless
> node0, then the panic mentioned in [1] will also be fixed. Even though
> this problem has been solved by dropping the NODE_MIN_SIZE constrain
> in x86 [2], it would be better to fix it in core MM as well.
> 
> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/page_alloc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ee392a324802..e978272699d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5052,8 +5052,11 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
>   	int min_val = INT_MAX;
>   	int best_node = NUMA_NO_NODE;
>   
> -	/* Use the local node if we haven't already */
> -	if (!node_isset(node, *used_node_mask)) {
> +	/*
> +	 * Use the local node if we haven't already. But for memoryless local
> +	 * node, we should skip it and fallback to other nodes.
> +	 */
> +	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
>   		node_set(node, *used_node_mask);
>   		return node;
>   	}

Makes sense to me; I suspect that online_pages() will just to the right 
thing and call build_all_zonelists() to fix it up.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

