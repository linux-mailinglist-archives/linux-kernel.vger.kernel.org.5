Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4407AC642
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjIXB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjIXB6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 21:58:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62176124
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 18:58:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578a62c088cso4128072a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 18:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695520686; x=1696125486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ8gUVcwY7z28ISZZjmTU5keHHyihVN0UqOd3/TKTzs=;
        b=ohh9zu0M8u1jGlMckxS9BXphiQDtCDbJLIy8Mo8EGzn5/LwjjPiAIYCxltJghxYgKF
         BNjMnuoUV09bQ/Tl1yzYBz/3hIXkxP841+yJw//ZCl2NwGQzxLAWp8NsTFkrOBe77MnR
         vtikd9iUodNl6Zr0TjtacWBpUOEHGHn4E1dyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695520686; x=1696125486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ8gUVcwY7z28ISZZjmTU5keHHyihVN0UqOd3/TKTzs=;
        b=krCOOVE9cWZIAQDl0frstBgGv+s0R4CNOrx/1SUfBw1HujaAjEpTz2lG6axYPw+GG2
         IHdNldQgcDri89mTZDjeUbVGANBj29VlWp82YgV69umF7LZY4AuCfiHwCayS4iJSqdDp
         8g/u1LDtxPGyv6bXH8bH8R68gIjyt9BcUHSNz483fEUh3zJmiG6ClAAxxk+CHuZ6o6ZS
         zP5J6u3Q3QJ/QBQbzgKtlqu5BeFKrPTEnQT6rbxJhlg2H8WSkYK7q0s2BMnwMoSQurzK
         lUMRLTPYfO9uRcGRL9Ouv9lWAFgPLaSLykGfPZyWYYjtNez+4OCEGplK74lVTgr5F7kj
         JmxA==
X-Gm-Message-State: AOJu0YyqAFgQXH2c8kHIFpGQgH9+RAfKGTIiCpChuKGlR1fv1rmurUdK
        QfhXbepdw5j0VdG4jwril3RQFQ==
X-Google-Smtp-Source: AGHT+IFZ8OVroTf1PpluoM4S33qys6AHEQkcl5cNA4O3ypvYjGbV0p78+YtJzXG+ybZ1gN3G/6Dg0w==
X-Received: by 2002:a17:90b:4a88:b0:274:9be9:7ee3 with SMTP id lp8-20020a17090b4a8800b002749be97ee3mr5225651pjb.8.1695520685811;
        Sat, 23 Sep 2023 18:58:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a001100b00276a58e37c1sm7782731pja.38.2023.09.23.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 18:58:05 -0700 (PDT)
Date:   Sat, 23 Sep 2023 18:58:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Message-ID: <202309231838.CB16E6B5@keescook>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
 <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
 <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
 <202309200803.1911A584@keescook>
 <af696700-ae4b-346e-4c52-3a7a21b0f46c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af696700-ae4b-346e-4c52-3a7a21b0f46c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 01:46:35PM +0900, Tetsuo Handa wrote:
> On 2023/09/21 0:08, Kees Cook wrote:
> > I feel like you are willfully not listening to us when we say that this
> > doesn't block out of tree LSMs. Again, there is nothing here that stops
> > it. To prove this point, here is an out of tree LSM that works with this
> > series. So let's move from theoretical to practical: given this example,
> > why do you think out of tree LSMs are blocked?
> 
> Because an LSM ID value

But my example includes one.

> > diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> > index eeda59a77c02..23b7a8f79cef 100644
> > --- a/include/uapi/linux/lsm.h
> > +++ b/include/uapi/linux/lsm.h
> > @@ -63,6 +63,8 @@ struct lsm_ctx {
> >  #define LSM_ID_BPF		110
> >  #define LSM_ID_LANDLOCK		111
> >  
> > +#define LSM_ID_GOAT		1138
> > +
> >  /*
> >   * LSM_ATTR_XXX definitions identify different LSM attributes
> >   * which are used in the kernel's LSM userspace API. Support
> 
> is assigned to LSM only when that LSM became no longer out of tree.

Why? My example code will work just fine. The only possible reason
it could be awkward would be if an out of tree LSM became so useful
that the author decided to upstream it, and risked colliding with an
existing LSM id. But lsm_id::id is a u64 (not an enum!), so there is
a HUGE space available. If out of tree LSMs used the epoch time they
were first authored as their id, the chances of a collision would be
approaching zero. There isn't an out of tree LSM written every second,
but if there were, it would take 584 billion years to run out of LSM ids.

And, as mentioned several times before, this is _not a new problem_, and
exists for out of tree syscalls, out of tree prctls, etc. I even DID
this for the Yama LSM when it looked like it wasn't going to get
upstream in the early days. Its prctl number _is not sequential_:

include/uapi/linux/prctl.h:#define PR_SET_PTRACER 0x59616d61

(And you'll see 0x59616d61 in ASCII is "Yama"; my effort to avoid
collision.)

So, there is both ability (u64) and precedent (Yama) for this. Having an
LSM id is _not_ a blocker for out of tree LSMs, and I've given the proof.

-Kees

-- 
Kees Cook
