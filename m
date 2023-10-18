Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677917CDAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJRLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRLoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:44:37 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87AFE;
        Wed, 18 Oct 2023 04:44:35 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-457bac7c3f5so2705527137.2;
        Wed, 18 Oct 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697629475; x=1698234275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiYUDUcKnehSjffzREvUBbALA9UBWc+RpuBwUEC7x8A=;
        b=IE5sUdIUWXPbljHgL38+01IdQTSlAotc5tL6Su/0PiD2X+C+BJ8cKn/hBg1H/qKPwD
         HoxMyQ06a04N3n5TCB83wSeAFmOe0l4L/xHblUIFY1FYp4nFYK71VS6TlfzbjfljZ5uQ
         QDaybcDB6gT35YOXxqIgryjA4847WGu/ro4CY5Q+3v1Tr2I7FmymFOKoigcAGXFkX+Me
         RsfgYjYX7AFdG/l+BdYT2NNGbIDieKt6Pu/8IIiV8oWvLaeep6Jbs45InKMGb6+L+lQR
         PgQRnX9K8/Y4/h0ABhAhQrYUcPCg7Z8l5QqvyJYfPngWsDGGzJalQl7OOouxwFFBuYqS
         G5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629475; x=1698234275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiYUDUcKnehSjffzREvUBbALA9UBWc+RpuBwUEC7x8A=;
        b=SM2oSV7xSqTZmn72Iv1untFUCKoaVQ/P44uyD3ELjTwNDPAIukdZOzG6GTlnDS3MDG
         7QW4HXMO8V2EJwFuJHfFMTXGgu3BJf/YCcuhOqqlkq9vy9Ycyg816T1kmY1OT0PARVPw
         fzJNVXFmDQp2xLtZ1NGWhmaAqOgaqnZPNxMFgEJ65gTk+bplwh4YOzRYP1ID4i/D86R9
         5DFhEr6vGoXUfvptiKo/GlNGKbDhYS/+1ouDOZ960kFd1R+gFfbFgnNdUYOK9tUXVzmZ
         1CeMq76e9C2OO0Ja54MPBSxWf2rbuMzQrLLCQNELwlcNKYNLZLE42OnmKlZv5OQbsBL6
         0JwA==
X-Gm-Message-State: AOJu0YwTtwOffezVMlNH/4QSp/pehxThagbjUafrJr5TrTrAkOjbqr1V
        oKSx1EZl7runnYI25V2AAEP1AvF105hFfS0RYnmzYTxeHdw=
X-Google-Smtp-Source: AGHT+IEXtfkdK4Eo2DAhBcc51Slee5bbKqaF6DfWGL8SlocR50WyYe9feEanqX+tiO0Ann7oB1PHlGy3oZ1c781Pc3k=
X-Received: by 2002:a67:e010:0:b0:454:6ccc:ab79 with SMTP id
 c16-20020a67e010000000b004546cccab79mr4656821vsl.11.1697629474747; Wed, 18
 Oct 2023 04:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
In-Reply-To: <20231018-amtime-v1-1-e066bae97285@kernel.org>
From:   Klara Modin <klarasmodin@gmail.com>
Date:   Wed, 18 Oct 2023 13:44:23 +0200
Message-ID: <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
To:     Jeff Layton <jlayton@kernel.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that this patch fixes the issue, thanks!

Den ons 18 okt. 2023 kl 13:15 skrev Jeff Layton <jlayton@kernel.org>:
>
> Klara reported seeing mangled mtimes when dealing with FAT. Fix the
> braino in the FAT conversion to the new timestamp accessors.
>
> Fixes: e57260ae3226 (fat: convert to new timestamp accessors)
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This patch fixes the bug that Klara reported late yesterday. The issue
> is a bad by-hand conversion of __fat_write_inode to the new timestamp
> accessor functions.
>
> Christian, this patch should probably be squashed into e57260ae3226.
>
> Thanks!
> Jeff
> ---
>  fs/fat/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index aa87f323fd44..1fac3dabf130 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -888,9 +888,9 @@ static int __fat_write_inode(struct inode *inode, int wait)
>                 raw_entry->size = cpu_to_le32(inode->i_size);
>         raw_entry->attr = fat_make_attrs(inode);
>         fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
> +       mtime = inode_get_mtime(inode);
>         fat_time_unix2fat(sbi, &mtime, &raw_entry->time,
>                           &raw_entry->date, NULL);
> -       inode_set_mtime_to_ts(inode, mtime);
>         if (sbi->options.isvfat) {
>                 struct timespec64 ts = inode_get_atime(inode);
>                 __le16 atime;
>
> ---
> base-commit: fea0e8fc7829dc85f82c8a1a8249630f6fb85553
> change-id: 20231018-amtime-24d2effcc9a9
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>
