Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3F788DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjHYRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbjHYRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:38:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798292128
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:38:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so16811907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692985083; x=1693589883;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nW0lHbEH2B08cVP1PWHu98ltXXBWNNKQyHzU/WWXVBg=;
        b=vn4NLE80Ek9GDI0l8rmwhGAFZ6JE/I3eUGF3uLS3egRG40IHqIQPHIsjSutvU8y5xL
         Njj/tLMcKkb15HZWuZFzflfPCy7+B8iPSh9ZgnfJgZh0Kw60IZroSrw4BgDeFiOsH3OI
         yuiAWyJ1pcGeBsx1rZieeM5ZlBicl0471NqKG4ALCHozh8MN0fiHKxVPnnaHmmkhpvdF
         tyM/kkDeSXNVDdI9OsrIJVAGF48h9ehJCDz5PH/O7naQnt5MFca9GG8GHFf00+hcu+eO
         KaehujKdOBagy0UPqXO5wxuhodsw9nST+n4coH1oZT18/NyAallpETLm8eWbEru5rcyD
         bxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692985083; x=1693589883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nW0lHbEH2B08cVP1PWHu98ltXXBWNNKQyHzU/WWXVBg=;
        b=cHE8D2AcpkVOf7tVYDvn7CGIsrW1hYhEMSlqjK/37qpZ0NodnNUWnhmltS8uXspGr7
         1AlkJoWBk80vp6Uk+5hvKiE9+4KcUORyLQkVIR4aBfFk9r6lTigdsimRRiNNmHEYbL11
         PEWdHh71lW8YArzvVkACpyIhN6ZmPBQnUQiGT8JmvDxs/D3CnMvzlvcBzBoBci7X/Eh8
         QDJBEWdR20DqRmdi576FALCyGBRV1dqH/91jPZbbijzma8EPuMrLbHfbTb+BvNPqRhUZ
         Y/WeFSkEZHVM6/HGJBFeySZpbDOD9qG8Y5F5800JlSaGTtptHGqJ6cjit9WocLbD4Zr+
         ByQw==
X-Gm-Message-State: AOJu0YxQhS8XBB4uA6sSKRyQObOhF5JAU+lSBa94CzBs6hdOglRNd/oH
        pRCaHuql7niaoEGzN4MYI+6F5GzVx/DWQkFin/I=
X-Google-Smtp-Source: AGHT+IHh4uVC5aH+i5xEI7dEkjUEt+yyAPTH2Q365Oe63akHuYT/y05k9vHwgZxXbnuGD7oaMh2+4z+0vlx0AQ24A5M=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:dd9c:e8e8:b275:92e3])
 (user=ndesaulniers job=sendgmr) by 2002:a25:3284:0:b0:d5d:6bfe:76d6 with SMTP
 id y126-20020a253284000000b00d5d6bfe76d6mr460590yby.8.1692985083762; Fri, 25
 Aug 2023 10:38:03 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:38:01 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPjm6GQC/22MwQ7CIBAFf6XZsxiW0kI8+R/GQwtLS6LFgCGah
 n+X9qbxOC9vZoVE0VOCU7NCpOyTD0uF9tCAmYdlIuZtZRBctFwLyWwwiRlUQ2dJOeQt1OsjkvO
 vPXO5Vp59eob43qsZt/UnkJEh6xXxHoXSo3bnKYTpRkcT7rAVsvhniWppqYfR9R2ill9WKeUDw 9hoTs8AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692985082; l=9234;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=eNHemkeELfQC57dQP3CgrFEDRhCWp3y52DYMEFkhFy4=; b=dTfxeajlSMkHazbF+bce+tV9cZMKgDf0kPy8dBaNmvhbNxmmtqvJK15nn/4/QVVk0vgRK2He7
 rdNI+uwdKIYBJF1kQqyy0w4Q/4IAJnbTNOadhGrkW+XCACgxHmjqN0q
X-Mailer: b4 0.12.3
Message-ID: <20230825-docs-v3-1-384048d32a51@google.com>
Subject: [PATCH v3] Documentation/llvm: refresh docs
From:   ndesaulniers@google.com
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
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

