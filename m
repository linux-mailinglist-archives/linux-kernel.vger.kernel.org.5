Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0C792732
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349156AbjIEQVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354770AbjIEONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:13:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA452197;
        Tue,  5 Sep 2023 07:13:03 -0700 (PDT)
X-UUID: 4e8227f84bf611ee8051498923ad61e6-20230905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=r8m+Ysh7MzIJQJW0je35DqRSDl/nm2DaTMoSX9cJ1NA=;
        b=rWe9fIQmI7MOPgVE78rl+6d+/kUxS8it5DsKkjqQK8fE3HJtZVReUleyMI6E37dc9yrN5uBdZvj7lfza23sd1LshsLl7vLdcqrgShBrGjwQn3zggmE2ArQfQe00zxNYhcCHhPf90imA5wWpUMO69vXeOlGPInNMnxKN34Yg/zRQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9b81e403-5ddd-4f01-866e-f156d96bef57,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-20
X-CID-META: VersionHash:0ad78a4,CLOUDID:cedaabc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 4e8227f84bf611ee8051498923ad61e6-20230905
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tze-nan.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 587380143; Tue, 05 Sep 2023 22:12:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Sep 2023 22:12:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Sep 2023 22:12:53 +0800
From:   Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>,
        <cheng-jui.wang@mediatek.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] ring-buffer: Do not read at &event->array[0] if it across the page
Date:   Tue, 5 Sep 2023 22:12:45 +0800
Message-ID: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading from the tracing/trace, the ftrace reader rarely encounters
a KASAN invalid access issue.
It is likely that the writer has disrupted the ring_buffer that the reader
is currently parsing. the kasan report is as below:

[name:report&]BUG: KASAN: invalid-access in rb_iter_head_event+0x27c/0x3d0
[name:report&]Read of size 4 at addr 71ffff8111a18000 by task xxxx
[name:report_sw_tags&]Pointer tag: [71], memory tag: [0f]
[name:report&]
CPU: 2 PID: 380 Comm: xxxx
Call trace:
dump_backtrace+0x168/0x1b0
show_stack+0x2c/0x3c
dump_stack_lvl+0xa4/0xd4
print_report+0x268/0x9b0
kasan_report+0xdc/0x148
kasan_tag_mismatch+0x28/0x3c
__hwasan_tag_mismatch+0x2c/0x58
rb_event_length() [inline]
rb_iter_head_event+0x27c/0x3d0
ring_buffer_iter_peek+0x23c/0x6e0
__find_next_entry+0x1ac/0x3d8
s_next+0x1f0/0x310
seq_read_iter+0x4e8/0x77c
seq_read+0xf8/0x150
vfs_read+0x1a8/0x4cc

In some edge cases, ftrace reader could access to an invalid address,
specifically when reading 4 bytes beyond the end of the currently page.
While issue happened, the dump of rb_iter_head_event is shown as below:

    in function rb_iter_head_event:
          - iter->head = 0xFEC
          - iter->next_event = 0xFEC
          - commit = 0xFF0
          - read_stamp = 0x2955AC46DB0
          - page_stamp = 0x2955AC2439A
          - iter->head_page->page = 0x71FFFF8111A17000
          - iter->head_page->time_stamp = 0x2956A142267
          - iter->head_page->page->commit = 0xFF0
          - the content in iter->head_page->page
                0x71FFFF8111A17FF0: 01010075 00002421 0A123B7C FFFFFFC0

In rb_iter_head_event, reader will call rb_event_length with argument
(struct ring_buffer_event *event = 0x71FFFF8111A17FFC).
Since the content data start at address 0x71FFFF8111A17FFC are 0xFFFFFFC0.
event->type will be interpret as 0x0, than the reader will try to get the
length by accessing event->array[0], which is an invalid address:
    &event->array[0] = 0x71FFFF8111A18000

Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
---
Following patch may not become a solution, it merely checks if the address
to be accessed is valid or not within the rb_event_length before access.
And not sure if there is any side-effect it can lead to.

I am curious about what a better solution for this issue would look like.
Should we address the problem from the writer or the reader?

Also I wonder if the cause of the issue is exactly as I suspected.
Any Suggestion will be appreciated.

Test below can reproduce the issue in 2 hours on kernel-6.1.24:
    $cd /sys/kernel/tracing/
    # make the reader and writer race more through resize the buffer to 8kb
    $echo 8 > buffer_size_kn
    # enable all events
    $echo 1 > event/enable
    # enable trace
    $echo 1 > tracing_on
 
    # write and run a script that keep reading trace
    $./read_trace.sh

    ``` read_trace.sh
       while :
       do
           cat /sys/kernel/tracing/trace > /dev/null
       done

    ```
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78502d4c7214..ed5ddc3a134b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -200,6 +200,8 @@ rb_event_length(struct ring_buffer_event *event)
 		if (rb_null_event(event))
 			/* undefined */
 			return -1;
+		if (((unsigned long)event & 0xfffUL) >= PAGE_SIZE - 4)
+			return -1;
 		return  event->array[0] + RB_EVNT_HDR_SIZE;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
@@ -209,6 +211,8 @@ rb_event_length(struct ring_buffer_event *event)
 		return RB_LEN_TIME_STAMP;
 
 	case RINGBUF_TYPE_DATA:
+		if ((((unsigned long)event & 0xfffUL) >= PAGE_SIZE - 4) && !event->type_len)
+			return -1;
 		return rb_event_data_length(event);
 	default:
 		WARN_ON_ONCE(1);
-- 
2.18.0

