Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2297D990D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjJ0M4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJ0M4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:56:13 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43871AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:56:07 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SH2j11TNVzMqTT5;
        Fri, 27 Oct 2023 12:56:05 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SH2hz6f9bzMpnyv;
        Fri, 27 Oct 2023 14:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698411365;
        bh=QLUOoYYvr+Bp0vOk4oq52t6xX//eg65+2Kt6Rrj+F80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzqdC0uHeFaE/RAqamsgM3tIr2OvFxlVcZuqCExgD/dc6aTQT1bNtoZOxCJnlIBZ8
         u86WcEql0uIWVHlhJ1Cm30u13gnXd5iiuE6m+nZ0NNUfkE9CkddK6EEPWG4Kydns4l
         77wmyvAubvUdJaUV594E5b95euoekVDz1muoDMrw=
Date:   Fri, 27 Oct 2023 14:56:00 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the landlock tree
Message-ID: <20231027.Soon0Gee4xul@digikod.net>
References: <20231027163400.5764d549@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027163400.5764d549@canb.auug.org.au>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen, your patch is good! I tested it with the merge of my
branch and LSM/dev-staging.

The new Landlock changes (tested in -next for a few weeks) add a new
call to security_add_hooks() which gets a new signature with commit
9b09f11320db ("LSM: Identify modules by more than name") from
the LSM/dev-staging branch [1].

I plan to send a PR with my branch in the next merge window (for
v6.7-rc1).

We should squash Stephen's patch in commit 9b09f11320db ("LSM:
Identify modules by more than name") but it would not be possible
without my branch. I see two solutions:
* keep Stephen's patch in -next only, or
* rebase LSM/dev-staging on my branch now, and rebase it later on
  v6.7-rc1 once my branch is merged (which is the workflow described in
  [1]).

Paul, what do you think?

[1] https://lore.kernel.org/r/CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com

On Fri, Oct 27, 2023 at 04:34:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the landlock tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from security/landlock/net.c:14:
> security/landlock/net.c: In function 'landlock_add_net_hooks':
> security/landlock/common.h:12:23: error: passing argument 3 of 'security_add_hooks' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    12 | #define LANDLOCK_NAME "landlock"
>       |                       ^~~~~~~~~~
>       |                       |
>       |                       char *
> security/landlock/net.c:199:28: note: in expansion of macro 'LANDLOCK_NAME'
>   199 |                            LANDLOCK_NAME);
>       |                            ^~~~~~~~~~~~~
> In file included from security/landlock/setup.h:12,
>                  from security/landlock/cred.h:17,
>                  from security/landlock/net.c:15:
> include/linux/lsm_hooks.h:120:53: note: expected 'const struct lsm_id *' but argument is of type 'char *'
>   120 |                                const struct lsm_id *lsmid);
>       |                                ~~~~~~~~~~~~~~~~~~~~~^~~~~
> 
> Caused by commit
> 
>   fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> 
> interacting with commit
> 
>   9b09f11320db ("LSM: Identify modules by more than name")
> 
> from the security tree.
> 
> I have applied the following merge resolution patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Oct 2023 16:13:32 +1100
> Subject: [PATCH] fixup for "landlock: Support network rules with TCP bind and
>  connect"
> 
> interacting with "LSM: Identify modules by more than name"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  security/landlock/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index aaa92c2b1f08..efa1b644a4af 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -196,5 +196,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  __init void landlock_add_net_hooks(void)
>  {
>  	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
> -			   LANDLOCK_NAME);
> +			   &landlock_lsmid);
>  }
> -- 
> 2.40.1
> 
> -- 
> Cheers,
> Stephen Rothwell


