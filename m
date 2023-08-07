Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA5772B05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjHGQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHGQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833B1BF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zFP8XpgqMd1ZR+xUc/aq9ardUQohRgS98TLoMxhZWU=;
        b=TeqlOsojErq9/NDkd08RY9jbBQjMqNPR5Pn5deCxhOey1/Py4LzlhxpxNCfcM+D28P02cV
        0nyZRO088WTxGfLutxWuFKTmqRv+S6zfsMpPFp4M2KlDa4Hfno8r0KXHNxmRXk1JH9ZTSq
        FAYRpkMsijNg0K5IkzbjkB2JmTzetOg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-uEE4ilScOiCtkkoRNJu-dw-1; Mon, 07 Aug 2023 12:33:03 -0400
X-MC-Unique: uEE4ilScOiCtkkoRNJu-dw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so135806866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425979; x=1692030779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zFP8XpgqMd1ZR+xUc/aq9ardUQohRgS98TLoMxhZWU=;
        b=RiNApnMHZJ1axvRbU21EQqs640ZFobXaBIo9f8ubRc2cfxt53lwz7PijrwWzD6rzOP
         sImFPjTpDdNMBnsPH0VMlXi4eTSuMiWNjB7Ky/WZBOw7nZsqutG5oS50KskztP9htoXY
         2NZQXsf8cgJTexarZlhdesbM8HNnY/HD2zPFkOT2suBM6bCNVwyihRRu+MCMdNu8Bddt
         +l27M+gidgpsYR239AqYHq/cpPWCRgPzmFDhJIQWF63UEEdxAFYlbo0OGYIRLJog0wRY
         /eaQgNLtJJ8EG3crAAfvGnpgLCpzKFW7Yjfesvf6+ZVLogobtM4K8ub4plqmuv3Y6C9C
         I71g==
X-Gm-Message-State: AOJu0YzHdao7obn9kstQGmIuvtcU/wKb+9Hk1ZYrPa/gYKolPVxscZPJ
        6i2sj+G6v0KYmeUxvq2JVzEbMyA83S+f+d+F6dcMlvBBDR3KRFNbIUnTuYh7rxxcuxurzQ/dAUT
        DPFMZeEuUmaiiPLD9coDgdUNs
X-Received: by 2002:a17:906:5dce:b0:99c:aa43:b20c with SMTP id p14-20020a1709065dce00b0099caa43b20cmr6276324ejv.33.1691425978964;
        Mon, 07 Aug 2023 09:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzwa0036YfN6zZ9wxNCsP6a+2soTFVv0lKi71JnNJfbR+fIxNYwVKxG8hEDVJBGDY4OrEouA==
X-Received: by 2002:a17:906:5dce:b0:99c:aa43:b20c with SMTP id p14-20020a1709065dce00b0099caa43b20cmr6276305ejv.33.1691425978678;
        Mon, 07 Aug 2023 09:32:58 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b00992b0745548sm5435523ejb.152.2023.08.07.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:32:58 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH drm-misc-next 4/5] drm/nouveau: uvmm: remove incorrect calls to mas_unlock()
Date:   Mon,  7 Aug 2023 18:32:25 +0200
Message-ID: <20230807163238.2091-5-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
References: <20230807163238.2091-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect calls to mas_unlock() in the unwind path of
__nouveau_uvma_region_insert(). The region maple tree uses an external
lock instead, namely the global uvmm lock.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2acbac73e57a..91b964ef98b1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -279,15 +279,11 @@ __nouveau_uvma_region_insert(struct nouveau_uvmm *uvmm,
 	u64 last = addr + range - 1;
 	MA_STATE(mas, &uvmm->region_mt, addr, addr);
 
-	if (unlikely(mas_walk(&mas))) {
-		mas_unlock(&mas);
+	if (unlikely(mas_walk(&mas)))
 		return -EEXIST;
-	}
 
-	if (unlikely(mas.last < last)) {
-		mas_unlock(&mas);
+	if (unlikely(mas.last < last))
 		return -EEXIST;
-	}
 
 	mas.index = addr;
 	mas.last = last;
-- 
2.41.0

