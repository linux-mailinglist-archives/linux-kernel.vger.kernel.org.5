Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC47BE50E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbjJIPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377698AbjJIPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:45 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A66123
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:37:11 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S43775RMKzMpnst;
        Mon,  9 Oct 2023 15:37:07 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S43752y9GzMppB4;
        Mon,  9 Oct 2023 17:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696865827;
        bh=cckq9ovgURWeuDsq98a+f35kYfa/8F4jXEqh6IzlR3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCck3znyNdWqN3MzYz+w3ihd5zetMeMTIID7gg9ktvqZXEOS47+8RiDEAiFaYNtg0
         K+AzQkBxYmuVtBqcloRyGcuNQ5nhrergMzSc3qsP375Id+fzyhNTZ8kIYXxmA1CFBM
         On1W6gqkPYtxBCw7BzeLe9zfDCF0u5jN9bC7xTGU=
Date:   Mon, 9 Oct 2023 17:36:59 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v15 04/11] LSM: syscalls for current process attributes
Message-ID: <20231009.MieQu5ou2loo@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-5-casey@schaufler-ca.com>
 <20231003.kooghohS2Aiz@digikod.net>
 <CAHC9VhT_ijmqo9ap-EokWHuALsMAqome2qcWgst3eRP6m+vbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT_ijmqo9ap-EokWHuALsMAqome2qcWgst3eRP6m+vbRA@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:04:34PM -0400, Paul Moore wrote:
