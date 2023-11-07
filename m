Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC87E3696
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjKGIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjKGIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:25:09 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE447A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:25:06 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e9b0514cb2so6784991fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699345506; x=1699950306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VeWHnX3FKLObEtyX6GlSBLB+HcaO16fQrZJABNKmrA=;
        b=cLCmXf+e1aVBC5VsMclcZ9lveK/9V4cebjR5A9VGG1Rqu5Yo+eblCXVdz0w+ewjN2C
         GD5eMgOQWpkNkQrNxYYRrkJX8BZvEW65QbdeZQElubVd8H8I1ojRWwSApuvxQB/52wPs
         cQRG4GJjZjC6tjSFDRmMMoWEH/5MsiV1nYkOV2tP9S6qMR6ds7nx3070zC9akkMqwROF
         2QGhCf8zHXsVWRfLVkMIy8STU6QYCRmcvBpkwJcY97oG8O2eYBB8Mf3YQ9i5C2iIwxq+
         O2qnbKh0PFh0wtPbGceZG4tFJBPQcVxp1n9N2gVwS09ERZJ1THzFSs8KTmNJJMP8uKsY
         ozjQ==
X-Gm-Message-State: AOJu0YzCcHlhyCKOQcepjyM+7PFvnJqevwxGeVjXegleI2VqSNRVrQTj
        YovHm3CNjl9juqbbxYfrTLw1J+d9p1sea7EsloZSo/fgIdXp
X-Google-Smtp-Source: AGHT+IGJEd5Nq1Mz1pOFbxEaR60SDM8zts1GWxm0RyeCCsYGeWxT13dinNOJtnz8GWzdFwASj7cOe1upjxWEL6VJP2SWJnCZs7e9
MIME-Version: 1.0
X-Received: by 2002:a05:6870:241a:b0:1dd:7381:e05 with SMTP id
 n26-20020a056870241a00b001dd73810e05mr950466oap.3.1699345506174; Tue, 07 Nov
 2023 00:25:06 -0800 (PST)
Date:   Tue, 07 Nov 2023 00:25:06 -0800
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f0e4406098bb529@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From:   syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jiri@nvidia.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1734cd60e80000
start commit:   d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b4cd60e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4cd60e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

Reported-by: syzbot+9817a610349542589c42@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
