Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16DA773E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHHQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjHHQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:00 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466CA5F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:49:53 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id ada2fe7eead31-4475e383c03so1099076137.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509782; x=1692114582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=Kp8yD31CIuJnuzUNe/xRb4x2s4oW3zmQV+PobGu+VX5inYwVe+fpQL0H72Pd5jRzD/
         ZxlbHC7K7GsO0FF4uJoRFF8Ia7rp+jznOVaeasEGn5B3JS+OriGlBzkMbitEaTdW5WfH
         0aM+A1pFTfpnW6GhP9R6N2J+DBzcsjddzKk/NoW5bsjoY/vPh5CpNnD8iU2tUJzE7zyi
         HrziGWsi45JjfW4bLbBZOWKPPLhawHZ31Ef+h9fjD99L01DxKXeSgRPeJE7ymjX4vp5S
         wzoFqH1WqDKEX1tw5dWJvabcww+MFsqKjnATcnRNnu/jjDY8zTgJYDAL9PSPVbKlkw0/
         0vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509782; x=1692114582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=eEpuJWtQLfgKPqExKIjTkIVvVw148UiYEqEvajqVwflK/oqZrZS6QHTbE2mXCDaPJE
         0MA3aQ6yNsZDdxMBt/vuApwhyUEegE2Bwvjv+gxTEsnc1nAdvOJFG5Y+jZrCmRwBRAix
         qSZR9UATNXEiIXvc4S8OY3nPQMPMF9v8ObThF6uDbKSkcrJiB2f9KJWoxMjPdinA2QIR
         R47U+FP0cOSpq06ZmNPh3SMPpr+W0nHHim12YIb1rTV+c9dwf8uXNkSa8K+mAr6s0a1A
         hVksUaDOS9JmPje9tlsbTm/d+LsABYBxfyCeOrCOyFiPM0LWm24a2MPi8WexvPqM6BTH
         lc2g==
X-Gm-Message-State: AOJu0YzemErUjhxtPS1dBhA3ySFVi4FXfkszGoLJ0qgf1viOKCgzk+RJ
        L5H06m6zXfxHbYodsa6+18V2WqifvU4=
X-Google-Smtp-Source: AGHT+IG4txtV+6uc+oKF7CSQYQrKbqcJE3xU2dySXADEt+XujAyR+d+nq4ZhFg4L/8/3n+EKVUl8bqf3zUk=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:98a1:340:cd3f:85e0])
 (user=nogikh job=sendgmr) by 2002:a05:6902:4a7:b0:d11:3c58:2068 with SMTP id
 r7-20020a05690204a700b00d113c582068mr72309ybs.2.1691505300509; Tue, 08 Aug
 2023 07:35:00 -0700 (PDT)
Date:   Tue,  8 Aug 2023 16:34:57 +0200
In-Reply-To: <0000000000004a33ca0601500f33@google.com>
Mime-Version: 1.0
References: <0000000000004a33ca0601500f33@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808143457.3503251-1-nogikh@google.com>
Subject: Re: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   Aleksandr Nogikh <nogikh@google.com>
To:     syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Cc:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, nogikh@google.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:

#syz fix: can: j1939: transport: make sure the aborted session will be deactivated only once
