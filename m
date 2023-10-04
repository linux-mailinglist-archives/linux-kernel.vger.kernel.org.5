Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531DA7B7CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjJDJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjJDJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:57:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91759E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:57:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c6052422acso108085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696413469; x=1697018269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM7BG54IGeNcadztHnJVieIfNJYmVQnqoKio+eTmSoc=;
        b=b2jCyj0xQ1v7uedK+4/PvDlrUIrlZ0bSL+10XrEchycRNIMP2IPTObmRFGABM3hznN
         aRFy/HCLE/07zBJwWvvi21eJmVFtPdOOa3V7xjLfwfxcWPkZYEZ0nPAFpxb/4OPTCeNU
         da7KdgVDWuUBq+YLae4jjLxuhMiawumWQkNN4JjF49pIas9EiJZlQYduQOR+5j0RGGtu
         +MUt8eMDZgp3Z6cBRWNrCw9GLJKuEFmn18bmU39Ws3bAckwnxFFjDh3XUCj6kCMJrR6o
         9viS34JZZgAtfPwcK+Inh5FSvITtGIqDnkwHr4WthMJcH2Gh49NpxgzbwAtA2HEo/yMq
         B9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413469; x=1697018269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM7BG54IGeNcadztHnJVieIfNJYmVQnqoKio+eTmSoc=;
        b=PIb2x6ilgB5i5RxqTje8ZOW8arliZk1/P4d7hi8mSXcHdKyzdlRHPrZ+8y/itjNqsJ
         9by0Eyw1TC/9OlqjJ6CJFE/UQT/IBvRsQHFmamlSbnPzA93oQuQrCTQRGdZqnvwh6PxH
         9nMpFKt2uZoTwoqXJDXtkNNcMnNRjPcZRe5oAjLYoZ9fG1hlRje4nJ2NpT0/uavuD/Xu
         gxBhV5n0USvFIsO3eNfhqr79w3M6ru98JjaOwOHXRwGAKcgf+3utmN/+AcV3W9bDC/ys
         KCcVZwtclyciMHtVih9Hbtb4awFdKDCT7W0z+eJvMGNGuNEKrpz5AdxgUNUN5qDE/dQl
         M1Lg==
X-Gm-Message-State: AOJu0YwzNpbpk8fiIYb77HZVr86j2m5yOfqVLd8kbyLKycda7PghFga9
        CYbPV9/98tniS3Vb9aEWC1FVso5sXpEkDJvS+fykXA==
X-Google-Smtp-Source: AGHT+IEIDOc4KVSYMmRNDXodVgTUVlh7i7f8MWEUu4ZiNyUP9I+Q9wNcnYFIvP908iaq23sTB++9/0TUlP0w7aUboPk=
X-Received: by 2002:a17:903:22c3:b0:1c3:3649:1f6a with SMTP id
 y3-20020a17090322c300b001c336491f6amr137837plg.7.1696413469078; Wed, 04 Oct
 2023 02:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044b47605ee8544b2@google.com> <000000000000e99a3e0606e0169e@google.com>
In-Reply-To: <000000000000e99a3e0606e0169e@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 4 Oct 2023 11:57:37 +0200
Message-ID: <CANp29Y4MJvu7RANUknMGthSMDJb2u_5_BOgfYce=SiMKK1aKtQ@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __ext4_journal_stop
To:     syzbot <syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, joneslee@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com,
        syzkaller-bugs@googlegroups.com, tudor.ambarus@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 10:49=E2=80=AFAM syzbot
<syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> ext4: fix race condition between buffer write and page_mkwrite

There's been such a series, but it apparently did not get through.
Let's unfix the bug, syzbot will either do a fix bisection and find
the actual fix commit or auto-invalidate the bug.

#syz unfix


>
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
>
> #syz fix: exact-commit-title
>
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
>
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbdab24d5bf96d57=
c50b0
>
> ---
> [1] I expect the commit to be present in:
>
> 1. for-kernelci branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> 2. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>
> 3. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
>
> 4. main branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
> The full list of 9 trees can be found at
> https://syzkaller.appspot.com/upstream/repos
