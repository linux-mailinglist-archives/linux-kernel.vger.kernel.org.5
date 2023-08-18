Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5A780F42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378172AbjHRPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378209AbjHRPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:34:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B292D59;
        Fri, 18 Aug 2023 08:34:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-997c4107d62so136952266b.0;
        Fri, 18 Aug 2023 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692372843; x=1692977643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bF4TgkbLm0fvbwnbGkYZU8P4NjgBdb0I7AE42Vz1VxE=;
        b=YM89jcpEG/wAcdZAu583E+8CcevhptfW93UQ74eV1QkAa6Iqln1binF7pJ+05ZO3Zu
         oV8OJzyEdUzEwEYl9wp56pHlQdAGaY494/vONT6nFp92Kj1skRTqqYfi6ngB9X/BCshQ
         KxPnx42/YMdwGKYAAD3XfNVqmBbefz38MK/v2sKLuHieUqbhPU6kFIV1M9jMiiS/Nl+I
         2aQ7W6/1wVDPzdmGqrHFLTuJhS7GeG3GzkPKp32HQ+aZArR37UHw8WwrIvfBPdG3v/sp
         DT93dfGdpc/8QUMwH/oU3H2FOu5A31hVz47O1StOXstcrMoZ2bMoxpfXnEwysbBN+lwm
         o5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372843; x=1692977643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bF4TgkbLm0fvbwnbGkYZU8P4NjgBdb0I7AE42Vz1VxE=;
        b=DEI5fo6gSBQl9HtNYcvXjfnJWVfIdWok1LtsiHSaLKDuIjuF6V5bgVGmH5CQPY1Rxc
         Ewnz/ZUtdKrA9hQlhBR6zu1M5bl+yCl/E1nIe+YAsDUgS5p8lFy8CYLKE95t3xsEw5sm
         giyNYjJ15etqJS5+aDebmEGKWNwv695xdG2C8kf9J1/mlFFGkjRZKDeHYIqlEtQ0RSeW
         xfh6ZQLa4DiOjlVcZRWN2OvPWyz/qPMNgNXEyCse3PeErzqzLh7YKj17T5gaYp24bxan
         fJiKpcpNClKoGZVX9qtY2VN+yGqkCD9XVdCrek5bscAl7t+dgXF5d/uJVSNprh9q0qgj
         0pDQ==
X-Gm-Message-State: AOJu0YzCKrNQleEIZt/ZmDe3/licXzgKaHBfeFrVfq6iaN3fWMEQyJfC
        rmZdbq91Q8E2urYtBaqM0ixXct5T81hDIw==
X-Google-Smtp-Source: AGHT+IGicpmCzG4jBwkYy0+7/tsg17Kebn63f9HkvNw3qynPSaJZGVjBWRakzh6PsexvBfBQd3p80g==
X-Received: by 2002:a17:907:75e6:b0:987:5761:2868 with SMTP id jz6-20020a17090775e600b0098757612868mr2184753ejc.11.1692372842475;
        Fri, 18 Aug 2023 08:34:02 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id kd16-20020a17090798d000b00992b7ff3993sm1299671ejc.126.2023.08.18.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:34:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: set next pointer before attaching to list
Date:   Fri, 18 Aug 2023 17:33:58 +0200
Message-Id: <20230818153358.179248-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the next pointer in filename_trans_read_helper() before attaching
the new node under construction to the list, otherwise garbage would be
dereferenced on subsequent failure during cleanup in the out goto label.

Fixes: 430059024389 ("selinux: implement new format of filename transitions")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 28bd75dc6f71..2d528f699a22 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2009,6 +2009,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 		if (!datum)
 			goto out;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2021,7 +2022,6 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 			goto out;
 
 		datum->otype = le32_to_cpu(buf[0]);
-		datum->next = NULL;
 
 		dst = &datum->next;
 	}
-- 
2.40.1

