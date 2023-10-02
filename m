Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A217B5190
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjJBLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:40:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F8C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:40:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6052422acso230455ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696246813; x=1696851613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLVFIqlHvCsToXbvjaX//5QRbVVrNU/QMz+r3CPFqwk=;
        b=jYGq5w7d20sPmtWF1SA3HjBNT9tJPY+iGxRB/GtWdr4py3EErRFFAUQE/WcmtTAW/T
         Nq/C97i1UgKzghwcfYifthqKPHYLKQt3YZkr6693rPQgU/TfjjuLv1WLUiB7x6fDk4kH
         bm6dPMEQkMJVGg/NBokLKp9qMLjHl837ZynkxjDnRK2ScunUGC7PdXBFZyQmwdojDmd/
         elItS6nTocvW0Jta4UyF186rKM2rxxKPH4CQJvoK3pxp/kmRYU1O7crbx813gX2KjgeA
         qmS1uBes1PGfS+Vp4Zp/KpIy5abFuDoTSbpNJKVDPCXaSi89Ia4nzY6weMyK1WGZmkMb
         776Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696246813; x=1696851613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLVFIqlHvCsToXbvjaX//5QRbVVrNU/QMz+r3CPFqwk=;
        b=R2+vwczCT79nDKleVM0E3WVF2E72hQdZVQPPkcN61v0R+Eesojq+zvigV0Hjo/DKsX
         X4T8gBxq7eoSvM9WUNbDeAhKm1i43U7pFt4Mwhr6i5cWi+fHZ5VTK0yoxHMF43zRCiOf
         zMJ+0GU8XbcWuCmnFVv4s+K3pk9/RPuZjbvgakpwWWpcUKJnL+UMu4LB2+p0jHk4BWur
         9fXd83bwpKQ2dqdXBSDSv1oPsqPfQ21dqupr1DbmKrc2uNVJCtB4JQERfbn/mDAibAKD
         +uYPyDvSpQdCNwVNdPncnhzT76emTtC3O9QTjH4+HGFU4PznYouCNoRxeKkeq1HjjKak
         0o1Q==
X-Gm-Message-State: AOJu0Yx7PSPKpKKhqU5K+1bkTRKjSVGirUCMtGjbH+cQz3ypkNeCZ5NQ
        TQmXE3wqIiEvl8VcQzHUQN7iIfOiiNpepiCWoIppGA==
X-Google-Smtp-Source: AGHT+IEOKouSvre5nLaFMRxSwekiM9eKfNYjVdDE3GzzrXOScJfZnPTXR03P3Gq3hjqY27TsaJTewtRc9HfM8qdwTSw=
X-Received: by 2002:a17:902:d4d2:b0:1c1:e54a:3971 with SMTP id
 o18-20020a170902d4d200b001c1e54a3971mr184481plg.1.1696246812759; Mon, 02 Oct
 2023 04:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000035aab005ec690a00@google.com> <0000000000002b41f10606a01a89@google.com>
In-Reply-To: <0000000000002b41f10606a01a89@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 2 Oct 2023 13:40:01 +0200
Message-ID: <CANp29Y5Xp3gSJ4JC6QP_XSiWPPoAsOV8EPEyCNrwPy-cFc2uFw@mail.gmail.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
To:     syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
Cc:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yiyang13@huawei.com,
        zhangqiumiao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 6:29=E2=80=AFAM syzbot
<syzbot+893c55305230e719a203@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 3c4f8333b582487a2d1e02171f1465531cde53e3
> Author: Yi Yang <yiyang13@huawei.com>
> Date:   Fri Aug 11 03:11:21 2023 +0000
>
>     tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D121e6a9268=
0000
> start commit:   a4412fdd49dc error-injection: Add prompt for function err=
o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcc4b2e0a8e8a8=
366
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D893c55305230e71=
9a203
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12b1ca83880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1023c5e388000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup=
_mux

#syz fix: tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_m=
ux

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
