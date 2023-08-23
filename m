Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0A785378
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjHWJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjHWJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:03:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8412D40
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:57:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1f6f3884so697086066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692781074; x=1693385874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j94zWW7Vhu+ruknitmkA2V61CnG1G233OM0eLPAXM94=;
        b=aE8USWDve+ALI4xTEFgpO9tclZQeUCRPADb7topbHxa8xw8n2gjpZWpr25uzUb1d4o
         4gpCN6Emb7DSX1w/oGpJviJTtYX/bJDMj7FFb+2x3llYXXXXG6N21MPPWNQjQTx95phM
         6C0E8hjoDSmo7sa8LyQ85wpYsjHjgvBIAKw7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781074; x=1693385874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j94zWW7Vhu+ruknitmkA2V61CnG1G233OM0eLPAXM94=;
        b=HEJvDxAY7VxbLTBMjZ/2KIlK7qeDMSKvS499hHiY8wA2a5vMlyPMcWhy11gRvxdTTv
         fN1C2c3bqKKhU9ChUlqqj0vgLjOJgyKuvo41RyMk16+7aK2ax5fpMVO52exsejWNEKh0
         4BKxkt0MyJk07ZyWvmWS5oXWc2Wo8na15wW73MCbh9F4L3DsHbeQ/ysqFFgLPiTFZPYz
         SEoGxYDB1sBLnX9K66SR8u10Atarz+zOWdPT0M7Z2cK79/x6Vc4WyftYLv1dike6GQl9
         V3fWbOjpptzCrnEKEkd9HVJWUxZHbY7MBAGH3csfDjF/73HwlQmRbTeP6ZMnitWNI/IP
         q1Uw==
X-Gm-Message-State: AOJu0Yw4SepJarz5DC+tTM7RdjXafXCaZgMzVICFbfShx+2/hgtUV8TJ
        zmRDIzcUVr1MLx4slQJeAndYzDxAocLZ7wJkMscHXw==
X-Google-Smtp-Source: AGHT+IHu4J7XyCWwQocI/2gqFnASyJynFOF4R6ZFGu4VmMZ/F7bDbjKPAe77MZcL9mjbpK2ZFj2uWOntDLLUgUi3yH4=
X-Received: by 2002:a17:907:801f:b0:99b:d599:5086 with SMTP id
 ft31-20020a170907801f00b0099bd5995086mr8048062ejc.75.1692781073800; Wed, 23
 Aug 2023 01:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com> <20230711043405.66256-2-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230711043405.66256-2-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 10:57:42 +0200
Message-ID: <CAJfpegvkcYcJYL0Q6XxF1E0MiQ5NxvReP4H=7Ra=yCrDLTqD1A@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: check attributes staleness on fuse_iget()
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
> Function fuse_direntplus_link() might call fuse_iget() to initialize a new
> fuse_inode and change its attributes. If fi->attr_version is always
> initialized with 0, even if the attributes returned by the FUSE_READDIR
> request is staled, as the new fi->attr_version is 0, fuse_change_attributes
> will still set the staled attributes to inode. This wrong behaviour may
> cause file size inconsistency even when there is no changes from
> server-side.
>
> To reproduce the issue, consider the following 2 programs (A and B) are
> running concurrently,
>
>         A                                               B
> ----------------------------------      --------------------------------
> { /fusemnt/dir/f is a file path in a fuse mount, the size of f is 0. }
>
> readdir(/fusemnt/dir) start
> //Daemon set size 0 to f direntry
>                                         fallocate(f, 1024)
>                                         stat(f) // B see size 1024
>                                         echo 2 > /proc/sys/vm/drop_caches
> readdir(/fusemnt/dir) reply to kernel
> Kernel set 0 to the I_NEW inode
>
>                                         stat(f) // B see size 0
>
> In the above case, only program B is modifying the file size, however, B
> observes file size changing between the 2 'readonly' stat() calls. To fix
> this issue, we should make sure readdirplus still follows the rule of
> attr_version staleness checking even if the fi->attr_version is lost due to
> inode eviction. So this patch increases fc->attr_version on inode eviction,
> and compares request attr_version and the fc->attr_version when a
> FUSE_READDIRPLUS request is finished.

Thanks for the report.  It's really interesting that you are the first
to notice this misbehavior, even though it's been there since the
beginning.

The fix looks correct but suboptimal: fc->attr_version will get
incremented due to non-evict events as well, which could lead to false
positives.   I'd add another counter (e.g. fc->evict_ctr) and manage
that separately for lookup type operations (LOOKUP/READDIRPLUS).

Thanks,
Miklos
