Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAA7AE350
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjIZB1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZB1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:27:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69F10C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:27:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-415155b2796so118851cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695691625; x=1696296425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJZ8DTZgXHrAJDCbxYXGIIn2xWrlIREKhset9GbZ85o=;
        b=MFF3m37QXYOoEzTmyKrHeWmo6QZFTTUZbkux7YOYFbzyh68cdelSVj4uLhxBjhfJu/
         0wNcCwPY2xyIo1Rg9D2LhjI2p+hFoXxbZHpMaJXJmYq0aqoIpM8twf+j1COn/VzYI7kT
         z1XSYpqfFD85fzMwMj+aCDTTKdaBbj0zIzxs2ve+y2+HvgE67VqxJp42sEBBZN2xOs0J
         ianIvB56QOowI4hvEiC1T8RF32STnNCx9NLzzOcdAXgLEfw85X6tCoGgGYLbwFUtBzjo
         CmBcNTgQBgZjJPAduv4BIU4zq+LiGe/c4CVLbVAsdT6v5ETF0mmjhMSXr/Rt/D9yQEVE
         xkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695691625; x=1696296425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJZ8DTZgXHrAJDCbxYXGIIn2xWrlIREKhset9GbZ85o=;
        b=VWjmm62N/abu3G3cd+8o+Nq586Jyls7EW7HAzmfwVWfof/oFaQeC9w6n3cEWPCb+16
         skPWhi4BakLkWfC44qp0s4jwwjb3A3b19rjXiiz1VHglLBZaPGncF3QBR71+wESFOC6d
         hxlvQKr523sWzJND6iyFMPCK43NlZGG9znasH2b8uuDjZ6si+4tn1MngVKwXhElbgjzV
         e9ED+yr4CQQqvF05z4Btcw7o959EVF4YH0GWndEhWUV5vKZf2owI3P72ciAf9WoWC35q
         zn5Rl4WGwgwQ6/1J5zWOR4DcVDPkD0aXgWItsoDmua7RKjVuNMSYqx6PRC1tHdp8MKqU
         feMw==
X-Gm-Message-State: AOJu0Yx5eMzWTYOhqpPYnneboN9F6eAqXSzgtOIDH6KV/5TO+8MlHhCz
        9goOlGdzPqNBQPqvN4qPQW+5SE4JQbFYl5mDnQrXnQ==
X-Google-Smtp-Source: AGHT+IGW23N2ycJGn5IXfXvo9jFIGJrG+TvvqJv4hGBBnHR3ftYu6mIoPoYB4pRHF+iobeLa8q4Tvthih4Qo8cHsMdg=
X-Received: by 2002:ac8:5dcf:0:b0:418:fb5:83d9 with SMTP id
 e15-20020ac85dcf000000b004180fb583d9mr85485qtx.19.1695691624879; Mon, 25 Sep
 2023 18:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-6-mic@digikod.net>
In-Reply-To: <20230921061641.273654-6-mic@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 25 Sep 2023 18:26:28 -0700
Message-ID: <CALmYWFubLv+yd9NWMMwt4FUdYnbghMC=GHeZm4oaSOctqnwbVA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
> and open requests.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h |  32 +++++++++++
>  security/landlock/fs.c    |  62 ++++++++++++++++++---
>  3 files changed, 199 insertions(+), 9 deletions(-)
>
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index d9589d07e126..148fc0fafef4 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -14,6 +14,25 @@
>
>  atomic64_t ruleset_and_domain_counter =3D ATOMIC64_INIT(0);
>
> +static const char *op_to_string(enum landlock_operation operation)
> +{
> +       const char *const desc[] =3D {
> +               [0] =3D "",
> +               [LANDLOCK_OP_MKDIR] =3D "mkdir",
> +               [LANDLOCK_OP_MKNOD] =3D "mknod",
> +               [LANDLOCK_OP_SYMLINK] =3D "symlink",
> +               [LANDLOCK_OP_UNLINK] =3D "unlink",
> +               [LANDLOCK_OP_RMDIR] =3D "rmdir",
> +               [LANDLOCK_OP_TRUNCATE] =3D "truncate",
> +               [LANDLOCK_OP_OPEN] =3D "open",
> +       };
> +
> +       if (WARN_ON_ONCE(operation < 0 || operation > ARRAY_SIZE(desc)))
> +               return "unknown";
> +
> +       return desc[operation];
> +}
> +
>  #define BIT_INDEX(bit) HWEIGHT(bit - 1)
>
>  static void log_accesses(struct audit_buffer *const ab,
> @@ -141,3 +160,98 @@ void landlock_log_release_ruleset(const struct landl=
ock_ruleset *const ruleset)
>         audit_log_format(ab, "op=3Drelease-%s %s=3D%llu", name, name, id)=
;
>         audit_log_end(ab);
>  }
> +
> +/* Update request.youngest_domain and request.missing_access */
> +static void
> +update_request(struct landlock_request *const request,
> +              const struct landlock_ruleset *const domain,
> +              const access_mask_t access_request,
> +              const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCES=
S_FS])
> +{
> +       const unsigned long access_req =3D access_request;
> +       unsigned long access_bit;
> +       long youngest_denied_layer =3D -1;
> +       const struct landlock_hierarchy *node =3D domain->hierarchy;
> +       size_t i;
> +
> +       WARN_ON_ONCE(request->youngest_domain);
> +       WARN_ON_ONCE(request->missing_access);
> +
> +       if (WARN_ON_ONCE(!access_request))
> +               return;
> +
> +       if (WARN_ON_ONCE(!layer_masks))
> +               return;
> +
> +       for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks=
)) {
> +               long domain_layer;
> +
> +               if (!(*layer_masks)[access_bit])
> +                       continue;
> +
> +               domain_layer =3D __fls((*layer_masks)[access_bit]);
> +
> +               /*
> +                * Gets the access rights that are missing from
> +                * the youngest (i.e. closest) domain.
> +                */
> +               if (domain_layer =3D=3D youngest_denied_layer) {
> +                       request->missing_access |=3D BIT_ULL(access_bit);
> +               } else if (domain_layer > youngest_denied_layer) {
> +                       youngest_denied_layer =3D domain_layer;
> +                       request->missing_access =3D BIT_ULL(access_bit);
> +               }
> +       }
> +
> +       WARN_ON_ONCE(!request->missing_access);
> +       WARN_ON_ONCE(youngest_denied_layer < 0);
> +
> +       /* Gets the nearest domain ID that denies request.missing_access =
*/
> +       for (i =3D domain->num_layers - youngest_denied_layer - 1; i > 0;=
 i--)
