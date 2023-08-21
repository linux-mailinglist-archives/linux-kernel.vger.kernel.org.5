Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDC783061
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHUSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjHUSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:58 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BE58EE1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76d873c6e8aso240609785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643070; x=1693247870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQIFQGhOFbBlf64eoEhx/6zam9QXvcRrDKvqgUYhMRM=;
        b=t+wh1mGsSpug9tSfvVbtQ0+ZT7w0zsIr5mQvD0qoxacPfoOB+g2smHBIaDUAnqGCFs
         nIfnUdLtFYhQBZzhdHCTMaFYxsrPCFH1JfaNCChGC9YbwVfc039vhqD/6cfA3MYQnjXH
         VnrReFpdUByuwNsccH6RNDOmypzGn9sVNUCpx57arQCc0x4tVqKXgIGYkDFV9KBaqjrQ
         pxv3g/whFqiiwVnugwxvXEqJIJv2e0lbpLu7n6wEiONmvwSrNdWgKg0k0M5tjjCMTiqP
         8klZP0Q9u44cm9eKrDYTJStOMjv0qClBRgbJJF2O0USOGCxQqFT+VQ3RhL0tCbvB0de1
         67lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643070; x=1693247870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQIFQGhOFbBlf64eoEhx/6zam9QXvcRrDKvqgUYhMRM=;
        b=HOKsugsnqNYHgfnv73uKdLGGRqKevon6PpGDhiUHxwZoLKk+SiGV0ou6gUiSC5bfx4
         VhkmCt4WdIGzp49J8+xeXDbbi8iWAf6F1mdd0gfl4Pp/yLbr6rCuO8GOrn26m3Wfzu7H
         Q7k/YkBxRl5xiK5+6puYAR9P94O2cTg97EqTJYn009DgVPrfDRTgRc0QwWRA/P8SFbKH
         qgUq11CM1dvZKYEbfhQyyb2h2BA3Ibhc4Ukt4KuMb7zn++T4mCREycTLMIgVVLDq5zKg
         kQyu3VUDG+4w9WCHPAg8tT34N1uV1+t2LvUNT7R2BJeL/s7Gw/XufC9bZkkOkF/TJPGI
         jLQw==
X-Gm-Message-State: AOJu0Yzs+QzPhc+uzkoFj87XFGjUHqWyp+1B9VPz+IFpH8l5q/MVHPtI
        1FLZFCybZ/DB3/cs6pLkisbWwkxtxN6B/55BIQUnWw==
X-Google-Smtp-Source: AGHT+IE91JFTBmOR/4UxoEL0MhPPZyAeK/R20HWilTQEJg9pfeBIBxkRJCzCQ4B/j3c4553iIqhoEg==
X-Received: by 2002:a05:620a:4407:b0:76c:c90d:2ef0 with SMTP id v7-20020a05620a440700b0076cc90d2ef0mr10398847qkp.32.1692643069805;
        Mon, 21 Aug 2023 11:37:49 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a130a00b00767c961eb47sm2648001qkj.43.2023.08.21.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:49 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] mm: page_alloc: fix move_freepages_block() range error
Date:   Mon, 21 Aug 2023 14:33:38 -0400
Message-ID: <20230821183733.106619-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821183733.106619-1-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a block is partially outside the zone of the cursor page, the
function cuts the range to the pivot page instead of the zone
start. This can leave large parts of the block behind, which
encourages incompatible page mixing down the line (ask for one type,
get another), and thus long-term fragmentation.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6a4004f07123..6fcda8e96f16 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1697,7 +1697,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
 
 	/* Do not cross zone boundaries */
 	if (!zone_spans_pfn(zone, start_pfn))
-		start_pfn = pfn;
+		start_pfn = zone->zone_start_pfn;
 	if (!zone_spans_pfn(zone, end_pfn))
 		return 0;
 
-- 
2.41.0

