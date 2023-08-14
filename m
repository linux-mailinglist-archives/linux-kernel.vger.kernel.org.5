Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602377BA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjHNNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjHNNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:36:12 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D9010C6;
        Mon, 14 Aug 2023 06:35:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 383902DC;
        Mon, 14 Aug 2023 13:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 383902DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692020158; bh=TTfv8kyCp+lhTXNlRfFTNBLGGFbAUEW/7RUG2jpU/lA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jzVnUWEeH0OBts9ZGWMVY16Ee4OZCCdCOllpzYuGjxL2jP5/bu/ssntiDH3y3nvBD
         O3PU2D2PG03RjZqrNKvt0hHAsxKlebT0FKBtNE/5Einys6RC8fL2/mhuV+4ZsRS4Fi
         a1tBF3Z1jeSC7fr59WzGvWbWK1SuGttXXinXdOHWPlQWz4sI56/PIeLxA0Y4CjzO+2
         ipWPJPL3ZqW9/aCH+MxhAoy+aOiUadLGpDgZCdmtKaZdyBmbaivIebZ0tAxxcYZFZ3
         E0jRRBCVYi/gt/OkTIVEJjmnRO4NkzwPhEVjRXQMcDpQP8jdRna6CNq6uqF2JPhGW6
         uiKiS9d0+HSXg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        jan.kiszka@siemens.com, kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: Re: [PATCH 2/8] Documentation/sphinx: fix Python string escapes
In-Reply-To: <20230814060704.79655-3-bgray@linux.ibm.com>
References: <20230814060704.79655-1-bgray@linux.ibm.com>
 <20230814060704.79655-3-bgray@linux.ibm.com>
Date:   Mon, 14 Aug 2023 07:35:57 -0600
Message-ID: <87jztxwxtu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Gray <bgray@linux.ibm.com> writes:

> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
>
> Fix these now to get ahead of it before it's an error.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  Documentation/sphinx/cdomain.py             | 2 +-
>  Documentation/sphinx/kernel_abi.py          | 2 +-
>  Documentation/sphinx/kernel_feat.py         | 2 +-
>  Documentation/sphinx/kerneldoc.py           | 2 +-
>  Documentation/sphinx/maintainers_include.py | 8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)

So I am the maintainer for this stuff...is there a reason you didn't
copy me on this work?

> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
> index ca8ac9e59ded..dbdc74bd0772 100644
> --- a/Documentation/sphinx/cdomain.py
> +++ b/Documentation/sphinx/cdomain.py
> @@ -93,7 +93,7 @@ def markup_ctype_refs(match):
>  #
>  RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
>  def markup_c_expr(match):
> -    return '\ ``' + match.group(2) + '``\ '
> +    return '\\ ``' + match.group(2) + '``\\ '

I have to wonder about this one; I doubt the intent was to insert a
literal backslash.  I have to fire up my ancient build environment to
even try this, but even if it's right...

>  #
>  # Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> index b5feb5b1d905..b9f026f016fd 100644
> --- a/Documentation/sphinx/kernel_abi.py
> +++ b/Documentation/sphinx/kernel_abi.py
> @@ -138,7 +138,7 @@ class KernelCmd(Directive):
>                  code_block += "\n    " + l
>              lines = code_block + "\n\n"
>  
> -        line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
> +        line_regex = re.compile("^\\.\\. LINENO (\\S+)\\#([0-9]+)$")

All of these really just want to be raw strings - a much more minimal
fix that makes the result quite a bit more readable:

     line_regex = re.compile(r"^\.\. LINENO (\S+)\#([0-9]+)$")
                             ^
                             |
  ---------------------------+

That, I think, is how these should be fixed.

Thanks,

jon
