Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B47800B51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbjLAM4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLAM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:56:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0B10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:56:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00a9c6f283so295647266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1701435403; x=1702040203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM3txpR7KJT3aJLknAwcYyGwwkt0hTNGCSJEHZF76+c=;
        b=dwm77DbY05vUESPpsO+GLsOcz3tWtZGm+Z6tydNvmu7KkBI5Qnq24MnUa0iBnVty5H
         HQv2jbbICt28S4AkGc8n5Yo+NN9qNs0nN1lBGr/G4YeSwJwQbespYfuGDmSrRzedVHI7
         45uNlbJpvXRdrWyoDw0xyYyLxlRB+pdqhHBVixZ9rzsNoiIX1Dq/tNme98BlEkb0acda
         Zk1U71zj2UUhCEqa9mpvg94E0zGlrqb+Ao8Q/ip0bRf6CuvIlBJnygPJ+Xq7U8cP8IN5
         VKYmAZQIOtPC6mNWaXHRgY13E38DGbRN3VkZbkLqE2A+YVlmGulnjwse5Ec9y6fcQKsm
         UYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435403; x=1702040203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM3txpR7KJT3aJLknAwcYyGwwkt0hTNGCSJEHZF76+c=;
        b=W9AUc34yBhFKpwoQYkoG/guxy6NNPL1bEawqhSJNX2OPG9/sWeN7taFiFKvvjDeylh
         SbiWxThvISEfRxbwF6qm6HHDNWpsRodlI52X49N5hi0N/R6B++u0/Jucuy0yEyhC2Siz
         2ISmRLu6MWW5/3n+b6N1DlDe5lQXcnTJsUo1KwOPzNSgG6an81RgAY89AFgUYxVaCv6k
         JlMogfvf02zJFbYY8C2M+jrZPBZiivit5yiGg443veStVfcbTVtx4/EiibPiqV+Y4wIA
         evXft7lQ9xUK27XJZ9DQt93+SEJwW6mdefdwznkBNnYZpeasTqjoBh28x/ulLhNKtUo8
         lUmA==
X-Gm-Message-State: AOJu0Ywp37Aya7cbdBQprRBJX1vFD8OBsK/D49EsRirm1TDFgaoGR0CF
        rOezqcjkkpKJiyVFNvs6F0lzNg==
X-Google-Smtp-Source: AGHT+IHp8Nv4OXPtvFgF6XpWvvRxj9c2EaQ1SrhCB00kpjwuFfVPKkcfIqVfgPCkzqkIRsPhVs+yKQ==
X-Received: by 2002:a17:906:718b:b0:9fe:81a:c258 with SMTP id h11-20020a170906718b00b009fe081ac258mr1704769ejk.26.1701435402759;
        Fri, 01 Dec 2023 04:56:42 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f0b6500529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0b:6500:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906a00a00b00a0be4fec1b4sm1870231ejy.138.2023.12.01.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:56:42 -0800 (PST)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/kernfs/dir: obey S_ISGID
Date:   Fri,  1 Dec 2023 13:56:38 +0100
Message-Id: <20231201125638.1699026-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201125638.1699026-1-max.kellermann@ionos.com>
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of S_ISGID is usually done by inode_init_owner() in all other
filesystems, but kernfs doesn't use that function.  In kernfs, struct
kernfs_node is the primary data structure, and struct inode is only
created from it on demand.  Therefore, inode_init_owner() can't be
used and we need to imitate its behavior.

S_ISGID support is useful for the cgroup filesystem; it allows
subtrees managed by an unprivileged process to retain a certain owner
gid, which then enables sharing access to the subtree with another
unprivileged process.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/kernfs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..7580cc340d28 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -676,6 +676,17 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
-- 
2.39.2

