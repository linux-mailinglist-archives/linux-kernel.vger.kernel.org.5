Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530677E0C62
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjKCXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKCXnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:43:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C6D48;
        Fri,  3 Nov 2023 16:43:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32f8246103cso517499f8f.1;
        Fri, 03 Nov 2023 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699055000; x=1699659800; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYCqZrVNGN2mIiQCLNklLY55LWgupbs56ES5k10+bBg=;
        b=izndATHn1TwiU5cxtdKcYqnGZSd8bo17Ne+6X80it3cq75eJPH9DUcs+de/Rvk3OjQ
         aPNaLRGiGyBMOoFQdU7km4DUSBX9prSXsIO0V/qDAJgLWvsiSY5bGcPx+gKDgFdu9AhQ
         rO7IepD+0ZBAfydEuYfkAPazx4lYQ8ptPQwzMs7MgwJECiJiS7Hh24QrpGAB8cxXqNxk
         +ke2u5ssBcnBiGDkQ445mMpx0xWwEsCG1U0mxOtNo+oJIhbNhiIrGDc24oUpiWUtFH5/
         2QKVWcXvoU+/3WGWqO4ll2i1Qb5Wv813YnNKuWxv2XzdsQQZex9M2YFBpIio08CFypBS
         ljLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699055000; x=1699659800;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYCqZrVNGN2mIiQCLNklLY55LWgupbs56ES5k10+bBg=;
        b=PX0Fctd4iMQUNhI7RaT3Kz8PQSHr74abzjifYiT/shTK/GPAAQ+SKfMQ1X2+mShDv1
         njn5abTripLp9eWrCjyAqZM+yos+NrmACAvm3JK4GCBZRBYbHJ/lDKhUHwYL92VHgc15
         4W8uwfjKP3s2aIBrAfzVS0dkUjfS360vEMpE+zVMzJM9LZll+LGLKUToeWbPGeUQifo5
         sJ/ph9lKQL80xC2BLsxuPoqjjiq+qeiCDRRTBPiwYZCQE8sgpqI4e8NL9Ro0ygRKmnH7
         yXMRIRPm5wd+4owMsAfAgg068u4Wq0kfuHltroJm66B1NN3+dMryx57blpXhuS6vo88b
         6LWQ==
X-Gm-Message-State: AOJu0Yw84nbNbm9/orPbgWPMuneB1kvKvOhurIFSOyh1s2C1B+HbHQLc
        qPaTYmNkwNYAtC21OkxHJtGeos7iYnlFH9SJ
X-Google-Smtp-Source: AGHT+IE3UIErq3s44P5X8FLUBvx23u92ky4//OEqSGX6pvS923TCn2oJbN67sSoyczLKMJq/rZDynQ==
X-Received: by 2002:a5d:6c65:0:b0:32d:eac9:da52 with SMTP id r5-20020a5d6c65000000b0032deac9da52mr16238232wrz.5.1699055000345;
        Fri, 03 Nov 2023 16:43:20 -0700 (PDT)
Received: from localhost.localdomain ([94.203.174.192])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d68ce000000b0032daf848f68sm2993793wrw.59.2023.11.03.16.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:43:19 -0700 (PDT)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
        dmitrii.bundin.a@gmail.com
Subject: [PATCH] kbuild: deb-pkg: apply short --rules-file option
Date:   Sat,  4 Nov 2023 02:42:47 +0300
Message-Id: <20231103234247.4505-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long --rules-file option might not be available for some older
versions of dpkg-buildpackage resulting in build failures. The -R option
has been available since 1.14.17 allowing builds for larger allowing
builds for larger set of versions of dpkg-buildpackage.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 2bcab02da965..0afbf5ad2919 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		--rules-file='$(MAKE) -f debian/rules' --jobs=1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		-R'$(MAKE) -f debian/rules' --jobs=1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
-- 
2.17.1

