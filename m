Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5117884DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbjHYKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjHYKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:25:27 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918992689
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:25:02 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 25 Aug 2023 12:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1692959041; bh=2rnHvOPgsvKYbBiLLEwFMNGH7uF/YJHrz/RlvrfDtCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DC25E/+sCQH6l9klBzlq/VgUo9hVVMaX98Z6ihm3oZyAUnmr7ldN+5DseXKy2swIw
         tBQS7xwZP6dyzMk/EsvOQvYL3Sovf6aGHfBQkQJoQR0Qp23FwjHbw12H+olrunEcqi
         iT8uln7laOGYN4g+abq1GI9I3kNbWq1LOM+cggK8=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 71EA381C29;
        Fri, 25 Aug 2023 12:24:01 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 66E03180DA0; Fri, 25 Aug 2023 12:24:01 +0200 (CEST)
Date:   Fri, 25 Aug 2023 12:24:01 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     masahiroy@kernel.org, bgray@linux.ibm.com, ajd@linux.ibm.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH v2] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC
 date
Message-ID: <ZOiBQaPiWj0FqCLM@buildd.core.avm.de>
References: <ZOPTbkHvj8XQiott@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOPTbkHvj8XQiott@mail.google.com>
X-purgate-ID: 149429::1692959041-3FB0A28E-915A8AB7/0/0
X-purgate-type: clean
X-purgate-size: 3145
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:13:18AM +1200, Paulo Miguel Almeida wrote:
> When KBUILD_BUILD_TIMESTAMP is specified, the date command will parse
> it to Unix Epoch time in UTC. However, the date command is
> timezone-aware so it will convert from the local timezone to UTC first
> which hits some of the sanity checks added on commit 5efb685bb3af1
> ("initramfs: Check negative timestamp to prevent broken cpio archive")
> 
> This creates an edge case for the UTC+<N> part of the world. For instance
> 
>  - In New Zealand (UTC+12:00):
>      $ date -d"1970-01-01" +%s
>      -43200
> 
>      $ make KBUILD_BUILD_TIMESTAMP=1970-01-01
>      make[1]: Entering directory '<snip>/linux/'
>        GEN     Makefile
>        DESCEND objtool
>        INSTALL libsubcmd_headers
>        CALL    ../scripts/checksyscalls.sh
>        GEN     usr/initramfs_data.cpio
>      ERROR: Timestamp out of range for cpio format
>      make[4]: *** [../usr/Makefile:76: usr/initramfs_data.cpio] Error 1
> 
>  - In Seattle, WA (UTC-07:00):
>      $ date -d"1970-01-01" +%s
>      32400
> 
>      $ make KBUILD_BUILD_TIMESTAMP=1970-01-01
>      <builds fine>
> 
> Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
> conversion is done, which fixes the edge case aforementioned
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> 
> - v2: Document behaviour and way to override it on
>       Documentation/kbuild/kbuild.rst. (Req: Andrew Donnellan)
> 
> - v1: https://lore.kernel.org/lkml/ZMSdUS37BD5b%2Fdn7@mail.google.com/
> ---
>  Documentation/kbuild/kbuild.rst | 9 ++++++++-
>  usr/gen_initramfs.sh            | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index bd906407e307..8c204186c762 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -296,7 +296,14 @@ KBUILD_BUILD_TIMESTAMP
>  Setting this to a date string overrides the timestamp used in the
>  UTS_VERSION definition (uname -v in the running kernel). The value has to
>  be a string that can be passed to date -d. The default value
> -is the output of the date command at one point during build.
> +is the output of the date command at one point during build. E.g.::
> +
> +    $ make KBUILD_BUILD_TIMESTAMP="1991-08-25"
> +
> +By default, the value is interpreted as UTC. To override this, append
> +the desired timezone. E.g.::

This is still not true for IKHEADERS; there we still need to set TZ=UTC:

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -85,3 +85,3 @@ find $cpio_dir -type f -print0 |
 # Create archive and try to normalize metadata for reproducibility.
-tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+TZ=UTC tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
     --owner=0 --group=0 --sort=name --numeric-owner \

but I can send such a patch later.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
