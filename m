Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858897D5EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjJYAHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJYAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:07:35 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E499DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:07:33 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e990f0629cso7871540fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698192452; x=1698797252;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h61pamVNNcEp402Yhu8TGYZL7jtM04uYQ13XOvQik5E=;
        b=X86oZKwBmm06QtMKb/GDz3YUN543R0khVbCcL3WAhva3eEqy9ttD4sFB8mRrVy4KbH
         HUt9Sg1w/7lzivD2ww3+6mHOwfGdQpOK1yP6StIh8x5ouaikL5jK1O7BfoDDqEghk9o7
         xVrdjQ5guz274zxhEIOmKyioBSYle//tULo3DIawxFByXmSFbsAGZOekdtdVTblIV8YM
         neSseNezLtrfs+sKZAkwQZ0NgDvzGR0VZ4jFl7YRz9gCbYEON4j0nJNaa0okzw+SknNM
         P4QJrWrBXtDTvjEpAJdjgS4+JS/JSBqwrUZ4ddoBBifKQ8962VmI1ffAZEad35ehTJDz
         3EqA==
X-Gm-Message-State: AOJu0Yxx9LRN5aTOYUMVE6GtZRDwQtGSMKUVhDQ2vOUs2aWVffm4dMp1
        SCLLYVRDRSQPDArnMIJGk36GXM/VW2UH3mpyLpe/AZjySVZm
X-Google-Smtp-Source: AGHT+IFiUZ73nifBkYmIbZJWY6K2fUH4fZjbeeve6JWATWreguR4LDiCR3OKFBxncuacUu2ENnyxBzEq0NvMaeKy5+r8nopQOnQ/
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7190:b0:1e9:f918:1295 with SMTP id
 d16-20020a056870719000b001e9f9181295mr6404221oah.7.1698192452670; Tue, 24 Oct
 2023 17:07:32 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:07:32 -0700
In-Reply-To: <000000000000985ef90607610b0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6dbc706087f3df8@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
From:   syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, postmaster@duagon.onmicrosoft.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit edd33b8807a1fa6268a71758bf38de0b4adf2e70
Author: Hugh Dickins <hughd@google.com>
Date:   Tue Oct 3 09:29:00 2023 +0000

    mempolicy: migration attempt to match interleave nodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d353cb680000
start commit:   e8361b005d7c Add linux-next specific files for 20231023
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=103353cb680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d353cb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39bda8753f457952
dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13714705680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1236430b680000

Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com
Fixes: edd33b8807a1 ("mempolicy: migration attempt to match interleave nodes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
