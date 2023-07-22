Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2C75DCE6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGVOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:19:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69482709;
        Sat, 22 Jul 2023 07:19:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so41883231fa.1;
        Sat, 22 Jul 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690035576; x=1690640376;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cj7Am9y7Ub1W147cRpCDox5jRFGPz/3xm9Zj5ypIhV4=;
        b=FgbBkhrbb6/jRw2JfVhRhA6ZHxpJ00oIhBqj8Uizt7l1/HZk1+tLekUphlt97EHvmE
         PoQKWBhXXPzjrQ1/hJ9040j/tgo6pbRstMynfpJFHSvDU8HcmCI06w7iN4zpMyV0L/8G
         LIJteBlgAwQwCzpN36DVOMenx2AhExqe2lxVNPI0/XC67/feKivLfKRwHo7wT3NsYSHs
         oKgNVfijaeCuSZqdsTe5t6ZgRGQDknvmzguaz58H4Wmc4Sc8OO0yBiZoV2eZBxm/X7FS
         YdY/wjjYg6GUEhzojiPmtGKm8vMK5uVo0J3plISXSm169bHizaHMthIJ73hVNm7oG8F3
         GORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690035576; x=1690640376;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Am9y7Ub1W147cRpCDox5jRFGPz/3xm9Zj5ypIhV4=;
        b=DpAWi6pMP5CDRdGzfXEAGk2MgxKagP0LkycmZMvqcBJjy5lHm0R5wWjlNhqQGWCGJ8
         L+FWQieuEedPRDTQQBRAVx0Nt/boNPg/DXRRpSg1Cd4EdJe16BHJEcjrKH/N6XisH1Ih
         ZqgmNFtnlHTCkP8xvZGKUKoIU28z15/bD47eO+xrQSlxiFpiWYgqlosge8pdCK15IZKc
         2ai8P0AFtG929nF99q13yDAgXv4FRFqEIGX0zVm7y0RBMRjYKQDihiYfT2TD1AALVKtI
         iAmwponHeVQjk5BdhAcw5mzy9VuqqkM9Is321E4BGVJD+sDuX3tGsANP2lgnAX44L8Fq
         5fVg==
X-Gm-Message-State: ABy/qLbq3y3VK7s7mpyugV5zhVXa6O2I7M05+uFVPdheM6LaacGwbWdT
        fHTbI23czmbTmUP4lhyIvnJRXqDyhSaaNeKznhZ6C8gJ
X-Google-Smtp-Source: APBJJlE6cLw63WGQBPm5k6xt4dM/k8TPLxHhACie+tWizqLN2a/ompqsLyQ6v/MFlSvm22rScmbflCb/xpy4FezOiqw=
X-Received: by 2002:a2e:7205:0:b0:2b9:383b:89fc with SMTP id
 n5-20020a2e7205000000b002b9383b89fcmr3211936ljc.0.1690035575499; Sat, 22 Jul
 2023 07:19:35 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 22 Jul 2023 09:19:24 -0500
Message-ID: <CAH2r5msCqEDv1mUMMVTg8t7K+CO82Ha_xQoYJ-FkQ9h83By5wA@mail.gmail.com>
Subject: [GIT PULL] smb3 client minor debugging fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc2-smb3-client-fixes

for you to fetch changes up to ac0ce20fd8eaa9f5e193d138fbf1749c780928d0:

  cifs: update internal module version number for cifs.ko (2023-07-20
08:30:32 -0500)

----------------------------------------------------------------
add small debugging improvement
- it is helpful for network debugging of smb3 problems to be able to
use directory not just file (e.g. access to empty share)
----------------------------------------------------------------
Shyam Prasad N (1):
      cifs: allow dumping keys for directories too

Steve French (1):
      cifs: update internal module version number for cifs.ko

 fs/smb/client/cifsfs.h |  2 +-
 fs/smb/client/ioctl.c  | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)


--
Thanks,

Steve
