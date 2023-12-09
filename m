Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE580B2AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjLIHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjLIHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:04:58 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359F193
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:05:05 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fb04956beeso5248499fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 23:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105504; x=1702710304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eO/qrxPVsyHIYvBjnrSE4zBIKRTMybaDgQV47h24H0=;
        b=KnkwxGSov+LBo9iU/TfyUoNytOnC1F/DCpDI3Nbuw/lubwFgBCjOf9C1nRct1dp99e
         k4qZGfRrdr+s3foLtg8EDYWd3n2t9e6WrGP43oPMII5QEnQcKaPDIzVyqZJcH5Zjr6yd
         eIKunxFQVD8HjuW1bveYguJzC+SW8qWNVeGiYGSRWa8jBQ2N36fBixWqwmHSWdPmgq2x
         GAPhZAsV79XxJuJx2fWpwA5kPP4hg71blnp73xT9MJoDVmIXMQOb2/AFAxHNfub29jYo
         H2UpRUlGRM1DSXLqH7iCYXogC/8vMkG5eQiB9grpeN6pLXPkjjAg3lFrwrGiE8n3k+6u
         clxQ==
X-Gm-Message-State: AOJu0YwhpxVIIVCih8B3c9ABcpl0dPFT8Ub0JKeJOrofdXQ5DAEbKKx0
        kQeOi7K4jOuKddDp4PbEQp64LEla1V5+vBnyVzz+KUBlzFY/
X-Google-Smtp-Source: AGHT+IHtzAhf8RsRK2iGRVopyc/WOqcXl9f1i6Mwj3H/sWYaxs1hx/dBWH3vBbIrm7+GTRHETtZ9uUFmhpAQ0slu0Ydi/ILHnXFt
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e310:b0:1fa:edd5:cb79 with SMTP id
 z16-20020a056870e31000b001faedd5cb79mr1130751oad.4.1702105504464; Fri, 08 Dec
 2023 23:05:04 -0800 (PST)
Date:   Fri, 08 Dec 2023 23:05:04 -0800
In-Reply-To: <tencent_366443176A9766C6D8D36A8374896363B605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6c78b060c0e51bb@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/qrtr/af_qrtr.c:293:44: error: 'struct qrtr_tx_flow' has no member named 'failed'; did you mean 'tx_failed'?
net/qrtr/af_qrtr.c:299:49: error: 'struct qrtr_tx_flow' has no member named 'failed'; did you mean 'tx_failed'?


Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1508339ce80000

