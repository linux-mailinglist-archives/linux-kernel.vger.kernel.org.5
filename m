Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB654799C47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbjIJB4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 21:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJB4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 21:56:37 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7F5132
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 18:56:33 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c0e161e18fso50956105ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 18:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694310992; x=1694915792;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1AnbtdmHLxtYiw5SSlT3Mzclo1imdNxgM3fzBo8Y6I=;
        b=sofLR6ol7aHA2rZQ0HkoI4o9pMq+AzK839nLq0cKkQfclNFMbj/MPO4hf4rQDJmFSg
         lLivs9LEMx+9snol5NlhiNDZ6zLqDIcKrA26k9eL9sVCU++cA//2L1DTkYuOQxDpC54u
         WpsMEn1f5zTui906r/U3k0Ek+H6Siv+FVAnMOOo5iht7hAwGfBZkY0OLX9uTFhpON4Ac
         QVA/k+381d1AsCecYzkx39hWZNYbrILpmZKPyVIRLcXYaxVszp4Fx2DN3+RzYVFZwt0a
         i7KqR8TYYcggz7xK+JMl9FL/vFa6z0TFREAw84+uVOOzJdkpRGmBCWzAQVVhNC908yas
         7Sdw==
X-Gm-Message-State: AOJu0Ywg5b8gHqZzABzVWMyh4gNklXFsMpW1qz9kvD2YWOzwLy1fqJ8a
        +2WvcgQ4dISQlUyAVq6frz1j4HUN8GbmG02bJwlln6usA17l
X-Google-Smtp-Source: AGHT+IHiUFnYR5e4ZxlOCvxRqzDbIqM/FX2HwdXWmfaqC03/C7L5M31f5pyYJ99GJ9Mjc0cInXFJjLtDqAyIvRPodQqxHEOcKuqO
MIME-Version: 1.0
X-Received: by 2002:a17:902:eb8c:b0:1bb:cdea:d959 with SMTP id
 q12-20020a170902eb8c00b001bbcdead959mr2473963plg.0.1694310992663; Sat, 09 Sep
 2023 18:56:32 -0700 (PDT)
Date:   Sat, 09 Sep 2023 18:56:32 -0700
In-Reply-To: <000000000000885d8605e91963fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db589b0604f784dd@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Read in iput
From:   syzbot <syzbot+870ae3a4c7a251c996bd@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, elver@google.com,
        jacob.e.keller@intel.com, kuba@kernel.org, leonro@nvidia.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c1b05105573b2cd5845921eb0d2caa26e2144a34
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Wed Nov 9 18:32:54 2022 +0000

    genetlink: fix single op policy dump when do is present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17eb48a0680000
start commit:   105a36f3694e Merge tag 'kbuild-fixes-v6.0-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=870ae3a4c7a251c996bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17274404880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: genetlink: fix single op policy dump when do is present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
