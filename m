Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB427F69E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKXAiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXAiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:38:02 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32332B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:38:09 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cf8aba90c0so16087125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700786288; x=1701391088;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPLTnc8KvHWqsxcIPXp2s7Iad5LW8gL2my2v8cVDRX4=;
        b=YTd9uMxLYJSaiFq3CTuBRAhrGr3fCGLwLOdxXdR3I+8UKIs3L5vcSZVOj8RfmVHSvs
         VejaV1SgJG2EcSblvnfNSbrRgv2vtZsBeG9tP4jwe7O8iOX9A6mRtfVI/vo1fpzGjn9X
         P6FhSC1vgXdV/ksR1OvP+WegqH1S/kLb8kE08X3gwBFyYcA4M8+XgY+x8EEUn3bdnzRQ
         oac/GzMnwrmmEkW+oBxvlZ0b1EY2XpJqHIXvoZ4PH0ZUQKfceQS38Jzv83chqy8qsHr/
         jNtEIxb3agPqbQZ5T+xyTBYzguw0sVCDIaeFCf8f+NFKWmBSR64yL7/NmNzxMGpU8CXs
         2pJg==
X-Gm-Message-State: AOJu0Yyr/6Iy4Zx6JDFHv5Z/ecbJIUKzU1dNYowG8mmCAge3xWfuHPxf
        w+GjpWmZU+E33uzd4gmtN11T+vnYIQ4qO+Tjkwv0ko66XeSC
X-Google-Smtp-Source: AGHT+IG/i1S1qxSA6e88vsKZWkSX6vhKxjX8h9mxmSMPbbTM6FrVEA9zYJvddT/18F2HyONTerLjCeEBKu6vOEGP/7EgeqRxciue
MIME-Version: 1.0
X-Received: by 2002:a17:902:b948:b0:1cc:cc77:94ed with SMTP id
 h8-20020a170902b94800b001cccc7794edmr247078pls.10.1700786288803; Thu, 23 Nov
 2023 16:38:08 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:38:08 -0800
In-Reply-To: <000000000000f2771905a46374fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000954422060adb2aa3@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     administracion@diocesisdeleon.org, ap420073@gmail.com,
        davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1a33e10e4a95cb109ff1145098175df3113313ef
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun May 3 05:22:19 2020 +0000

    net: partially revert dynamic lockdep key changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cd55af680000
start commit:   feb9c5e19e91 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142d55af680000
console output: https://syzkaller.appspot.com/x/log.txt?x=102d55af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14430eb9f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13738f71f00000

Reported-by: syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com
Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
