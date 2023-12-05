Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88696805BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjLEQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjLEQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:56:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3D1B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:56:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FD1C433C8;
        Tue,  5 Dec 2023 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795410;
        bh=vnVlZzqZdVGwXpKfqdKy0p7fnqLtksgs6J1ySIaSR9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYk14YHqwKu/eQeU5wvHKIl9+iR73IzAs5hZk7hrajH5Fs7/jfaxhNuguireTAqgg
         NPxTRIdxGIMIn8lXXWqQaHOHfZGE4uNcMJ4SrZ0oU87SPTIqK3tEhZlgYHZSi1SkwN
         QxXWMl1Yb+rbgU5mSsOwLfjdCYQl9+0FVwvSWyXkG506yjZA/lqErMy+uhPXtFwcLF
         O8i7eVKSgLWBuKoZhyO1A38bJMBH8L+b403kvRSSpLOGR0NMIqN2lumxAIG52teTkS
         bZteHHYuDnXknMPNrKxiwySMgtSVEyhb483Y4oxSOsB7lrLLcgnEL12hwlVhgEJZr7
         fiPENfQVHPKdA==
Date:   Tue, 5 Dec 2023 09:56:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jialu Xu <xujialu@vimux.org>
Cc:     ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gen_compile_commands.py: fix path resolve with
 symlinks in it
Message-ID: <20231205165648.GA391810@dev-arch.thelio-3990X>
References: <20231204165920.GA16980@dev-arch.thelio-3990X>
 <20231205021523.4152128-2-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205021523.4152128-2-xujialu@vimux.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jialu,

On Tue, Dec 05, 2023 at 10:15:26AM +0800, Jialu Xu wrote:
> When symbolic links are involved in the path, os.path.abspath might not
> resolve the symlinks and instead return the absolute path with the
> symlinks intact.
> 
> Use pathlib.Path resolve() instead of os.path.abspath()
> 
> Signed-off-by: Jialu Xu <xujialu@vimux.org>

Thanks for the clarification in your previous message [1], I suppose
that makes sense as to why nobody has reported this to us because that
is a rather odd situation that the upstream kernel would not experience.

I think that some of those details should be in the commit message,
along with a short example like you provided, so that we know exactly
what the situation was and how this patch resolves it.

Perhaps something like (please feel free to correct or reword as you
feel necessary):

"When a path contains relative symbolic links, os.path.abspath() might
not follow the symlinks and instead return the absolute path with just
the relative paths resolved, resulting in an incorrect path.

<broken example>

Use pathlib.Path.resolve(), which resolves the symlinks and normalizes
the paths correctly.

<working example>"

The actual fix seems fine to me. Feel free to add

  Reviewed-by: Nathan Chancellor <nathan@kernel.org>

to the subsequent submission and please include both

  Masahiro Yamada <masahiroy@kernel.org>
  linux-kbuild@vger.kernel.org

on it in addition to the people you have here, as he is the one who
actually applies gen_compile_commands.py changes (I am going to send a
MAINTAINERS change for this).

[1]: https://lore.kernel.org/20231205021523.4152128-1-xujialu@vimux.org/

Cheers,
Nathan

> ---
>  scripts/clang-tools/gen_compile_commands.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 180952fb91c1b..99e28b7152c19 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -11,6 +11,7 @@ import argparse
>  import json
>  import logging
>  import os
> +from pathlib import Path
>  import re
>  import subprocess
>  import sys
> @@ -172,8 +173,9 @@ def process_line(root_directory, command_prefix, file_path):
>      # by Make, so this code replaces the escaped version with '#'.
>      prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
>  
> -    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
> -    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
> +    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
> +    # Convert Path object to a string because 'PosixPath' is not JSON serializable.
> +    abs_path = str(Path(root_directory, file_path).resolve())
>      if not os.path.exists(abs_path):
>          raise ValueError('File %s not found' % abs_path)
>      return {
> -- 
> 2.39.2
> 
> 