> On Tue, Oct 3, 2023 at 10:09 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Sep 12, 2023 at 01:56:49PM -0700, Casey Schaufler wrote:
> > > Create a system call lsm_get_self_attr() to provide the security
> > > module maintained attributes of the current process.
> > > Create a system call lsm_set_self_attr() to set a security
> > > module maintained attribute of the current process.
> > > Historically these attributes have been exposed to user space via
> > > entries in procfs under /proc/self/attr.
> > >
> > > The attribute value is provided in a lsm_ctx structure. The structure
> > > identifies the size of the attribute, and the attribute value. The format
> > > of the attribute value is defined by the security module. A flags field
> > > is included for LSM specific information. It is currently unused and must
> > > be 0. The total size of the data, including the lsm_ctx structure and any
> > > padding, is maintained as well.
> > >
> > > struct lsm_ctx {
> > >         __u64 id;
> > >         __u64 flags;
> > >         __u64 len;
> > >         __u64 ctx_len;
> > >         __u8 ctx[];
> > > };
> > >
> > > Two new LSM hooks are used to interface with the LSMs.
> > > security_getselfattr() collects the lsm_ctx values from the
> > > LSMs that support the hook, accounting for space requirements.
> > > security_setselfattr() identifies which LSM the attribute is
> > > intended for and passes it along.
> > >
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > ---
> > >  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
> > >  include/linux/lsm_hook_defs.h       |   4 +
> > >  include/linux/lsm_hooks.h           |   1 +
> > >  include/linux/security.h            |  19 ++++
> > >  include/linux/syscalls.h            |   5 +
> > >  include/uapi/linux/lsm.h            |  36 +++++++
> > >  kernel/sys_ni.c                     |   2 +
> > >  security/Makefile                   |   1 +
> > >  security/lsm_syscalls.c             |  57 +++++++++++
> > >  security/security.c                 | 152 ++++++++++++++++++++++++++++
> > >  10 files changed, 347 insertions(+)
> > >  create mode 100644 Documentation/userspace-api/lsm.rst
> > >  create mode 100644 security/lsm_syscalls.c
> 
> ...
> 
> > > diff --git a/security/security.c b/security/security.c
> > > index a3489c04b783..0d179750d964 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
> > >  }
> > >  EXPORT_SYMBOL(security_d_instantiate);
> > >
> > > +/*
> > > + * Please keep this in sync with it's counterpart in security/lsm_syscalls.c
> > > + */
> > > +
> > > +/**
> > > + * security_getselfattr - Read an LSM attribute of the current process.
> > > + * @attr: which attribute to return
> > > + * @uctx: the user-space destination for the information, or NULL
> > > + * @size: pointer to the size of space available to receive the data
> > > + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> > > + * attributes associated with the LSM identified in the passed @ctx be
> > > + * reported.
> > > + *
> > > + * A NULL value for @uctx can be used to get both the number of attributes
> > > + * and the size of the data.
> > > + *
> > > + * Returns the number of attributes found on success, negative value
> > > + * on error. @size is reset to the total size of the data.
> > > + * If @size is insufficient to contain the data -E2BIG is returned.
> > > + */
> > > +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> > > +                      size_t __user *size, u32 flags)
> > > +{
> > > +     struct security_hook_list *hp;
> > > +     struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> > > +     u8 __user *base = (u8 __user *)uctx;
> > > +     size_t total = 0;
> > > +     size_t entrysize;
> > > +     size_t left;
> > > +     bool toobig = false;
> > > +     bool single = false;
> > > +     int count = 0;
> > > +     int rc;
> > > +
> > > +     if (attr == LSM_ATTR_UNDEF)
> > > +             return -EINVAL;
> > > +     if (size == NULL)
> > > +             return -EINVAL;
> > > +     if (get_user(left, size))
> > > +             return -EFAULT;
> > > +
> > > +     if (flags) {
> > > +             /*
> > > +              * Only flag supported is LSM_FLAG_SINGLE
> > > +              */
> > > +             if (flags != LSM_FLAG_SINGLE)
> > > +                     return -EINVAL;
> > > +             if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))
> >
> > I'm not sure if we should return -EINVAL or -EFAULT when uctx == NULL.
> > Because uctx is optional (when LSM_FLAG_SINGLE is not set), I guess
> > -EINVAL is OK.
> 
> That's a good point, we should probably the error codes here: if uctx
> is NULL in the LSM_FLAG_SINGLE case we should return -EINVAL, if the
> copy_from_user() fails we should return -EFAULT.
> 
> > > +                     return -EFAULT;
> > > +             /*
> > > +              * If the LSM ID isn't specified it is an error.
> > > +              */
> > > +             if (lctx.id == LSM_ID_UNDEF)
> > > +                     return -EINVAL;
> > > +             single = true;
> > > +     }
> > > +
> > > +     /*
> > > +      * In the usual case gather all the data from the LSMs.
> > > +      * In the single case only get the data from the LSM specified.
> > > +      */
> > > +     hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> > > +             if (single && lctx.id != hp->lsmid->id)
> > > +                     continue;
> > > +             entrysize = left;
> > > +             if (base)
> > > +                     uctx = (struct lsm_ctx __user *)(base + total);
> > > +             rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
> > > +             if (rc == -EOPNOTSUPP) {
> > > +                     rc = 0;
> > > +                     continue;
> > > +             }
> > > +             if (rc == -E2BIG) {
> > > +                     toobig = true;
> > > +                     left = 0;
> > > +             } else if (rc < 0)
> > > +                     return rc;
> > > +             else
> > > +                     left -= entrysize;
> > > +
> > > +             total += entrysize;
> > > +             count += rc;
> >
> > There is a bug if rc == -E2BIG
> 
> Can you elaborate a bit more on this? Nothing is jumping out at me as
> obviously broken... are you talking about @count becoming garbage due
> to @rc being equal to -E2BIG?  If that is the case it should be okay
> since we explicitly return -E2BIG, not @count, if @toobig is true.

Indeed, in this case count will not be returned thanks to toobig. I'd
suggest to "continue" if rc == -E2BIG (like for -EOPNOTSUPP) to avoid an
inconsistent count value, which could bite us one day.

> 
> > > +             if (single)
> > > +                     break;
> > > +     }
> > > +     if (put_user(total, size))
> > > +             return -EFAULT;
> > > +     if (toobig)
> > > +             return -E2BIG;
> > > +     if (count == 0)
> > > +             return LSM_RET_DEFAULT(getselfattr);
> > > +     return count;
> > > +}
> 
> -- 
> paul-moore.com
