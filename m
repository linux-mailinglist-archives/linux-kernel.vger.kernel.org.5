Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484B782AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjHUNsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjHUNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A194BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE1F63786
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F37C433C8;
        Mon, 21 Aug 2023 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625729;
        bh=gD518kNrvUu4+K4e0YMv450TTE2x5VU7KtXDuYQpHeM=;
        h=Date:From:To:Cc:Subject:From;
        b=S+TZr9eYhTTFyzbilTUMacxqROvfo/MEu/vGW8S+P5fAd3jqf8BjZJ7FAx1WxLDNE
         Pl7lWz5PglZ7kz4Mjn6mAGh+g/C8YCaFkgFlZayf/GOyQXxviT8wuTFu1G9ODdqfVT
         xpAK9aoiV0RwaLSIDf77G80F6dSiHeOf7/lpbSCDAiZPlj/RbJsxFhu1YpbWLc24ZP
         JspIGaSaDUVEdzyT510xGzDV+gTWxl+zgbnUYkmSEI7JIErZ72yd+ZAr52bICVAiuo
         b4K0MT08o1lNA2/3xnw0Guhoq/fRa03o5EoIMOPClBqPjyoY2ADr+6X5NWnU7C+p5v
         rRS/KPB1OHWSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC22140722; Mon, 21 Aug 2023 10:48:46 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:48:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf bpf augmented_raw_syscalls: Add an assert to make sure
 sizeof(augmented_arg->value) is a power of two.
Message-ID: <ZONrPo0NSqdbXiGx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to what was done in the previous cset for sizeof(saddr), we need
to make sure sizeof(augmented_arg->value) is a power of two to do bounds
checking using &=:

  augmented_len &= sizeof(augmented_arg->value) - 1;

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 43549b63b433d81e..90ce22f9c1a94004 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -160,6 +160,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 	 */
 	if (string_len > 0) {
 		augmented_len -= sizeof(augmented_arg->value) - string_len;
+		_Static_assert(is_power_of_2(sizeof(augmented_arg->value)), "sizeof(augmented_arg->value) needs to be a power of two");
 		augmented_len &= sizeof(augmented_arg->value) - 1;
 		augmented_arg->size = string_len;
 	} else {
-- 
2.37.1

