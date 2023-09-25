Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2207ADBD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjIYPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjIYPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F12121
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a65f9147ccso824047566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695656472; x=1696261272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm7sOARsZZGXTiHqGHX7p0Bo9SfB/BQShVjUnQbebW0=;
        b=JnIJxUgSc5i7nq8yqlPlGNsN86fRxw7kK3ZTfAWcKmWzTl8Y6WfCZBgo7TbC1Izui9
         I1dWnCHcCMyThY7NNd7bdx39s06ENk9SgSmMbmbY99XgXbj7t5iSlYS4vaWcPdD1R9cK
         Kr/Z6rhC+XKermGhza8ggPlRmJ1LrZVomtC08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656472; x=1696261272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sm7sOARsZZGXTiHqGHX7p0Bo9SfB/BQShVjUnQbebW0=;
        b=O+lHRqjTqjWftNle518Afhtzt4FkNq91sMYXEb3JwR/Be9S71XjmyOacotNl5J6Jt8
         VcL5bvJ48NB5UljkO/Low2Cbz2ItCdlW4PtDRA57j5LAoCL69CUDYi/K0OtchNlq30Zj
         Rpq9bEI/B1vhFFjOaSbZLMP7ZyibrhdYxFElQqZppiomKNTJsXtzfeScIRxHEsTTSLue
         Mn+MYgeCOy7wuL766w1pckCYZD4KNwUJdQQIr/5pTIfO0CiM7jYRd52tjmmGY/W29RJ7
         IamcTp8aDIsEaTjVKqSVc7i1DmFKlxym+lvKF4NHCRqcnFelZqmIBxSOkYS3EV7cUHTy
         UbxA==
X-Gm-Message-State: AOJu0Yxo0tA/rjQbqU/JJTriRWfB5bd1vBYdtBeKbuW8VOK/OoHA5tdT
        cxd4zlF1X+WPSv/VFYoIasdQFepwS1q9HbL1OSD8Zw==
X-Google-Smtp-Source: AGHT+IEA0obgVSTbxbOxjgkOBDcMqXVHTV9RwPKYtPE0d938NcyYll+LzAB4/mJoSEaANNKRkeCHmw==
X-Received: by 2002:a17:906:5a44:b0:9ae:5253:175b with SMTP id my4-20020a1709065a4400b009ae5253175bmr6162949ejc.34.1695656472138;
        Mon, 25 Sep 2023 08:41:12 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906168c00b009737b8d47b6sm6432190ejd.203.2023.09.25.08.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:41:11 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so821917566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:11 -0700 (PDT)
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id
 25-20020a170906329900b009ae6196a4d0mr6349094ejw.17.1695656471127; Mon, 25 Sep
 2023 08:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230923191420.10c42e4f@rorschach.local.home> <CAHk-=wh=aOhPAJn-E8T+GofoBeCtXuoEXZcw6A009MO4s3mNAA@mail.gmail.com>
 <20230925105335.5d8f6af0@rorschach.local.home>
In-Reply-To: <20230925105335.5d8f6af0@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Sep 2023 08:40:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnHNfd8BqA=CxiAeOnPRDw=5DUJCakCJqtRJ8t=JWCZQ@mail.gmail.com>
Message-ID: <CAHk-=wjnHNfd8BqA=CxiAeOnPRDw=5DUJCakCJqtRJ8t=JWCZQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for 6.6-rc2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
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

On Mon, 25 Sept 2023 at 07:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> These dentries and inodes are allocated for the top level directory and
> wasting memory for most users. When an instance is created it makes
> matters even worse.

So honestly, dentries are *tiny*. They are probably not any bigger
than the backing data structures you use to keep track of the names in
teh first place.

The memory cost is likely almost from the inodes, which are indeed
pretty big and fat.

> If there's a better way to achieve the same thing, I'll happily do it.

Do you actually *need* individual inodes for each of the entries in tracefd?

Because I think the *big* memory savings would be to use one single
inode for every file (make directories have individual inodes,
anything else will confuse user-space 'pwd' etc mightily)

Then you'd

 (a) have the actual tracefs-specific data in dentry->d_fsdata

 (b) use "-inode->i_op->getattr()" to make the stat() info look
different for different files (if you even care, but you might)

and I think that would be most of it.

You might hit some gotcha somewhere - things like "dcache_readdir()
will take the inode number just from the inode, and there's no
callback for it", so if you care about showing unique inode numbers to
user space, we might need to help you out some way.

But that "reuse a single inode" is actually a very traditional
pattern, even if I suspect that pattern doesn't remain anywhere. /proc
used to do things like that, iirc.

                        Linus
