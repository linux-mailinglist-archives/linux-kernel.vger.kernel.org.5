Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08117D92A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJ0IwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0IwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0561106
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1810672b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396739; x=1699001539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/jz+invX/2cwEvTPvTxl2fOwHAofZoD0Kt25dPPUM8=;
        b=mBU97PKHllQxHvpZPhS/I1vkKK0NCX7TXjlsneceNyZbUw964gCmZvDS/Qyn/4NnJH
         ll4N1UImuq6XZGSLzPpsBH0o8mADGM3pT+lumRJt4ocqVEqcsE/UNzn4YQXE97pTdSfA
         4buEhP2yAenfwtSAdWPgb6p7DMvJHJ1WUDQg3HKS5JpvgrUMQSqdOOm0Kf/1CkSF6a1N
         cp9OicVesAfJl8XOhDm1dWputsfPKGhLv3xFksAwwqOIMIS+Hw8qba2+g9DZs+0I1mJH
         p0tq6lZou7nNX6ANjwV+yx3lnfRTOY9Su7YTcnZm+hNzRoYAJtrCqTkbiQeZwyRD3aFn
         t+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396739; x=1699001539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/jz+invX/2cwEvTPvTxl2fOwHAofZoD0Kt25dPPUM8=;
        b=mxUcXI5W2EEvHDex0etyAsFo2rscH1MuzIweR8ppIWduJdTqKVqA5V2CiQ2TE/CAUx
         pycUgbGAFLUyunDg5d/Bf0e6jcFXvZojcC0bRgsg2Bsm05wX1Q7HO9RnKYrdwIhbXhKm
         Nv+FWy0PHzLuwWPThFbyKnjmYKMIunTtPRzT+84T45mU4FhpVXexnBxW3hFa/1jdVC/a
         NwI+ujwWA9FiHZn8U1sFjDHGtou98ettsklBinuLIHFnusFKqqbBJVBXHE7EeTbxzn72
         21Ld/7HTYAVh84HHGcRECBYwRyEdmHiPz/9BBd7bHQUafaOy6XgxDeUoZmv1Uf9kGrhu
         x95w==
X-Gm-Message-State: AOJu0YwljBoJrkNwWO3/XHSL10okAfF41TzpaGWXcJNNYXaHVh5xjX2W
        KxrPP9mKsSMGIkaMb12GqUc=
X-Google-Smtp-Source: AGHT+IEUIIFk1saxMUL/R7S1hyUsR3PQibo1z6oRrjkNpS3JHza4O/ki+fD8Atx8LtbXq1uNXRo5Aw==
X-Received: by 2002:a05:6a21:9998:b0:17b:8404:96df with SMTP id ve24-20020a056a21999800b0017b840496dfmr2313207pzb.41.1698396739315;
        Fri, 27 Oct 2023 01:52:19 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:18 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 01/10] staging: vt6655: Type encoding info dropped from array name "cwRXBCNTSFOff"
Date:   Fri, 27 Oct 2023 14:21:50 +0530
Message-Id: <b66d2cfebc199c20ff05143185400b6afd351f5a.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698396278.git.opensource206@gmail.com>
References: <cover.1698396278.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array name "cwRXBCNTSFOff" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 079fd01c6780..aa1017d7399c 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -50,7 +50,7 @@
 
 /*---------------------  Static Variables  --------------------------*/
 
-static const unsigned short cwRXBCNTSFOff[MAX_RATE] = {
+static const unsigned short rx_bcn_tsf_off[MAX_RATE] = {
 	17, 17, 17, 17, 34, 23, 17, 11, 8, 5, 4, 3};
 
 /*---------------------  Static Functions  --------------------------*/
@@ -712,7 +712,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
 {
 	unsigned short wRxBcnTSFOffst;
 
-	wRxBcnTSFOffst = cwRXBCNTSFOff[byRxRate % MAX_RATE];
+	wRxBcnTSFOffst = rx_bcn_tsf_off[byRxRate % MAX_RATE];
 
 	qwTSF2 += (u64)wRxBcnTSFOffst;
 
-- 
2.34.1

