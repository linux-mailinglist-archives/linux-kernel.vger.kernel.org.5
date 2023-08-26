Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDA789931
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjHZVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHZVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:07:42 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB2E50
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:40 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5633b7e5f90so1282991eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693084060; x=1693688860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OOg8+maoDUe9q7mOudOl/p44V4LSOgvZCREz8VZty8=;
        b=IonTgb9QkQqRKfraItYCeB897JjYJHlJowFFlaXyLOHThcHeevaluGOSb24nj2j/aI
         nllWloXEwhHSIKFXO1Kjam1TY4Kjh2xx/Om70Uw+cckcr1rYaZoU7AH+bzpE4YpsXPF0
         1o7szmlYtgD4DlYrJaznxyxMmjOeHzEMIkXaGNM+5vy1+DYbe09s3puCiKiMZ2l2M2U0
         dki6Z3FEB4zx8/P4n9yd4UAcafMkmytN+TXL2zon3P7I5xjHbJEXEOqIa4Z6ioDpQLDP
         kMTJ1+muMnEvz95RtM7C9jPiglUOjdG4LLhRnqB+wv4wDIHXqKyqMOWsSMb2pXY3cV5N
         UoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084060; x=1693688860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OOg8+maoDUe9q7mOudOl/p44V4LSOgvZCREz8VZty8=;
        b=FGZHgjFohqHZztWn0WyC0Ecasv7cLWICzkgBM+7gYMsRC5Q7JcbbfjIqGPInqFKpiV
         2Xj177T55RxpD063ogM2gnQJkt88fdHo++E2vJUevmSxZVadwI4WBZ9hpEYlMwQmTROM
         tg/QC9hYjYBV5tiHfwM5Cwa/ljJfMRcUZlySmIe22GGVmwoW4RJpmBf/0YEsWfnIyemB
         +a6Abcj5WwD7a4RATQPpSMOUKXc5YtWsYV8M+tE0PnsHVve5VCNB072VR0VEHauPIMMc
         KcK8KUajZuOTU/TXB/OqtABvUC5GckW8dCiRJBWW08i3HT0glg6MKc8bsgFyRd6Ql++x
         QlmQ==
X-Gm-Message-State: AOJu0YxC4MuA3tYtR547IeglleIIKsPNA14ZaSozcDmlQqFv+B+/jAIF
        FyNfQvEMazAI5rrAsQgGw0DjMsfnSG0=
X-Google-Smtp-Source: AGHT+IHcNDE4V9Ev+F8vIZR6rYrKZg8hjUpAjYOuvW78cQxwnOngTIEOKA3T1SLgzzpYEwazHVUydQ==
X-Received: by 2002:a05:6870:e0ca:b0:1b3:f010:87c2 with SMTP id a10-20020a056870e0ca00b001b3f01087c2mr7402646oab.30.1693084059835;
        Sat, 26 Aug 2023 14:07:39 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id w3-20020a0c8e43000000b0064f50e2c551sm1488377qvb.1.2023.08.26.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:07:39 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH 3/4] staging: vme_user: fix check unnecessary blank lines in vme_fake.c
Date:   Sat, 26 Aug 2023 18:05:17 -0300
Message-ID: <dde6f13f92a7cb17e01aceaeabe790656078326e.1693082101.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693082101.git.alexondunkan@gmail.com>
References: <cover.1693082101.git.alexondunkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Blank lines aren't necessary before a close brace '}'
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index dbaf050f88e5..4258ed6033e7 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -584,7 +584,6 @@ static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
 					aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
@@ -770,7 +769,6 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 				       aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
-- 
2.41.0

