Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C5803B01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjLDQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLDQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:59:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F427B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:59:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5FC433C8;
        Mon,  4 Dec 2023 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709162;
        bh=HsRSNN6CpvmvZAZ4yUoTzbjW0yuOeGGx/khxv4eeGtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=didfVJq6y/6VNbAau4ux2zMDTvbk3bR1iCMcgr2s7RSHUt7Plq0+NIfgG+QGn0sVq
         USjAh5l0Cy6smgZwKWSI4he5ofSZLKwjFYpJZUKFMXt29Q8W96SgYuguTd5ruv978n
         3VCYNsJcW/jGfNNsJQFAJlk+OeF+6dESEMS2XXo/xQCWYipcGRZlkL4xjF9lSNLWxR
         cvj/4S6wlmf0//Sq0RbjpmrgBYKouefqpankUA5aeytIdMTQAhhrDMs4Kio+5fDs6n
         zlfzMHXtmHQO0AeX3IJKZAI2pku39SJmepOsQUhQCqMMF/9Z1WpRCKukQt987+KeG1
         cdtcCSbcC9cAQ==
Date:   Mon, 4 Dec 2023 09:59:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jialu Xu <xujialu@vimux.org>
Cc:     ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_compile_commands.py: fix path resolve with symlinks
 in it
Message-ID: <20231204165920.GA16980@dev-arch.thelio-3990X>
References: <20231204104141.3618547-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204104141.3618547-1-xujialu@vimux.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:41:42PM +0800, Jialu Xu wrote:
> When symbolic links are involved in the path, os.path.abspath might not
> resolve the symlinks and instead return the absolute path with the
> symlinks intact.

Can you provide an example or more detailed description of how this
behavior is currently broken? I can't really understand how having
symlinks in the path after normalization would break anything but I am
potentially missing something :)

> use pathlib.Path resolve() instead of os.path.abspath()
> 
> Signed-off-by: Jialu Xu <xujialu@vimux.org>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 180952fb91c1b..0a6c0996b4a8f 100755
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
> @@ -172,8 +173,8 @@ def process_line(root_directory, command_prefix, file_path):
>      # by Make, so this code replaces the escaped version with '#'.
>      prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
>  
> -    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
> -    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
> +    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
> +    abs_path = str(Path(os.path.join(root_directory, file_path)).resolve())

I think this can be more simply:

    abs_path = str(Path(root_directory, file_path).resolve())

I think there should be a comment around why we are creating a Path
object then creating a string from it, rather than using the Path object
directly, namely that PosixPath is not JSON serializable.

>      if not os.path.exists(abs_path):
>          raise ValueError('File %s not found' % abs_path)
>      return {
> -- 
> 2.39.2
> 
