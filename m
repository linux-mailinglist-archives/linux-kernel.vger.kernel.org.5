Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7376D00F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjHBO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHBO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC71723;
        Wed,  2 Aug 2023 07:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65D0619B3;
        Wed,  2 Aug 2023 14:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B44C433C7;
        Wed,  2 Aug 2023 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690986506;
        bh=Z4JOTOXE88xHck3RMo4XJjkzZ+TXGkjviveE+ctMbxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzdqEgSPFmXZJINCHiAYXr0aqydeYRU8nvXGVdAKvsnZo77OkFFdGtgiUWLr/2G0y
         JL6tTyhQJE8LIw30oRey+gJqdzTs1u04FRYAJrkAdw4mPVs3LYXlYMaQULzIFD4LxH
         PY7hQX0OQcot636XJRSxAuK7S8hXxslLn7rML6oLggu3fxH3kHKMFXh8chYll1dZmq
         Gz3hN2BujhBdTJvkOfElcafRoCHLmTyXRFq9r0vYHnmPaOYQvZPuUzCK7faTLMh4k7
         9LnxAXvF5VBYVhXt8t6FeB0BbGNo+QHtR3EWcsIaZ6DoekDyGfGRq2MOYDgvxBRa7i
         BSdiImK1bw2yA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A0054012D; Wed,  2 Aug 2023 11:28:23 -0300 (-03)
Date:   Wed, 2 Aug 2023 11:28:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 1/2 Resend] perf build: Update feature check for clang
 and llvm
Message-ID: <ZMpoB1bYk+KfTDJA@kernel.org>
References: <20230725150347.3479291-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725150347.3479291-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 25, 2023 at 05:03:46PM +0200, Thomas Richter escreveu:
> Perf build auto-detects features and packages already installed
> for its build. This is done in directory tools/build/feature. This
> directory contains small sample programs. When they successfully
> compile the necessary prereqs in form of libraries and header
> files are present.
> 
> Such a check is also done for llvm and clang. And the checks fail.
> 
> Fix this and update to the latest C++ standard and use the
> new library provided by clang (which contains new packaging)
> see this link for reference:
>  https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Component-Libraries-In-clang-lib-Package
> 
> Output before:
>  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
> 	ll test-clang.make.output
>  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> 	 	> test-clang.make.output 2>&1 -std=gnu++14 \
> 	-I/usr/include 		\
> 	-L/usr/lib64		\
> 	-Wl,--start-group -lclangBasic -lclangDriver	\
> 	  -lclangFrontend -lclangEdit -lclangLex	\
> 	  -lclangAST -Wl,--end-group 			\
> 	-lLLVM-16	\
> 			\
> 	> test-clang.make.output 2>&1
>  make: *** [Makefile:356: test-clang.bin] Error 1
>  -bash: ./test-clang.bin: No such file or directory
>  -rw-r--r--. 1 root root 252041 Jul 12 09:56 test-clang.make.output
>  #
> 
> File test-clang.make.output contains many lines of unreferenced
> symbols.
> 
> Output after:
>  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
> 	cat test-clang.make.output
>  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> 	 > test-clang.make.output 2>&1 -std=gnu++17	\
> 	-I/usr/include 		\
> 	-L/usr/lib64		\
> 	-Wl,--start-group -lclang-cpp -Wl,--end-group	\
> 	-lLLVM-16	\
> 			\
> 	> test-clang.make.output 2>&1
>  #

Thanks, tested and applied. Added some notes about needing to have
'llvm-devel' and 'clang-devel' installed to do the tests.

- arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/build/feature/Makefile | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 2cd6dbbee088..3184f387990a 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
>  	$(BUILD)
>  
>  $(OUTPUT)test-llvm.bin:
> -	$(BUILDXX) -std=gnu++14 				\
> +	$(BUILDXX) -std=gnu++17 				\
>  		-I$(shell $(LLVM_CONFIG) --includedir) 		\
>  		-L$(shell $(LLVM_CONFIG) --libdir)		\
>  		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
> @@ -348,17 +348,15 @@ $(OUTPUT)test-llvm.bin:
>  		> $(@:.bin=.make.output) 2>&1
>  
>  $(OUTPUT)test-llvm-version.bin:
> -	$(BUILDXX) -std=gnu++14					\
> +	$(BUILDXX) -std=gnu++17					\
>  		-I$(shell $(LLVM_CONFIG) --includedir)		\
>  		> $(@:.bin=.make.output) 2>&1
>  
>  $(OUTPUT)test-clang.bin:
> -	$(BUILDXX) -std=gnu++14					\
> +	$(BUILDXX) -std=gnu++17					\
>  		-I$(shell $(LLVM_CONFIG) --includedir) 		\
>  		-L$(shell $(LLVM_CONFIG) --libdir)		\
> -		-Wl,--start-group -lclangBasic -lclangDriver	\
> -		  -lclangFrontend -lclangEdit -lclangLex	\
> -		  -lclangAST -Wl,--end-group 			\
> +		-Wl,--start-group -lclang-cpp -Wl,--end-group	\
>  		$(shell $(LLVM_CONFIG) --libs Core option)	\
>  		$(shell $(LLVM_CONFIG) --system-libs)		\
>  		> $(@:.bin=.make.output) 2>&1
> -- 
> 2.41.0
> 

-- 

- Arnaldo
