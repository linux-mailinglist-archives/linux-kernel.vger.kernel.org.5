Return-Path: <linux-kernel+bounces-109278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A2988171A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420E9281EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A26E5F7;
	Wed, 20 Mar 2024 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oeqi0EEe"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27016AFA9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957899; cv=none; b=VsDaJteBYGh2Zw6xw6/nSWcl7bRMhot7F4Vexoo2MVPFvsYpnBwpO3IHpw1yZk2y348kdCRm+Vm9gdjfWhLuFQKECAbbj9tC+96Rk0u/xqmJI2w0EalnA6V10vzMjwJ1nqeL0sIW+1IMEgL8F92vAcej6pF2b4tK5Cc5ecrxsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957899; c=relaxed/simple;
	bh=chh7+4ighc5NuwdQQeGKX+BZyp9DPW+3AXLyBTIdbs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOHZH5c4kEYVHDVKABOSfjsrK4UlhcStlwFPN9Y/ZaPlesQz18fefwy/2a9JUVnImqI5CgQQWlrcetJoiAYDq7Og5SlFVT9BOvbwHr6O9JtPxU3wbR6N407MsBUMS755JZN632qwmtvyjfutWpYR74gf9jehvF3Ai36LyMeDie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oeqi0EEe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690e2d194f6so1278566d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957897; x=1711562697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30OLZu1BB8NMv+SdqAZeeZ3/L8O0lM0O1+2bSt3RnLI=;
        b=oeqi0EEeNXlwr7O9CdaXhGXvicEBFrLJ2qUd4l+yYVn60ZHnatgfEiiNzyaJ6scfLp
         iSQA4u/ojU7tiU/+Pc6glzUNEH5MZk88NlOlZETF7ePKJZsX373t96wNAgvMpLjK/hZV
         0byWrUiWwBukNX4lp1hmMlu5bX5dSkH94erSQV7pLSRz8akiizPJlqh5rfaxVKXSzwCC
         gNBWtcF69hK6A0IkwGszDa3MtHvgTVKdIFr2QJqdtjxP2A7GZboUcq2zN0cLyVzEfHvQ
         VibbzaJEPGsTcDikLQ9e2ucanAor/D37gujMb8inc0aFApCbHXHo0WeFiYPiIA1mId7j
         P1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957897; x=1711562697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30OLZu1BB8NMv+SdqAZeeZ3/L8O0lM0O1+2bSt3RnLI=;
        b=gEbrtNJDF9eLk3cg5ZMijwrusQhfFOgGgxhG5VaW3rbYRopnlSj4aiBAdQl6fkOr7i
         yRKREyOlAvaaPU2e/DAHQfjWNp9KHYM8paonxpQ5o++mgCtAOWDP8HMPJ1S1JLI2lbjn
         d7Uwi0TGrhIZ0N0LC5MYMbTnyS3RKq51wQfkczRR3wAJ0HA5y4h9XhGpdCH4WEALtZfC
         EZhLfGT8CuK0JVC2QWcGlmZ5QI5XUlIyf5bnej7MuPz5bB/g0alixsna+Ola/+uXjbQt
         ENPA6b2t3zjDeVXOaCetk5ORNg/ODv0UfgPMlpoUBqcvphsD5D00TwdMEiEKn7QCEkzZ
         ZCOw==
X-Forwarded-Encrypted: i=1; AJvYcCX+VLC33oejQ1ja5EYpzZQEGZJURTN7k1xd8jBzT4g44cIAK5EguQN6MQzx75+0qaksyPuNuW4VD3vOvrYPVCHXaw+VEGKctDTZNcDW
X-Gm-Message-State: AOJu0Yz7SdZjoHCvYak9zo7aKvI7c556ufCYtyt3SUV/4U43CHwiO2a1
	VWQWQWAZejTBIO67nqKw7slrwuHXiP7JPPZ0QZ6jDc2LolkojbNa50HCQuG2U8E=
X-Google-Smtp-Source: AGHT+IG5sxaRbIJ5O7l1kuKbDMw7LMa+PdnsbFz8dadgYPyg3jWsjDbKYtsMujG8RnvxMdWfiNyJxw==
X-Received: by 2002:a0c:f64f:0:b0:696:442c:a659 with SMTP id s15-20020a0cf64f000000b00696442ca659mr3116723qvm.52.1710957896840;
        Wed, 20 Mar 2024 11:04:56 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 15-20020a0562140dcf00b00690cbd296fesm8183030qvt.121.2024.03.20.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:56 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] mm: page_alloc: move free pages when converting block during isolation
Date: Wed, 20 Mar 2024 14:02:09 -0400
Message-ID: <20240320180429.678181-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When claiming a block during compaction isolation, move any remaining
free pages to the correct freelists as well, instead of stranding them
on the wrong list. Otherwise, this encourages incompatible page mixing
down the line, and thus long-term fragmentation.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4529893d9f04..a1376a6fe7e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2683,9 +2683,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt))
+			if (migratetype_is_mergeable(mt)) {
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
+				move_freepages_block(zone, page,
+						     MIGRATE_MOVABLE, NULL);
+			}
 		}
 	}
 
-- 
2.44.0


