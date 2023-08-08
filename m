Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC97743C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjHHSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHHSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:09:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC81B528
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:11:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKjSt1MjkzrSMp;
        Tue,  8 Aug 2023 14:09:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 14:10:44 +0800
Subject: Re: [PATCH] mm: remove unneeded __meminit annotation
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230808015831.608454-1-linmiaohe@huawei.com>
 <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
 <308f326d-c7ae-be49-22af-189a81a89aa2@huawei.com>
 <ZNGzqRYzC8lbLG9s@casper.infradead.org>
 <ZNG1+PV5nG8YZDev@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <68b73067-59bf-e25f-448f-79ec60fc6639@huawei.com>
Date:   Tue, 8 Aug 2023 14:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZNG1+PV5nG8YZDev@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 11:26, Matthew Wilcox wrote:
> On Tue, Aug 08, 2023 at 04:16:57AM +0100, Matthew Wilcox wrote:
>> On Tue, Aug 08, 2023 at 11:08:36AM +0800, Miaohe Lin wrote:
>>> On 2023/8/8 10:31, Matthew Wilcox wrote:
>>>> On Tue, Aug 08, 2023 at 09:58:31AM +0800, Miaohe Lin wrote:
>>>>> kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
>>>>> is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
>>>>> __meminit annotation. No functional change intended.
>>>>
>>>> I don't understand why this is an improvement.  If CONFIG_MEMORY_HOTREMOVE
>>>> is disabled, the linker drops this section (... right?)  If it's enabled,
>>>
>>> When CONFIG_MEMORY_HOTREMOVE is disabled, without this patch:
>>>
>>> size mm/compaction.o
>>>    text	   data	    bss	    dec	    hex	filename
>>>  103164	  30873	      0	 134037	  20b95	mm/compaction.o
>>>
>>> size mm/vmscan.o
>>>    text	   data	    bss	    dec	    hex	filename
>>>  158775	  49612	     64	 208451	  32e43	mm/vmscan.o
>>>
>>> while with this patch:
>>>
>>> size mm/compaction.o
>>>    text	   data	    bss	    dec	    hex	filename
>>>  102915	  30865	      0	 133780	  20a94	mm/compaction.o
>>>
>>> size mm/vmscan.o
>>>    text	   data	    bss	    dec	    hex	filename
>>>  158534	  49604	     64	 208202	  32d4a	mm/vmscan.o
>>>
>>> We can reduce each .o by ~250 bytes.
>>
>> But this is before the linker step!  That will be where the meminit
>> sections get dropped.  Assuming they are; I haven't verified.  You need
>> to compare before/after of the vmlinux, not the individual .o files.

When CONFIG_MEMORY_HOTREMOVE is disabled, without patch:

size vmlinux
   text	   data	    bss	    dec	    hex	filename
70648396	21668938	17985540	110302874	693169a	vmlinux

while with patch:

size vmlinux
   text	   data	    bss	    dec	    hex	filename
70648128	21668938	17985540	110302606	693158e	vmlinux

vmlinux is still reduced by 268 bytes.

> 
> Ah, found it:
> 
> #if defined(CONFIG_MEMORY_HOTPLUG)
> #define MEM_KEEP(sec)    *(.mem##sec)
> #define MEM_DISCARD(sec)
> #else
> #define MEM_KEEP(sec)
> #define MEM_DISCARD(sec) *(.mem##sec)
> #endif
> 
> in include/asm-generic/vmlinux.lds.h

When CONFIG_MEMORY_HOTREMOVE is disabled, without this patch, kswapd_stop() and kcompactd_stop()
are dropped after system init.

But no insist in this patch.

Thanks for your comment.

