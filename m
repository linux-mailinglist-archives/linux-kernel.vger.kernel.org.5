Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F5763854
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjGZOGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGZOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:06:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F61211F;
        Wed, 26 Jul 2023 07:06:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso68023645e9.3;
        Wed, 26 Jul 2023 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690380388; x=1690985188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9CExGnNyyTMqIBKgfK9jLWHHsLv2lLgzC/iVvVseu6I=;
        b=Ht2si9k7sgQ4FHp41Xh1A2JRiS/sAP7mdGhwnc82tNBq2KhiDxPAVt0aK1A2VTj/XL
         nKkWfon54v9QVETu+4fnEDvnhNnBXu0k5Gjhzmeykacz160OyXbdRQqNNrJCvs+d75cN
         RJSh8S/UYpiNUYzZn+/dx/NnjJVCLrviDsiyHYAzoIN+cIAGo1Svk3ZBw8tq1EZ6H+NQ
         S/SvRXJSWsOqTHMKEmeuOyYb2dRTNpYw3qN/MMDIB5QY/2i14OhKwTGiO2iM1F4KAUdk
         Cbo/9PRDySRvy2vGVOTd42gYrMA3Oig9enZ2Cdbtol9jr7U6zljhvbpXtiXY+B8Y5DWH
         h0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380388; x=1690985188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CExGnNyyTMqIBKgfK9jLWHHsLv2lLgzC/iVvVseu6I=;
        b=i+44yP5V1daNO/EVMinSQxlR8jc2B4fMaEcwAKMrMMqbGaQF8JmAvlSa+1CoQx+i2g
         GFTr91meuGkDzcOpYRwuGMmxoY6McwMjOnREQjM2sF1RBrYKcO8oj18R4EzHBUAJspAg
         6726qSgzxqEa3fnRUwcy4Fq8hs6Fo2zp1bszTig1tEI/ckkz8O7tPmCS/mhGH4/VeqTY
         4vd/25toPetGNo4NxrZ3+8jxEwvQj80Y02KPVRCW0tHSKEKnpwSu1Lz6y5EW+rbekvGK
         GlRtZWqyaFYjXeNPQTc2Can7e+6lGLSBM/ZWq7tiqcK3dA0K9307ITdm8YzILRNQFByA
         mqhw==
X-Gm-Message-State: ABy/qLbpZhH+bCRQWWk0jNEKoThnvu7MncTkr8+xt96YrqSsDEjDO7yJ
        Xls1F+LM5DmXJDaTy3j4hFg=
X-Google-Smtp-Source: APBJJlGdNjDudSlbDDSi8kE8qRRQF0XYpEHL6Oi54V8yNv6mrteRqEmoKAod05XfMB4/ihqfy+LAQQ==
X-Received: by 2002:a05:600c:20d3:b0:3fd:3006:410a with SMTP id y19-20020a05600c20d300b003fd3006410amr1444089wmm.25.1690380387879;
        Wed, 26 Jul 2023 07:06:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b0031432f1528csm20078420wru.45.2023.07.26.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:06:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] accel/qaic: remove redundant pointer pexec
Date:   Wed, 26 Jul 2023 15:06:26 +0100
Message-Id: <20230726140626.264952-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer pexec is being assigned a value however it is never read. The
assignment is redundant and can be removed. Replace sizeof(*pexec)
with sizeof the type and remove the declaration of pointer pexec.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: completely remove the declaration of pexec and replace sizeof(*pexec)
with size of the type.

---
 drivers/accel/qaic/qaic_data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index e9a1cb779b30..a90b64b325b4 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1292,7 +1292,6 @@ static void update_profiling_data(struct drm_file *file_priv,
 static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv,
 				   bool is_partial)
 {
-	struct qaic_partial_execute_entry *pexec;
 	struct qaic_execute *args = data;
 	struct qaic_execute_entry *exec;
 	struct dma_bridge_chan *dbc;
@@ -1312,7 +1311,7 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 
 	received_ts = ktime_get_ns();
 
-	size = is_partial ? sizeof(*pexec) : sizeof(*exec);
+	size = is_partial ? sizeof(struct qaic_partial_execute_entry) : sizeof(*exec);
 	n = (unsigned long)size * args->hdr.count;
 	if (args->hdr.count == 0 || n / args->hdr.count != size)
 		return -EINVAL;
@@ -1320,7 +1319,6 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	user_data = u64_to_user_ptr(args->data);
 
 	exec = kcalloc(args->hdr.count, size, GFP_KERNEL);
-	pexec = (struct qaic_partial_execute_entry *)exec;
 	if (!exec)
 		return -ENOMEM;
 
-- 
2.39.2

