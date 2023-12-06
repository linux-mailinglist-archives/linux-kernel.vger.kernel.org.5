Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD6807860
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379219AbjLFTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442775AbjLFTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:07:00 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5DEEE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:07:07 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb2b95e667so287235fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889626; x=1702494426;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e68f6FqKue8M0jGzCiJGUHLxmm0XLk+1FExZwxvkydY=;
        b=DwVGtGbSoFS8dLlbxHpQnMzX8RefW7xe+e+3q0nwQZ5geqgek3bpo1rdEwGXLrrRIj
         akHR37+6OhwZF5B4gBDHcViYAIz7vv7+B7nf68smu3S1T9+sUzz4pB29005R1a+tPFsU
         yDjvXN6FyvdiXC2IYkComyXw78zzCMIfqIrU7uwFMfRI3p+yoEZB6MFWHyNhftUmxVik
         epFoHvcQWBV1tZ9vzPzibCX8VzuB0j64yfabfq2nf611y3Eg8iF3V+/7Y4nXqZost8H5
         7Zh3Pyp1hBcU1jvHM6VK3KoTCgLFPyF7ydGTQxqJnSBctP0OpoJXp4u+3QvZzqzIgTjo
         TvHw==
X-Gm-Message-State: AOJu0YyMdXCDRjaNLNrF95DMhoF43NpwVWwSMH40NmQnKjzlfiXPWh2/
        6bNllaHTNH37X2DKZjrikqKfOIrzWG/X+M17yuBO6cZAZQZHPgQ=
X-Google-Smtp-Source: AGHT+IEGhW9OFgCk6+fUXuLu4B9IRHNKj5ifxABzBTym95ASC+GaDuhpKpuQMT+xrZiyqgXOtcQR+4VlYb2qROLsRkxD0qMT6VbI
MIME-Version: 1.0
X-Received: by 2002:a05:6871:593:b0:1fb:1b3c:b5f8 with SMTP id
 u19-20020a056871059300b001fb1b3cb5f8mr1627282oan.2.1701889626348; Wed, 06 Dec
 2023 11:07:06 -0800 (PST)
Date:   Wed, 06 Dec 2023 11:07:06 -0800
In-Reply-To: <CH0PR10MB511315588F14A86E6A3E332D9584A@CH0PR10MB5113.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0232e060bdc0e9e@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/hugetlb.c:6485:17: error: too few arguments to function 'set_huge_pte_at'


Tested on:

commit:         bee0e776 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1621e60ee80000

