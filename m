Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B979D137
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjILMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjILMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EDD9F;
        Tue, 12 Sep 2023 05:37:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5078650f8f.0;
        Tue, 12 Sep 2023 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522269; x=1695127069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEO6kgqgI5vn5yqCel7J3Crgbo274n/viTPMDLC7L+A=;
        b=UiZBd69W9ZPkGlw5DnU+JQTZZlJrRVdWTThVjGnV7Ux4arE6H6Ne47vkJGj3IkU3rg
         UXrSocBbNoJrdDh4vDDfxR/AK0oUrFIXUZVAy3IkRd5IVjocsGQQuXFMFoQxYUVreE0y
         NvCV2oC348kSVJQFLMazIaq3Ghcl6Bmx4YOL1781a4OxKjonJjqoXbSOl6H82vbzOupG
         rPsaGpIJx6JwT/s1KiuE8Yx5tZ7OjWHMGxPyw4aABWGHuODuGC8K4Z10FWGlYMnGBtFA
         xZKBSIJMWPqYEMmeqiviN+/+v60tsDKzuGplFFcj+P9ai9csgFMqUgwl+qrFkKAdFK3b
         ranw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522269; x=1695127069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEO6kgqgI5vn5yqCel7J3Crgbo274n/viTPMDLC7L+A=;
        b=R5R3jtGgJ35H6Dx71SCuOPNBGYXlmAqd4B7kIVaNR3Kqe5Ef9FkJaQfUelf+hhK3Sx
         tIJoGA1WXrV2J99ID7pZ3YieJqdLeQG/BEmdck0oR14xw6CnZDWq5uKyz7/6ODvh4gff
         eHuXz53/Vb8nTW8MOUM7NRmFzvnGfZ5AtLfDAvwz+8dYwQQO7U73nyKQ0juFlhmkxB7B
         9heZTU0AbMyOfXr+HY7LznvduEuLdIAETnJypYptgCBsVw0vfbyVlzHWnvV80hybM2p1
         tpYO9eNZF7fGCfHiK9Ck0uELTRqxlyFCQm3yU0Bjex1PBdZUCfxYilEz/Zz3H6bSP28H
         pnFw==
X-Gm-Message-State: AOJu0YzhB1/v32uYeL8Ym7TyvE8LA7jcH69PP/eDk+CXI+O/mQdPCKYF
        emWfD6RFBc1rdH1wSlloTsE=
X-Google-Smtp-Source: AGHT+IHl/OXcJHtvaj4TIUpM83JndSB4xGljGcu/Vx4JZhhUO+zqjuAd0nO/tlPxv53fDqnB/ETV8w==
X-Received: by 2002:adf:e491:0:b0:319:6997:942e with SMTP id i17-20020adfe491000000b003196997942emr10164158wrm.8.1694522269336;
        Tue, 12 Sep 2023 05:37:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcd07000000b00401c595fcc7sm16010129wmj.11.2023.09.12.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5][next] bcachefs: remove redundant initializations of variables start_offset and end_offset
Date:   Tue, 12 Sep 2023 13:37:42 +0100
Message-Id: <20230912123744.3929609-4-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables start_offset and end_offset are being initialized with
values that are never read, they being re-assigned later on. The
initializations are redundant and can be removed.

Cleans up clang-scan build warnings:
fs/bcachefs/fs-io.c:243:11: warning: Value stored to 'start_offset' during
its initialization is never read [deadcode.DeadStores]
fs/bcachefs/fs-io.c:244:11: warning: Value stored to 'end_offset' during
its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/fs-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index ceab12fb8a8f..c108335e0502 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -240,8 +240,8 @@ static int __bch2_truncate_folio(struct bch_inode_info *inode,
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct address_space *mapping = inode->v.i_mapping;
 	struct bch_folio *s;
-	unsigned start_offset = start & (PAGE_SIZE - 1);
-	unsigned end_offset = ((end - 1) & (PAGE_SIZE - 1)) + 1;
+	unsigned start_offset;
+	unsigned end_offset;
 	unsigned i;
 	struct folio *folio;
 	s64 i_sectors_delta = 0;
-- 
2.39.2

