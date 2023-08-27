Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74A78A12D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjH0TeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjH0TeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:34:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E21C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bd0a0a675dso2046427a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693164836; x=1693769636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8owQxhS5E1ZOUbfMsVXpc+yZBo+YfqBQ9stCS1V4Rks=;
        b=bcmTitmpWn3IWkMlJ4Fk3NHl0O4WTAM+ApwKk04XiVShA81yMZQk+zbbI/7oEAcJTR
         0N7d2sq0R0LjK0D3TPVdjzxKKXSMuHiyFA8C5jCF5qOVilxdM9dVzzEnnjtliNEasizd
         q96fCR/f0aZOiPwUWrPZZ4q9AzqjIGJzsjDPM/+08JupvpcGJUVDx+UQp7dx0q8dv7Lf
         tWO87AEtJ1Z7ZKOKzO4cB4u2sjygfBx3TO+bPPHTKHmDdtPmwZhf8GI0c+ikBHO7mQa9
         WKPvtZ52j0AdmhqmiTzE0BN7TrP/eN1rpaaDB5TJzkOh+wyWU170kRgX/afaRUCFI7pc
         jRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693164836; x=1693769636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8owQxhS5E1ZOUbfMsVXpc+yZBo+YfqBQ9stCS1V4Rks=;
        b=iMv5JHk5i/rOjUwfzKmDe66hBvKDwooNtweL7G5W7s8n21S7NN4idm3Lx29hXSdQJu
         uEJglJz1e+PFojmPBbewkrodf7/qtZXW5NiJBo7TCgkdGrBm2hpKUTgh3Yef08bfamLl
         2jK2jGnjIQLSlztcx8bRxIY9GKPs39nS3CcQ5Mwi4rtF1YkAe7wYm8hWpgoLamupSYTQ
         +eKrRTBkCa2pj2M8jtqYf2IXKxQ7lvyAsLmXY9v3qeecmHymsNQI1Faw/RpzD2Ww4noH
         O2Fd4niZDduYuHIH5RLip0sx4SG8Le0DOVWels8YtMW2rkWkP/r8aHPZQcJIFXCexXJl
         aE2A==
X-Gm-Message-State: AOJu0YwQLWfjQPp2OYSBr71uDNBRx9IxoMQiV+X+//ibr9IDaaTI/ZQR
        R1+RxlsO1C++4Ay1nUM5d3U=
X-Google-Smtp-Source: AGHT+IGwitpPpk9uf84c8V9vFO9dcSj7DyQ9HBaAP1ghSUC0m5PPfvHgEdrc+6o1Ayo982i2Fi7h0A==
X-Received: by 2002:a9d:7f8e:0:b0:6b7:56f6:f846 with SMTP id t14-20020a9d7f8e000000b006b756f6f846mr12173664otp.5.1693164836484;
        Sun, 27 Aug 2023 12:33:56 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006b96384ba1csm1640272otk.77.2023.08.27.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 12:33:56 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH v4 3/4] staging: vme_user: fix check unnecessary blank lines in vme_fake.c
Date:   Sun, 27 Aug 2023 16:32:54 -0300
Message-ID: <dde6f13f92a7cb17e01aceaeabe790656078326e.1693164540.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693164540.git.alexondunkan@gmail.com>
References: <cover.1693164540.git.alexondunkan@gmail.com>
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

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

Changes in v3:
- Sent patch series in a single email thread, noted by Nam Cao

Changes in v4:
- Versioning the patch series with the forgotten information
about the changes in the previous versions, noted by Greg KH

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

