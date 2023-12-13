Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D381168B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442129AbjLMP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442372AbjLMPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A385F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702480233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/uSB49jsn0w9wzpuib1HRs5w7XO+B0YoYfbjQMuHLo=;
        b=RH0HlXNZlGzeGeYCcNzGSlHEhIugif+qKz2KPU4vENnfE8VUdjcNN4xeNI7MT+ofKXAR4u
        ru8pu6AV07FLA7Hyl2jQqvt63BBTgR8ECeViMaYEgyrBRCfWNoDMEEA/SQZzO0QC5QzP5X
        U+8I4jm3QcF9ZDc2o2ZEYQf3vUTYrTw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--xq0q9X-P2y-52XoiaX_wA-1; Wed, 13 Dec 2023 10:10:32 -0500
X-MC-Unique: -xq0q9X-P2y-52XoiaX_wA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d2e29bd3ddso37113065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480231; x=1703085031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/uSB49jsn0w9wzpuib1HRs5w7XO+B0YoYfbjQMuHLo=;
        b=PtVHZpELwzNnwZiiUu50QJcLUu3ZY9v1kBXXRaGlTY5wunzjqTtlg5AbLcgNY9+PVD
         UeMLCFI3m6qKJoITWRj73cM4nmiXqu+g4JOOSBu6SOMOIPZ5sl7C66pBhMxXX9KBMD+r
         7BBJHEdokJvDMrEUr6z8kMbhNw+K/ZzIG0onMlF4Lt02RkVWbZzZ4yfC1M/NiwGdsd2S
         MhLOr+QQRTyg95xd83ynRQwY0QmrayAlvsSoVy6gKST381BHZe1MIwsqiw0OB2jeNnl8
         y5tpR1vXi+kWDXu+62DUbGy6H0hlxDKTQb5dlGfqFqie5tOeuue59zw+k3OoiKahkFX5
         kvSA==
X-Gm-Message-State: AOJu0YxP6GP2puxrOQin4Y7/yy1YKvnOpn+X+Gwtjzh4lGsFbAazDKpg
        bP/iWIFTFiHWCcsXpi3upv2yLyuQiCM4BDLZJIxYuvfn1vGYaSr68+yXJ9h/sMEYWc6pZQoU1Ac
        AdnyCA6W7P01L54SlV1qAs22pUyvdKTR8RxHR4nvv
X-Received: by 2002:a17:902:bb16:b0:1d3:5020:4afc with SMTP id im22-20020a170902bb1600b001d350204afcmr303177plb.23.1702480230759;
        Wed, 13 Dec 2023 07:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJQDiEHxH6Fv1FyPFGmRNRbnncBiOQLr0KIXQY/DKLNknOl95kj0L0XwwAX71BDrStiAwKvwIrPtESW2mwPGE=
X-Received: by 2002:a17:902:bb16:b0:1d3:5020:4afc with SMTP id
 im22-20020a170902bb1600b001d350204afcmr303160plb.23.1702480230460; Wed, 13
 Dec 2023 07:10:30 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
In-Reply-To: <20231213-drehen-einquartieren-56bbdda1177e@brauner>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 13 Dec 2023 16:10:18 +0100
Message-ID: <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
To:     Christian Brauner <brauner@kernel.org>
Cc:     xingwei lee <xrivendell7@gmail.com>,
        syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:45=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Wed, Dec 13, 2023 at 02:35:58PM +0800, xingwei lee wrote:
> > Hello, I reproduced this bug with repro.c and repro.txt since it
> > relatively large please see
> > https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6
> >
> > Since this bug in the dashboard
> > https://syzkaller.appspot.com/bug?extid=3D0c64a8706d587f73409e use
> > kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/log/?id=3Daed8aee11130a954356200afa3f1b8753e8a9482
> > kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=
=3Ddf91a3034fe3f122
> >
> > my repro.c use the seem config and it crash report like below, and
> > it=E2=80=99s almost can make sure it the same as bug reported by syzobt=
.
>
> Uh, can you reproduce this on mainline?
> I so far fail to even with your repro.

I regularly run afoul of not running "losetup -f" before these
reproducers and so they end up doing nothing; see here:

https://lore.kernel.org/all/CAHc6FU7b-BaBXrMR3UqbZGF3a_y=3D20TKkCNde1GvqbmN=
2-h1xw@mail.gmail.com/

Andreas

