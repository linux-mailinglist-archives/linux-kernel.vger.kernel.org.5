Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24787A1F72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjIONCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjIONCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:02:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0A1713;
        Fri, 15 Sep 2023 06:02:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A6C43140;
        Fri, 15 Sep 2023 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694782960;
        bh=PF90Mq9GKBKhxFzP0kY+WP/uPSlw1h/Ixf38Df80sAg=;
        h=From:To:Cc:Subject:Date:From;
        b=sdlLB7uZhOUd36nT6/0DPR3XafPHCIC5J5TscCYoPUoqqEkS3URooqj0j4t0eCyzG
         +F4MFAbxTjDq0J8nAF/TGGo+2Owbph+3iOCgAB8Y9s5qvQt5mMPXXT3P77bzDMf3D2
         J7cocD61SHPXFDhs0bZkoGyzpurKcSF3qjsId7Dz+Kte9ac3pQWNkAmJTWGTF8AoVc
         4zG0gNkKvXs2h0EGM5sp+bgz4sqTJU89jyJtGVJyvl2RBmSNVWNJK0E5NQJFWCE26D
         99Knb9BzeDoMl4fkq4aP80h5m4SlMz3ZsZ8OE71qT6zYyQhhhmfkr+IzXHB+hXy7lJ
         EWyOkktOt8vwA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/rtla: Do not stop user-space if a cpu is offline
Date:   Fri, 15 Sep 2023 15:02:32 +0200
Message-Id: <59cf2c882900ab7de91c6ee33b382ac7fa6b4ed0.1694781909.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no CPU list is passed, timerlat in user-space will dispatch
one thread per sysconf(_SC_NPROCESSORS_CONF). However, not all
CPU might be available, for instance, if HT is disabled.

Currently, rtla timerlat is stopping the session if an user-space
thread cannot set affinity to a CPU, or if a running user-space
thread is killed. However, this is too restrictive.

So, reduce the error to a debug message, and rtla timerlat run as
long as there is at least one user-space thread alive.

Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_u.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index 05e310696dd5..01dbf9a6b5a5 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -45,7 +45,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	retval = sched_setaffinity(gettid(), sizeof(set), &set);
 	if (retval == -1) {
-		err_msg("Error setting user thread affinity\n");
+		debug_msg("Error setting user thread affinity %d, is the CPU online?\n", cpu);
 		exit(1);
 	}
 
@@ -193,7 +193,9 @@ void *timerlat_u_dispatcher(void *data)
 					procs_count--;
 				}
 			}
-			break;
+
+			if (!procs_count)
+				break;
 		}
 
 		sleep(1);
-- 
2.38.1