> +               node =3D node->parent;
> +       request->youngest_domain =3D node->id;
> +}
> +
> +static void
> +log_request(const int error, struct landlock_request *const request,
> +           const struct landlock_ruleset *const domain,
> +           const access_mask_t access_request,
> +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_F=
S])
> +{
> +       struct audit_buffer *ab;
> +
> +       if (WARN_ON_ONCE(!error))
> +               return;
> +       if (WARN_ON_ONCE(!request))
> +               return;
> +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> +               return;
> +
> +       /* Uses GFP_ATOMIC to not sleep. */
> +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN=
,
> +                            AUDIT_LANDLOCK);
> +       if (!ab)
> +               return;
> +
> +       update_request(request, domain, access_request, layer_masks);
> +
> +       log_task(ab);
> +       audit_log_format(ab, " domain=3D%llu op=3D%s errno=3D%d missing-f=
s-accesses=3D",
> +                        request->youngest_domain,
> +                        op_to_string(request->operation), -error);
> +       log_accesses(ab, request->missing_access);
> +       audit_log_lsm_data(ab, &request->audit);
> +       audit_log_end(ab);
> +}
> +
> +// TODO: Make it generic, not FS-centric.
> +int landlock_log_request(
> +       const int error, struct landlock_request *const request,
> +       const struct landlock_ruleset *const domain,
> +       const access_mask_t access_request,
> +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> +{
> +       /* No need to log the access request, only the missing accesses. =
*/
> +       log_request(error, request, domain, access_request, layer_masks);
> +       return error;
> +}
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index bc17dc8ca6f1..8edc68b98fca 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -13,6 +13,23 @@
>
>  #include "ruleset.h"
>
> +enum landlock_operation {
> +       LANDLOCK_OP_MKDIR =3D 1,
> +       LANDLOCK_OP_MKNOD,
> +       LANDLOCK_OP_SYMLINK,
> +       LANDLOCK_OP_UNLINK,
> +       LANDLOCK_OP_RMDIR,
> +       LANDLOCK_OP_TRUNCATE,
> +       LANDLOCK_OP_OPEN,
> +};
> +
> +struct landlock_request {
> +       const enum landlock_operation operation;
> +       access_mask_t missing_access;
> +       u64 youngest_domain;
> +       struct common_audit_data audit;
> +};
> +
>  #ifdef CONFIG_AUDIT
>
>  void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)=
;
> @@ -20,6 +37,12 @@ void landlock_log_restrict_self(struct landlock_rulese=
t *const domain,
>                                 struct landlock_ruleset *const ruleset);
>  void landlock_log_release_ruleset(const struct landlock_ruleset *const r=
uleset);
>
> +int landlock_log_request(
> +       const int error, struct landlock_request *const request,
> +       const struct landlock_ruleset *const domain,
> +       const access_mask_t access_request,
> +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS]);
> +
>  #else /* CONFIG_AUDIT */
>
>  static inline void
> @@ -38,6 +61,15 @@ landlock_log_release_ruleset(const struct landlock_rul=
eset *const ruleset)
>  {
>  }
>
> +static inline int landlock_log_request(
> +       const int error, struct landlock_request *const request,
> +       const struct landlock_ruleset *const domain,
> +       const access_mask_t access_request,
> +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> +{
> +       return error;
> +}
> +
>  #endif /* CONFIG_AUDIT */
>
>  #endif /* _SECURITY_LANDLOCK_AUDIT_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 978e325d8708..104dfb2abc32 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/list.h>
> +#include <linux/lsm_audit.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> @@ -30,6 +31,7 @@
>  #include <linux/workqueue.h>
>  #include <uapi/linux/landlock.h>
>
> +#include "audit.h"
>  #include "common.h"
>  #include "cred.h"
>  #include "fs.h"
> @@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
>  }
>
>  static int current_check_access_path(const struct path *const path,
> -                                    access_mask_t access_request)
> +                                    access_mask_t access_request,
> +                                    struct landlock_request *const reque=
st)
>  {
>         const struct landlock_ruleset *const dom =3D
>                 landlock_get_current_domain();
> @@ -650,7 +653,10 @@ static int current_check_access_path(const struct pa=
th *const path,
>                                        NULL, 0, NULL, NULL))
>                 return 0;
>
> -       return -EACCES;
> +       request->audit.type =3D LSM_AUDIT_DATA_PATH;
> +       request->audit.u.path =3D *path;
> +       return landlock_log_request(-EACCES, request, dom, access_request=
,
> +                                   &layer_masks);

