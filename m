Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0978B9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjH1UjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjH1UjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:39:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD1109
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:39:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59222a14ee1so54368587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693255152; x=1693859952;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XhrkWiQBnHmzMnkAE+NYbdoZdy6UiyASIH0GRgNQ/sU=;
        b=urfxC/+oTHLuj+i6cn0/azuq+FFaWj+TnME6nhesd8cw0L5Hhx/TUyll1F+Er3mk1V
         EPtJEawuJ7LmK9shNHvS9h/gGI6VsaHwg4Nca8og7fCRD7CQB4X3Kfa9FsaRnST6k8xO
         0dr5yHSkjVGAHS3J7o6VojOEbV63NzFkgqMmpXOQ582xX256DdnHrjUmmPC4cmLFHEin
         Z1O8sfXNGBnPb7WSs4WCuskoLd5HzDd2PmDt8VBcd9vco3CTPXvj+3hemrc7Ly+8daso
         R24co0ytNidRJebijXU8YN6wM8GK/12rUxTgs3qJ/AEYZkHtELGzmn5jHkz2rJQRiQlW
         odaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255152; x=1693859952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhrkWiQBnHmzMnkAE+NYbdoZdy6UiyASIH0GRgNQ/sU=;
        b=EXVa+nwR86UUiZ6j1QqSM0MrH2u+Fiwno76pFaw48DSdbhpKMj5UbGZgzemFtMS+zw
         UeWgHHRmGS2ERgRGRb/gicEy1LdLe+gmiQlsCTdGaVgbYTdnPAPsa9UgcsDZUA+a8icw
         JyfV1PKcgmC0OFu7RTiB4ytcawLd7k8h0z83qdrFoO95chJbykfp9AVLUdf/XxhQOtjF
         ZRi1GM6q8QV0WsyZ+3JkLxEN04xThSL7NSCYrg49i/YsXnlGutmAnvQUfiAp4WKbWikG
         lircy0+hxlnBadw6V2T+7yUMGbl2xti9QZOp6JADl92okOvx7DeoD49vTz795KjhCTY4
         JFKw==
X-Gm-Message-State: AOJu0YwzkQ3Oz9SKokT5f8FJjbny7YoLa/MnMcdJab17D3If7mSoWWH4
        lyDyu39jnvp/qqV83dlAGpwIRVQkJsgqDPYgZE8=
X-Google-Smtp-Source: AGHT+IGlwLCXXsjKROwMA/eBuqL6pO5hd66mEIQL7qVwZn+m6vX+Qy5OakE1dsfnaIt9WkB4KXLqeb7R2EWnAWB0U3E=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a25:74c6:0:b0:d0c:c83b:94ed with SMTP
 id p189-20020a2574c6000000b00d0cc83b94edmr811734ybc.10.1693255152253; Mon, 28
 Aug 2023 13:39:12 -0700 (PDT)
Date:   Mon, 28 Aug 2023 13:39:06 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOkF7WQC/3WMwQ7CIBAFf6XZsxhAKtiT/2Eao7hQEi1kaYim4
 d/F3j3Oy5tZISMFzDB0KxCWkEOcG8hdB3a6zR5ZeDQGyeWBG2lYSvZK2K5ICzsqraR2XFkU0JR E6MJ7y13GxlPIS6TPVi/it/4JFcEE08r1/d0Ic+L67GP0T9zb+IKx1voFZACn56kAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693255150; l=2020;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=xcYx2Rp6x+lRWSqPslFnv6rJuAz/HxMw+0OdY1ALQZs=; b=v17oTu32hcx8X2o5oavi8I5UUOWMaIGdmbzoTP9nH19+mbccNNnrpEkGWrOiXO5zDJPWL5d/n
 rm1iEXciqeaAqQHb6RBdzIzkcNFhLuv32jqEmsXHABpaRsTnDZThqrj
X-Mailer: b4 0.12.3
Message-ID: <20230828-ppc_rerevert-v2-1-46b71a3656c6@google.com>
Subject: [PATCH v2] reapply: powerpc/xmon: Relax frame size for clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a manual revert of commit
7f3c5d099b6f8452dc4dcfe4179ea48e6a13d0eb, but using
ccflags-$(CONFIG_CC_IS_CLANG) which is shorter.

Turns out that this is reproducible still under specific compiler
versions (mea culpa: I did not test every supported version of clang),
and even a few randconfigs bots found.

We'll have to revisit this again in the future, for now back this out.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/252#issuecomment-1690371256
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308260344.Vc4Giuk7-lkp@intel.com/
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Use ccflags-$(CONFIG_CC_IS_CLANG) as per Nathan.
- Move that to be below the initial setting of ccflags-y as per Nathan.
- Add Nathan's Suggested-by and Reviewed-by tags.
- Update commit message slightly, including oneline.
- Link to v1: https://lore.kernel.org/r/20230828-ppc_rerevert-v1-1-74f55b818907@google.com
---
 arch/powerpc/xmon/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 7705aa74a24d..682c7c0a6f77 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -12,6 +12,10 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
+# Clang stores addresses on the stack causing the frame size to blow
+# out. See https://github.com/ClangBuiltLinux/linux/issues/252
+ccflags-$(CONFIG_CC_IS_CLANG) += -Wframe-larger-than=4096
+
 obj-y			+= xmon.o nonstdio.o spr_access.o xmon_bpts.o
 
 ifdef CONFIG_XMON_DISASSEMBLY

---
base-commit: 2ee82481c392eec06a7ef28df61b7f0d8e45be2e
change-id: 20230828-ppc_rerevert-647427f04ce1

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

