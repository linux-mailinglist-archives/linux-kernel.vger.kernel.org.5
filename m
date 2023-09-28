Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863CA7B23BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjI1RWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjI1RWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:22:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5DDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:22:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a645e54806so1682494866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695921735; x=1696526535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbBBWlIG8ShXasc+/VZ6EV1FLcrQl5lcjcGdAjjkp7k=;
        b=ZU6ZHB1G6hrLMPSGlFT8Mt0LpqT8WdAbk7Jr/BInTp5SM6EkvLRAAgUhTQhwi4yDVf
         WYKRdzhuF5QBKZeuyA6aeDuKcJGjwU4XcrdV1jC27ron9kC1hjGq/ciXzCVSvYIdKLxu
         P27sACuCpDNP0U8veXpJuclNsl4gdkIsyRi00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921735; x=1696526535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbBBWlIG8ShXasc+/VZ6EV1FLcrQl5lcjcGdAjjkp7k=;
        b=iGOvbk1J0ma26ymA7PERqbX8xBNMVi6mUakMGP0OfP2aiW5Mxa3/tD7XanNFsRqCl/
         GPwk2GpW+R2VMB8/ojGgtGSagxLvIZFWc44VN78FAtSlWU6TbXdRy9n+WS8qSXKrfonq
         QGeD1+6SbnecJOzCnOd/B9jSiJFN4qp9MHr5qighm5oEVJVS9wLXihPrHFJWhmSFZdTn
         dqJ26oFrKbIhY7GR8X2z9vaLw6YQcxfubUuu9T+GtQj2GFyagSaeWTqk2hDgPs7MaZZ8
         YGMA/HilMADSG6l4J831pXDhHPqYgAwIGs5QxWTHU+5cg2j0qT2/5E45UVdu7NogYddf
         aDCQ==
X-Gm-Message-State: AOJu0YyBUwujKSc5j7MiwmulLWRLaAp6pGQ6hhuGYk0/MpQQjjSs8K0X
        tUKDOPXahuiB3UyfX4LyvKgz3S5gEBli6qDcqGLxpuq7
X-Google-Smtp-Source: AGHT+IGMUmf+7BS4g0cEAno5opRIm6nbV3CUAq2GHUWsZaxN5vKDIw5bs6fhWrdzuUOfaRlB9UmVkQ==
X-Received: by 2002:a17:906:209e:b0:9a2:120a:5779 with SMTP id 30-20020a170906209e00b009a2120a5779mr1811530ejq.60.1695921734848;
        Thu, 28 Sep 2023 10:22:14 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b0099b921de301sm11178509ejc.159.2023.09.28.10.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:22:14 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so1677189566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:22:13 -0700 (PDT)
X-Received: by 2002:a17:906:32cb:b0:9a2:232f:6f85 with SMTP id
 k11-20020a17090632cb00b009a2232f6f85mr1865368ejk.52.1695921733456; Thu, 28
 Sep 2023 10:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
In-Reply-To: <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Sep 2023 10:21:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
Message-ID: <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 07:44, Jann Horn <jannh@google.com> wrote:
>
> The issue I see with the current __fget_files_rcu() is that the
> "file->f_mode & mask" is no longer effective in its current position,
> it would have to be moved down below the get_file_rcu() call.

Yes, you're right.

But moving it down below the "re-check that the fdt pointer and the
file pointer still matches" should be easy and sufficient.

> There are also some weird get_file_rcu() users in other places like
> BPF's task_file_seq_get_next and in gfs2_glockfd_next_file that do
> weird stuff without the recheck, especially gfs2_glockfd_next_file
> even looks at the inodes of files without taking a reference (which
> seems a little dodgy but maybe actually currently works because inodes
> are also RCU-freed?).

The inodes are also RCU-free'd, but that is indeed dodgy.

I think it happens to work, and we actually have a somewhat similar
pattern in the RCU lookup code (except with dentry->d_inode, not
file->f_inode), because as you say the inode data structure itself is
rcu-free'd, but more importantly, that code does the "get_file_rcu()"
afterwards.

And yes, right now that works fine, because it will fail if the file
f_count goes down to zero.

And f_count will go down to zero before we really tear down the inode with

        file->f_op->release(inode, file);

and (more importantly) the dput -> dentry_kill -> dentry_unlink_inode
-> release.

So that get_file_rcu() will currently protect against any "oh, the
inode is stale and about to be released".

But yes, that protection would be broken by SLAB_TYPESAFE_BY_RCU,
since then the "f_count is zero" is no longer a final thing.

It's fixable by having the same "double check the file table" that I
do think we should do regardless. That get_file_rcu() pattern may
*work*, but it's very very dodgy.

                Linus
