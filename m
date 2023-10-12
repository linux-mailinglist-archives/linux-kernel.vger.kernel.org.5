Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECE7C6334
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJLDKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJLDKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:10:41 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426894;
        Wed, 11 Oct 2023 20:10:35 -0700 (PDT)
X-UUID: dc0421b70b7940d7926d50df32f29ce6-20231012
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9b9bbf93-d7da-4406-ae38-5608042cc064,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:9b9bbf93-d7da-4406-ae38-5608042cc064,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:d119d5bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:231012110834CN4UMJ2D,BulkQuantity:1,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dc0421b70b7940d7926d50df32f29ce6-20231012
X-User: chentao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1733807883; Thu, 12 Oct 2023 11:10:21 +0800
From:   "Kunwu.Chan" <chentao@kylinos.cn>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        seanjc@google.com, kprateek.nayak@amd.com, robert.richter@amd.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com, "Kunwu.Chan" <chentao@kylinos.cn>
Subject: [PATCH] perf tools: Put the function return operation at the end of the function
Date:   Thu, 12 Oct 2023 11:10:03 +0800
Message-Id: <20231012031003.842368-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function return operations should be performed after resource release.

Fixes: 4e1b9c679fcb ("perf tools: Refactor print_event_desc()")
Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
---
 tools/perf/util/header.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..5763f21844b1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1998,13 +1998,14 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 			id++;
 		}
 	}
-out:
-	free(buf);
-	return events;
+
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

