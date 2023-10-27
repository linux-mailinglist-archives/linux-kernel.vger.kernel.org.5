Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D57D93B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjJ0JbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345511AbjJ0JbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E185AF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A998FC433CB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698399075;
        bh=32xHlCKJDS5VKbaDnq/BJ50yrsQl1IiT6t8Cc+ds0xw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WGxUc1FmDwpRMtD63eKBtmnZlRk8Tg0JPxrzPQOmn6suFUppoL9QFGmJbCMbap66u
         jw5XfvHszulDB0yrr4uDnBZ9k4vOzjvEztAhjT4U7BtOFHenB9hHHOPJMTDUvbpozF
         ivMlaEglIuAk8JYqTmWW+ZWwrf4BBVzXF8heFXcfHwoMtqccpoicG36FCU1eGoSaGN
         3AqPQe8ylRwNdpREywyuzp+kqdBMA34Elnr6AEaUxgn3vXjke0cH/Be9yVa0BPOXpC
         i064BGUh64LP/QIHmdbuNOIjTPinvMHMl48QXoeBf7cgSA+YudChMcrgR1It0eUjVC
         G+s2U9UbfT9cA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so3795306a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzKKUXdBQVafTddM3HFgJPCsWmzetCqAvO+9AiuD2BYtsVOVfAI
        ObLferJKSqkaKajrnFoYS2w3w2HgWy7NfwznwFA=
X-Google-Smtp-Source: AGHT+IH6nvqzaXYwfoTx6Tkant12vcAxlz0QhF3Rd0CNwO7QrMhJlXP0wW5HvOn5mcLfA09F5m5iWkBwXRFdijBWOL4=
X-Received: by 2002:a05:6402:1f90:b0:540:2a8f:806f with SMTP id
 c16-20020a0564021f9000b005402a8f806fmr5124196edc.3.1698399074112; Fri, 27 Oct
 2023 02:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <1698048691-19521-1-git-send-email-yangtiezhu@loongson.cn>
 <1698048691-19521-9-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7yYYtBQ8=oxSjdn=Jnne8mUK17n_S6c6O1bLC4B7VVcg@mail.gmail.com> <4a516dcf-aac6-48c9-9082-ac812f313edc@loongson.cn>
In-Reply-To: <4a516dcf-aac6-48c9-9082-ac812f313edc@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 27 Oct 2023 17:31:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Xov4vg8ezSeHfDVRJF2t4Sj9jMLwNYZAKR3bsTGm6JA@mail.gmail.com>
Message-ID: <CAAhV-H5Xov4vg8ezSeHfDVRJF2t4Sj9jMLwNYZAKR3bsTGm6JA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] LoongArch: Add ORC stack unwinder support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 5:25=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 10/27/2023 03:02 PM, Huacai Chen wrote:
> > v3 works in most cases, v4 cannot work completely (stop at show_stack),=
 why?
>
> There are no obvious differences of this patch between v3 and v4.
>
> > [   61.642993] Call Trace:
> > [   61.642995] [<9000000002ad3808>] show_stack+0x40/0x17c
>
> I can not reproduce the above issue with this patch unless remove
> the option "-falign-functions" in arch/loongarch/Makefile, please
> make sure the option "-falign-functions" is in your test code.
A compiler issue? Can you try this one? Thanks.
https://mirrors.wsyu.edu.cn/fedora/linux/Yongbao/cross-toolchain/20231026/

Huacai

>
> Thanks,
> Tiezhu
>
>
