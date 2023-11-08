Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099697E5275
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjKHJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjKHJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:13:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EE9F;
        Wed,  8 Nov 2023 01:13:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso6721387b3a.3;
        Wed, 08 Nov 2023 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699434796; x=1700039596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCAzZOLM6VBb1qJenEGSAomGqBz67B3OQEi+85kaQbs=;
        b=OyDyunivj2M6jQFCUaR36ZbZiivNlnFhIi9qbUl6qQ8LOzeTsRX50xPUOJq2KQRbCt
         93mU5a+dozhTFgChgzL3IDNEnzYbDFnfvqn3TnmtwpMRD7zkqp3yai/UwRT9YVftGiLX
         GkJ6lSrz3FXpOgNaE2WTHZ5D7KvFu89AbmuwzcaK2VUtjdldS3WwNCbk0fwgiXkjvkSb
         F2hPXeAUgNOcpro/03JJmJ7q+N5zQBTjks5FZajpUSg4dzvYRqyPabyoDvGYMZIviYNl
         iB0FXlchmr3YSWATAgiq7nrXSdfyCZcepXRUYGeFIz6qvXoqrGnAq9Dw0qS9zRk6X62c
         Ieqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699434796; x=1700039596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCAzZOLM6VBb1qJenEGSAomGqBz67B3OQEi+85kaQbs=;
        b=g2zns5KbYkae2+UXarLh0LpM4u1of1FWo03aKBM5Gi6RJNYD7OftR4thsc76zXcNXp
         460fL3BRCI1BlzdAJtdyR2Zi0vZrTqWdwUy6A2nXNUkF0OwVdHca422dLEDRp8Dn/lUp
         a64hyLMLPIOdW0S8Tu4tCyhpf6NjWIfYlg1SmtArBO6Ujo/+yrBz6aWoegVta7eKIQtg
         EoULIKs+DvlNJFm+UIYCtjVS1b4BTTm9RTU0kBDWVa6InSFo/rYysTJIVBT/3YZad8aV
         0EQAFOGoclP98CNqQOMlF0CInzVMNuJ5pMf1I2bKaps1jHOcxwHQH6aRC7SgTLcVW/0d
         4nZQ==
X-Gm-Message-State: AOJu0YzcJBgEg1Fv+6h0VEBt1IPIqOQP7lDRBg7+ITCul5XY5UYCliBj
        RSEDqpcbEDMLI95q3mgF10Y=
X-Google-Smtp-Source: AGHT+IGInqo4mT5vj74fw06D+iMd3Gssloh/EHnAdRCq2VbbTbYQORHEWwtfKd4KpysQJpOnVziVSg==
X-Received: by 2002:a05:6a00:1881:b0:6be:9c0:7195 with SMTP id x1-20020a056a00188100b006be09c07195mr1233467pfh.20.1699434796137;
        Wed, 08 Nov 2023 01:13:16 -0800 (PST)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.134])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006be5e537b6csm8585967pfn.63.2023.11.08.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 01:13:15 -0800 (PST)
From:   Tuo Li <islituo@gmail.com>
To:     mchehab@kernel.org, yongsuyoo0215@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] media: dvb-core: Fix a possible null-pointer dereference due to data race in dvbdmx_write()
Date:   Wed,  8 Nov 2023 17:13:00 +0800
Message-Id: <20231108091300.3124649-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct field dmx_demux.frontend is often protected by the lock
dvb_demux.mutex when is accessed. Here is an example in
dvbdmx_connect_frontend():

  mutex_lock(&dvbdemux->mutex);

  demux->frontend = frontend;
  mutex_unlock(&dvbdemux->mutex);

However, the variable demux->frontend is accessed without holding the lock
dvbdemux->mutex in dvbdmx_write():

  if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))

In my opinion, this may be a harmful race, because if demux->fontend is set
to NULL right after the first condition is checked, a null-pointer
dereference can occur when accessing the field demux->frontend->source.

To fix this possible null-pointer dereference caused by data race, a lock
and unlock pair is added when accessing the variable demux->frontend.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/media/dvb-core/dvb_demux.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 7c4d86bfdd6c..791db667e2ed 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -1141,8 +1141,11 @@ static int dvbdmx_write(struct dmx_demux *demux, const char __user *buf, size_t
 	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 	void *p;
 
-	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))
+	mutex_lock(&dvbdemux->mutex);
+	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE)) {
+		mutex_unlock(&dvbdemux->mutex);
 		return -EINVAL;
+	}
 
 	p = memdup_user(buf, count);
 	if (IS_ERR(p))
-- 
2.34.1

