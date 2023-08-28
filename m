Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB96878AE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjH1LE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjH1LEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:04:38 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66EAB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:04:35 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bde8160fbdso28463855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220675; x=1693825475;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAE+2HYfYhVD8qu8qviilvat+opvTDEp0h5ZbXA1nw0=;
        b=ZId39NNGM4M04BCnaWZBQ2c76ekKlL/D5/RhIrp7hmebVGT4du7+w1jXHEc+WSKnqE
         o3PDf089DpCkg2SNfzU/mfCZFNhEC9f1Xvf74+Kxs0WFgb4ugvxMNIueUwFDpQJfVH9m
         in6YfQRcD1ZLdQ+A7DWTpf9p1I49MIinv3qt1j4mFrx/ONagn3p6+ONsTTblIVD9qk4E
         mhgk6F8xxVOcLEYX+xnQT44DnY+6+prf2SuxA2EJ97SBTrHrJbGdRcLlBccW2LWClGt8
         YkXi4yRCCdtanBBrupNwwzSw+y+079+Xg/ym+L4SbkpWFMSHJV1BnkatLnTtKfTja7Uy
         AE/A==
X-Gm-Message-State: AOJu0YwfuuphqtDIWBIDkG7LNu5eHME/LgV789fWWO4sjEF0hLReMmgD
        lT1b21XPlZj9VhlGgq7Tt8BQf0sbodtLVsPp0GifgdaV3x3w
X-Google-Smtp-Source: AGHT+IFtCvS9uIpt8BB6QQL11faTq/pEr68bIeSxnFL9V6zDVg+aAGJnEno0RzC2BePxdA/cK8YI43XG3c2DuOuX+BftQknj85iq
MIME-Version: 1.0
X-Received: by 2002:a17:902:da8b:b0:1b8:8fe2:6627 with SMTP id
 j11-20020a170902da8b00b001b88fe26627mr9022025plx.8.1693220674964; Mon, 28 Aug
 2023 04:04:34 -0700 (PDT)
Date:   Mon, 28 Aug 2023 04:04:34 -0700
In-Reply-To: <20230828103004.3804-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db957b0603f9a837@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in ceph_compare_super
From:   syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 28c736b0e92e: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1"]: exit status 1
From https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
 + 28c736b0e92e...2ee82481c392 master        -> fc608f7504e8b3e110eb6e7b798cef357818c5e1/master  (forced update)
 + 0b86d65557b6...63006762d709 pending-fixes -> fc608f7504e8b3e110eb6e7b798cef357818c5e1/pending-fixes  (forced update)
   f7757129e3de..2dde18cd1d8f  stable        -> fc608f7504e8b3e110eb6e7b798cef357818c5e1/stable
 * [new tag]                   next-20230828 -> next-20230828
error: cannot lock ref 'refs/tags/v6.5': 'refs/tags/v6.5/vfs.fixes' exists; cannot create 'refs/tags/v6.5'
 ! [new tag]                   v6.5          -> v6.5  (unable to update local ref)
error: some local refs could not be updated; try running
 'git remote prune fc608f7504e8b3e110eb6e7b798cef357818c5e1' to remove any old, conflicting branches



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 28c736b0e92e
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=2b8cbfa6e34e51b6aa50
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108a71dfa80000

