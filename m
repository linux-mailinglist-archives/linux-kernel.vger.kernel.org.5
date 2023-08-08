Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283477375B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjHHDIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHHDIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:08:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2F9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:08:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKdN53LLxzNmsy;
        Tue,  8 Aug 2023 11:05:09 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:08:37 +0800
Subject: Re: [PATCH] mm: remove unneeded __meminit annotation
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230808015831.608454-1-linmiaohe@huawei.com>
 <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <308f326d-c7ae-be49-22af-189a81a89aa2@huawei.com>
Date:   Tue, 8 Aug 2023 11:08:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZNGo5Y4vQ3rQn0vf@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2023/8/8 10:31, Matthew Wilcox wrote:
> On Tue, Aug 08, 2023 at 09:58:31AM +0800, Miaohe Lin wrote:
>> kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
>> is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
>> __meminit annotation. No functional change intended.
> 
> I don't understand why this is an improvement.  If CONFIG_MEMORY_HOTREMOVE
> is disabled, the linker drops this section (... right?)  If it's enabled,

When CONFIG_MEMORY_HOTREMOVE is disabled, without this patch:

size mm/compaction.o
   text	   data	    bss	    dec	    hex	filename
 103164	  30873	      0	 134037	  20b95	mm/compaction.o

size mm/vmscan.o
   text	   data	    bss	    dec	    hex	filename
 158775	  49612	     64	 208451	  32e43	mm/vmscan.o

while with this patch:

size mm/compaction.o
   text	   data	    bss	    dec	    hex	filename
 102915	  30865	      0	 133780	  20a94	mm/compaction.o

size mm/vmscan.o
   text	   data	    bss	    dec	    hex	filename
 158534	  49604	     64	 208202	  32d4a	mm/vmscan.o

We can reduce each .o by ~250 bytes.

> then it gets shunted off into a cold section.  So it seems like this
> patch strictly makes things worse.  But maybe I misunderstood.

What about add __cold annotation? Something like:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb4db273bf7e..e27ffa22c70f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7902,7 +7902,7 @@ void __meminit kswapd_run(int nid)
  * Called by memory hotplug when all memory in a node is offlined.  Caller must
  * be holding mem_hotplug_begin/done().
  */
-void kswapd_stop(int nid)
+void __cold kswapd_stop(int nid)
 {
        pg_data_t *pgdat = NODE_DATA(nid);
        struct task_struct *kswapd;

Thanks.
