Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427EE7EC24F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjKOMc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbjKOMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:32:56 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6D11D;
        Wed, 15 Nov 2023 04:32:51 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5842ea6f4d5so4202939eaf.2;
        Wed, 15 Nov 2023 04:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700051571; x=1700656371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ymwjRDEGx/rob7YccBbw/VIQH/kl+vjNZlHHnqtAps=;
        b=YQMuhsywkJ61hF14wJoTL0OqucIfKGY+3lLTvsALGGWuSA5guJe0+qe24x50onDS1N
         fGsCR7XnPJrkZWl6pJOSiWS4w3wYx/eSGN1xw7HQqixHLDEIzWuDLs8CThVc/pBigOuF
         jbZl7Kd6B4k259e/Um+AzzfwYaWpIoyMQzIi0fY60kJpNsDurLh9xa1KvTPquzEbQfrj
         sfazPHfDkpiKb6ewFhKIPea6rvFSvi6lQHhYL94Kw1qBJx2YXZjmQuUQKl+wXANGob5u
         p+Y9WAiqy2uKHfPI9kXPxHRpZtr+x/gUCEvpzCJT8S6Ro6jiILAG7F9iAyCkjwsavyzX
         B9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700051571; x=1700656371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ymwjRDEGx/rob7YccBbw/VIQH/kl+vjNZlHHnqtAps=;
        b=ORRMU/FCH7t+WNbuawIn/+OYaREheRjokJjO8uT7eSdJFKDicfOx8lyn2zqtT1InyU
         VeydgyhnuDO0jwHsdpVzj7PfeUpelfHzOPM0wHPx/63oyC7RzJ3p8fEeqT6NAydKTaQJ
         jRLcvp+2y/CY697EBdUtk7zFHo66m8d0sF+gQZA0IZMJnvfsmA+6LprSyUGT7HZufIOW
         ZJnQx7PqlZrdd3d9g92I4YOm3ScUW+uIAQDOlUWGOzV4pvXDwoeResV09wXSeMFo34cT
         M1mToGWDORbhE+Dl3lAX9dpVKthaeZJvYnZGhrkdTTWCLCuwZQ2/+HkuZMbVHv0uXs5+
         i63A==
X-Gm-Message-State: AOJu0YyE1X1DcIwMe6kCNCHB9ykrfR8T8iZ3JN6hpAHs0b15yugVa8P8
        L58LmqjnVBYzlcNxxGKjSSD6hGSbUtGPBYLKGVg=
X-Google-Smtp-Source: AGHT+IEBph6GDP9TYIekLFUBCs2FVguHPZRPGLsFxmuAwoOLYw75BIT/GaqpGs1U2TNQwZ9O5LjS2VswBrLZtbgpjec=
X-Received: by 2002:a4a:9204:0:b0:581:e750:9995 with SMTP id
 f4-20020a4a9204000000b00581e7509995mr11552460ooh.3.1700051571046; Wed, 15 Nov
 2023 04:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20231114153108.1932884-1-haowenchao2@huawei.com> <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
In-Reply-To: <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 15 Nov 2023 13:32:38 +0100
Message-ID: <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:35=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 11/14/23 23:31, Wenchao Hao wrote:
> > This issue is reported by smatch, get_quota_realm() might return
> > ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
> > value.
> >
> > Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> > ---
> >   fs/ceph/quota.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> > index 9d36c3532de1..c4b2929c6a83 100644
> > --- a/fs/ceph/quota.c
> > +++ b/fs/ceph/quota.c
> > @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client=
 *fsc, struct kstatfs *buf)
> >       realm =3D get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> >                               QUOTA_GET_MAX_BYTES, true);
> >       up_read(&mdsc->snap_rwsem);
> > -     if (!realm)
> > +     if (IS_ERR_OR_NULL(realm))
> >               return false;
> >
> >       spin_lock(&realm->inodes_with_caps_lock);
>
> Good catch.
>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>
> We should CC the stable mail list.

Hi Xiubo,

What exactly is being fixed here?  get_quota_realm() is called with
retry=3Dtrue, which means that no errors can be returned -- EAGAIN, the
only error that get_quota_realm() can otherwise generate, would be
handled internally by retrying.

Am I missing something that makes this qualify for stable?

Thanks,

                Ilya
