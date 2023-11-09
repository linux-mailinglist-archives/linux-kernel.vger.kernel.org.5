Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87D07E727B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjKITxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjKITxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:53:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E4E8;
        Thu,  9 Nov 2023 11:53:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133A3C433C8;
        Thu,  9 Nov 2023 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699559586;
        bh=eAfm4jAdWpAXm0xg4wBaDhMAGvKxNe8hlm3McaGXMf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuPJoQsg2Nluh0hA+Awn6vBxF6boxnJ7ydExYFFOVWg2sB6K9eZVG8GPu2LcjsGNl
         vTiLy++iGkUNmysdr0UCj9lz9fEA4le75nTDmdbNz79OXlBMwy5LqNEjZEeQUU5RjM
         YxFnKqQPlkuoLljFu/nCHvhrGQDjuvkL/qe90CaKd8JzYHfzIk7YMZGpi1gF8hUE9f
         cX1aXPf5je9EJqGaP6EP/Dbi8uXBd8+oSWji6kS8bTrsSs4ddbPfEb4Wtz9O4uTsfP
         veo0q5OPpyP3dcZSEejTNcCkv21k1REON1pIMvaRsXF4Rx9UDecCCirBqdLpyShntN
         rAr7gTxDobOZQ==
Date:   Thu, 9 Nov 2023 11:53:04 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Indu Bhagat <indu.bhagat@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Message-ID: <20231109195304.m4sghaxx66al4wlt@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
 <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
 <20231109193759.6wugcdpucoilnncl@treble>
 <20231109144956.0c20fd98@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109144956.0c20fd98@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 02:49:56PM -0500, Steven Rostedt wrote:
> On Thu, 9 Nov 2023 11:37:59 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > > The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We
> > > fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as you
> > > have already noted. For x86_64, its not an issue though, yes.  
> > 
> > Agreed.  I actually had v2 implemented but then realized my binutils was
> > older so I changed to v1 for testing.  But yeah, we can make v2 the
> > minimum.
> 
> Cool, my test box has binutils 2.41, so it should be good to go ;-)

You'll need something like this (untested!)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index b167c19497e5..f8b2a520a689 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -142,10 +142,8 @@ static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
 				break;
 		} else {
 			/* SFRAME_FDE_TYPE_PCMASK */
-#if 0 /* sframe v2 */
 			if (ip_off % fde->rep_size < fre_ip_off)
 				break;
-#endif
 		}
 
 		SFRAME_GET_USER_UNSIGNED(fre_info, f, 1);
@@ -304,7 +302,7 @@ int __sframe_add_section(struct sframe_file *file)
 		return -EFAULT;
 
 	if (shdr.preamble.magic != SFRAME_MAGIC ||
-	    shdr.preamble.version != SFRAME_VERSION_1 ||
+	    shdr.preamble.version != SFRAME_VERSION_2 ||
 	    (!shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
 	    shdr.fdes_off > shdr.fres_off) {
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index 1f91b696daf5..1adfc88b784d 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -125,10 +125,8 @@ struct sframe_fde {
 	u32 fres_off;
 	u32 fres_num;
 	u8  info;
-#if 0 /* TODO sframe v2 */
 	u8  rep_size;
 	u16 padding;
-#endif
 } __packed;
 
 /*
