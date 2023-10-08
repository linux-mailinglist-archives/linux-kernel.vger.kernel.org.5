Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F77BCF4F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjJHQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:57:29 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E28B3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:57:28 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dd691b1037so6149862fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 09:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784248; x=1697389048;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0OpDAngG10xpmhVSxqYUkvqTPKRTSFUJShfAHatMwg=;
        b=NQxYNqNcprBBi9fBFeyFreS/qTFNanTNE3j9bX6TIDMGdo5Ts3mCWZJLvHEITDMSmI
         20DJk3eKczF1T75qkHDvP5uAkJZFin2JtgMa5kxxb4jJuel7qkcww3DWNRTanrcs49uH
         dtrE1B3X3iFkOvoJsqesA0JmfX0mfSRUdMHyrCsbMOFdn37VHqPKYXuOzMannsMqWXps
         SAtGjayYy+2jNESxzR4ANYg5TePHUVlqQ9sdB90WcLR5n5lyq/JwTOA6eR3kX3+pbioz
         R0kRqhPfvoMRqJj3OjQoKF2XKBsPKQxmRpslyz/7JCS8sHgIpuI9CZaySoEjblotdIK+
         sHkA==
X-Gm-Message-State: AOJu0YzApy7AG7B421cYaxyFjiI4zPjq56TqRwnWbvVNfZkwlQyiRs5h
        sh/FvKbTqmp+lpCFv6dpbrCP095pCJm+9ldRLvWKY60ZrXt2
X-Google-Smtp-Source: AGHT+IGNcEiyFDgDYD7nh8JVTo7bGNGHXpMgWzyPRnf99gRX7e4Lt8LB8Qc28HMJTdaAFFi5OEXyWxgCeH6wR0WotHyC+ZOJnxz5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1b8a:b0:1e5:7dbf:c2d5 with SMTP id
 hm10-20020a0568701b8a00b001e57dbfc2d5mr3290437oab.4.1696784248369; Sun, 08
 Oct 2023 09:57:28 -0700 (PDT)
Date:   Sun, 08 Oct 2023 09:57:28 -0700
In-Reply-To: <000000000000d730410602d76cf6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006278b30607375e8f@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work
From:   syzbot <syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jhs@mojatatu.com, jiri@nvidia.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, victor@mojatatu.com,
        vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e978e9680000
start commit:   cacc6e22932f tpm: Add a helper for checking hwrng enabled
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=b904439e05f11f81ac62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a49fcda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136f8679a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
