Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D6754DC4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGPHyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGPHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:54:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CA71BE;
        Sun, 16 Jul 2023 00:54:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4F02E5BC88;
        Sun, 16 Jul 2023 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689494044;
        bh=0f4ynGEdL9ZA2xjUzHGruHP+HC3rtDv/fjZJ0E0YZwc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oSVVqwPuLC7aFBOpK2mNa3aj//hnquewRU6xmfhwj3349CJ5Z7er6Kcite7q6exYS
         3yXjqGWR2iVgesbTkSb/bnYyUyUT1rG5Q+VlHANTE6BKb+GtvJ8fVKnNPFwA4WOGv+
         GHTY+fVDo/LJzx575o+eQjUcz19hGyKCle7UeuIutPUtOK1bPf0AWD96NoMNGr0/jc
         XJP+R9/mUn8fTt9tFx/33RMT3gIik1Y+JsGMuS40nUDg/mhJBY5qnHLGYhqnSQjB/O
         qT7NoIrQiaP3gSXqo27wvdu3hGfFKoD1w/imNCmU1CilUubIP9F4sRgUbXeby72nPb
         hoQme5cmzFssQ==
Message-ID: <3de23cc5-ceef-555d-8a16-854f179705bc@asahilina.net>
Date:   Sun, 16 Jul 2023 16:53:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 03/11] rust: Use absolute paths to build Rust objects
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
 <20230714-classless_lockdep-v1-3-229b9671ce31@asahilina.net>
 <20230715153509.64a7ac38.gary@garyguo.net>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230715153509.64a7ac38.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 23.35, Gary Guo wrote:
> On Fri, 14 Jul 2023 18:13:55 +0900
> Asahi Lina <lina@asahilina.net> wrote:
> 
>> We want to use caller_location to uniquely identify callsites, to
>> automatically create lockdep classes without macros. The location
>> filename in local code uses the relative path passed to the compiler,
>> but if that code is generic and instantiated from another crate, the
>> path becomes absolute.
>>
>> To make this work and keep the paths consistent, always pass an absolute
>> path to the compiler. Then the Location path is always identical
>> regardless of how the code is being compiled.
> 
> I wonder if this can have some reproducible build implications. We
> probably also need to use remap-path-prefix?

We already end up with absolute paths in objects anyway, just not 
consistently. If it were consistently relative paths that would be fine 
too, but it looks like Rust likes to internally absolute-ize some paths, 
that's why I wrote this patch to make it always like that.

TIL about remap-path-prefix, that looks very useful! I'll give it a try.

> 
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>   rust/Makefile          | 2 +-
>>   scripts/Makefile.build | 8 ++++----
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/rust/Makefile b/rust/Makefile
>> index 7c9d9f11aec5..552f023099c8 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -369,7 +369,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
>>   		--emit=dep-info=$(depfile) --emit=obj=$@ \
>>   		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
>>   		--crate-type rlib -L$(objtree)/$(obj) \
>> -		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
>> +		--crate-name $(patsubst %.o,%,$(notdir $@)) $(abspath $<) \
>>   	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>>   
>>   rust-analyzer:
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 6413342a03f4..c925b90ebd80 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -283,27 +283,27 @@ rust_common_cmd = \
>>   # would not match each other.
>>   
>>   quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>> -      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<
>> +      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $(abspath $<)
>>   
>>   $(obj)/%.o: $(src)/%.rs FORCE
>>   	$(call if_changed_dep,rustc_o_rs)
>>   
>>   quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>>         cmd_rustc_rsi_rs = \
>> -	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
>> +	$(rust_common_cmd) -Zunpretty=expanded $(abspath $<) >$@; \
>>   	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
>>   
>>   $(obj)/%.rsi: $(src)/%.rs FORCE
>>   	$(call if_changed_dep,rustc_rsi_rs)
>>   
>>   quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>> -      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $<
>> +      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $(abspath $<)
>>   
>>   $(obj)/%.s: $(src)/%.rs FORCE
>>   	$(call if_changed_dep,rustc_s_rs)
>>   
>>   quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>> -      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $<
>> +      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $(abspath $<)
>>   
>>   $(obj)/%.ll: $(src)/%.rs FORCE
>>   	$(call if_changed_dep,rustc_ll_rs)
>>
> 
> 

~~ Lina

