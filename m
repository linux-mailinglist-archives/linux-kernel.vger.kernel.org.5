Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EA7C8713
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjJMNmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:42:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A900BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:42:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9b70b9671so136085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697204555; x=1697809355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjqyPXBdry23aOsu0Z1m4PgFLk4vyVFNTA4AUMGfh+k=;
        b=wq9zv8Tyxl0tSbLpenB5/qZ7Rx7POecLpXoSbaaKBXRo3iUS0OQxJZlmmX8gTmgH/P
         +aCQanBSk1H+IH7PekZAWmnO+jTJK12swTnl8uw5F2trPyEE38Qyq6I13BOvUUpvei1S
         sg4RZS1KHctLJHeBTelYiaI4MVKGn/0vT+akkJt4j/u38t4VRdlr+HEGtCPRs/shXi42
         uh06lx8JDoinXsqS/WcZt2JDh9+L5zLmM19FvSF/iMutdfHDD1zIFPTkwDKH9RHzGMbE
         nGQG3on4WArxlp5OffFYSCnKMQjXaBk35qUnBykzMoQGvQGBJTgvb7BtsqAr8I3VDKxx
         oRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204555; x=1697809355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjqyPXBdry23aOsu0Z1m4PgFLk4vyVFNTA4AUMGfh+k=;
        b=V3iDaYS7Pvpc7LjR32wxRbCr8/jOHF8V06fWvTHP1Ul6G1vN1DScu3ynQaAex6qK34
         KtufuzJTidP4LD8t+aqZ4cdlXOxAwz7PsqISwr44Yhepf0BQtXAqHIDrxI09cZRFu+m4
         eNOWL7vso1iJdcAcDEE0OhiD8n/bVNzhS7IcfNlBskta+9zfdFljfCISfXh4tORR7lb/
         +xLwD4gCLOQjE+se+1mCelbOfRBHz+R/cuvCeTWEYTbDzPV+sUUus/lFN09p7ALoetGd
         zNpfTQVPAUVMc0CWY11efu7lQmdzjjjBqSUjrTuj0i8QlByxzEWXa463pNnbQEJ9T3eQ
         aCOw==
X-Gm-Message-State: AOJu0YzjHyaquJ42OLN6omR/JfKPw9WectHgTtDnVLF5D8rICq0oxKro
        +2n/j+tg5Os6jB41NaVrYGbWRhnr8YthO45q7NuyGA==
X-Google-Smtp-Source: AGHT+IGUDstTxcQCrHaD2gLuKfQ70TL6pV03cfGCQeKh12njH/f1q9NV/T55M1ZOwbdWh5X4/yJ/xpobCQBFGgnwrXs=
X-Received: by 2002:a17:902:d58b:b0:1c9:c480:1797 with SMTP id
 k11-20020a170902d58b00b001c9c4801797mr145034plh.11.1697204554562; Fri, 13 Oct
 2023 06:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007634c1060793197c@google.com> <ZSklqKDnv9OAGMC3@Sun>
In-Reply-To: <ZSklqKDnv9OAGMC3@Sun>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 13 Oct 2023 15:42:23 +0200
Message-ID: <CANp29Y6DfZWQqOiziU5ysBjRfvP-ZgRfdhuf4RF6MT5Y+J1k-Q@mail.gmail.com>
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
To:     Zenithal <i@zenithal.me>
Cc:     syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 1:11=E2=80=AFPM Zenithal <i@zenithal.me> wrote:
>
> #syz test: git@github.com:ZenithalHourlyRate/linux.git usbip-fix-wrong-pl=
atform-data
>

FWIW you'd better pass https://github.com/ZenithalHourlyRate/linux.git
in there instead of git@github.com:ZenithalHourlyRate/linux.git.