It might be more readable to let landlock_log_request return void.
Then the code will look like below.

landlock_log_request(-EACCES, request, dom, access_request,  &layer_masks);
return -EACCES;

The allow/deny logic will be in this function, i.e. reader
doesn't need to check landlock_log_request's implementation to find
out it never returns 0.

-Jeff

>  }
>
>  static inline access_mask_t get_mode_access(const umode_t mode)
> @@ -1097,6 +1103,7 @@ static int hook_path_link(struct dentry *const old_=
dentry,
>                           const struct path *const new_dir,
>                           struct dentry *const new_dentry)
>  {
> +       // TODO: Implement fine-grained audit
>         return current_check_refer_path(old_dentry, new_dir, new_dentry, =
false,
>                                         false);
>  }
> @@ -1115,38 +1122,67 @@ static int hook_path_rename(const struct path *co=
nst old_dir,
>  static int hook_path_mkdir(const struct path *const dir,
>                            struct dentry *const dentry, const umode_t mod=
e)
>  {
> -       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR=
);
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_MKDIR,
> +       };
> +
> +       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR=
,
> +                                        &request);
>  }
>
>  static int hook_path_mknod(const struct path *const dir,
>                            struct dentry *const dentry, const umode_t mod=
e,
>                            const unsigned int dev)
>  {
> -       return current_check_access_path(dir, get_mode_access(mode));
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_MKNOD,
> +       };
> +
> +       return current_check_access_path(dir, get_mode_access(mode), &req=
uest);
>  }
>
>  static int hook_path_symlink(const struct path *const dir,
>                              struct dentry *const dentry,
>                              const char *const old_name)
>  {
> -       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM=
);
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_SYMLINK,
> +       };
> +
> +       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM=
,
> +                                        &request);
>  }
>
>  static int hook_path_unlink(const struct path *const dir,
>                             struct dentry *const dentry)
>  {
> -       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_F=
ILE);
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_UNLINK,
> +       };
> +
> +       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_F=
ILE,
> +                                        &request);
>  }
>
>  static int hook_path_rmdir(const struct path *const dir,
>                            struct dentry *const dentry)
>  {
> -       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_D=
IR);
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_RMDIR,
> +       };
> +
> +       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_D=
IR,
> +                                        &request);
>  }
>
>  static int hook_path_truncate(const struct path *const path)
>  {
> -       return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCAT=
E);
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_TRUNCATE,
> +       };
> +
> +       return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCAT=
E,
> +                                        &request);
>  }
>
>  /* File hooks */
> @@ -1199,6 +1235,13 @@ static int hook_file_open(struct file *const file)
>         const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCA=
TE;
>         const struct landlock_ruleset *const dom =3D
>                 landlock_get_current_domain();
> +       struct landlock_request request =3D {
> +               .operation =3D LANDLOCK_OP_OPEN,
> +               .audit =3D {
> +                       .type =3D LSM_AUDIT_DATA_PATH,
> +                       .u.path =3D file->f_path,
> +               },
> +       };
>
>         if (!dom)
>                 return 0;
> @@ -1249,7 +1292,8 @@ static int hook_file_open(struct file *const file)
>         if ((open_access_request & allowed_access) =3D=3D open_access_req=
uest)
>                 return 0;
>
> -       return -EACCES;
> +       return landlock_log_request(-EACCES, &request, dom, open_access_r=
equest,
> +                                   &layer_masks);
>  }
>
>  static int hook_file_truncate(struct file *const file)
> --
> 2.42.0
>
