Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC17562CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGQMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGQMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:32:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B999C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:32:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704991ea05so42388397b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689597139; x=1692189139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSx1KFOZHhK5rBz5q5WI44760CDuuL645BIBMYOSus=;
        b=Cx7gZnSCWUuLzsQIC695ZQ31J+qffQKaUSIIA/Ta6q2pIbK9wHaQMinbKBAqcaPI+c
         FENA1Rws5+HoQ/f8Za7vqnk/1vpLRIwGeDm2IpTde6FpM5apb66SFjzftmuh3lBzysVB
         8Rx+sfR+kg70aBZLBtfbQyoMhxHqzsy6NL4AF4uGYPQZKQDRhIdzCLOXWxunvZpsykyw
         ChY+aR8BlLr28BJFbjEvhVRlT7QpDGGaw34QmfhDl3oDdkmCpkaQd6wIZrWkof5ZzeZH
         XQ70Xa6j5IpUQW/3u95HOFOzluZk6GryzL2weec0APRvqBWF0c//NTRaUr4mdp9No1YG
         D4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597139; x=1692189139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSx1KFOZHhK5rBz5q5WI44760CDuuL645BIBMYOSus=;
        b=QmATEHNe13YXx3RjG4ajEUR/s+J1hdC0zKsKrLYjLiKlKtoOvjTZasWgddzjNzPtA4
         WC6zsCYJeM/Ly9EvfVAxYuccmiRcC009dLHr4o68FGot2wfIiGzlj4Yrzvv8jPLPW9nv
         PPFPOuo5icprT2CXvTBNkH+XtHRYYtOSd4d+MEzG3S8XysomFdRW7UmYmd/1QGqYph8P
         B3XYKzpiQggwUmXaV7lEZmlG81RCUZvTFXKUF92cdpqBeL42pY3e8zXa61lZby2h/EyX
         pInS588k1RW32i7Qyorn7vrbNSamf65jumXtiOccasBt3FeeoNGKbOFcvRj0hzw1Utns
         B4Yg==
X-Gm-Message-State: ABy/qLZYlwQoX1MXGDVJM0/jTPjF06GxeqcPoDDwOzfhK2rmeB7gG3y3
        hjlIsKeKcCmWETqEchANSA7bdO6H5wI=
X-Google-Smtp-Source: APBJJlF8OuoRwqn3kvulYRYYr8yYr3IHhx9y5lKLEb/tJcb9M9a3xeosZq0kD6pK3XLaQy68f7yAviaOgn0=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:d0c3:d89e:d01:e399])
 (user=nogikh job=sendgmr) by 2002:a81:8b41:0:b0:579:fa4c:1f23 with SMTP id
 e1-20020a818b41000000b00579fa4c1f23mr163675ywk.10.1689597138664; Mon, 17 Jul
 2023 05:32:18 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:32:15 +0200
In-Reply-To: <000000000000dd5c040600366c6f@google.com>
Mime-Version: 1.0
References: <000000000000dd5c040600366c6f@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717123215.3627471-1-nogikh@google.com>
Subject: Re: Re: [syzbot] KASAN: use-after-free Write in j1939_sock_pending_del
From:   Aleksandr Nogikh <nogikh@google.com>
To:     syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com
Cc:     bst@pengutronix.de, dania@coconnect-ltd.com, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, nogikh@google.com, o.rempel@pengutronix.de,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This bug is marked as fixed by commit:
> can: j1939: socket: rework socket locking for

> But I can't find it in the tested trees[1] for more than 90 days.

#syz fix: can: j1939: socket: rework socket locking for j1939_sk_release() and j1939_sk_sendmsg()


