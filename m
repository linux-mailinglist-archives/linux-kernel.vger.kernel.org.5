Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E656E7D4531
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJXB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXB5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:57:38 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746FA6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:57:34 -0700 (PDT)
Message-ID: <3853229d-f68b-4960-8679-70d6f6aff9aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698112652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjgMBTuitzWiqP1VcTJIuT4VtPo4lD7nloc78b4VZx4=;
        b=TtQ3KVyew64mhmsodXWVnBiE7CVDnvKHUF0hZZAVTl6JC9JB/PbJPd7kMyhG3w8jkliNji
        WFaHIPwoXbV6ozjjVW0ivWgodejQYMD/thWQNK3DL/7ALURmqKyWltcDTikNMAcVoi/oG6
        SzPEdkGNoKgGLb72/LHldviYu8ZYi+M=
Date:   Tue, 24 Oct 2023 09:57:25 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 1/6] slub: Keep track of whether slub is on the
 per-node partial list
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <20231021144317.3400916-2-chengming.zhou@linux.dev>
 <ZTZn23OzQfAm6epp@casper.infradead.org>
 <ZTadrbMDcWPKMjde@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZTadrbMDcWPKMjde@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/24 00:22, Matthew Wilcox wrote:
> On Mon, Oct 23, 2023 at 01:32:27PM +0100, Matthew Wilcox wrote:
>> _Assuming_ that it's safe to use the non-atomic flag setting, I'd
>> rather see this done as ...
>>
>> static inline void slab_set_node_partial(struct slab *slab)
>> {
>> 	__folio_set_workingset(slab_folio(slab));
> 
> Ugh, I meant to delete this line.  I meant to just write the next line.
> 
>> 	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
>> }

Yes, it's safe to use the non-atomic version here, since it's protected
by the slub per-node list_lock and we want better performance here.

Ok, will change to directly use __set_bit() and __clear_bit() instead of
polluting the "workingset" interfaces there.

Thanks.
