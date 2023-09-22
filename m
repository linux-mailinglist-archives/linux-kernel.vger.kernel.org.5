Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BF7AB8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjIVSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjIVSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D662D79
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5c91bec75so21058035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405223; x=1696010023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/L92X22dJhyhtQ8lDKApFNV7vkLUEgyD7DW61AIGrg=;
        b=R9xyZN9cQTzCHh1zGdoKQao8yI/eVpTF6uJsDtWMYY9GWDxthUzvTpDgsXfpkWgh/V
         /YdrSM1hp+eLqX2UPVgWaL9dStDGnatO9ahE+XSJD1OT50KM+lT5TJGelJE5MTBTX30t
         wdulrdqgzfVkdLnMjJs0YdPshpQ7OKZseb+YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405223; x=1696010023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/L92X22dJhyhtQ8lDKApFNV7vkLUEgyD7DW61AIGrg=;
        b=WJPx0RynbUf5EaG2bGIukW1Biqh5pEwH+QzEA21fu6STk7v5CehexHPCqmQf4MTEZc
         tk8wKkrJSVy6aB/EFwY0EsEzW8RMQMaMuV+StjVwEM7rQkGNMDrW4iGWBHZWEsV4sCe1
         fa81bnxIG/nUpl0YXTqu9c4afvw7pSjcBcVxLIa4wwlZOgQWrHByqOxuyvFxqlzXLaYh
         iEV6HtPp0hYagqpdoJU/7jkGIQk+fQ6H1Mfbq3OsMeV64Xs5nynps1LMia6Ik7v7eg0/
         2L6tHQPY+VdAw0/2UrOgDPYQsjv4yqflQQHWifnzm9/SZ8FCS1VYQYDdVmDER0XS0bb9
         mBZw==
X-Gm-Message-State: AOJu0YzZWmL3mwGxaTgcOTichZI4no+REEeuBOdUA9jiLyfKRkDi5Nix
        E4P2METoXeNqfn5jcVSj17u7vw==
X-Google-Smtp-Source: AGHT+IHGWszC9sNGNLlYcYJz1tQiG2EBYKJI1eKGKzyA7OlbgEJ46OgR6p2V4Nmm7b7vzpvejaUosA==
X-Received: by 2002:a17:903:110d:b0:1bb:d280:5e0b with SMTP id n13-20020a170903110d00b001bbd2805e0bmr246508plh.18.1695405223181;
        Fri, 22 Sep 2023 10:53:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001bdbe6c86a9sm3779903plb.225.2023.09.22.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
Date:   Fri, 22 Sep 2023 10:53:41 -0700
Message-Id: <20230922175341.work.919-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=keescook@chromium.org;
 h=from:subject:message-id; bh=yU2HdTIvaMKiOikp0zqOQXXfFgKhOPJCGAbuECY4jOI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSlvezRdvtVZduY7QM2bmTOaemd9ierWA9Ag
 6m2g04zvqaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UpQAKCRCJcvTf3G3A
 Jj+VD/9XA5O7ImEBS5lp7pFupDLhl0qpeveeJl1/ws9XB4+qfWGwP+u+B/yGl1V1if8pWYaZHlS
 gsqmwyDwotCQkne3cBhWOEhu34q/vFTAAFYkmFsBxgqdEmAvCgw6E93LPtr32936+3M036VPvAF
 69Kn+xQ++3aBnlnaUnGWexWUQtZ1BS1/3Qk1BZX9wiZcM2AppV+v03THCd2OnaV7GiuE8rZLidJ
 IKwzISZpU7HmiLVADRtiQRxDQYY7udzm1EYCbIKeB16siRiRX/wJ8B0rmqgucSPZNQOor4PZM4l
 vgNXz3L3qYnqgZa8ZT96/zA8GcZu7v8wB3rYxEfOqmYw43FXc0J0geWreIJRzsL9HEFlKGt1dSQ
 rOFKd0sHwKcpv9uSOSDoYV7pbxj7ZQ24AKv7OeLykWg9uOpGPezAYIKNyHMbgHpRqmgHihP1Tmj
 4otwf/3z+CJgIl0XIVW0W1B6YF4lUaRB5hyf71QQggSR4OB0ReLaLvDMAtIslb+edPFvWeTzTHs
 YSmoWaWdM3Mh1xXVaa4/UzuDRz1J8T3rY1YXU0VoYQZAsZIknGkKW3jUm/ZVnO4Gk0P7rHrxkSA
 udeto6Sq0lS20NGkgL1YMg62eSI2ZRseFlf3zhvVz6ax5crha3+IWjhindVoZ+Xh3fMVbQllLbX
 FqtV4/g FbpWcylQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct tsens_priv.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/thermal/qcom/tsens.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2805de1c6827..cb637fa289ca 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -585,7 +585,7 @@ struct tsens_priv {
 	struct dentry			*debug_root;
 	struct dentry			*debug;
 
-	struct tsens_sensor		sensor[];
+	struct tsens_sensor		sensor[] __counted_by(num_sensors);
 };
 
 /**
-- 
2.34.1

