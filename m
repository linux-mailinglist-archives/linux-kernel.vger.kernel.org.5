Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5337B74AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjJCXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjJCXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:18:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D30DC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3af603da0d1so924902b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375122; x=1696979922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdsHXAOoB55+JJQE0KPED0/ojG5uLpG2jYoS9vwlMXA=;
        b=moKkfxREeo+nE9oZ/1undv3solsmEk1wuT6fWrZ7LePNQ4aGPvRIvXDh9hQbwBMot7
         XBIbD4P7+6GWNN+Bk+8m5gP93VAei1NQ1Fow8ix3ELBLAaJHKyYJ8o6z15bXXN38uVfg
         /0KBHWp9K7d/6YS4gBPZ87eHl5qPBHbwqMiGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375122; x=1696979922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdsHXAOoB55+JJQE0KPED0/ojG5uLpG2jYoS9vwlMXA=;
        b=ZGwBxQuURnyTbZkkfI6xYWCzcDgERWZexEatfUipG+pViggMr/u+bB0GQFLRcwWRKZ
         X+fcx6LEQkXhtQ7rEgnjiHd4lUtruAQj+Z2HWzHt6ZqLt76eLdmOyr+WT10ZnqvLNkgQ
         LxfWfJqbOTn3Plin6ACt1NFCT3m70s1xUuryQznjkHe9IIkfDjs1iYY7pwje28wCkO3A
         wjUlL3BsUXZtH0/ChpQPrZPTueAZGYeJwbGAgrfaK5zHbl6n24qn4OTxYakuo5BtbEFA
         38cnd5Fd/jUVg6GqY+4SCJabmjbLDaLJAd97WlqG16MPyV+XbB8xEq++5HOO9He1AIV8
         dcQA==
X-Gm-Message-State: AOJu0YzFTUm6K2A36yimF7wySOS57WVRC8zjWIsG0olsxGhYUaYWgRPr
        IG0BfX420T/GL9xuJgQGFEgraw==
X-Google-Smtp-Source: AGHT+IGwY7x1Jd3Xo8SdOthYWU+oTJqfkFc49D9CbuUgNubDqiQrc4IQtxbXynCMrh3eZWfVkLJL3A==
X-Received: by 2002:a05:6358:292a:b0:14d:6f1e:cfd7 with SMTP id y42-20020a056358292a00b0014d6f1ecfd7mr1094715rwb.12.1696375122373;
        Tue, 03 Oct 2023 16:18:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0026d214a2b33sm131393pjb.7.2023.10.03.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Gurucharan G <gurucharanx.g@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] i40e: Annotate struct i40e_qvlist_info with __counted_by
Date:   Tue,  3 Oct 2023 16:18:38 -0700
Message-Id: <20231003231838.work.510-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=keescook@chromium.org;
 h=from:subject:message-id; bh=XJmzLNCWCq9YJs2cHWDwGPsTN/+2AuiJN1wF3YGzDV0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFOp5cWExP0FGb1XOfa88nHjK8wg6ypG15KM
 sMyDpMQtHCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhTgAKCRCJcvTf3G3A
 Jk2cD/0X92kJJBn7TO38jm2i1YhnSulInssq7vfXn13tXcHB299D7h/dNsj2MS45px/FmCwSHbL
 O8Gt4OGxRF6xt8udrKExaljjXh9erDJMgs/pvTdQZakYtRpZqizAN34S0sXXjEYaGHR74sAziqf
 LeMGpPzsQoC8RjpdiJGpClQSAjkk2ms/ZkQW8ClLsCmgRcpslZmZifY3UhW7KBKsYZMLCVRp07k
 7/dWHhYhNT0i5GSnU1eCTTjvPk8tCY7suSKbBw40JmMsZ6W34OdUhAKUUBPvCHt+RoY7olPaPvT
 cXtC8x8tjREOv/pP7lMLDdXxsD9y2qIdimDNoaVRispFjidmNbqgybVPS2ksQtpMxQ3bQR1uy4p
 ZqZ792mGi2W+YH6Hxkf2/Sh9XmFSwMwPmYfcI3z8SyqN3tJJGoZKTebTK+R9tKkgzkrJtT1FrPB
 Yz7ggeiZ1v3Vod+Y1aYyEpHvHJBpRkGKHOT1pbKihy1e14srFxJ+2u/sSx43Tha58iNTERjaIwh
 Hn44PyNLQDfiSS3P155/ty3NdovaUsvTC6pPGBqAk0OU8AUSoaha+EcIJnU4yxLsWNxt171z082
 CgdMMNgYFnZ6eBo7ETY54sYXh1/rzDPF1CqFF8sc6Fb5uN4jYQPSUdNZQGc3d3mW6vuwRMtTFcZ
 DdbEI8a HM7vhe5A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct i40e_qvlist_info.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Gurucharan G <gurucharanx.g@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/net/intel/i40e_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/net/intel/i40e_client.h b/include/linux/net/intel/i40e_client.h
index ed42bd5f639f..0aa4411528fc 100644
--- a/include/linux/net/intel/i40e_client.h
+++ b/include/linux/net/intel/i40e_client.h
@@ -45,7 +45,7 @@ struct i40e_qv_info {
 
 struct i40e_qvlist_info {
 	u32 num_vectors;
-	struct i40e_qv_info qv_info[];
+	struct i40e_qv_info qv_info[] __counted_by(num_vectors);
 };
 
 
-- 
2.34.1

