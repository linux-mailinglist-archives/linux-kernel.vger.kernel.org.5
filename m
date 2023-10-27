Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976F77D9F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjJ0SHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJ0SHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:07:06 -0400
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 11:07:03 PDT
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA9AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:07:03 -0700 (PDT)
Received: by gentwo.org (Postfix, from userid 1003)
        id BD2E348F4E; Fri, 27 Oct 2023 10:57:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id BC6E9489FB;
        Fri, 27 Oct 2023 10:57:56 -0700 (PDT)
Date:   Fri, 27 Oct 2023 10:57:56 -0700 (PDT)
From:   Christoph Lameter <cl@linux.com>
To:     chengming.zhou@linux.dev
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
In-Reply-To: <20231024093345.3676493-1-chengming.zhou@linux.dev>
Message-ID: <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, chengming.zhou@linux.dev wrote:

> 2. Solution
> ===========
> We solve these problems by leaving slabs unfrozen when moving out of
> the node partial list and on CPU partial list, so "frozen" bit is 0.
>
> These partial slabs won't be manipulate concurrently by alloc path,
> the only racer is free path, which may manipulate its list when !inuse.
> So we need to introduce another synchronization way to avoid it, we
> reuse PG_workingset to keep track of whether the slab is on node partial
> list or not, only in that case we can manipulate the slab list.
>
> The slab will be delay frozen when it's picked to actively use by the
> CPU, it becomes full at the same time, in which case we still need to
> rely on "frozen" bit to avoid manipulating its list. So the slab will
> be frozen only when activate use and be unfrozen only when deactivate.

I think we have to clear our terminology a bit about what a "frozen" slab 
is.

Before this patch a frozen slab is not on the node partial list and 
therefore its state on the list does not have to be considered during 
freeing and other operations. The frozen slab could be actively allocated 
from.

From the source:

*   Frozen slabs
  *
  *   If a slab is frozen then it is exempt from list management. It is not
  *   on any list except per cpu partial list. The processor that froze the
  *   slab is the one who can perform list operations on the slab. Other
  *   processors may put objects onto the freelist but the processor that
  *   froze the slab is the only one that can retrieve the objects from the
  *   slab's freelist.
  *


After this patch the PG_workingset indicates the state of being on 
the partial lists.

What does "frozen slab" then mean? The slab is being allocated from? Is 
that information useful or can we drop the frozen flag?

Update the definition?

