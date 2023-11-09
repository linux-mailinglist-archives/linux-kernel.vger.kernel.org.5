Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACCE7E7266
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbjKITeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKITeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:34:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20A13ABA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:34:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B48C433CA;
        Thu,  9 Nov 2023 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699558445;
        bh=HangeVUVmhwWRN8WVmsyQOCqs3wh0FV9a/LAuVniz0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVDUDSs8mVb3YVHbhPaym+QrVeY/3M37kd3WYfp7G5n4hwb+SNJ9QNFmKaL4/Om/h
         1SU916cCeATq2KW92OURxz7jx53mK67hfVoAQRxXusc75JNcF1heSvKuPNOUp1jV9k
         s19UPPlfaR3vSoOT+UgwFmV+aHuz9oeik+/53qxkROKZyqJZKJcDz3pArCahIxQHbw
         TTYhzr5K6mSgH2IX2fS9jy8wtB1mcZO8c/xPRYs50f41vANGbWbv7nkomr46uVt9hj
         y4clVZBJpzLgxHVnbFOXopA1kGTfgyn1VlfdLtOVKU8CD/lIJ42K1neaH1hogP0Mgx
         qZcGkxbrKO8pQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8C06D40094; Thu,  9 Nov 2023 16:34:02 -0300 (-03)
Date:   Thu, 9 Nov 2023 16:34:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/5] perf tools: Add get_unaligned_leNN()
Message-ID: <ZU00KlJHTQ1Z7w+1@kernel.org>
References: <20231005190451.175568-1-adrian.hunter@intel.com>
 <20231005190451.175568-2-adrian.hunter@intel.com>
 <ZR8QnasisGEsaaDR@kernel.org>
 <ZTptUSQkDYujx9/T@kernel.org>
 <7c5b626c-1de9-4c12-a781-e44985b4a797@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5b626c-1de9-4c12-a781-e44985b4a797@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 26, 2023 at 07:09:26PM +0300, Adrian Hunter escreveu:
> On 26/10/23 16:44, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 05, 2023 at 04:38:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Oct 05, 2023 at 10:04:47PM +0300, Adrian Hunter escreveu:
> >>> Add get_unaligned_le16(), get_unaligned_le32 and get_unaligned_le64, same
> >>> as include/asm-generic/unaligned.h.
> >>>
> >>> Use diagnostic pragmas to ignore -Wpacked used by perf build.
> >>
> >> Can we get the tools copy of include/asm-generic/unaligned.h closer and
> >> have it in check-headers.sh?
> > 
> > And this is not building when cross building to mips, mips64 and mipsel
> > on debian:experimental:
> > 
> > In file included from util/intel-pt-decoder/intel-pt-pkt-decoder.c:10:
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le16':
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
> 
> So I guess another diagnostic pragma is needed, perhaps the following works?
> 
> #pragma GCC diagnostic ignored "-Wattributes"

Yeah, I tested with this and it works, I'll add a patch with your
Suggested-by, ok?

- Arnaldo
 
> 
> >    13 |         const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
> >       |                             ^
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:28: note: in expansion of macro '__get_unaligned_t'
> >    27 |         return le16_to_cpu(__get_unaligned_t(__le16, p));
> >       |                            ^~~~~~~~~~~~~~~~~
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le32':
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
> >    13 |         const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
> >       |                             ^
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:32:28: note: in expansion of macro '__get_unaligned_t'
> >    32 |         return le32_to_cpu(__get_unaligned_t(__le32, p));
> >       |                            ^~~~~~~~~~~~~~~~~
> > 
> > 
> > Ditto for some other distros when cross building on ubuntu:18.04
> > 
> >   MKDIR   /tmp/build/perf/util/perf-regs-arch/
> > In file included from /usr/sparc64-linux-gnu/include/bits/byteswap.h:34:0,
> >                  from /usr/sparc64-linux-gnu/include/endian.h:60,
> >                  from util/intel-pt-decoder/intel-pt-pkt-decoder.c:9:
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le16':
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:22: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
> >   const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr); \
> >                       ^
> > /git/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:21: note: in expansion of macro '__get_unaligned_t'
> >   return le16_to_cpu(__get_unaligned_t(__le16, p));
> >                      ^~~~~~~~~~~~~~~~~
> > 
> >   37    14.17 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >   38    13.56 ubuntu:18.04-x-arm64          : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >   42    12.70 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >   44    13.95 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >   45    13.08 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >  
> >> - Arnaldo
> >>  
> >>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> ---
> >>>  tools/include/asm-generic/unaligned.h | 20 ++++++++++++++++++++
> >>>  1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
> >>> index 47387c607035..9140bb4e16c6 100644
> >>> --- a/tools/include/asm-generic/unaligned.h
> >>> +++ b/tools/include/asm-generic/unaligned.h
> >>> @@ -6,6 +6,9 @@
> >>>  #ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> >>>  #define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> >>>  
> >>> +#pragma GCC diagnostic push
> >>> +#pragma GCC diagnostic ignored "-Wpacked"
> >>> +
> >>>  #define __get_unaligned_t(type, ptr) ({						\
> >>>  	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> >>>  	__pptr->x;								\
> >>> @@ -19,5 +22,22 @@
> >>>  #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
> >>>  #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
> >>>  
> >>> +static inline u16 get_unaligned_le16(const void *p)
> >>> +{
> >>> +	return le16_to_cpu(__get_unaligned_t(__le16, p));
> >>> +}
> >>> +
> >>> +static inline u32 get_unaligned_le32(const void *p)
> >>> +{
> >>> +	return le32_to_cpu(__get_unaligned_t(__le32, p));
> >>> +}
> >>> +
> >>> +static inline u64 get_unaligned_le64(const void *p)
> >>> +{
> >>> +	return le64_to_cpu(__get_unaligned_t(__le64, p));
> >>> +}
> >>> +
> >>> +#pragma GCC diagnostic pop
> >>> +
> >>>  #endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
> >>>  
> >>> -- 
> >>> 2.34.1
> >>>
> >>
> >> -- 
> >>
> >> - Arnaldo
> > 
> 

-- 

- Arnaldo
