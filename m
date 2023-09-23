Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0731B7ABDC4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 06:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIWErZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 00:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjIWErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 00:47:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396719E;
        Fri, 22 Sep 2023 21:47:17 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38N4kYnm032599;
        Sat, 23 Sep 2023 13:46:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 23 Sep 2023 13:46:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38N4kYZc032591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Sep 2023 13:46:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af696700-ae4b-346e-4c52-3a7a21b0f46c@I-love.SAKURA.ne.jp>
Date:   Sat, 23 Sep 2023 13:46:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
 <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
 <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
 <202309200803.1911A584@keescook>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202309200803.1911A584@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/21 0:08, Kees Cook wrote:
> I feel like you are willfully not listening to us when we say that this
> doesn't block out of tree LSMs. Again, there is nothing here that stops
> it. To prove this point, here is an out of tree LSM that works with this
> series. So let's move from theoretical to practical: given this example,
> why do you think out of tree LSMs are blocked?

Because an LSM ID value

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index eeda59a77c02..23b7a8f79cef 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -63,6 +63,8 @@ struct lsm_ctx {
>  #define LSM_ID_BPF		110
>  #define LSM_ID_LANDLOCK		111
>  
> +#define LSM_ID_GOAT		1138
> +
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
>   * which are used in the kernel's LSM userspace API. Support

is assigned to LSM only when that LSM became no longer out of tree.

I'm against the policy that only LSM modules that succeeded to become
in-tree are assigned LSM ID. That's not a good usage of identifier.

Quoting from https://lkml.kernel.org/r/4a6b6e2c-9872-4d4c-e42e-4ff0fb79f3ae@I-love.SAKURA.ne.jp :

  The sane and the better usage of LSM ID is to register any publicly available
  LSMs. If LSM ID serves as an index for what LSMs are available in the world,
  by maintaining "the LSM module name, the LSM ID value, short description about
  that LSM module, the public git repository or web site for more information
  about that LSM module" pairs, people can easily find what LSMs could be used
  for their purpose, and developers can avoid re-inventing similar LSM modules
  which are already available somewhere in the world (and optionally helps
  avoiding module name collisions with any publicly available LSMs).

You must not say "We don't care about out of tree LSMs." when talking about this patch.

