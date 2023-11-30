Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784A77FF7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjK3RPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjK3RPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:15:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEFD10D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:15:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05350C433C7;
        Thu, 30 Nov 2023 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364543;
        bh=Wlvb5OMI7zyV+dQmp5l6lvvjWwarL8CBxj+Vgr0bH8M=;
        h=Date:From:To:Cc:Subject:From;
        b=Lo6bVce15XkFyAiquk70qtjY0WYh0fju1bW8hYywGGnMS+7UVb8Da8E8/tsDMj02z
         hF2ry2uRWYp8FiwoEVyydaLNnluq/nBIys/rl9Be8Nja4TxTFGHHpqgQe5hVWiiikI
         g4ZNbgp2S31BvrAfe79BdzwCSIRn0kjQ0dLPMrlverQtQ0YpgtJPYpSTBxK/aRgIm2
         e8O5XY5iTzgG3HvMlJrUmHLUG9noqPYfF3tAlNn5CtMp51oRoUXpvntzn9FC4rBGal
         2MIGoAoef9t3S0qGGld90VHrmS17bRH4tDmQ9d28TFdOa0Kp1T7do+kgwVbiL/8khe
         bID4J9fJsDz6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C63E40094; Thu, 30 Nov 2023 14:15:40 -0300 (-03)
Date:   Thu, 30 Nov 2023 14:15:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] libapi: Add missing linux/types.h header to get the
 __u64 type on io.h
Message-ID: <ZWjDPL+IzPPsuC3X@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are functions using __u64, so we need to have the linux/types.h
header otherwise we'll break when its not included before api/io.h.

Fixes: e95770af4c4a280f ("tools api: Add a lightweight buffered reading api")
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index a77b74c5fb655a8c..2a7fe9758813172d 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/types.h>
 
 struct io {
 	/* File descriptor being read/ */
-- 
2.41.0

