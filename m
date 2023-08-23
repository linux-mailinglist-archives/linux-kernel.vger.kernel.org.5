Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60586785388
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjHWJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjHWJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:07:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C561BEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:02:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a1681fa868so646957266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692781314; x=1693386114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htSMjdk85wELugVDXAhr8cuhpjEm2Q5vyQ8twDUxEyk=;
        b=hG3ilkGGJUfAI8sRdQkgGVOuFHUn22bI04fyKmmYAttiVJlkyoYN3afCusCr4PMbkA
         pNfZSGNZXoSy2v14RslrgQtlmPD00F52wpUwPUo+INhkkkDq8S5TgiTaX1OmH6cwxhvM
         K+2F0DAHY0lZgmYME1PI3mNPKJN0EmsDIGstw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781314; x=1693386114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htSMjdk85wELugVDXAhr8cuhpjEm2Q5vyQ8twDUxEyk=;
        b=gd8kVSSGugo0aGGj++6KSjvStTHOmGpuO3CQBDc9UY0g3FI5NeoBLPHxVp065FX/wF
         +YQvDAGmqcZQ6uO8AjoYfae7MwNCHSCVlA0U4rMb0rLp+CPc44J1NBBr850cYXkzbXYv
         f/WwOVOQDed7XB6g3h1Ov0Ru/10rS9uzPZGeiGom+re+5JTSs1hytrNOzrv5xOamfBdf
         MjzZlqdmki6Z3F6FYwBxf++ZbUebzAPsilq1t6v8Y5ppntMINy28nVcxfdZJg7kXOe6S
         ZEIUzHUQx4mkhl3BcGd3v9Iu+O53mVSGsaJ5lX90UOluGep6v+gACk9rzhaTNPmkBCpl
         iopg==
X-Gm-Message-State: AOJu0YzXVy+R0EyQBV0N70st1E/2YYDu153BBPslay+ySRQ4SguNTMwe
        vwxvQPPI1uw2Y8Iqu7OoE3WCTeBl5cbwSnKxvXbccA==
X-Google-Smtp-Source: AGHT+IETRpv9wXDM4ZeEVu1LHXQq7WY3Gxn4hHYL3/vW0KawK2WFCTMwX7ltbe/FKT2CNlG4aOJ/vzL7dF8Br1Y5zzw=
X-Received: by 2002:a17:906:1d9:b0:991:b554:e64b with SMTP id
 25-20020a17090601d900b00991b554e64bmr10551621ejj.54.1692781313930; Wed, 23
 Aug 2023 02:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com> <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 11:01:42 +0200
Message-ID: <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: add FOPEN_INVAL_ATTR
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Add FOPEN_INVAL_ATTR so that the fuse daemon can ask kernel to invalidate
> the attr cache on file open.
>
> The fi->attr_version should be increased when handling FOPEN_INVAL_ATTR.
> Because if a FUSE request returning attributes (getattr, setattr, lookup,
> and readdirplus) starts before a FUSE_OPEN replying FOPEN_INVAL_ATTR, but
> finishes after the FUSE_OPEN, staled attributes will be set to the inode
> and falsely clears the inval_mask.
>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/fuse/file.c            | 10 ++++++++++
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index de37a3a06a71..412824a11b7b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -215,6 +215,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>                 file_update_time(file);
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>         }
> +
> +       if (ff->open_flags & FOPEN_INVAL_ATTR) {
> +               struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +               spin_lock(&fi->lock);
> +               fi->attr_version = atomic64_inc_return(&fc->attr_version);

No need to add locking or change fi->attr_version.  This will be done
next time the attributes are updated.

Thanks,
Miklos
