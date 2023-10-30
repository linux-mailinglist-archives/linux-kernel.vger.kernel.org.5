Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C077DC059
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJ3TZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjJ3TZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:25:23 -0400
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D65B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:25:20 -0700 (PDT)
Received: by gentwo.org (Postfix, from userid 1003)
        id BD90248F2C; Mon, 30 Oct 2023 12:25:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id BC0EE48CA2;
        Mon, 30 Oct 2023 12:25:19 -0700 (PDT)
Date:   Mon, 30 Oct 2023 12:25:19 -0700 (PDT)
From:   Christoph Lameter <cl@linux.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
In-Reply-To: <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
Message-ID: <7f70d130-c05a-3cb7-9509-41c21c3014fb@linux.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev> <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com> <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023, Chengming Zhou wrote:

> 2. But for full slab (slab->freelist == NULL), PG_workingset is not much useful, we don't
>   safely know whether it's used as the cpu slab or not just from this flag. So __slab_free()
>   still rely on the "frozen" bit to know it.
>
> 3. And the maintaining of "frozen" has no extra cost now, since it's changed together with "freelist"
>   and other counter using cmpxchg, we already have the cmpxchg when start to use a slab as the cpu slab.
>
> Maybe I missed something, I don't know how to drop the frozen flag.


Maybe frozen is now = PG_Workingset | cmpxchg-frozen?


