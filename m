Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675C476713D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjG1P4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjG1Pzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B138421B;
        Fri, 28 Jul 2023 08:55:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9922d6f003cso328691566b.0;
        Fri, 28 Jul 2023 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559720; x=1691164520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPHbKlNohEyT6fHekCE2tm7ibKK+fjaWchkmGqjYMrs=;
        b=nRseK7z65pCewXQfBxUb9pU4jiS+a1bz8h14DsuF3KLRf9Kq8QFUEnBH8kLrdtQmSQ
         2jWf39AwJjxUQQ6SMKQo8HICYrdEtgMpR8OQdAigEOgsFtSlxYAyjbm6IViTbFiY7siS
         jtGjVgBc14MwEl9imJxJQtov1PUzh8jT/Dup52LUK9io/dXU+1JkoRVdD+PBhPtD+EwP
         4iK8oa4xn6aHMGsbWr4edP8dbLoq+hkCEB/WErSf8laR0GxSgTJamVXnKDe+cPLd0Kh3
         ONfZ8vs4DBdTQbIyp+hT5lCHJ2gta2Zs0+prif/VbtH2EWGirCEDBh8VtBCihY88gbFC
         JzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559720; x=1691164520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPHbKlNohEyT6fHekCE2tm7ibKK+fjaWchkmGqjYMrs=;
        b=Vo0qCHp+04t2vJ8QfUu9QxwWk32rZ9Wfx0uzVuCT52OflK/mv/hAmZbFW1hW/vcD/d
         1sHWpl2po7biyInWV0xebFSYIsHBi6d+nKKvbKC06LtV1gy4xL/GL+8YpMU4ZeBGzVut
         3yfU/PoqA5VMqPvJrY9QunJ8bao7C7HLp3YQEOzALDZwagrB9HlCsTX4qh9W68JMV2fu
         /NrfynJCmA+/0xkwqPYmXZukEKS5mfEe414PIN/G/TMN8SDaOCq1hEF31p8HlqxyNzgu
         ZlG7ZC7V4Q/iufnHE5xDAgdcFYg14U0IW7VyU3SiHU5oF4XnL+YKAGdbYHlPzPwiv2Hr
         rNaQ==
X-Gm-Message-State: ABy/qLb22miU8LVtdIEf6J7fIRkhvU4R7NY+HSxpC6VYg8mKOStwk8fP
        b2pFVzJzZS2DDFRv9pfODZ1VODai8i005v9j
X-Google-Smtp-Source: APBJJlGe+A0oWKQVcwl9usSCqVsNHg79O6cAF7pjMMrsUc/ACIUT6KvXtk7Mzq4GWcS1Q5m24zSzLw==
X-Received: by 2002:a17:906:31db:b0:993:d88e:41ed with SMTP id f27-20020a17090631db00b00993d88e41edmr2757566ejf.3.1690559720100;
        Fri, 28 Jul 2023 08:55:20 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] selinux: avoid implicit conversion in nlmsgtab code
Date:   Fri, 28 Jul 2023 17:54:59 +0200
Message-Id: <20230728155501.39632-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an unsigned type as loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/nlmsgtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2ee7b4ed43ef..2f8fab949633 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -153,7 +153,8 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
 
 static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, size_t tabsize)
 {
-	int i, err = -EINVAL;
+	u32 i;
+	int err = -EINVAL;
 
 	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
 		if (nlmsg_type == tab[i].nlmsg_type) {
-- 
2.40.1

