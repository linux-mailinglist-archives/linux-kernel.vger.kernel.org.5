Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29257E8DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKLAjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:39:15 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09FB2D5E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:39:11 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce31c4a653so1933339a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1699749550; x=1700354350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SMdZhVnZz0fqTFpbpWpMnfjrZwQQWUBQ+09KRZM6bk=;
        b=ND4G2PEVbqlRJ25gI11IFRVvGxJww1OY9oS90UtCWRpp/j5wsBzUdZDQfyvB5MCmPS
         DcWKXPCROIT4HYEz2jDA9yuRmcIDYmLzk7ldoOYT3voiFDMjRYOzGcTSGGVU7SIJncr3
         orJ5n0CrMjh9W8hQz38aUV6PZ4qJYR0bBLDTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699749550; x=1700354350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SMdZhVnZz0fqTFpbpWpMnfjrZwQQWUBQ+09KRZM6bk=;
        b=qV7o3+vT8244XMB6LKUj9TvXXlXq5uy1YDnMAo8b2Im6lwzF1EFCo+jbmCVlStwSim
         /tFM2sB/QqwlOzlqOMMAWqUHGM0NPvOQgv4s7V899oyOzCmnF+naCyBqzTDDgWCjRZ7m
         Mai2epGwJpXl7eLy0gjk2PjlDi8KUfY65KZ8fzm8klABgtcX6ddw2X86BCcLit/AD8tc
         3xpGMDK5oG70HookVqFjzyLgMeFa4IeNbz+AODkI8P/2oxRvyKRqpCFh8a4aZEi7IQjC
         SaBqgfoAyskclZILG4FOzLmn5WD0MG2c5MpczjXqROw5ijxMVhA9Mz5osheltnrfrvqR
         AB0Q==
X-Gm-Message-State: AOJu0Yx+V9v2M5NU2j6fLYdwdDy8nZdQDQVCMGmw4UalQD4GQEYpW3n8
        YgwzUYDNObIqyTEDLOEo5WX8ew==
X-Google-Smtp-Source: AGHT+IGND5EiY5rsM60+M9msCw+cxltmVHYmIfuK7Si2A9gvKX0asaZh1RIgrJ2nVqXvCxZ2VAtkHA==
X-Received: by 2002:a05:6830:3499:b0:6d6:4c25:5a56 with SMTP id c25-20020a056830349900b006d64c255a56mr4958073otu.12.1699749550442;
        Sat, 11 Nov 2023 16:39:10 -0800 (PST)
Received: from nuc.. ([202.83.99.71])
        by smtp.gmail.com with ESMTPSA id w23-20020a170902a71700b001bc676df6a9sm1789682plq.132.2023.11.11.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 16:39:09 -0800 (PST)
From:   Daniel J Blueman <daniel@quora.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] bcachefs: Fix potential sleeping during mount
Date:   Sun, 12 Nov 2023 00:38:41 +0000
Message-Id: <20231112003841.20186-1-daniel@quora.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During mount, bcachefs mount option processing may sleep while allocating a string buffer.

Fix this by reference counting in order to take the atomic path.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 fs/bcachefs/disk_groups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index 1f334124055b..4d0cb0ccff32 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -555,6 +555,7 @@ void bch2_target_to_text(struct printbuf *out, struct bch_fs *c, unsigned v)
 	case TARGET_DEV: {
 		struct bch_dev *ca;
 
+		out->atomic++;
 		rcu_read_lock();
 		ca = t.dev < c->sb.nr_devices
 			? rcu_dereference(c->devs[t.dev])
@@ -570,6 +571,7 @@ void bch2_target_to_text(struct printbuf *out, struct bch_fs *c, unsigned v)
 		}
 
 		rcu_read_unlock();
+		out->atomic--;
 		break;
 	}
 	case TARGET_GROUP:
-- 
2.40.1

