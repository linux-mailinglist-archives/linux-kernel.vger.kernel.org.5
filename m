Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A860B75908F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGSIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGSIpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:45:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928E136
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso6160e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=Shfd+XwM+ukB58E8y/z8euPhlM+SvzoOTYSs6aINdGFcivqnZsETWBhPWCQIfabh1+
         ixRB7zSx6pOpNIowU2P30GYQm5Wwb97ikG+XbEaaNP+T6GL562JY0N0Ce5y2zR/pfkiF
         L/otFKwsLEHDB2Pp5lCN/TGKEZzQ9npdeY9DSXZeCDvG8yPk9SYtT4WC7wonBWJPQ+yd
         j0hsMO2acZ5Sm70zmtbKHynIg9QiwD7weWGFOkfrasA/3NWRGIFNYz46mM7fClKvuLlk
         mHAqFEuhCsm1JSKkH3qvy+iXVHkFjSIcAEm3sZvUpBe3ruQ/wSDjYccFvINIwTUfI/su
         v3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=ZZP+nxf8BXHv1Mx+ivkxqJEYFmda4mAtVnJLsLIubMB1/y8qlS3xQRc2NmIBUdzk3C
         anDsEqC+/MhwnyxX4QwK9ueUx4Xe+gan5oojI4xz/xjLQ560+MPbyoM/KLz2aQt/LfPD
         GyRduNCKI7oiWf8GNBWzfX09a9ZXKk+5VMx/SvqOEnWExlkHk9HrIlHZZ20LPakRwnE4
         x3ZpDgGfrLP5lu4GO64jz7tMfux9AzTTASVYkYfH7VTfdOeKugMPOpk5/F3W+p4CwPLt
         cgJU5pmyv7J01y/t+cxR6Q9CMjZcKMUvQdRzf8hX9pDJqmsnx51mrRRSQirxCO046vn/
         1fww==
X-Gm-Message-State: ABy/qLY+MWKye5AdfgHX9Luug98F75Kihk/dzjRpOp8VoG4C2U+JqExR
        wWcIwkPFm+aWfFO6axX04F0ikvurZCkbXsWniZSd4A==
X-Google-Smtp-Source: APBJJlHLnwRtT8dY4p/gFDWF0KgvHLNMG0seYCvYQfXnGLLU6blkTWYuxyClSv9V8XvEISNEZUh5P+X8OHVF+seMG/k=
X-Received: by 2002:a19:7018:0:b0:4f2:632d:4d61 with SMTP id
 h24-20020a197018000000b004f2632d4d61mr166153lfc.6.1689756319638; Wed, 19 Jul
 2023 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000049baa505e65e3939@google.com> <00000000000077b5650600b48ed0@google.com>
 <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <20230718124548.7b1d3196@kernel.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 19 Jul 2023 10:45:07 +0200
Message-ID: <CANp29Y6T2sKnnTGtotraCX8saAUw1kSUhS-be=3GM_t+szZ-3Q@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>,
        davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit d772781964415c63759572b917e21c4f7ec08d9f
> > Author: Jakub Kicinski <kuba@kernel.org>
> > Date:   Fri Jan 6 06:33:54 2023 +0000
> >
> >     devlink: bump the instance index directly when iterating
>
> Hm, don't think so. It's not the first issue where syzbot decided
> this commit was the resolution. I wonder what makes it special.

Judging by the bisection log, the commit fixed some "INFO: rcu
detected stall in" error that was also triggerable by the reproducer.
Though for me it's not clear how exactly -- at least the reproducer
does not seem to be interacting with devlink..

--=20
Aleksandr


>
> --
