Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411F76F8DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHDEUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHDEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:20:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BE35BC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 21:20:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bba04b9df3so14549675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 21:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691122832; x=1691727632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad/FcpxuBxv4GmuGDEXaoeeXnYfsgrYDuuE2WEQNHRE=;
        b=bL66U/DOtQaMlkD6sBFqEgc+4rwJfGyOoZFfRpyIs7K6E/mitQbRMaUqRJEr2Ef5Op
         ML/bR6hvKP4gm14zEtE1WrWNRhxsBKAxGjfA8IKBOZumhPgbUbRLlNVv/aYNXU2fuJ8q
         QBLtL3zNtrjweO9gj3uC/wpUxzNyco3gUX2QId/ys1lerkeQeGxiq2jc1EZITpJvCLvb
         BUfy7idpXGubaBwOmGrnEu79oKBdPeEVIGLlctu8tOwBcXcryT6u1QV2LOfc53uT5FMn
         nsswK8kgGSdQhDaaYbVH27m5NCl9rARgp0NMVUKsT62Zknj8QSybJYdEDKIWTTW3LZkB
         yixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122832; x=1691727632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad/FcpxuBxv4GmuGDEXaoeeXnYfsgrYDuuE2WEQNHRE=;
        b=Cjc8efZUVWkYunD9yq5JKzCvkXoeKaMDFR5Jcfx1EDkFzggGYPoVDN97l5e/vu9jLe
         Rdr5RuKqwhJRBdwlpnyW/soFXZbTKLbNTu4cyiN46QKRTt/D5BMzWeTgtGHvwC9kHf0j
         pjAGtpJFHo4utwjEZoGKjBSGVBjI5O2IQs77iI+art9Kr4eNgNM1A84wsyv847END0eW
         vClxzzVxKCJBT2OO75nmIgJ3zNuufax8rBb3ax7CdLAqOzBKJVj+NBdXJPaCnHfmxezy
         Y1emaE0vKkaX0C4gOoX0jxN6UuEk/fVS/pyj4w1fjlz0EdnBkeRPVeVbta6fwXy8r6zz
         WZZA==
X-Gm-Message-State: AOJu0YxWNMeQ62D4DggyGsTxBTNQY//+chns+Eyq09YfBbwOSarqebW7
        OHnW7S6Pgh6hYWERPzFoElJTSkPa1AXFlw==
X-Google-Smtp-Source: AGHT+IFKYdeKLX/DB9LH66FpCPX82AzIXspBG7VI2BVAVdUvDRKyvsUkbmKiOOpQfAWyYH4sGXycsw==
X-Received: by 2002:a17:902:d34c:b0:1b6:c229:c350 with SMTP id l12-20020a170902d34c00b001b6c229c350mr698292plk.18.1691122832084;
        Thu, 03 Aug 2023 21:20:32 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:9428:7df2:aef6:7a3e])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b866472e8dsm636235plg.241.2023.08.03.21.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:20:31 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] ipc:msg: replace one-element array with flexible-array member
Date:   Thu,  3 Aug 2023 21:19:49 -0700
Message-Id: <20230804041949.5724-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
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

One-element arrays are obsolete, and flexible
array members have taken their place. So, in
struct compat_msgbuf, replace the one-element
array with a flexible-array member.

This fixes warnings such as:
./ipc/msg.c:981:6-11: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 ipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..ee6af4fe52bf 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -978,7 +978,7 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 
 struct compat_msgbuf {
 	compat_long_t mtype;
-	char mtext[1];
+	char mtext[];
 };
 
 long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
-- 
2.34.1

