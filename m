Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B480B75F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjLIXFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 18:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 18:05:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B3FA;
        Sat,  9 Dec 2023 15:05:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3332f1512e8so3078413f8f.2;
        Sat, 09 Dec 2023 15:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702163143; x=1702767943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duSDdrXx/MdhBGHNkwvfOFuexJ4Lp5LgT0yaxlsN+gg=;
        b=JhXYwaGK6U482bWvb6URGDZx/KhvdxV0JfECIRJ8hmr3QIPvYq/0ucK/O5o5Or8Iuh
         35Pn7u9naHdLvD8EHm4Dv47lp/mDFRUUlJ0oE/P6R8cmk2+fFKHukHp06PgiPLRx/VeZ
         2+UXB/5Q2jUYPTMH9gx0XmVBvP1Q5mWv17GUTv4GUqH9PsL4af7DW4DiYptBOe/bpHWn
         qSKlVXoo0uDcA1FUyfiJ30izNoUIkO6MVp9v+Y1X8dEy0IEzf0ImKSHZ1nVzZf1rPRe0
         KKQWMKOlEHk29ePV/s9iSNaDXzpvJhaFWH9JbV302Be1Ek4RwbdlOBinKRBAgynSdGsm
         l+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702163143; x=1702767943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duSDdrXx/MdhBGHNkwvfOFuexJ4Lp5LgT0yaxlsN+gg=;
        b=v1c2U90t8EIAAuE6nM+QfxkbUVGnORqW28sLEWla7OpFxDwVb04bCr87T6LWpd5S2c
         zrQCg2OJS44j91aylOqzwyywKixx7WX4nteedf4AEYRomUayNSVNKBAXOjISc04q3RML
         Vk7sutknEC1Or3LaTMH3DAjnO7BDDYgrre08uoPBf79/qEjvJbQ+4xFcudTlK/KvsQO0
         J7WRckNNUPHHlPk/C6jo3fYLX6CfZeOAWsImKKYt18tskWxV32QF+KxqAFQ01l110EXB
         rQs36rhLnE8eAXA61oC431QVwoBWMqUTR31PjPKIB0/zqC01cSe1+9Cls+Sc7yv/j4YN
         KuLA==
X-Gm-Message-State: AOJu0YxQ+atgSESbi+aN2XWHf73Fb3U4LOlUTaDjJUYsp3Jz73Kfq36R
        RdIwNa3EXYc7A1FL59CW9x4=
X-Google-Smtp-Source: AGHT+IH8a4E5LwfBo47ptLRB1AvoIqmDkcI8a0+kqSSKA8Oi9xC6xo+U9mqjIOpVPgmdOvHFGVKh7A==
X-Received: by 2002:a5d:5301:0:b0:333:2fd2:6f5b with SMTP id e1-20020a5d5301000000b003332fd26f5bmr969350wrv.101.1702163142765;
        Sat, 09 Dec 2023 15:05:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d608e000000b003333c2c313bsm5171210wrt.100.2023.12.09.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:05:42 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/selftests: Fix spelling mistake "initialiased" -> "initialised"
Date:   Sat,  9 Dec 2023 23:05:41 +0000
Message-Id: <20231209230541.4055786-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index e57f9390076c..d684a70f2c04 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -504,7 +504,7 @@ static int igt_dmabuf_export_vmap(void *arg)
 	}
 
 	if (memchr_inv(ptr, 0, dmabuf->size)) {
-		pr_err("Exported object not initialiased to zero!\n");
+		pr_err("Exported object not initialised to zero!\n");
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.39.2

