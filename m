Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEF801174
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378656AbjLARB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjLARBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:01:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF9106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:02:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94609C433C8;
        Fri,  1 Dec 2023 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701450120;
        bh=y7kiPIdMJ/eHRHRKfNv778aTflt1jqgDvDpBOIx25i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qk7/+MmhgtRaOSV3nMg2hBe9LMIviJrooLIwyhArHVbQegd6wgxG7ggpgUri5+FF9
         SIs8mNRQqX1iDqAWeRcRoQXWYA6nCSDkQUtvllR7KSQrW3tJQxyJ+t+DT0RmPu2UVl
         PenZWXCm30cBL4KiL8L2KHCrEnrVFjLvPx7HaaQJLklVmuhRkEftssFwPzIYS2aKn8
         cm8AHoOou/Z8Ol8u/e/Cb9cQ0HSbjT94qaR5WcweEtHlRA8suG3K79jT21HcJfIhBO
         nZuNVlEpPS2lenVtkdIj9sgCnltzmtV7m01UMKotFlWjb/JW7ALin/eLabr6eaxUEK
         0Aa6we3I13Kyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAD9340094; Fri,  1 Dec 2023 14:01:57 -0300 (-03)
Date:   Fri, 1 Dec 2023 14:01:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it
 isn't available in busybox
Message-ID: <ZWoRhbyvClv0TffR@kernel.org>
References: <ZWkEeqdmCHMLhLr2@kernel.org>
 <ecad5dffa8474ed8a5367e917610e707@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecad5dffa8474ed8a5367e917610e707@AcuMS.aculab.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 01, 2023 at 12:05:31PM +0000, David Laight escreveu:
> ...
> >  # Create list of architectures that have a specific errno.h.
> >  archlist=""
> > -for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
> > +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d | while read arch ; do basename
> > $arch ; done | sort -r); do
> >  	test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
> >  done
> 
> Jeepers ...
> Does this work?
> 	for f in $toolsdir/arch/*/include/uapi/asm/errno.h; do
> 		[ ! -f $f ] && break
> 		d=${f%/include/uapi/asm/errno.h}
> 		archlist="${d##*/} $archlist"
> 	done
> No fork()s or exec()s.
> I think it only differs in having a trailing space instead of a leading one.

⬢[acme@toolbox perf-tools-next]$ for f in tools/arch/*/include/uapi/asm/errno.h; do d=${f%/include/uapi/asm/errno.h} ; arch="${d##*/}" ; echo "'$arch'" ; done
'alpha'
'mips'
'parisc'
'powerpc'
'sparc'
'x86'
⬢[acme@toolbox perf-tools-next]$ for arch in $(find tools/arch -maxdepth 1 -mindepth 1 -type d | while read arch ; do basename $arch ; done | sort -r) ; do test -f tools/arch/$arch/include/uapi/asm/errno.h && echo "'$arch'" ; done
'x86'
'sparc'
'powerpc'
'parisc'
'mips'
'alpha'
⬢[acme@toolbox perf-tools-next]$

There was a reason for having x86 first, lemme dig it... Just to have
as the first strcmp in:

const char *arch_syscalls__strerrno(const char *arch, int err)
{
        if (!strcmp(arch, "x86"))
                return errno_to_name__x86(err);
        if (!strcmp(arch, "sparc"))
                return errno_to_name__sparc(err);
        if (!strcmp(arch, "powerpc"))
                return errno_to_name__powerpc(err);
        if (!strcmp(arch, "parisc"))
                return errno_to_name__parisc(err);
        if (!strcmp(arch, "mips"))
                return errno_to_name__mips(err);
        if (!strcmp(arch, "alpha"))
                return errno_to_name__alpha(err);
        return errno_to_name__generic(err);
}

But that is a weak reason, we better make users resolve the right
errno_to_name__$arch() pointer just once and use it without that strcmp.

Will do it in a follow up patch.

Thanks, the resulting diff is below, but I'll first do changes that will
remove the need for arch_syscalls__strerrno.

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 3ec8781344db13ba..b6e0767b4b34e46a 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -76,7 +76,9 @@ EoHEADER
 
 # Create list of architectures that have a specific errno.h.
 archlist=""
-for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d | while read arch ; do basename $arch ; done | sort -r); do
+for f in $toolsdir/arch/*/include/uapi/asm/errno.h; do
+	d=${f%/include/uapi/asm/errno.h}
+	arch="${d##*/}"
 	test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
 done
 


