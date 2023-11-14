Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687A7EABE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjKNIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjKNIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EB1A8;
        Tue, 14 Nov 2023 00:45:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso5507494b3a.3;
        Tue, 14 Nov 2023 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951540; x=1700556340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgKg2EOxZmZGIT91NGubi8L9VnRq79wrMG69PPwZDig=;
        b=LfuSs1/+ZMUH8Y68R6LMkE0FxVmSNB/C5HAwh15u5Ikx3J3neSpv/v1lOq+QmwRJQs
         zccIA/pjXoNVt9csPXNHFFVXMXwQ1k3W1zZbjWuxobPBxRy12u2/mndCDLutN32uist8
         YEYP0c18Cgv0SZwhUWoj9HEX+4Fruxj1pErGzf6upNdAsab9NJgek3Lquug19vyCZ1fc
         RMzqJ1qK8IJW0MbHxpAhcLeHAETeEGOyWz/mCwuB384nTQuN8lLiThbyFO1WG8t/MmWq
         ZaVWrOSn8ABPP69oxDF0nWaPezWt+Xr87/O53PZEsM+70tcDRLTWwos2wNhByf28q3HL
         GuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951540; x=1700556340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgKg2EOxZmZGIT91NGubi8L9VnRq79wrMG69PPwZDig=;
        b=pY8v8GF+C/cLrrIoIuhFPaIC4D8xlXa1ynMjqtuXFS/e95BgQWQTSvZhN0t3UBxv9r
         0zIofP2sPb7GoOeVDk4xUaRQcfnCHLhSSY2JBeXrvzXrYNZ/k2HnGaiNBDEo8TwPQg0T
         a86W8Jbb/h32XR/ekG+WfiFhdtaj1JySwpl8rhQSwT3TGHoCSmpWNLbwRE46ZjoKMPva
         0XrwgHOP0gT05ydH7J9/LZjYijCsqzajM+PWd9Ve+OErIx6t5qRXeDjox/ngHyiwfz21
         SOLuCoFhbGzj2+LVOy8gpgcRq696SH6IUMGFJcEQwDWx0Mk3JhPJzN48Y9x9Q1Oq/nCN
         RgoA==
X-Gm-Message-State: AOJu0Yy3M/wN338lka4GtsYUxgZX4tvv0f/TE1AoL/gTS7liKlqUaM4b
        BgZf9lPQzpstVGTm7gkAMcnN0ZMnn58=
X-Google-Smtp-Source: AGHT+IFlSHAg5p8+m1IEbiPV+w22XNJj7+Za2uPIalfCqWII/0kzQpnTmoluwT8AM37TRJc3f+wGow==
X-Received: by 2002:a05:6a00:1d8d:b0:6c4:e7a0:af29 with SMTP id z13-20020a056a001d8d00b006c4e7a0af29mr10589103pfw.19.1699951539723;
        Tue, 14 Nov 2023 00:45:39 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:39 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] nilfs2: Convert nilfs_forget_buffer to use a folio
Date:   Tue, 14 Nov 2023 17:44:20 +0900
Message-Id: <20231114084436.2755-5-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Save two hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 06b04758f289..3882acde1b3e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -73,7 +73,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *inode,
  */
 void nilfs_forget_buffer(struct buffer_head *bh)
 {
-	struct page *page = bh->b_page;
+	struct folio *folio = bh->b_folio;
 	const unsigned long clear_bits =
 		(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 		 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
@@ -81,12 +81,12 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
-	if (nilfs_page_buffers_clean(page))
-		__nilfs_clear_page_dirty(page);
+	if (nilfs_page_buffers_clean(&folio->page))
+		__nilfs_clear_page_dirty(&folio->page);
 
 	bh->b_blocknr = -1;
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
+	folio_clear_uptodate(folio);
+	folio_clear_mappedtodisk(folio);
 	unlock_buffer(bh);
 	brelse(bh);
 }
-- 
2.34.1

