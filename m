Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807A7EABF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjKNIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjKNIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DCD63;
        Tue, 14 Nov 2023 00:46:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c34e87b571so4448722b3a.3;
        Tue, 14 Nov 2023 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951560; x=1700556360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OonMHeI+fmAL+SrfrNy+FjwHGIExPKOm7s2HbIBrKs=;
        b=Vmy3PRzIwy9D1KpvmXPnqxxPHBP3RQPmqHVwShkW9FxluvJGKlx+M+z09eSBi7nC0G
         TDx6jR+SkHxjVawrKM+2CdnL3rqKEpaLP0eCOXNMospYt8ifCLAo/OEFI9s1IvXUBYLL
         WpjFqHzAUAC1xsw96fUUDfD2XEga75Gi4iyKYVXU8moZfgthpcnJzWZhRiPQh6+mOHA6
         L+Rm8ET7ARacmTjIXXSB89kAuaEWhWrm27rUdAl0fksjvsiq5Rnq6NmgZ/EurBHlS66X
         wiQznxEBq1NNZqTZSSqqHC94Umdl7L5Wyxke1r4IofPBz+nouA3oxwhyBO0iT8PxIB6u
         Xm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951560; x=1700556360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OonMHeI+fmAL+SrfrNy+FjwHGIExPKOm7s2HbIBrKs=;
        b=TBgXMYArTFoaPcxYh3IPLWQfRzyhjgVyZrcUHRrhbJGzF99FB99EdMwCbZ5ILql7W5
         TB8Pw+4pphipkHfVKWtUqbFxmbF/BAskQc7x3l7klXlvXEPbws4mDFTj/8x6vAgs5wH2
         U9ORJ1aV+hpE88ejXxfk/LJsHzdYDViwiETQdji+BXd65whbR2ANi+E3rm0l+XIN02gC
         AxWUOoLXswmwXZd+w2qZo3PRUa8Ima7wch0Mv+JHkS19hGyNnJ/rXP2G27ysPLwQ5a8w
         7/EKSkgA7Uc5wJ2bzGIOenInwFx2mju5n0bjYSBdR7wpm0An7pliD2NweWzC4T7kCGAT
         iWAg==
X-Gm-Message-State: AOJu0YyhFI0o5WS/TSOYFOQbfzvK8+gL+QNdPedr0zQEWv81t+WwG9st
        afNc0uax9y0p7FcJboZh+o+WrRbZCBo=
X-Google-Smtp-Source: AGHT+IFAGIFuRdPqdq+CxEO0+ss9bCRhvkOQNokqpUyu1pFAtz15mtmc75fcxU6hdDGH/yQ3P76XYA==
X-Received: by 2002:a62:b403:0:b0:6bc:b13c:35d5 with SMTP id h3-20020a62b403000000b006bcb13c35d5mr6461057pfn.13.1699951560636;
        Tue, 14 Nov 2023 00:46:00 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:00 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] nilfs2: Convert nilfs_btnode_create_block to use a folio
Date:   Tue, 14 Nov 2023 17:44:31 +0900
Message-Id: <20231114084436.2755-16-konishi.ryusuke@gmail.com>
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

Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5710833ac1cc..691a50410ea9 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -64,8 +64,8 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
 
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	return bh;
 }
 
-- 
2.34.1

