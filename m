Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D10782908
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjHUM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjHUM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:29:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC89C2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:29:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so687371a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692620987; x=1693225787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnJhMEuBXlJhnu7AWbqCOJoArmxP5ku2UiTWG22q0hI=;
        b=5WNaR+iZi97RIIhzPfCtCYmyRk+s/Wmbqcp6Al/7o/8lkfRphQg0D8gZtiFitE6gyx
         7Nnsfw7nVkQu2ThZn3Zp9OgM+uzeoo0slsR7z03i39PC7oiM8yzQknPCdGNU/NzSPKeT
         jWyi3O8vztgh1czvBpim4vnbpqn6IEpMb6lOnw0Q7S8umWp4oKIhVq29TYZXnQSBNKWn
         hO7HkT58PaS+KTW9mXwBotYRcyoyV18sW57rhhJaJjfPeswzPVVk+RhLG8cYNEkbiOIl
         nGhqNI/qSbrdz6pAEZdLs9F0p59MVT8avfwZwaNowZtNV82elwE8fHvZR+884iKBO0wF
         9QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620987; x=1693225787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnJhMEuBXlJhnu7AWbqCOJoArmxP5ku2UiTWG22q0hI=;
        b=Zl5yXi8JNbgVFioMv4toVrijiYfng9qrVYZMEdNxhhSwLOiKTEveka4LeDG5MRcMrS
         pquiqpobnX5jbDyi2VVC/IgXTG5fFgWxmDMe9dl0hdCX01SzeloFSYE9wnwzYfC8MHiG
         aKCxHZIzbUUenFfI3+QC5X46rgLHHMqPqkUXydxFomXiGyFzgz6KNqIhY0EnobC4hhWy
         hytBAD2lg+HOAVOpUcNYXSWa5B+3T8r07FeEPrJI9CMNVyFIu5cMshlvkTCsub+Sn4tv
         7zC97Foa81VZZMZ81SX48EiBmLdMzjb26xeCjPpKgE7IgSo72Nu75TL6RE8mXk48zu3P
         FXUA==
X-Gm-Message-State: AOJu0YwXqhnNrVLF7ZBq7qS6E1QkdCfutnMWkIzCnxAwC2hvnUB/OIrl
        7fJhf/RGMX076MUeVhD+2FlM/oTgGsbZ0ehWb9IHor+eM0/rg80YV6A=
X-Google-Smtp-Source: AGHT+IFIGYVGP7/7ZDw/ywiettAKjJLScN7pIyytefnZWrrxPbgn2mLJJAFttBNK42lqFRUIWNqGgu2FMIaEVW6smnk=
X-Received: by 2002:a17:906:31c1:b0:99d:a6b9:fd04 with SMTP id
 f1-20020a17090631c100b0099da6b9fd04mr4711211ejf.46.1692620986919; Mon, 21 Aug
 2023 05:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <x49wmxuub14.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49wmxuub14.fsf@segfault.boston.devel.redhat.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Mon, 21 Aug 2023 14:29:35 +0200
Message-ID: <CAHKB1wKws+ha+rsO-kn-qW_XqshNV0g0hDLHjFRxg67FdHGEVg@mail.gmail.com>
Subject: Re: [PATCH v4] io_uring: add a sysctl to disable io_uring system-wide
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        corbet@lwn.net, akpm@linux-foundation.org, keescook@chromium.org,
        ribalda@chromium.org, rostedt@goodmis.org, jannh@google.com,
        chenhuacai@kernel.org, gpiccoli@igalia.com, ldufour@linux.ibm.com,
        evn@google.com, poprdi@google.com, jordyzomer@google.com,
        krisman@suse.de, andres@anarazel.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 16 Aug 2023 at 19:50, Jeff Moyer <jmoyer@redhat.com> wrote:
>   Matteo, you didn't reply to Jens' message about pulling the patch, so
>   I figured you got busy, so I picked up the patch.  I hope you're okay
>   with the signoff.

Hi, yeah sorry I was on vacation until today so I didn't see the thread.
Thanks for picking this up! I would agree with Gabriel that option 1
should also allow processes which have CAP_SYS_ADMIN.

--
Matteo
