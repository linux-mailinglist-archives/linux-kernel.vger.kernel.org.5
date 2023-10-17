Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CE7CC54B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjJQN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJQN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:57:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB0F7;
        Tue, 17 Oct 2023 06:57:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E98C433C8;
        Tue, 17 Oct 2023 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697551031;
        bh=v3aKpN8UUgPyVtSsihJ/qo5Rto/3lpMGnPsA17qQyno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wj8IJNltf+fAmFI4JxrpvL19SI0EW/kNkUCglWmLvM5MtqsRgPvQQiEYerRxSIE7T
         u3mFeYVePzEEUNhqaBxt5AIM7zdY3rEf9uHzkJ/61QzHFa+VZ/fhy80TktkyWEkc6p
         8B0Fowb/aC3S/kCHEkKg1xjnWI1wBwO9FLTFPet8=
Date:   Tue, 17 Oct 2023 15:57:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <2023101716-sporting-geology-2de2@gregkh>
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
 <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:58:22AM +0200, Vegard Nossum wrote:
> 
> On 16/10/2023 18:58, Greg Kroah-Hartman wrote:
> > On Mon, Oct 16, 2023 at 09:23:36PM +0530, Harshit Mogalapalli wrote:
> > > Cause for this build issue:
> > > Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
> > > 
> > > And this issue is not in upstream due to presence of commit d6e6a27d960f
> > > ("tools: Fix math.h breakage") in upstream but not in 5.15.y
> > 
> > Ok, I'll go drop the patch entirely, I can't even get perf to build at
> > all for me on 5.15, which is why I've given up on it even mattering
> > anymore :(
> 
> Just for maximal clarity, there are several commits involved here:
> 
> 1. babd04386b1d perf jit: Include program header in ELF files
> 
> This commit is already in 5.15.y but introduced a bug...
> 
> 2. 89b15d00527b perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> 
> This commit is in this -rc1 and fixes the bug above, but introduces a
> new perf build failure on 5.15.y. [This is the one I think you've now
> dropped.]
> 
> 3. d6e6a27d960f tools: Fix math.h breakage
> 
> This is a prerequisite for #2 and is not in 5.15.y. However, it has some
> conflicts on 5.15.y, i.e. it probably has some prerequisites of its own
> that I haven't looked into.
> 
> I guess the question is -- if we're dropping #2, should we drop #1 as
> well? Or... instead of dropping either of them we could also apply a
> minimal fix:

I can't "drop" #1, as it's already merged.

So how about sending a set of patches that you feel should be applied to
get this building for you?  As again, it doesn't work at all for me.

> Out of curiosity, Greg: what is your build error with perf? Given that
> it builds for us (and we actually package perf so we need it) it sounds
> like maybe you're missing a package in your environment or something? If
> you pass us your config + the output of
> 
>   make -C tools/perf/
> 
> I'd be happy to look into it. Only if you want though :-)

Sure!  Here's the output, good luck!

$ make -C tools/perf
make: Entering directory '/home/gregkh/linux/stable/linux-5.15.y/tools/perf'
  BUILD:   Doing 'make -j20' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/const.h' differs from latest version at 'include/uapi/linux/const.h'
diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
Makefile.config:1036: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1062: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
tests/bpf.c: In function ‘epoll_pwait_loop’:
tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
   36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
      |                 ^~~~~~~~~~~
In file included from tests/bpf.c:5:
/usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
  134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
      |            ^~~~~~~~~~~
  CC      util/jitdump.o
  CC      util/genelf.o
  CC      util/genelf_debug.o
cc1: all warnings being treated as errors
make[4]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:96: tests/bpf.o] Error 1
make[3]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:139: tests] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:7811,
                 from Context.xs:8:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘S_PerlEnv_putenv’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:295:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
  295 |     bool retval = putenv(str);
      |     ^~~~
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:3327:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_is_utf8_valid_partial_char_flags’:
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘STRLEN’ {aka ‘long unsigned int’} to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:2334:12: note: in expansion of macro ‘cBOOL’
 2334 |     return cBOOL(is_utf8_char_helper_(s0, e, flags));
      |            ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_newPADxVOP’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:3135:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 3135 |     OP *o = newOP(type, flags);
      |     ^~
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_cop_file_avn’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:3500:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 3500 |     const char *file = CopFILE(cop);
      |     ^~~~~
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:7812:
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h: In function ‘Perl_newSV_type’:
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_NULL’ not handled in switch [-Werror=switch-enum]
  420 |         switch(type) {
      |         ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_IV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_NV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_INVLIST’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVIV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVNV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVMG’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_REGEXP’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVGV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVLV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVCV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVFM’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVIO’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_LAST’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:383:5: error: enumeration value ‘SVt_LAST’ not handled in switch [-Werror=switch-enum]
  383 |     switch (type) {
      |     ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h: In function ‘Perl_sv_setpv_freshbuf’:
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4252:52: note: in expansion of macro ‘cBOOL’
 4252 | #define UNLIKELY(cond)                      EXPECT(cBOOL(cond),FALSE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1724:13: note: in expansion of macro ‘UNLIKELY’
 1724 |         if (UNLIKELY(TAINT_get))        \
      |             ^~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:996:34: note: in expansion of macro ‘cBOOL’
  996 | #   define TAINT_get            (cBOOL(UNLIKELY(PL_tainted)))    /* Is something tainted? */
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1724:22: note: in expansion of macro ‘TAINT_get’
 1724 |         if (UNLIKELY(TAINT_get))        \
      |                      ^~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:996:5: note: in expansion of macro ‘SvTAINT’
  996 |     SvTAINT(sv);
      |     ^~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4252:52: note: in expansion of macro ‘cBOOL’
 4252 | #define UNLIKELY(cond)                      EXPECT(cBOOL(cond),FALSE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1718:42: note: in expansion of macro ‘UNLIKELY’
 1718 | #define SvTAINTED_on(sv)  STMT_START{ if(UNLIKELY(TAINTING_get)){sv_taint(sv);}   }STMT_END
      |                                          ^~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:997:34: note: in expansion of macro ‘cBOOL’
  997 | #   define TAINTING_get         (cBOOL(UNLIKELY(PL_tainting)))
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1718:51: note: in expansion of macro ‘TAINTING_get’
 1718 | #define SvTAINTED_on(sv)  STMT_START{ if(UNLIKELY(TAINTING_get)){sv_taint(sv);}   }STMT_END
      |                                                   ^~~~~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1725:13: note: in expansion of macro ‘SvTAINTED_on’
 1725 |             SvTAINTED_on(sv);           \
      |             ^~~~~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:996:5: note: in expansion of macro ‘SvTAINT’
  996 |     SvTAINT(sv);
      |     ^~~~~~~
Context.c: In function ‘XS_Perf__Trace__Context_common_pc’:
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:2494:33: error: cast from function call of type ‘IV’ {aka ‘long int’} to non-matching type ‘struct scripting_context *’ [-Werror=bad-function-cast]
 2494 | #  define INT2PTR(any,d)        (any)(d)
      |                                 ^
Context.c:55:39: note: in expansion of macro ‘INT2PTR’
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4251:52: note: in expansion of macro ‘cBOOL’
 4251 | #define LIKELY(cond)                        EXPECT(cBOOL(cond),TRUE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:429:13: note: in expansion of macro ‘LIKELY’
  429 |         if (LIKELY(                                                     \
      |             ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:996:34: note: in expansion of macro ‘cBOOL’
  996 | #   define TAINT_get            (cBOOL(UNLIKELY(PL_tainted)))    /* Is something tainted? */
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:431:28: note: in expansion of macro ‘TAINT_get’
  431 |             & (do_taint ? !TAINT_get : 1)))                             \
      |                            ^~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:495:38: note: in expansion of macro ‘TARGi’
  495 | #define PUSHi(i)        STMT_START { TARGi(i,1); PUSHs(TARG); } STMT_END
      |                                      ^~~~~
Context.c:60:13: note: in expansion of macro ‘PUSHi’
Context.c: In function ‘XS_Perf__Trace__Context_common_flags’:
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:2494:33: error: cast from function call of type ‘IV’ {aka ‘long int’} to non-matching type ‘struct scripting_context *’ [-Werror=bad-function-cast]
 2494 | #  define INT2PTR(any,d)        (any)(d)
      |                                 ^
Context.c:78:39: note: in expansion of macro ‘INT2PTR’
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4251:52: note: in expansion of macro ‘cBOOL’
 4251 | #define LIKELY(cond)                        EXPECT(cBOOL(cond),TRUE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:429:13: note: in expansion of macro ‘LIKELY’
  429 |         if (LIKELY(                                                     \
      |             ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:996:34: note: in expansion of macro ‘cBOOL’
  996 | #   define TAINT_get            (cBOOL(UNLIKELY(PL_tainted)))    /* Is something tainted? */
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:431:28: note: in expansion of macro ‘TAINT_get’
  431 |             & (do_taint ? !TAINT_get : 1)))                             \
      |                            ^~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:495:38: note: in expansion of macro ‘TARGi’
  495 | #define PUSHi(i)        STMT_START { TARGi(i,1); PUSHs(TARG); } STMT_END
      |                                      ^~~~~
Context.c:83:13: note: in expansion of macro ‘PUSHi’
Context.c: In function ‘XS_Perf__Trace__Context_common_lock_depth’:
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:2494:33: error: cast from function call of type ‘IV’ {aka ‘long int’} to non-matching type ‘struct scripting_context *’ [-Werror=bad-function-cast]
 2494 | #  define INT2PTR(any,d)        (any)(d)
      |                                 ^
Context.c:101:39: note: in expansion of macro ‘INT2PTR’
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4251:52: note: in expansion of macro ‘cBOOL’
 4251 | #define LIKELY(cond)                        EXPECT(cBOOL(cond),TRUE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:429:13: note: in expansion of macro ‘LIKELY’
  429 |         if (LIKELY(                                                     \
      |             ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:996:34: note: in expansion of macro ‘cBOOL’
  996 | #   define TAINT_get            (cBOOL(UNLIKELY(PL_tainted)))    /* Is something tainted? */
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:431:28: note: in expansion of macro ‘TAINT_get’
  431 |             & (do_taint ? !TAINT_get : 1)))                             \
      |                            ^~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/pp.h:495:38: note: in expansion of macro ‘TARGi’
  495 | #define PUSHi(i)        STMT_START { TARGi(i,1); PUSHs(TARG); } STMT_END
      |                                      ^~~~~
Context.c:106:13: note: in expansion of macro ‘PUSHi’
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:7811,
                 from util/scripting-engines/trace-event-perl.c:35:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘S_PerlEnv_putenv’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:295:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
  295 |     bool retval = putenv(str);
      |     ^~~~
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:3327:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_is_utf8_valid_partial_char_flags’:
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘STRLEN’ {aka ‘long unsigned int’} to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:2334:12: note: in expansion of macro ‘cBOOL’
 2334 |     return cBOOL(is_utf8_char_helper_(s0, e, flags));
      |            ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_newPADxVOP’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:3135:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 3135 |     OP *o = newOP(type, flags);
      |     ^~
/usr/lib/perl5/5.38/core_perl/CORE/inline.h: In function ‘Perl_cop_file_avn’:
/usr/lib/perl5/5.38/core_perl/CORE/inline.h:3500:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 3500 |     const char *file = CopFILE(cop);
      |     ^~~~~
cc1: all warnings being treated as errors
In file included from /usr/lib/perl5/5.38/core_perl/CORE/perl.h:7812:
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h: In function ‘Perl_newSV_type’:
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_NULL’ not handled in switch [-Werror=switch-enum]
  420 |         switch(type) {
      |         ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_IV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_NV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_INVLIST’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVIV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVNV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVMG’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_REGEXP’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVGV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVLV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVCV’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVFM’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_PVIO’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:420:9: error: enumeration value ‘SVt_LAST’ not handled in switch [-Werror=switch-enum]
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:383:5: error: enumeration value ‘SVt_LAST’ not handled in switch [-Werror=switch-enum]
  383 |     switch (type) {
      |     ^~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h: In function ‘Perl_sv_setpv_freshbuf’:
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4252:52: note: in expansion of macro ‘cBOOL’
 4252 | #define UNLIKELY(cond)                      EXPECT(cBOOL(cond),FALSE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1724:13: note: in expansion of macro ‘UNLIKELY’
 1724 |         if (UNLIKELY(TAINT_get))        \
      |             ^~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:996:34: note: in expansion of macro ‘cBOOL’
  996 | #   define TAINT_get            (cBOOL(UNLIKELY(PL_tainted)))    /* Is something tainted? */
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1724:22: note: in expansion of macro ‘TAINT_get’
 1724 |         if (UNLIKELY(TAINT_get))        \
      |                      ^~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:996:5: note: in expansion of macro ‘SvTAINT’
  996 |     SvTAINT(sv);
      |     ^~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/handy.h:155:23: error: cast from function call of type ‘long int’ to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
  155 | #define cBOOL(cbool) ((bool) (cbool))
      |                       ^
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4231:62: note: in definition of macro ‘EXPECT’
 4231 | #  define EXPECT(expr,val)                  __builtin_expect(expr,val)
      |                                                              ^~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:4252:52: note: in expansion of macro ‘cBOOL’
 4252 | #define UNLIKELY(cond)                      EXPECT(cBOOL(cond),FALSE)
      |                                                    ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1718:42: note: in expansion of macro ‘UNLIKELY’
 1718 | #define SvTAINTED_on(sv)  STMT_START{ if(UNLIKELY(TAINTING_get)){sv_taint(sv);}   }STMT_END
      |                                          ^~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/perl.h:997:34: note: in expansion of macro ‘cBOOL’
  997 | #   define TAINTING_get         (cBOOL(UNLIKELY(PL_tainting)))
      |                                  ^~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1718:51: note: in expansion of macro ‘TAINTING_get’
 1718 | #define SvTAINTED_on(sv)  STMT_START{ if(UNLIKELY(TAINTING_get)){sv_taint(sv);}   }STMT_END
      |                                                   ^~~~~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv.h:1725:13: note: in expansion of macro ‘SvTAINTED_on’
 1725 |             SvTAINTED_on(sv);           \
      |             ^~~~~~~~~~~~
/usr/lib/perl5/5.38/core_perl/CORE/sv_inline.h:996:5: note: in expansion of macro ‘SvTAINT’
  996 |     SvTAINT(sv);
      |     ^~~~~~~
make[5]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:97: scripts/perl/Perf-Trace-Util/Context.o] Error 1
make[4]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:139: perl/Perf-Trace-Util] Error 2
make[3]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:139: scripts] Error 2
cc1: all warnings being treated as errors
make[5]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:96: util/scripting-engines/trace-event-perl.o] Error 1
make[4]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:139: scripting-engines] Error 2
make[3]: *** [/home/gregkh/linux/stable/linux-5.15.y/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:658: perf-in.o] Error 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/home/gregkh/linux/stable/linux-5.15.y/tools/perf'
