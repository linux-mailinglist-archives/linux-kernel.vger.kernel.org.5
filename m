Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54AE7AB8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjIVR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjIVRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:55:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D0358B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so692061b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405249; x=1696010049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lczi2Cwwgxsbc7BUm+vtmTYjmzCLrPy7IPWzoMjHXsA=;
        b=ebwM2fkOJ304R9q9EGa55WcVxfSQTdUIX6iCSAosIHS85pHHsATJxyEh2pDuEeJJEX
         qBaLRDvvmBtg0TUcJKpnseApLY1tyXPlZQi0hPWDPPv+lJR09rTx8b0tbQInEhKI5cPj
         kWdAtU83TPjXEcpQV0iBtb6w8uVMWZuE59LIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405249; x=1696010049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lczi2Cwwgxsbc7BUm+vtmTYjmzCLrPy7IPWzoMjHXsA=;
        b=mj8+nB5Xgxvb2//u572DL2JHAS8Tujr/N5p0qc42tBXyICmns/ceiZnKaZTm4RPpx3
         svHTEFQmmBJmosM/6hICo1PRh5qkEDsWPW1334tr38Qd2DhgK/4q2FkDCVXCnm2mMAQY
         ZVU2YDpE3uq4SQO2VTliGm8fMxHl59A7135C1Cawo0Kdg02bhcEN8lbKyEdBKMY/YRbR
         BBT7SMa0EhGZpd1A3gn6Gar0esRjSxWk0OdHsK+8tt01N3U1RF9jeIemzyighlTKryYD
         59TbZKThytbJh0rdwWFB87X+wK1olpZzPKZq68RZNV5w9WPtr+UeOYEHlGabCIx7xvzY
         Crmw==
X-Gm-Message-State: AOJu0YyYNVtMarHpy2xwUwLx5BFYRBs2ooUoL83EPFPLVD0LyLekmdWQ
        Dzk6zAvPVUoQ3iy7kGcMvN/DTA==
X-Google-Smtp-Source: AGHT+IHPOEfvzSqeKngrjgykEm0H7WgS4W6X29Dhf7MjjHQix/ksWTKhxaphtv4vvK0qiX09/owMvQ==
X-Received: by 2002:a05:6a20:1451:b0:154:a1e4:b676 with SMTP id a17-20020a056a20145100b00154a1e4b676mr388927pzi.4.1695405249724;
        Fri, 22 Sep 2023 10:54:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a170903234700b001b86dd825e7sm3790470plh.108.2023.09.22.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Siddh Raman Pant <code@siddh.me>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qian Cai <cai@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] watch_queue: Annotate struct watch_filter with __counted_by
Date:   Fri, 22 Sep 2023 10:54:08 -0700
Message-Id: <20230922175407.work.754-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=keescook@chromium.org;
 h=from:subject:message-id; bh=PSX5a1GORIau6HOLEFzIyGta203teU7R+OIUQRXG3Fk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTAOP5KZ2dBsFnuwjohj6M1/RzR+kLr/9Sv4
 5Rswa1TpGqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UwAAKCRCJcvTf3G3A
 JpjmD/9Vb3G83w+T0Wm/a0TVUDR575aerkGd7NneXzI+vKqZgtBAYZPk4naeGlBK2uKaFHbFdNr
 SlqoyxinV0iOg0ptX+Gf5W0eUVcJqHwqh4U+/pI7awSyRoAD2ABO0dsfxVpZSAeuCGfVrjct9Gd
 oQ+ndS4eDOmS6ZxpR6h+Z2l3h9MOOkGxqkx8DKV5GXifL5ZKYk1RQx+Uf4TwSgxqAd3ZHr7UGPu
 adWMmlITuMSzYPZx2CjFXaTX7UFjgYcJcQapVcH2Ah9eaXyE0lC/0AP49hCh8s366nf9wv56ebv
 v2SJEjmzwpCIZc2Wu9YW0m/rnd4jaw+loDzAVlwtAPAB527kuAdKZU27cvyJtH/JNyqid8TeJ4H
 wrgLm6ee9sA1pRh24Os8dwG318HMDhFouCEcmd7+XwFdqkb9dLVQD2fn/vee7yQEyWiWeQJaU0+
 yXescem2+8Vs9UR/1cVXg1v8bR1Wh21oalTGmLEzaHfWS3z/VLCPEQa3xTFfV7SD3ecYcHspZkE
 BzzasVKk8/UV2sWMkkMcdLtsRRlEFXsArK+JO0XvTE0186H+K1uLjuymyQ0j5ivbPH/vDHqjA0D
 1tryEZISdYtCxgwBqkQ/b+wsleVx9W9rHiBpH7TO/BfVgU8Jp7qS6q62Die+z0XY/kghOQvxIes
 6+wRhxw owRe2EBA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct watch_filter.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Howells <dhowells@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Siddh Raman Pant <code@siddh.me>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Qian Cai <cai@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/watch_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 45cd42f55d49..429c7b6afead 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -32,7 +32,7 @@ struct watch_filter {
 		DECLARE_BITMAP(type_filter, WATCH_TYPE__NR);
 	};
 	u32			nr_filters;	/* Number of filters */
-	struct watch_type_filter filters[];
+	struct watch_type_filter filters[] __counted_by(nr_filters);
 };
 
 struct watch_queue {
-- 
2.34.1

