Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A479F621
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjINBGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjINBGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:06:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F721BCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:06:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81503de9c9so548468276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694653599; x=1695258399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k/uDSMMkxzMgxotysOQ1I84LqRn/bUax7yAixLpqCc=;
        b=lzYK9szfFMR/skBd7EWiGnbfbrK7oawEVT3fgrS0+WZI56uBIdqMjTSFIzVDfbcgDu
         yUqXnMmAMaydCDSaQ/E5y+yJHqxUdIcyyqZHslmastkKAXef33nc2eeW6F6aTsHUXY/d
         iyHvVkFxKTtb36aIvb+ztzAJYeA9ZOCTvthq8rnh2JFeX1AY0ueijqjNFGF2fI7hfAPX
         eGu/3AWXCPNcajNEpTypoiywkCDhlpvgSTeE0nVv1NkBYedoevVFQBhP9PahRbwUOq0d
         ezO9gyeo8Qgi/RrrY8hCEpUUEx7s8VZSAqmgzJ2yqL9FXUNcsMqHe7A2ke7BI+QwDKqZ
         dZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694653599; x=1695258399;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2k/uDSMMkxzMgxotysOQ1I84LqRn/bUax7yAixLpqCc=;
        b=jGLh6QE7TXGQUqGhphVefWKG81Wvl0Sa2qvY0JnrNNonfJ9Ou4FpWILI4D9IqSG7R9
         HJncM/GGPmyoUycXuMOG+TbtlEEsR2Pcr9+NKiD8GP04Ngp+4gYKFzaA9z8sHmAoFtkZ
         +9G2BTTmFsSyVwJT8qqIi3dFDs7585ynkNk/6YM6LYx1Eobq7ciMAgYSXfwvrGZ+uMaC
         Vo7ByOX8jbtyJOvOuRx/pp60k5Xl1Q5JcsfIXLHEmA7mlhvPnC4k/s5vLUZIVnBhqz/F
         HxStl7/6lfksWvovK0sewqnWLiEGeyMvCn60/c0d5eoBMNA0c9CnZEDajB2nObyCTvcj
         bMGg==
X-Gm-Message-State: AOJu0Yz3XmqCz6QiHT1G0aUG/5JkL8LIhv2N87JSH/7jS5q6T1Is+Iye
        D3jZVa/TmBSKHgAfWbxhoLToAvUxl4M=
X-Google-Smtp-Source: AGHT+IEw9ZZhn0YdLMZxCCvSGbD9b5eWAH0z/RlOk+yU7xV5M++q8FPZWEHXTjqqB0hL5ZdTs5KmrrqsBlA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1816:b0:d0e:e780:81b3 with SMTP id
 cf22-20020a056902181600b00d0ee78081b3mr101657ybb.2.1694653599563; Wed, 13 Sep
 2023 18:06:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:06:36 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914010636.1391735-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Assert that vasprintf() is successful
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that vasprintf() succeeds as the "returned" string is undefined
on failure.  Checking the result also eliminates the only warning with
default options in KVM selftests, i.e. is the only thing getting in the
way of compile with -Werror.

  lib/test_util.c: In function =E2=80=98strdup_printf=E2=80=99:
  lib/test_util.c:390:9: error: ignoring return value of =E2=80=98vasprintf=
=E2=80=99
  declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-Werror=3Du=
nused-result]
  390 |         vasprintf(&str, fmt, ap);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~

Don't bother capturing the return value, allegedly vasprintf() can only
fail due to a memory allocation failure.

Fixes: dfaf20af7649 ("KVM: arm64: selftests: Replace str_with_index with st=
rdup_printf")
Cc: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>
Cc: Anup Patel <anup@brainfault.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

I haven't actually run the relevant tests, someone should probably do so on
ARM and/or RISC-V to make sure I didn't do something stupid.

 tools/testing/selftests/kvm/lib/test_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/se=
lftests/kvm/lib/test_util.c
index 3e36019eeb4a..5d7f28b02d73 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -387,7 +387,7 @@ char *strdup_printf(const char *fmt, ...)
 	char *str;
=20
 	va_start(ap, fmt);
-	vasprintf(&str, fmt, ap);
+	TEST_ASSERT(vasprintf(&str, fmt, ap) >=3D 0, "vasprintf() failed");
 	va_end(ap);
=20
 	return str;

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
--=20
2.42.0.283.g2d96d420d3-goog

