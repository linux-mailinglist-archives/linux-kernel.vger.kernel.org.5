Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C37FFCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjK3Uk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjK3Uk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:40:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D41703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:41:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2856254bd74so1240982a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701376863; x=1701981663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HToncW+LE9zv/92mmvcSPtZdBZoVOlwPwlFSkGOjsOE=;
        b=KqArQt8j49LztbJuDs5bQg1WD9YUnXMeVk0KOYid8RZIg6X6p4jcsEchBBTG3QAesG
         z9y4vA9ABXoM+z9dKcvvUanSKAmaYBffW6Draer049LSacHsXbv/fPim+AeoAaiFYMYI
         XSd44EzQlb1ImNNqD+MLm0i78ErsbWDZiSL+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376863; x=1701981663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HToncW+LE9zv/92mmvcSPtZdBZoVOlwPwlFSkGOjsOE=;
        b=VgAksyJETVwbndOwNL2gum2xisfRkRSlvtMy1/u8CCHKtGhUIxNhaIHf2qKr5OI9HL
         TmBLwsebcA4XV51HVfEHK1AmntJVKHpk9+S790ZDGNJLXUoQDJmaCn+PFaBaVOBvaMUF
         jlbQ0U4haxqhchmIXWe3TRX5upml7h2Q6VyM+yyMY6kZGp5b5t+fFSktKzNdrbmxzETY
         bMlFRmimSORcm5Yctnottd8J8FZwql+1tZbACtBIzXV9LhxnYbdU3DARPfRcZb9ZR8vk
         nFzprpNwN1io8GAPdtupEIeIHxuPUnJF+BPwJsdm94qHh640csEiqrPgJFejmJLOwnkv
         ZbNw==
X-Gm-Message-State: AOJu0YxlhQjnf0sPzcI46XZ1Bd9Bl5e9lm9MQIe6nbb84C57xy2vCa9a
        jtpXNNyE+YxZHwkM33M/av6qxg==
X-Google-Smtp-Source: AGHT+IHT8r+vIHM19r9/cmghSmd07BQmXDud2a0ZuvaCvL7MyTKzM4U/BnENyZhul9YQdIGyG7UUiA==
X-Received: by 2002:a17:90a:357:b0:280:11e2:12d6 with SMTP id 23-20020a17090a035700b0028011e212d6mr23564604pjf.45.1701376862994;
        Thu, 30 Nov 2023 12:41:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090ad70100b002802d9d4e96sm3643102pju.54.2023.11.30.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:41:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] scsi: zfcp: Replace strlcpy() with strscpy()
Date:   Thu, 30 Nov 2023 12:41:00 -0800
Message-Id: <20231130204056.it.978-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4T81lpDgaAOBeJi0R1mIeRgW4gBp3WUx30Gv6j9ztlg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPNc3DGEDg6n6R2jxBMkNqrOja1osTULCasaX
 UZxQBioA02JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjzXAAKCRCJcvTf3G3A
 Jt5HD/9yXU4FXoT7iWh3EJhfuA3Y8HjktI8X29ZdPW0aN9g75IBIIy3FgqByl/7RW4rsCf5IHqJ
 1aRTj37ijdQRxNQujB1di6Z5d4ENubNma2Mxr5wzCo8z/hpZT2jIPljlx3QkPgzrXLDYh2wMkqQ
 g69yTCJNXDdqug8Fva4Kd43e0vKoS/hYP7ZwpD5KLe8TjFTpvsO5mtx/6BmfOPjnT3hwE+j4yPt
 eaqmeLip+SqCsS2/8GAACN4LnGN80Nf5qBo2IxfcyqVb1GqVV7RJUUXH3O2XYzztawyWNwa9fbP
 lZ29Kv/CohmuVG0IJ16NnPQpampEdGS+3pruhhAN5bLYDDXoMKLyOKCzPvr+yi+KkvNQ8b2cnLy
 hHr55lbbbJzexMLk3qSUwrPXoZz3tXqJfKuU+QjiAbepT4atZ2iNNuJlpU+yEKy0joztLRe7siI
 AigbbIEwoO0HFTZ5XxhuSnjD3l0KUvs4a/MzQX6bPW/hlSDlgWgWPwASipbPWg4FsABC8skhV0d
 ytiReTa8uhR3GObcq6FbtR4lPUFRnrQAGEO5n+cFP7GQoCiDIXzCMbLC5llgbhie36UiI2pAyaD
 4FYFS6Gdgpz9+oTBiO9wC+OZczjqPLM6wDULZbIrqimHDLDi4wzoTfXXWj+IgukvhJRQYRIfY1A
 12tH4Xb UQs6sKKg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Overflow should be impossible here, but actually check for buffer sizes
being identical with BUILD_BUG_ON(), and include a run-time check as
well.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2:
 - add BUILD_BUG_ON (bblock)
 - CC SCSI maintainers (bblock)
 v1: https://lore.kernel.org/all/20231116191435.work.581-kees@kernel.org/
---
 drivers/s390/scsi/zfcp_fc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 4f0d0e55f0d4..d6516ab00437 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -900,8 +900,19 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
 	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
 			   FC_SYMBOLIC_NAME_SIZE);
 	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
-	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
-		      FC_SYMBOLIC_NAME_SIZE);
+
+	BUILD_BUG_ON(sizeof(rspn_req->name) !=
+			sizeof(fc_host_symbolic_name(shost)));
+	BUILD_BUG_ON(sizeof(rspn_req->name) !=
+			type_max(typeof(rspn_req->rspn.fr_name_len)) + 1);
+	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
+		      sizeof(rspn_req->name));
+	/*
+	 * It should be impossible for this to truncate (see BUILD_BUG_ON()
+	 * above), but be robust anyway.
+	 */
+	if (WARN_ON(len < 0))
+		len = sizeof(rspn_req->name) - 1;
 	rspn_req->rspn.fr_name_len = len;
 
 	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
-- 
2.34.1

