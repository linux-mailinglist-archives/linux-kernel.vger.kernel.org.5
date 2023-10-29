Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B957DAB3B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjJ2HCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2HCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:02:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7FBD6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:02:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a86b6391e9so29790167b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698562927; x=1699167727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1jEn34I9DmHyOBDF7eORRkO/BUN0oXBi8SLaLYZC4=;
        b=tpB0Z4gnbDTHnkilUsWyxJoC31l4KCP2N0NKBvwuL/J1zvKNJR2ZtUjF89b6yG9PyD
         WAKfJFro0G4OCYvKcbeShUmUwm2nb2m7cf/ABjQuocu6F7Sd0WGgC1IKmGtA13RihGEp
         9A8VghvcwvEYt8cScVdiU8wEV40w3z7pwCcyZhaSV8dFXs6EGqcGYsQw9lALYHhAwF/s
         spYOncmC8UTfAY4wvewQjus0DtC5MkFtugmJGQAPfxohLGHsEXjMSMCppxI1fle47AhR
         La8ry5hmdaXeoSYFi0vWkjB2eg2iNrZvOCwrrq+HV1XTfHofbS3hhxFyvQ4QYprN2js5
         C1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698562927; x=1699167727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr1jEn34I9DmHyOBDF7eORRkO/BUN0oXBi8SLaLYZC4=;
        b=BJ0qm7jNOkK9oPGD7vysRBkc6KfusB6IM5UbaRef+ZtqWSap8FzJ4k66OagepgEAjm
         D+Sn8FyqzUSf+7NjH0ZSGBZFBi9YObpeC9Un1IaiR9/riOLFVOUm6A62kBFf4qi1LzkV
         5/jG6QeT+71u0I9mKaA/Wel1pMONugE6Ve/mx+Q93IztL0zxHQXq8+8dgdqN717dYKzx
         A55ZiKKLqt8KelVF/X63hCAGGv5XQ1DM1xnYNFlJwyG40Dk7SyF09ys5dE/QUVdXv1q5
         iY0EnkYqVzazXNoBVocWfe1ies4SfB1oFNAD4iLTsbEYNqA9Jnq+oXsZlusiVSA5lgTF
         ZLww==
X-Gm-Message-State: AOJu0YxlVa7sNAUJV0lkrnZxco6wqCQCFheiynJ1mjMrLdgnsiR6FxhZ
        iF6sl1UC8hA4Ga+U8p+bImfvh0srYmxng+fNa9diuQ==
X-Google-Smtp-Source: AGHT+IH46zWdIofZTF8b3sby0+fpYaKI2g8ntd9k1TuOqN55P0kD6Q/Z+PmRz8OG0YldahGxFgPKHk0udQ5NrNjxna4=
X-Received: by 2002:a81:5754:0:b0:5a7:dda6:cbaf with SMTP id
 l81-20020a815754000000b005a7dda6cbafmr6596382ywb.19.1698562926640; Sun, 29
 Oct 2023 00:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231028164650.4f5ea18a@rorschach.local.home>
In-Reply-To: <20231028164650.4f5ea18a@rorschach.local.home>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 29 Oct 2023 12:31:54 +0530
Message-ID: <CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing ei->dentry
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave
        <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew
        Morton" <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 02:16, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The eventfs_inode (ei) is protected by SRCU, but the ei->dentry is not. It
> is protected by the eventfs_mutex. Anytime the eventfs_mutex is released,
> and access to the ei->dentry needs to be done, it should first check if
> ei->is_freed is set under the eventfs_mutex. If it is, then the ei->dentry
> is invalid and must not be used. The ei->dentry must only be accessed
> under the eventfs_mutex and after checking if ei->is_freed is set.
>
> When the ei is being freed, it will (under the eventfs_mutex) set is_freed
> and at the same time move the dentry to a free list to be cleared after
> the eventfs_mutex is released. This means that any access to the
> ei->dentry must check first if ei->is_freed is set, because if it is, then
> the dentry is on its way to be freed.
>
> Also add comments to describe this better.
>
> Link: https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
> Link: https://lore.kernel.org/all/CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com/
>
> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Following build errors have been noticed.