Recent fixes for an embargoed hardware security vulnerability failed to
link with ld.lld (LLVM's linker).  [0]  To be fair, our documentation
mentions ``CC=clang`` foremost with ``LLVM=1`` being buried "below the
fold."

We want to encourage the use of ``LLVM=1`` rather than just
``CC=clang``. Make that suggestion "above the fold" and "front and
center" in our docs.

While here, the following additional changes were made:
- remove the bit about CROSS_COMPILE setting --target=, that's no longer
  true.
- Add ARCH=loongarch to the list of maintained targets (though we're
  still working on getting defconfig building cleanly at the moment;
  we're pretty close).
- Bump ARCH=powerpc from CC=clang to LLVM=1 status.
- Promote ARCH=riscv from being Maintained to being Supported. Android
  is working towards supporting RISC-V, and we have excellent support
  from multiple companies in this regard.
- Note that the toolchain distribution on kernel.org has been built with
  profile data from kernel builds.
- Note how to use ccache with clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/1907 [0]
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v3:
- Note why kernel.org toolchains are shiny.
- Add note about ccache to doc and commit message.
- Link to v2: https://lore.kernel.org/r/20230824-docs-v2-1-848abf651184@google.com

Changes in v2:
- Commit message changes:
  - Put SOB tag above the fold.
  - Mention PPC change in commit message.
  - Fix typos in commit message.
  - Add Nathan's RB tag to commit message.
- Fix kernel doc warnings
- Reword s390 example under `The LLVM= argument`.
- Reword and add examples to `The LLVM_IAS= argument`.
- Link to v1: https://lore.kernel.org/r/20230824-docs-v1-1-67e061278b8f@google.com
---
 Documentation/kbuild/llvm.rst | 124 +++++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 44 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index c3851fe1900d..384622dd36b7 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -25,50 +25,38 @@ objects <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM
 that supports C and the GNU C extensions required by the kernel, and is
 pronounced "klang," not "see-lang."
 
-Clang
------
-
-The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
-``CC=`` should be set when selecting a config and during a build. ::
-
-	make CC=clang defconfig
-
-	make CC=clang
+Building with LLVM
+------------------
 
-Cross Compiling
----------------
+Invoke ``make`` via::
 
-A single Clang compiler binary will typically contain all supported backends,
-which can help simplify cross compiling. ::
-
-	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
+	make LLVM=1
 
-``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
-``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
-example: ::
+to compile for the host target. For cross compiling::
 
-	clang --target=aarch64-linux-gnu foo.c
+	make LLVM=1 ARCH=arm64
 
-LLVM Utilities
---------------
+The LLVM= argument
+------------------
 
-LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
-The full list of supported make variables::
+LLVM has substitutes for GNU binutils utilities. They can be enabled
+individually. The full list of supported make variables::
 
 	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
 	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
 	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
 
-To simplify the above command, Kbuild supports the ``LLVM`` variable::
-
-	make LLVM=1
+``LLVM=1`` expands to the above.
 
 If your LLVM tools are not available in your PATH, you can supply their
 location using the LLVM variable with a trailing slash::
 
 	make LLVM=/path/to/llvm/
 
-which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
+which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc. The
+following may also be used::
+
+	PATH=/path/to/llvm:$PATH make LLVM=1
 
 If your LLVM tools have a version suffix and you want to test with that
 explicit version rather than the unsuffixed executables like ``LLVM=1``, you
@@ -78,31 +66,72 @@ can pass the suffix using the ``LLVM`` variable::
 
 which will use ``clang-14``, ``ld.lld-14``, etc.
 
+To support combinations of out of tree paths with version suffixes, we
+recommend::
+
+	PATH=/path/to/llvm/:$PATH make LLVM=-14
+
 ``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
-``LLVM=1``. If you only wish to use certain LLVM utilities, use their respective
-make variables.
+``LLVM=1``. If you only wish to use certain LLVM utilities, use their
+respective make variables.
+
+The same value used for ``LLVM=`` should be set for each invocation of ``make``
+if configuring and building via distinct commands. ``LLVM=`` should also be set
+as an environment variable when running scripts that will eventually run
+``make``.
 
-The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
-disable it.
+Cross Compiling
+---------------
 
-Omitting CROSS_COMPILE
+A single Clang compiler binary (and corresponding LLVM utilities) will
+typically contain all supported back ends, which can help simplify cross
+compiling especially when ``LLVM=1`` is used. If you use only LLVM tools,
+``CROSS_COMPILE`` or target-triple-prefixes become unnecessary. Example::
+
+	make LLVM=1 ARCH=arm64
+
+As an example of mixing LLVM and GNU utilities, for a target like ``ARCH=s390``
+which does not yet have ``ld.lld`` or ``llvm-objcopy`` support, you could
+invoke ``make`` via::
+
+	make LLVM=1 ARCH=s390 LD=s390x-linux-gnu-ld.bfd \
+	  OBJCOPY=s390x-linux-gnu-objcopy
+
+This example will invoke ``s390x-linux-gnu-ld.bfd`` as the linker and
+``s390x-linux-gnu-objcopy``, so ensure those are reachable in your ``$PATH``.
+
+``CROSS_COMPILE`` is not used to prefix the Clang compiler binary (or
+corresponding LLVM utilities) as is the case for GNU utilities when ``LLVM=1``
+is not set.
+
+The LLVM_IAS= argument
 ----------------------
 
-As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
+Clang can assemble assembler code. You can pass ``LLVM_IAS=0`` to disable this
+behavior and have Clang invoke the corresponding non-integrated assembler
+instead. Example::
+
+	make LLVM=1 LLVM_IAS=0
+
+``CROSS_COMPILE`` is necessary when cross compiling and ``LLVM_IAS=0``
+is used in order to set ``--prefix=`` for the compiler to find the
+corresponding non-integrated assembler (typically, you don't want to use the
+system assembler when targeting another architecture). Example::
 
-If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
-from ``ARCH``.
+	make LLVM=1 ARCH=arm LLVM_IAS=0 CROSS_COMPILE=arm-linux-gnueabi-
 
-That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
 
-For example, to cross-compile the arm64 kernel::
+Ccache
+------
 
-	make ARCH=arm64 LLVM=1
+``ccache`` can be used with ``clang`` to improve subsequent builds, (though
+KBUILD_BUILD_TIMESTAMP_ should be set to a deterministic value between builds
+in order to avoid 100% cache misses, see Reprocible_builds_ for more info):
 
-If ``LLVM_IAS=0`` is specified, ``CROSS_COMPILE`` is also used to derive
-``--prefix=<path>`` to search for the GNU assembler and linker. ::
+	KBUILD_BUILD_TIMESTAMP='' make LLVM=1 CC="ccache clang"
 
-	make ARCH=arm64 LLVM=1 LLVM_IAS=0 CROSS_COMPILE=aarch64-linux-gnu-
+.. _KBUILD_BUILD_TIMESTAMP: kbuild.html#kbuild-build-timestamp
+.. _Reproducible_builds: reproducible-builds.html#timestamps
 
 Supported Architectures
 -----------------------
@@ -135,14 +164,17 @@ yet. Bug reports are always welcome at the issue tracker below!
    * - hexagon
      - Maintained
      - ``LLVM=1``
+   * - loongarch
+     - Maintained
+     - ``LLVM=1``
    * - mips
      - Maintained
      - ``LLVM=1``
    * - powerpc
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1``
    * - riscv
-     - Maintained
+     - Supported
      - ``LLVM=1``
    * - s390
      - Maintained
@@ -171,7 +203,11 @@ Getting Help
 Getting LLVM
 -------------
 
-We provide prebuilt stable versions of LLVM on `kernel.org <https://kernel.org/pub/tools/llvm/>`_.
+We provide prebuilt stable versions of LLVM on `kernel.org
+<https://kernel.org/pub/tools/llvm/>`_. These have been optimized with profile
+data for building Linux kernels, which should improve kernel build times
+relative to other distributions of LLVM.
+
 Below are links that may be useful for building LLVM from source or procuring
 it through a distribution's package manager.
 

---
base-commit: 93f5de5f648d2b1ce3540a4ac71756d4a852dc23
change-id: 20230824-docs-c17a5de7f103

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

