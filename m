Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF8785816
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjHWMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjHWMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:51:57 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 05:51:52 PDT
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D11E50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:51:52 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RW5WV3VT3zMqf5G;
        Wed, 23 Aug 2023 12:44:22 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RW5WT21vXz3b;
        Wed, 23 Aug 2023 14:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692794662;
        bh=OHYmJcKUIjYzDqHlAvxOZogSZbXprhogmIYhLAnLMq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTf9byPj/+Mgy/55YYKJAIhzkShM+IJENFodina+qEBi5ozLV7jX1yPK7sr8LLmXg
         kZ8XP4MoPUexJPj8urC1pkpCIVx4/1OMVqVfulBaYTG8JRKvJXIyj0tvip8mZC09Tr
         W9plt9A1uKambxAkui0riCGb5LZriJpqBwV2Q3p8=
Date:   Wed, 23 Aug 2023 14:44:19 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'sb' parameter in security_sb_remount()
Message-ID: <20230823.xeiYoo3BuPhu@digikod.net>
References: <ZOXIjzLnnbuoLOrF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXIjzLnnbuoLOrF@gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

On Wed, Aug 23, 2023 at 01:51:27PM +0500, Khadija Kamran wrote:
> The "sb_remount" hook has implementations registered in SELinux and
> Landlock. Looking at the function implementations we observe that the
> "sb" parameter is not changing.
> 
> Mark the "sb" parameter of LSM hook security_sb_remount() as "const"
> since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 2 +-
>  security/landlock/fs.c        | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 1c0c198f6fdb..fabe324922ec 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1074,7 +1074,7 @@ static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
>  	return -EPERM;
>  }
>  
> -static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
> +static int hook_sb_remount(const struct super_block *const sb, void *const mnt_opts)

Please format with clang-format -i security/landlock/*.[ch]

>  {
>  	if (!landlock_get_current_domain())
>  		return 0;