fs/tracefs/event_inode.c:348:1: error: return type defaults to 'int'
[-Werror=implicit-int]
  348 | create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
      | ^~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:251,
                 from include/linux/build_bug.h:5,
                 from include/linux/bits.h:21,
                 from include/linux/bitops.h:6,
                 from include/linux/radix-tree.h:11,
                 from include/linux/idr.h:15,
                 from include/linux/fsnotify_backend.h:13,
                 from include/linux/fsnotify.h:15,
                 from fs/tracefs/event_inode.c:17:
fs/tracefs/event_inode.c: In function 'create_dir_dentry':
include/linux/stddef.h:8:14: error: returning 'void *' from a function
with return type 'int' makes integer from pointer without a cast
[-Werror=int-conversion]
    8 | #define NULL ((void *)0)
      |              ^
fs/tracefs/event_inode.c:357:24: note: in expansion of macro 'NULL'
  357 |                 return NULL;
      |                        ^~~~
fs/tracefs/event_inode.c:366:24: error: returning 'struct dentry *'
from a function with return type 'int' makes integer from pointer
without a cast [-Werror=int-conversion]
  366 |                 return dentry;
      |                        ^~~~~~
fs/tracefs/event_inode.c:394:24: error: returning 'struct dentry *'
from a function with return type 'int' makes integer from pointer
without a cast [-Werror=int-conversion]
  394 |                 return dentry;
      |                        ^~~~~~
fs/tracefs/event_inode.c:416:34: error: returning 'struct dentry *'
from a function with return type 'int' makes integer from pointer
without a cast [-Werror=int-conversion]
  416 |         return invalidate ? NULL : dentry;
      |                ~~~~~~~~~~~~~~~~~~^~~~~~~~
fs/tracefs/event_inode.c: In function 'dcache_dir_open_wrapper':
fs/tracefs/event_inode.c:609:49: error: passing argument 2 of
'create_dir_dentry' from incompatible pointer type
[-Werror=incompatible-pointer-types]
  609 |                 d = create_dir_dentry(ei_child, parent, false);
      |                                                 ^~~~~~
      |                                                 |
      |                                                 struct dentry *
fs/tracefs/event_inode.c:348:68: note: expected 'struct eventfs_inode
*' but argument is of type 'struct dentry *'
  348 | create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
      |                                              ~~~~~~~~~~~~~~~~~~~~~~^~
fs/tracefs/event_inode.c:609:21: error: too few arguments to function
'create_dir_dentry'
  609 |                 d = create_dir_dentry(ei_child, parent, false);
      |                     ^~~~~~~~~~~~~~~~~
fs/tracefs/event_inode.c:348:1: note: declared here
  348 | create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
      | ^~~~~~~~~~~~~~~~~
fs/tracefs/event_inode.c:625:19: error: assignment to 'struct dentry
*' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
  625 |                 d = create_dir_dentry(ei, ei_child, parent, false);
      |                   ^
fs/tracefs/event_inode.c:626:46: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  626 |                                        parent, name, mode,
cdata, fops, false);
      |                                              ^
fs/tracefs/event_inode.c:626:52: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  626 |                                        parent, name, mode,
cdata, fops, false);
      |                                                    ^
fs/tracefs/event_inode.c:626:58: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  626 |                                        parent, name, mode,
cdata, fops, false);
      |                                                          ^
fs/tracefs/event_inode.c:626:65: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  626 |                                        parent, name, mode,
cdata, fops, false);
      |                                                                 ^
fs/tracefs/event_inode.c:626:71: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  626 |                                        parent, name, mode,
cdata, fops, false);
      |                                                                       ^
fs/tracefs/event_inode.c:626:71: error: statement with no effect
[-Werror=unused-value]
fs/tracefs/event_inode.c:626:78: error: expected ';' before ')' token
  626 |                                        parent, name, mode,
