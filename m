Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9461A7DEF40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbjKBJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjKBJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:53:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745FF7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:53:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51702C433C7;
        Thu,  2 Nov 2023 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698918792;
        bh=JQ4IzgN1tIeQMye2/+gyuWS8feDEz0F5Fh8il3PCjmc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kd0aPXOHlZgwv3BGBPZU+dOVFXmi6HrzuGTY02GKMwAzImZvnEta3GSFBX4ObnLWE
         uCxAh3lfEFEvmyolqD1bS2an+KFlsLC4J3OHhI85xVMwZhOc/YzGMW8MyaA0WuFQT6
         GwsirYTDe6q4aXxc+3a6AdsuzToN9yYpaJtIYVzrHG7f5um5hffoYBo4hW4nSInPib
         4K3uZ1SAC4q0QrLpe/htwqxltyYhJQ+lAs58n12kDOwa1iIV6tvV0GyyTnEf16dYLj
         yMXpa7HYIuDSBqf1swD+suQdTvIlOSxjtxzkdC7gdgEfnKJ11OGPmuZgZ/ceApR6xT
         XSOtymfcbtOug==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?Qmo=?= =?utf-8?B?w7ZybiBUw7ZwZWw=?= 
        <bjorn@rivosinc.com>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/build: Add clang cross-compilation flags to
 feature detection
In-Reply-To: <ZUNsFkZWxws6c5Vx@krava>
References: <20231102081441.240280-1-bjorn@kernel.org> <ZUNsFkZWxws6c5Vx@krava>
Date:   Thu, 02 Nov 2023 10:53:09 +0100
Message-ID: <871qd81ny2.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <olsajiri@gmail.com> writes:

> On Thu, Nov 02, 2023 at 09:14:41AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> When a tool cross-build has LLVM=3D1 set, the clang cross-compilation
>> flags are not passed to the feature detection build system. This
>> results in the host's features are detected instead of the targets.
>>=20
>> E.g, triggering a cross-build of bpftool:
>>=20
>>   cd tools/bpf/bpftool
>>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- LLVM=3D1
>>=20
>> would report the host's, and not the target's features.
>>=20
>> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
>> feature detection makefile.
>>=20
>> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  tools/build/Makefile.feature | 2 +-
>>  tools/build/feature/Makefile | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 934e2777a2db..25b009a6c05f 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -8,7 +8,7 @@ endif
>>=20=20
>>  feature_check =3D $(eval $(feature_check_code))
>>  define feature_check_code
>> -  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$=
(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))=
" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"=
$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATUR=
ES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
>> +  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$=
(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))=
" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"=
$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" CLANG_CROSS_FLAGS=3D"$(CLANG_CROS=
S_FLAGS)" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev=
/null && echo 1 || echo 0)
>>  endef
>>=20=20
>>  feature_set =3D $(eval $(feature_set_code))
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index dad79ede4e0a..0231a53024c7 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -84,12 +84,12 @@ PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>>=20=20
>>  all: $(FILES)
>>=20=20
>> -__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.=
c,$(@F)) $(LDFLAGS)
>> +__BUILD =3D $(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $=
@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
>>    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
>>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
>>    BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D=
2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED)=
 -DPACKAGE=3D'"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
>>=20=20
>> -__BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.b=
in,%.cpp,$(@F)) $(LDFLAGS)
>> +__BUILDXX =3D $(CXX) $(CXXFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror=
 -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
>>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
>>=20=20
>>  ###############################
>> @@ -259,10 +259,10 @@ $(OUTPUT)test-reallocarray.bin:
>>  	$(BUILD)
>>=20=20
>>  $(OUTPUT)test-libbfd-liberty.bin:
>> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE=3D'"perf"'=
 $(LDFLAGS) -lbfd -ldl -liberty
>> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c=
 -DPACKAGE=3D'"perf"' $(LDFLAGS) -lbfd -ldl -liberty
>>=20=20
>>  $(OUTPUT)test-libbfd-liberty-z.bin:
>> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE=3D'"perf"'=
 $(LDFLAGS) -lbfd -ldl -liberty -lz
>> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c=
 -DPACKAGE=3D'"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
>
> should we add this also to test-compile-32.bin/test-compile-x32.bin
> targets?

Ah, yes!

I'll spin a v2 with:
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0231a53024c7..c4458345e564 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -283,10 +283,10 @@ $(OUTPUT)test-libbabeltrace.bin:
        $(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabe=
ltrace)
=20
 $(OUTPUT)test-compile-32.bin:
-       $(CC) -m32 -o $@ test-compile.c
+       $(CC) $(CLANG_CROSS_FLAGS) -m32 -o $@ test-compile.c
=20
 $(OUTPUT)test-compile-x32.bin:
-       $(CC) -mx32 -o $@ test-compile.c
+       $(CC) $(CLANG_CROSS_FLAGS) -mx32 -o $@ test-compile.c
=20
 $(OUTPUT)test-zlib.bin:
        $(BUILD) -lz


Thanks for having a look, jirka!


Bj=C3=B6rn
