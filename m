Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E42809B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjLHFRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjLHFQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:16:58 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3E10D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:17:04 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb01440c98so3029016fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012623; x=1702617423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bot2e1cf/1z7AjkzDldd1Y3kuzm1SUJ0Ar5mAdYU9Bg=;
        b=M5H+wej8Pl0n6ws/s7bCT+tLBKjWgErodSAlni0p1zd3yvoKQQYvJ2HsAGiWb5g/An
         6ph0xy//aNUQd9uXJ2ViSdLDEWpusQEcRYf3SM5ZTyeKdOgl+6cHOlR30/SqxdgFaDA+
         201/D9ecLVXwdxM9isSCO1NwVKHTWx66ke0pjSZLu8EgAJK5Kib2tazb/Hmm/jZy7UT6
         UBhkvr+iijnRr1aVjaau5oOE24TV2f/15OHbFIMseEUgTHrlwkvhVF0Ja8FPkfIRGsM9
         nSj+dFDr6flxE4YFxEYc7V3E/T8Q16gefVWtjHxCgzHOWEHe1qRwRubxIj0/mG1AWwXD
         +RhA==
X-Gm-Message-State: AOJu0YwZRE+sK2X8QDeHK6IXJvpPfK1OHOTb4mvO4M36dZMHLKg9rgCy
        +NDhyJLq7WlR3Aq7UYR1OhjT77Fk+qfGtwaXLByqtm4CCJvMXA4=
X-Google-Smtp-Source: AGHT+IHjYYP64kwbxy/ZGUFp5/ZizptNtassOAH0m6dlWEHtyyR1dAhUDnZtKkLNUildXSRhFHXQYEcnH8dGsJzLOKV3w7bxgZCV
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d1c6:b0:1ea:37d:c12b with SMTP id
 b6-20020a056870d1c600b001ea037dc12bmr4511371oac.2.1702012623470; Thu, 07 Dec
 2023 21:17:03 -0800 (PST)
Date:   Thu, 07 Dec 2023 21:17:03 -0800
In-Reply-To: <20231208041309.2699993-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d348cd060bf8b1c4@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lib/radix-tree.c:718:17: error: implicit declaration of function '__radix_tree_delete'; did you mean 'radix_tree_delete'? [-Werror=implicit-function-declaration]
lib/radix-tree.c:1366:13: error: conflicting types for '__radix_tree_delete'; have 'bool(struct xarray *, struct xa_node *, void **)' {aka '_Bool(struct xarray *, struct xa_node *, void **)'}


Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1472fe6ce80000

