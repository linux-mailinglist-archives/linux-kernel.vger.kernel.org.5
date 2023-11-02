Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B57DEA9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbjKBCSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348236AbjKBCSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:18:14 -0400
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A5E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:18:08 -0700 (PDT)
Message-ID: <8933031a-1491-4942-8358-bca178698e6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698891487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eV0WyCSS6AIUSUkKoV2DO4u1mSBc/CtM3JJpyJaxcA=;
        b=UJ1dbRtnRTce7EEU2MNTfQZSlbrc7BWb8D+8hvI5cMuHdKKJjBKXRFSioYAJPnnNP7gaOk
        MCSRFkTafClrk/eQmNpzopa3Sqbg/T2hMyZ7HxElEivt5YLFM25Olx4MH5IwVVpI18Ao6T
        gowgJ3VkVk2aU+8YoSKqA7tmTk6nqGI=
Date:   Thu, 2 Nov 2023 10:17:38 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 0/9] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <ZUJTiGgWrkYQPwaf@fedora>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZUJTiGgWrkYQPwaf@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/1 21:33, Hyeonggon Yoo wrote:
> On Tue, Oct 31, 2023 at 02:07:32PM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Changes in RFC v4:
>>  - Reorder patches to put the two cleanup patches to the front.
>>  - Move slab_node_partial flag functions to mm/slub.c.
>>  - Fix freeze_slab() by using slab_update_freelist().
>>  - Fix build error when !CONFIG_SLUB_CPU_PARTIAL.
>>  - Add a patch to rename all *unfreeze_partials* functions.
>>  - Add a patch to update inconsistent documentations in the source.
>>  - Some comments and changelog improvements.
>>  - Add Reviewed-by and Suggested-by tags. Many thanks!
>>  - RFC v3: https://lore.kernel.org/all/20231024093345.3676493-1-chengming.zhou@linux.dev/
> 
> Hi,
> This series passed (yeah, v3 was broken as reported by the bot)
> hackbench + a set of MM tests on 30 different SLUB configs [1] [2]
> 
> For the series, feel free to add:
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Thanks!
> 
> [1] https://jenkins.kerneltesting.org/job/slab-experimental/21/
> [2] https://lava.kerneltesting.org/scheduler/alljobs
> 

Great! This is very helpful! I will add it in v5.

Thanks!
