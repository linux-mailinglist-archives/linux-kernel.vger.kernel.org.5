Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8FF76CFDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjHBORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjHBORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:17:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BF272D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:17:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso101135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690985855; x=1691590655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qwGbFPriiBctUTIf5EIt3Ji/aXV3Kuo6I3x1a+UHFM=;
        b=BG89yUNHMkxHF810dZQ2ZbAQDhv1zP8ZVtcAC67c+E/BGxxEfwn4+7QZVaZ2IEU3oA
         dRKokiLUubYgxTgf4Sn1wNsYw6fAD9khqzHlOtRG2LwfWMY+ycelPCDRCbw0mSP+JyLb
         +VOuz9juHYmbJwonRj+vuJwSQ9D/wf5YwXOUWYqZpNjbZxReeLdfs9GRzI59kYWZ/+Zw
         cbc1l3DsrC8fivpFjwhMETPUzPXDKc+Cr3V7cDVhiU64ItLEoj+QCp5Yw6HLZRuCwzAl
         gUXlCMjT+E7TpoT+C3mCINReshqlHXrs+Ui1zIP9CUJLu+27QClyR9Fk0PT8FjGosHSO
         uDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985855; x=1691590655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qwGbFPriiBctUTIf5EIt3Ji/aXV3Kuo6I3x1a+UHFM=;
        b=ZGi1C9o05QT09zRMRnQvpsq+pdCL7GaGC3TJ1fYLjhzjmauLaP3No2VAV8OcMTkcP0
         aPUgDIjPJmkun0hxfx3xxF3w5aDoFqyIKXiBnfPQGroIrqP2yZ2hzMMuo6y1lB7vWtsg
         jkj4lDxmfx4r69mCopHdLkWjNgbGcddtwXJ8/iQd4605UC4yjL2g6gx/t+6NYiG5DnGC
         cYkpHLzLb/dWqxxKHNVGdknamUVx4u5c4ctIA9KYwUtIvIU5trVi/75y1xGKC5N/9VA8
         G0DVsOxs/hodT6hURUeGbXP0S7bWF6zsd9JzBRMRQqy70xiUZup9FEPDOO9EviecjPxT
         dgTQ==
X-Gm-Message-State: ABy/qLa9eHS0H8Ff9UxsaLk/kn1vy/iLTfu5ElXcor5QL8IBFXi4HqpA
        phSmzDE/LkDKTXb+nO7yDdDngBlmNKNuaqFeRpJ44w==
X-Google-Smtp-Source: APBJJlFryeNX8uWaYtlPyiRZrYLoVMke66TACyC12BOcmdmUSt10i7iCuVQR7UWUxyqxD4dPSdQ7ot33jqSSw8snvwg=
X-Received: by 2002:a05:600c:3415:b0:3f7:e463:a0d6 with SMTP id
 y21-20020a05600c341500b003f7e463a0d6mr380986wmp.0.1690985854925; Wed, 02 Aug
 2023 07:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd151d05ece59b42@google.com> <000000000000261e660601dec2c2@google.com>
In-Reply-To: <000000000000261e660601dec2c2@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 2 Aug 2023 16:17:22 +0200
Message-ID: <CANp29Y5DKbC0oCcxoX-fST0LQ8=0KZ-RK-GXL=2Vw=3y++wtOw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_search_slot
To:     syzbot <syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com>
Cc:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 6:08=E2=80=AFPM syzbot
<syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b740d806166979488e798e41743aaec051f2443f
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Nov 7 16:44:51 2022 +0000
>
>     btrfs: free btrfs_path before copying root refs to userspace
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13015709a8=
0000
> start commit:   eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d01b6e319797=
4dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc06034aecf9f5ea=
b1ac1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124fc309880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D126dfde588000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: btrfs: free btrfs_path before copying root refs to userspace

Looks reasonable.
#syz fix: btrfs: free btrfs_path before copying root refs to userspace

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
