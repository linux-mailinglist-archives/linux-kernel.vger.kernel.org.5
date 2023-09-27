Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABF7B0C91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjI0TeD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjI0Tdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:33:55 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1E0198;
        Wed, 27 Sep 2023 12:33:53 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 3FDD240E1A;
        Wed, 27 Sep 2023 19:33:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 4324135;
        Wed, 27 Sep 2023 19:33:47 +0000 (UTC)
Message-ID: <60df84ba0615a26b1d0523037961fb1e5154fb43.camel@perches.com>
Subject: Re: [PATCH 3/3] get_maintainer: add patch-only pattern matching type
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Wed, 27 Sep 2023 12:33:45 -0700
In-Reply-To: <202309270913.911E51C@keescook>
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
         <20230927-get_maintainer_add_d-v1-3-28c207229e72@google.com>
         <202309270913.911E51C@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: wzzjqh7dki85yc9js1zi79rtajcecaoj
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 4324135
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+AdXi6X+8sFMUeeQydWXCeSqTe2H6e5M4=
X-HE-Tag: 1695843227-82629
X-HE-Meta: U2FsdGVkX1/UULqkEz6aLDLy5IPrQ9XTIuN8jtw1LSnLV1B1wOA4djPYSikWYcSlAyjOySNHDvEbw1indOrjOIIWvvQ1KUIDFJpPsnnfrOi2JUIfb2bw/UQyknwzqXs837T62tM0FkaSKX94YDovP+ZrUtw9AHuPGjpxC5EGfkbSs/3N2/OnoRS/MX8lASbhF0wwBUL443I/Yvcq02b3oufTzIBwdaylzKoyjZJLYbWGk9ai4h/8EcL5BNsb3Ooa4m5L8/RO0n7CQOl0wFVUQT27cssvFPw0NuTFRKOYaZLAv3xBXExg4N6+h9mAUKcWH8x0LVXgNBmYsoVXyT+hknfFnQFMou6W7GWq8e+Cf2NQY2+e2egWHWM9O97AJl57mZeOoOWVDhZa9fdqUKifXgZtUU9wGUOzPHRNJJKPoWfYc2NJ6gUaG7fa0pqXb598
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 09:15 -0700, Kees Cook wrote:
> On Wed, Sep 27, 2023 at 03:19:16AM +0000, Justin Stitt wrote:
> > Add the "D:" type which behaves the same as "K:" but will only match
> > content present in a patch file.
> > 
> > To illustrate:
> > 
> > Imagine this entry in MAINTAINERS:
> > 
> > NEW REPUBLIC
> > M: Han Solo <hansolo@rebelalliance.co>
> > W: https://www.jointheresistance.org
> > D: \bstrncpy\b
> > 
> > Our maintainer, Han, will only be added to the recipients if a patch
> > file is passed to get_maintainer (like what b4 does):
> > $ ./scripts/get_maintainer.pl 0004-some-change.patch
> > 
> > If the above patch has a `strncpy` present in the subject, commit log or
> > diff then Han will be to/cc'd.
> > 
> > However, in the event of a file from the tree given like:
> > $ ./scripts/get_maintainer.pl ./lib/string.c
> > 
> > Han will not be noisily to/cc'd (like a K: type would in this
> > circumstance)
> > 
> > Note that folks really shouldn't be using get_maintainer on tree files
> > anyways [1].
> > 
> > [1]: https://lore.kernel.org/all/20230726151515.1650519-1-kuba@kernel.org/
> 
> As Greg suggested, please drop the above paragraph and link. Then this
> looks good to me.
> 
> I would immediately want to send this patch too, so please feel free to
> add this to your series (and I bet many other hints on "git grep 'K:.\\b'"
> would want to switch from K: to D: too):
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -5057,7 +5057,7 @@ F:	Documentation/kbuild/llvm.rst
>  F:	include/linux/compiler-clang.h
>  F:	scripts/Makefile.clang
>  F:	scripts/clang-tools/
> -K:	\b(?i:clang|llvm)\b
> +D:	\b(?i:clang|llvm)\b

etc...

My assumption is that the K: --file use is just unnecessary
and it'd be better to only use the K: lookup on patches.

(and I've somehow stuffed up the receiving side of my
 email configuration so please ignore any emails to me
 that bounce for a while)

