Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6177DA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbjHPGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbjHPGpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:45:23 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 23:45:18 PDT
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B6106
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:45:18 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 08:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1692167927; bh=k3hAS1+1iUHRo4wF4qzMKr8eVjEgtg4A9FhNt1C+7Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkKp/7kSJwpC3JF9oelvTR0XKeVr1yQJvs6ZWddq3ezHBRh+BxZs+mCh9B4r8Z/sI
         GlrrZ2Ih7l6xS6FDjZim+7LHSgCBe6tuIyox3rVX73aTMq1OWSd0t63SPosWYd3J4b
         k5IsgBpNznzKRp3APRMK6r9xHDaEpaCF/zsAbnvA=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 051AB80B02;
        Wed, 16 Aug 2023 08:38:47 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id EA30F181499; Wed, 16 Aug 2023 08:38:46 +0200 (CEST)
Date:   Wed, 16 Aug 2023 08:38:46 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     masahiroy@kernel.org, bgray@linux.ibm.com, ajd@linux.ibm.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC
 date
Message-ID: <ZNxu9rzBOT9IngKe@buildd.core.avm.de>
References: <ZMSdUS37BD5b/dn7@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMSdUS37BD5b/dn7@mail.google.com>
X-TUID: 67IYUJfzghpU
X-purgate-ID: 149429::1692167927-EB41228E-835C30AB/0/0
X-purgate-type: clean
X-purgate-size: 2691
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 05:02:09PM +1200, Paulo Miguel Almeida wrote:
> When KBUILD_BUILD_TIMESTAMP is specified, the date command will parse
> it to Unix Epoch time in UTC. However, the date command is
> timezone-aware so it will convert from the local timezone to UTC first
> which hits some of the sanity checks added on commit 5efb685bb3af1
> ("initramfs: Check negative timestamp to prevent broken cpio archive")
> 
> This creates an edge case for the UTC+<N> part of the world. For instance
> 
>  - In New Zealand (UTC+12:00):
> 	$ date -d"1970-01-01" +%s
> 	-43200
> 
> 	$ make KBUILD_BUILD_TIMESTAMP=1970-01-01
> 	make[1]: Entering directory '<snip>/linux/'
> 	  GEN     Makefile
> 	  DESCEND objtool
> 	  INSTALL libsubcmd_headers
> 	  CALL    ../scripts/checksyscalls.sh
> 	  GEN     usr/initramfs_data.cpio
> 	ERROR: Timestamp out of range for cpio format
> 	make[4]: *** [../usr/Makefile:76: usr/initramfs_data.cpio] Error 1
> 
>  - In Seattle, WA (UTC-07:00):
> 	$ date -d"1970-01-01" +%s
> 	32400
> 
> 	$ make KBUILD_BUILD_TIMESTAMP=1970-01-01
> 	<builds fine>
> 
> Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
> conversion is done which fixes the edge case aforementioned.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---

Thanks for the patch!

Looking at 1970-01-01 concretely, you could circumvent your reported
issue by using KBUILD_BUILD_TIMESTAMP="1970-01-01 UTC".  But I think you
found an interesting point w/ regard to reproducibility, as time zone is
neither mentioned in Documentation/kbuild/reproducibility.rst
nor in Documentation/kbuild/kbuild.rst but influences the output of
'date -d' (w/o '-u') (or comparable) calls in usr/gen_initramfs.sh as
well as in kernel/gen_kheaders.sh ('TZ=UTC tar'?) and possibly in
scripts/kernel-doc.

I think some might be suprised that giving a YYYY-MM-DD date to
KBUILD_BUILD_TIMESTAMP leads to an effectively different timestamp in
initramfs_data.cpio, but I think your change is still reasonable.

Reviewed-by: Nicolas Schier <n.schier@avm.de>


>  usr/gen_initramfs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 14b5782f961a..a90316d9a080 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -221,7 +221,7 @@ while [ $# -gt 0 ]; do
>  			shift
>  			;;
>  		"-d")	# date for file mtimes
> -			timestamp="$(date -d"$1" +%s || :)"
> +			timestamp="$(date -d"$1" -u +%s || :)"
>  			if test -n "$timestamp"; then
>  				timestamp="-t $timestamp"
>  			fi
> -- 
> 2.40.1
> 

-- 
Nicolas Schier
