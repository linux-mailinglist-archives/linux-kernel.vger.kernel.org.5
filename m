Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480378E2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbjH3XBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbjH3XA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:00:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C92D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:00:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso1448355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693436438; x=1694041238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqxu+tFGh9Jqwxve6bfR96NTIDgvY/0bBwoU0szPzAI=;
        b=UdW4HQmCkXD9J3Sr2vSlTVqKsGeeJsj9XQSiEToN/QNMLvqP8DV89WxPP3xCvN8czM
         Ww2FXm5+fizzaVk8QINMPMlqmsgbDMweYY7rJM+AmLaFKVRS95w3osim3e8RbV8mHSYq
         0ZI2Hk2Sal5e/6V1AnmehvOs5ccK6+ZEGc/rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436438; x=1694041238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqxu+tFGh9Jqwxve6bfR96NTIDgvY/0bBwoU0szPzAI=;
        b=FxUVir8c0rIxSs+bOSF2CGIm1Dt1YFtWqe1CEnGzLmRwnXAsYSHjE3ka6iLBdyP990
         VL9avW08IkHKn0s9dXDDOuLspg0+7exk6nyIXqCuqlA3UlmD5FycZYWfxQOpVpHtFLD3
         5ugtnh5OCx1Qn/dOfRf63jPZfEMbaA1tx1odAkk9C567FJCypMTX62SniISkGKlLh/fh
         c1+W8h6qp96IKqDQZL+25bibG3BuFZQQz3T9vEQUJhG+p5LZHa0U8ehrMVVx9tvL2fQe
         xo9Sq89A3gWrvr/C37mMJ5pvU73LEF75aCZgpNjCE6lTCNjJRAYrJfDqYJQ2CcxKBtyD
         Yl1Q==
X-Gm-Message-State: AOJu0Yxnd2m4QpKoPByt/jImnh7spRY7COuJS/H1RmESfGaI66WuQPPD
        pLcH2RVgEUuGaH92LLhThL20aA==
X-Google-Smtp-Source: AGHT+IH5AprVacmHqYm3RuV5CCezVz/DJRyjbaoRrsUaqcqdsLDSojkrt58gIYwBMHkpfshuHjj+oA==
X-Received: by 2002:a17:903:2349:b0:1b8:90bd:d157 with SMTP id c9-20020a170903234900b001b890bdd157mr4044458plh.26.1693436438271;
        Wed, 30 Aug 2023 16:00:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001b81a97860asm28420plh.27.2023.08.30.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:00:37 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:00:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/2] ocfs2: Replace module_param_call with module_param_cb
Message-ID: <202308301546.5C789E5EC@keescook>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
 <20230830215426.4181755-2-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830215426.4181755-2-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:54:25PM +0000, Azeem Shaikh wrote:
> module_param_call has been marked obsolete [1], so replacing its usage with
> module_param_cb instead.
> 
> [1] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L296
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 81265123ce6c..33e529de93b2 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -83,8 +83,11 @@ static int param_get_dlmfs_capabilities(char *buffer,
>  	return strlcpy(buffer, DLMFS_CAPABILITIES,
>  		       strlen(DLMFS_CAPABILITIES) + 1);
>  }
> -module_param_call(capabilities, param_set_dlmfs_capabilities,
> -		  param_get_dlmfs_capabilities, NULL, 0444);
> +static const struct kernel_param_ops dlmfs_capabilities_ops = {
> +	.set = param_set_dlmfs_capabilities,
> +	.get = param_get_dlmfs_capabilities,
> +};
> +module_param_cb(capabilities, &dlmfs_capabilities_ops, NULL, 0444);
>  MODULE_PARM_DESC(capabilities, DLMFS_CAPABILITIES);

Oh, hm. Yeah, that's not good documentation. It was originally added in
9bbb9e5a33109b2832e2e63dcc7a132924ab374b, but that was doing some
casting and other things during the conversion to an ops structure.

I cleaned up all the last of those back in 2017, and I should have
dropped the "Obsolete" comment:
ece1996a21eeb344b49200e627c6660111009c10
b2f270e8747387335d80428c576118e7d87f69cc

The resulting patch you sent ends up literally open coding what it
already does...

#define module_param_call(name, _set, _get, arg, perm)                  \
        static const struct kernel_param_ops __param_ops_##name =       \
                { .flags = 0, .set = _set, .get = _get };               \
        __module_param_call(MODULE_PARAM_PREFIX,                        \
                            name, &__param_ops_##name, arg, perm, -1, 0)

#define module_param_cb(name, ops, arg, perm)                                 \
        __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)

Looking at usage, it's still common:

$ git grep '^module_param_call(' | wc -l
54
$ git grep '^module_param_cb(' | wc -l
93

And the users of module_param_cb() appear to be almost universally
open-coding the result. Only a few initialize struct members that aren't
.get and .set:

$ git grep -B6 ^module_param_cb

I'd say drop this patch and instead patch moduleparam.h to not say it's
deprecated. :P

-Kees

-- 
Kees Cook
