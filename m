Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99A280F490
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjLLR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:27:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E68E;
        Tue, 12 Dec 2023 09:27:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d06d42a58aso54601695ad.0;
        Tue, 12 Dec 2023 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402039; x=1703006839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVgafbUy1yoVoGBH+PlApmsusqaMuafzZh+z/PK2PwE=;
        b=FPtY/QHUUehnBEd8W7/PYOvYwbxs1AO/MWVKbZjALE5XbeLpTl1Zi+kdsnp+Z454WS
         NE1ld8+Vha8xulthfQ4Mq7KI/iNEn9GnFRgc3VaHO8GJpmlt20EyAsgrEwJeqmCASAG5
         sZEgxLswUt0hQ5iLq8z/BMPFGlGlR/g2JDqJ0Z4PdwWSPO3nJW4SOGlW7bQwW7tTKODU
         ehuP82rhIcCzJDDUL1HgH5ms0E6Neb678+IKAGl03W4lSYRAMj7s7dUb7hyQbeeO+jCj
         rS+CideBrZSdcpXKL+eCP916v0e+wYTW/n2914lKd3qyPGeV9hOTTjujqI7Gmk9KW3gE
         8Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402039; x=1703006839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVgafbUy1yoVoGBH+PlApmsusqaMuafzZh+z/PK2PwE=;
        b=KxXp64J5xPgGsT8Yytv2opBbld8hTVpPY36EvlYwTWXN56SEiMVR1BfKCH9UxwJigt
         01CqH/dn8GwBbqi4teEEPcZKSughhOdZXaURLfaq8Wbu2MTQbtMRxc99rT49ixo7djRO
         J5n9QpQmTZRMMsHpzsMUnz1i42S0LieXD0AszalSRBloCGcNdFn8YQ2nli2Gtnp7WxLD
         lTlNdhRbCldzfV6bwGTsjWD61YHQZEBO6q471w7n8JPcqcOv2QDqS57gDHDI4ALgI7v4
         YbgSvG3AaPvf3NwXpiHEAJVrm6M5jUUirnKClAOnFtNH1yRJKazk1k1Gp4gr+ccgAyOz
         YR/w==
X-Gm-Message-State: AOJu0YzI0sqhVSnuo3aZ+JCbV0TP98EE7KaJrQuz4RcTzroLJdiaj+EF
        8gfJa9UMN5LOldQPpKQ9k8cL0Y+3uG3YuOgo
X-Google-Smtp-Source: AGHT+IGPGjbUX+hHxAoRGLSoyjCh5c5hQrmYfnnNqkcEghF336vceXn7APzJBUI2pAvCWoMY34jYMg==
X-Received: by 2002:a17:902:ea0e:b0:1d0:cec3:4568 with SMTP id s14-20020a170902ea0e00b001d0cec34568mr7842357plg.54.1702402039260;
        Tue, 12 Dec 2023 09:27:19 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm8863170plg.145.2023.12.12.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:27:18 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Charles Han <hanchunchao@inspur.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 1/5] Documentation: RCU: Remove repeated word in comments
Date:   Tue, 12 Dec 2023 22:56:49 +0530
Message-Id: <20231212172653.11485-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212172343.GA11383@neeraj.linux>
References: <20231212172343.GA11383@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Han <hanchunchao@inspur.com>

Remove the repeated word "of" in comments.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 Documentation/RCU/torture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index b3b6dfa85248..49e7beea6ae1 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -185,7 +185,7 @@ argument.
 Not all changes require that all scenarios be run.  For example, a change
 to Tree SRCU might run only the SRCU-N and SRCU-P scenarios using the
 --configs argument to kvm.sh as follows:  "--configs 'SRCU-N SRCU-P'".
-Large systems can run multiple copies of of the full set of scenarios,
+Large systems can run multiple copies of the full set of scenarios,
 for example, a system with 448 hardware threads can run five instances
 of the full set concurrently.  To make this happen::
 
-- 
2.40.1

