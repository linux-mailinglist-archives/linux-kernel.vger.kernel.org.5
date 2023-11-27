Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650DB7FA2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjK0Obs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjK0ObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151A1707;
        Mon, 27 Nov 2023 06:30:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ce627400f6so32881405ad.2;
        Mon, 27 Nov 2023 06:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095452; x=1701700252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCM3sUYAk/tlBLIzo2SaDQBBpHgsnzA0anQsHtnDawg=;
        b=ExiDDPRoA0/zQHstCPV5m9COgyMsE1YPuklgiFPgFWE6RT4+cOV8WmkswESSFX/Jce
         7loF4QvMA8TxX/hqbjkLzvhXwtTSgMTefammgk9nkEC2Ylbtfk6te6J7VkU1AM8MTFWN
         1TT4v/c2jtEgd3ZTA9AApwx3MQhm4nKyCRIbesLDGvYKJvmhPvV8GGMQx3+ly66WHhHs
         AivmTasjb/efSxd5PMdU0JdqQAbt9BdHC6RCAnUsgT7ONtoGGvL8W6X4Cn6oWlq36QIh
         bDSQm2nLZqJN0nB8B5ASWYYKA/j+OPEc7IhSil13V6W/x3TNGNvN8Klt82DMTEX5eHl7
         TbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095452; x=1701700252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCM3sUYAk/tlBLIzo2SaDQBBpHgsnzA0anQsHtnDawg=;
        b=TBY9/dwEE94xkf3atuZOjEVJIl583gIpXrDTOmSIgWvBytA5ZVRF5delUsQtHSkM61
         kQRkixZVv3K4JQQCkB3beGPCZz/CLnVbfpHJZQuXsjfuLnwgWYgXljCxeJHzU8eTHAPi
         EQ9DdyrjLeQ4xIID9P0GPwJAR3al+XwD+ewc/3cOSo7DDKgdmz9YM0pLslQTzYFDOe19
         oLEX1KS5wJkYhsvpE56B5ddY5FeCMKRvuzyNZM3lqcmtp3qdIBvF0JhNy7XsOo/zesgv
         Xhvl7Cn7aDU8y5TtwDbs2Pnd/gQOV0aha3nE65eZgpdFGnWJtpIVUs6JHieefwk8LsEH
         PFOA==
X-Gm-Message-State: AOJu0Yyy6fOllCkc91//ALWad7qGspfWPUO1iD59uxMzuUMA3Gk5ZBjK
        ZTrsWWJMGX+uuBOCI1+kOGNGYQW8Ryg=
X-Google-Smtp-Source: AGHT+IGqs2p9AUmWg40Aa1szxvE9St37rUQlPzhh9gXKXTySpFbUaY+bo4T4WR14yruHNtlzdD7hHw==
X-Received: by 2002:a17:902:a589:b0:1cf:e880:cb8f with SMTP id az9-20020a170902a58900b001cfe880cb8fmr487203plb.55.1701095451896;
        Mon, 27 Nov 2023 06:30:51 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:30:51 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] nilfs2: Remove page_address() from nilfs_set_link
Date:   Mon, 27 Nov 2023 23:30:22 +0900
Message-Id: <20231127143036.2425-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

In preparation for removing kmap from directory handling, use
offset_in_page() to calculate 'from'.  Matches ext2.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index b9f13bdf8fba..9c0513245a3b 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -410,7 +410,7 @@ ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
-	unsigned int from = (char *)de - (char *)page_address(page);
+	unsigned int from = offset_in_page(de);
 	unsigned int to = from + nilfs_rec_len_from_disk(de->rec_len);
 	struct address_space *mapping = page->mapping;
 	int err;
-- 
2.34.1

