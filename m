Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746E7C65E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbjJLGyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjJLGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:53:59 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FF90;
        Wed, 11 Oct 2023 23:53:54 -0700 (PDT)
X-UUID: 99509de8b79a4cb8ad74cde247527ffd-20231012
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0aeba0b9-c2d8-482c-8283-f04d116d4eb4,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:-32768,RULE:Release_Ham,
        ACTION:release,TS:-9
X-CID-INFO: VERSION:1.1.32,REQID:0aeba0b9-c2d8-482c-8283-f04d116d4eb4,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:-32768,RULE:Release_Ham,AC
        TION:release,TS:-9
X-CID-META: VersionHash:5f78ec9,CLOUDID:8187d7bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:66|24|17|19|43|102,TC:nil,Content:0,
        EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
        ,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 99509de8b79a4cb8ad74cde247527ffd-20231012
X-User: chentao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1206692678; Thu, 12 Oct 2023 14:53:40 +0800
From:   "Kunwu.Chan" <chentao@kylinos.cn>
To:     adrian.hunter@intel.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        chentao@kylinos.cn, irogers@google.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, kprateek.nayak@amd.com,
        kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        robert.richter@amd.com, seanjc@google.com
Subject: [PATCH v2] perf tools: Put the function return operation at the end of the function
Date:   Thu, 12 Oct 2023 14:53:28 +0800
Message-Id: <20231012065328.878601-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <54481503-67c6-40ec-a02a-31f4db4205f7@intel.com>
References: <54481503-67c6-40ec-a02a-31f4db4205f7@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error paths go to the Release events process, while under normal
circumstances, go directly to the out process.

Fixes: 4e1b9c679fcb ("perf tools: Refactor print_event_desc()")
Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
---
 tools/perf/util/header.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..c2f23381a9c6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1998,13 +1998,14 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 			id++;
 		}
 	}
-out:
-	free(buf);
-	return events;
+goto out;
 error:
 	free_event_desc(events);
 	events = NULL;
-	goto out;
+
+out:
+	free(buf);
+	return events;
 }
 
 static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,
-- 
2.25.1

Sorry, the wrong patch was sent. The correct patch should be v2 as follows.
