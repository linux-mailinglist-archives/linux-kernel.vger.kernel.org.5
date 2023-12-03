Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE18025E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjLCRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:12:01 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E8CFC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:12:08 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b8b5b4edd8so985719b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 09:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701623527; x=1702228327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnOA559cJsD74+jDbOxr5NeqaYT/3Or+g749X6dWlG8=;
        b=TiqG4DaEAvSlamHQ8miqG9o3OSywq9osOgnHeIzQqKH6eczwOV0YxAlnIc62G/MBGB
         RicUhoM0MjOeUUwlkc3uafFdMlDRF87wK+XWVuCGwjmaBQ9q5AptcYAH711BeSydQtyF
         S4qUfvAlCPZ4DILUlcks6EudmOpI0fhqbC5iPgtYghJ6Qjie13Dh6YKpjnWl4l89tZhD
         IEhc83qsesDqDTXnOe9NRHbrSSULpGlpuupUQAOW7kDZuwRfMrhs3XULieiIIGBoTzbA
         AYxAUO9p42oSaIDqTDumHTElL7gadtLFxQ3c3t/6RmvrDUKRx8tMnWRQSENXRL+FF/th
         Dg+A==
X-Gm-Message-State: AOJu0YxwzS5HhYaICq/QO0BmAn6A+6fxORPAW+n+7/3vOoQ1A22vkEW8
        lbIXEGM30UhBeRA63wMdfo8DcxtZeyKUC1JTDZSEVpGsI/BH
X-Google-Smtp-Source: AGHT+IH3w+druH4uU8r+K5NJ9qcpom8kNoVM9v6ZZSeyWL37VhQJ0+itbXF4vhBXyRu7Z4vNSKIwSHKDrjDQp8ZxDNH4icrTItQ3
MIME-Version: 1.0
X-Received: by 2002:aca:2b15:0:b0:3b8:b1e3:c576 with SMTP id
 i21-20020aca2b15000000b003b8b1e3c576mr1312744oik.5.1701623527802; Sun, 03 Dec
 2023 09:12:07 -0800 (PST)
Date:   Sun, 03 Dec 2023 09:12:07 -0800
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea98f3060b9e19c3@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From:   syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        emmanuel.grumbach@intel.com, gregory.greenman@intel.com,
        jiri@nvidia.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 88717def36f7b19f12d6ad6644e73bf91cf86375
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Wed Sep 13 11:56:51 2023 +0000

    wifi: iwlwifi: mvm: add a debug print when we get a BAR

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161d9230e80000
start commit:   d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: iwlwifi: mvm: add a debug print when we get a BAR

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
