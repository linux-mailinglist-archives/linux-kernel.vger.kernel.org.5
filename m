Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAA7CD58A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjJRHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJRHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:37:42 -0400
Received: from out-198.mta0.migadu.com (out-198.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE77B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:37:40 -0700 (PDT)
Message-ID: <6fdb2e74-2918-4cd2-bbda-f00745b03b97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697614658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foiCuM1H7ljhyJH1H/r+XAx2HhX//BkMMbSuBQo9fHc=;
        b=GD9g58o9Ib0PEYOKxZHm/qm0HvTmWCnn2WxHVvnrlecED1sl9Q9Y7vSRp1xOMFPUylP138
        Wxgnw7qZh78PzRrVX7deqYD8HOlReBCO0vwZqvoweQBC5muS3aCyrQAH0ia7hLleHlGI8o
        palR01VPvGo5OxcXcthkMzEtu4d0GAA=
Date:   Wed, 18 Oct 2023 15:37:09 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/5] slub: Introduce on_partial()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
 <20231017154439.3036608-2-chengming.zhou@linux.dev>
 <ZS6uPqJMWgQfoD+j@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZS6uPqJMWgQfoD+j@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 23:54, Matthew Wilcox wrote:
> On Tue, Oct 17, 2023 at 03:44:35PM +0000, chengming.zhou@linux.dev wrote:
>> We change slab->__unused to slab->flags to use it as SLUB_FLAGS, which
>> now only include SF_NODE_PARTIAL flag. It indicates whether or not the
>> slab is on node partial list.
> 
> This is an unnecessarily complex solution.  As with the pfmemalloc bit,
> we can reuse the folio flags for a few flags.  I would recommend the
> PG_workingset bit for this purpose.
> 

Yeah, this is better indeed. Thanks for your suggestion!