cdata, fops, false);
      |
              ^
      |
              ;
fs/tracefs/event_inode.c:626:78: error: expected statement before ')' token
fs/tracefs/event_inode.c: In function 'eventfs_remove_dir':
fs/tracefs/event_inode.c:921:1: error: invalid use of void expression
  921 | +               call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
      | ^
cc1: all warnings being treated as errors

Links:
 - https://storage.tuxsuite.com/public/linaro/naresh/builds/2XQUK9V1Fm5uX0GdoaraRkzAN29/


> ---
>
> Changes since v1: https://lore.kernel.org/all/20231028163749.0d3429a1@rorschach.local.home/
>
>  - Add comment about ei->is_freed is a union along with ei->rcu and
>    ei->del_list so that others can find where ei->is_freed is set and
>    not get confused about why ei->dentry is being removed but ei->is_freed
>    isn't mentioned.
>
>  - And fixed change log to remove the double "Reported-by".
>
>  fs/tracefs/event_inode.c | 65 +++++++++++++++++++++++++++++++++-------
>  fs/tracefs/internal.h    |  3 +-
>  2 files changed, 56 insertions(+), 12 deletions(-)
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 4d2da7480e5f..45bddce7c747 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -24,7 +24,20 @@
>  #include <linux/delay.h>
>  #include "internal.h"
>
> +/*
> + * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
> + * to the ei->dentry must be done under this mutex and after checking
> + * if ei->is_freed is not set. The ei->dentry is released under the
> + * mutex at the same time ei->is_freed is set. If ei->is_freed is set
> + * then the ei->dentry is invalid.
> + */
>  static DEFINE_MUTEX(eventfs_mutex);
> +
> +/*
> + * The eventfs_inode (ei) itself is protected by SRCU. It is released from
> + * its parent's list and will have is_freed set (under eventfs_mutex).
> + * After the SRCU grace period is over, the ei may be freed.
> + */
>  DEFINE_STATIC_SRCU(eventfs_srcu);
>
>  static struct dentry *eventfs_root_lookup(struct inode *dir,
> @@ -234,6 +247,10 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
>         bool invalidate = false;
>
>         mutex_lock(&eventfs_mutex);
> +       if (ei->is_freed) {
> +               mutex_unlock(&eventfs_mutex);
> +               return NULL;
> +       }
>         /* If the e_dentry already has a dentry, use it */
>         if (*e_dentry) {
>                 /* lookup does not need to up the ref count */
> @@ -307,6 +324,8 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>         struct eventfs_inode *ei_child;
>         struct tracefs_inode *ti;
>
> +       lockdep_assert_held(&eventfs_mutex);
> +
>         /* srcu lock already held */
>         /* fill parent-child relation */
>         list_for_each_entry_srcu(ei_child, &ei->children, list,
> @@ -320,6 +339,7 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>
>  /**
>   * create_dir_dentry - Create a directory dentry for the eventfs_inode
> + * @pei: The eventfs_inode parent of ei.
>   * @ei: The eventfs_inode to create the directory for
>   * @parent: The dentry of the parent of this directory
>   * @lookup: True if this is called by the lookup code
> @@ -327,12 +347,17 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>   * This creates and attaches a directory dentry to the eventfs_inode @ei.
>   */
>  static struct dentry *
> -create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
> +create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
> +                 struct dentry *parent, bool lookup)
>  {
>         bool invalidate = false;
>         struct dentry *dentry = NULL;
>
>         mutex_lock(&eventfs_mutex);
> +       if (pei->is_freed || ei->is_freed) {
> +               mutex_unlock(&eventfs_mutex);
> +               return NULL;
> +       }
>         if (ei->dentry) {
>                 /* If the dentry already has a dentry, use it */
>                 dentry = ei->dentry;
> @@ -435,7 +460,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>          */
>         mutex_lock(&eventfs_mutex);
>         ei = READ_ONCE(ti->private);
> -       if (ei)
> +       if (ei && !ei->is_freed)
>                 ei_dentry = READ_ONCE(ei->dentry);
>         mutex_unlock(&eventfs_mutex);
>
> @@ -449,7 +474,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>                 if (strcmp(ei_child->name, name) != 0)
>                         continue;
>                 ret = simple_lookup(dir, dentry, flags);
> -               create_dir_dentry(ei_child, ei_dentry, true);
> +               create_dir_dentry(ei, ei_child, ei_dentry, true);
>                 created = true;
>                 break;
>         }
> @@ -583,7 +608,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>
>         list_for_each_entry_srcu(ei_child, &ei->children, list,
>                                  srcu_read_lock_held(&eventfs_srcu)) {
> -               d = create_dir_dentry(ei_child, parent, false);
> +               d = create_dir_dentry(ei, ei_child, parent, false);
>                 if (d) {
>                         ret = add_dentries(&dentries, d, cnt);
>                         if (ret < 0)
> @@ -637,6 +662,13 @@ static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
>         return ret;
>  }
>
> +static void free_ei(struct eventfs_inode *ei)
> +{
> +       kfree_const(ei->name);
> +       kfree(ei->d_children);
> +       kfree(ei);
> +}
> +
>  /**
>   * eventfs_create_dir - Create the eventfs_inode for this directory
>   * @name: The name of the directory to create.
> @@ -700,12 +732,20 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>         ei->nr_entries = size;
>         ei->data = data;
>         INIT_LIST_HEAD(&ei->children);
> +       INIT_LIST_HEAD(&ei->list);
>
>         mutex_lock(&eventfs_mutex);
> -       list_add_tail(&ei->list, &parent->children);
> -       ei->d_parent = parent->dentry;
> +       if (!parent->is_freed) {
> +               list_add_tail(&ei->list, &parent->children);
> +               ei->d_parent = parent->dentry;
> +       }
>         mutex_unlock(&eventfs_mutex);
>
> +       /* Was the parent freed? */
> +       if (list_empty(&ei->list)) {
> +               free_ei(ei);
> +               ei = NULL;
> +       }
>         return ei;
>  }
>
> @@ -787,13 +827,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>         return ERR_PTR(-ENOMEM);
>  }
>
> -static void free_ei(struct rcu_head *head)
> +static void free_rcu_ei(struct rcu_head *head)
>  {
>         struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
>
> -       kfree_const(ei->name);
> -       kfree(ei->d_children);
> -       kfree(ei);
> +       free_ei(ei);
>  }
>
>  /**
> @@ -880,7 +918,12 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
>                 for (i = 0; i < ei->nr_entries; i++)
>                         unhook_dentry(&ei->d_children[i], &dentry_list);
>                 unhook_dentry(&ei->dentry, &dentry_list);
> -               call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
> +               /*
> +                * Note, ei->is_freed is a union along with ei->rcu
> +                * and ei->del_list. When the ei is added to either
> +                * of those lists, it automatically sets ei->is_freed.
> +                */
> +               call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
>         }
>         mutex_unlock(&eventfs_mutex);
>
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 64fde9490f52..21a1fa682b74 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -30,7 +30,7 @@ struct eventfs_inode {
>         const struct eventfs_entry      *entries;
>         const char                      *name;
>         struct list_head                children;
> -       struct dentry                   *dentry;
> +       struct dentry                   *dentry; /* Check is_freed to access */
>         struct dentry                   *d_parent;
>         struct dentry                   **d_children;
>         void                            *data;
> @@ -39,6 +39,7 @@ struct eventfs_inode {
>          * @del_list:   list of eventfs_inode to delete
>          * @rcu:        eventfs_inode to delete in RCU
>          * @is_freed:   node is freed if one of the above is set
> +        *   Note if is_freed is set, then dentry is corrupted.
>          */
>         union {
>                 struct list_head        del_list;
> --
> 2.42.0
>
