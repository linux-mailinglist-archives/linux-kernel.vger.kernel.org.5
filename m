Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5F805F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbjLEUIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:08:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1E183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:08:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so2334a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701806906; x=1702411706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSrsxMtqGFne/rd9wakrOSxYSu6JhQYC9mQGxjxNaLs=;
        b=Nkej/qX5KPlULdY17d8saOt9nG58vBfKivU5+ekIFTPEr6Mr82mUOjFL9a0FETH1dv
         agMOMzvDhH4bOsf1vZjHBPNa5okI0KCyr841RRUZL7HJF3w/0daKxzr3ZL9d60IKas1N
         3f1Ftz0fvIxw8sqYMD9d3GScY+uEdoseI5WxaeFo26jlkr3hxW/cQCDz+nscQM8XlVE3
         UYNz7f++a/UjTLpsT6PQS+caTiQ0S8B0aHMk/cPMucBB8WXSX7sXNExMjTsi6Tdiv3DF
         V8qhfifY3UZVvRPm0fvUVFx0S4uKCKf2VoqNtAhCdVKPgiCOBMd9fQDPZIdsONoVOEVK
         KlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806906; x=1702411706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSrsxMtqGFne/rd9wakrOSxYSu6JhQYC9mQGxjxNaLs=;
        b=boUFxUDvZZ2qkf20ai/XY3dlk5jjLu8BeGuwocvlCvJLGxqSSbPSIV15Rn7dMiJXyy
         SRhezLbI0Db7Dt9mL9eMPP6hmFb/r+M+iVysCHVOR1imPKH47R/k8q3FljW9KOoipN9l
         1sIi8cMy0PDQfRbEJdV8B3NAJ8Ft2099e652TmMpgaJstkdRkaiN0Uf0fxudQGiLaYRM
         Fn4aBnoFb1UyM7L/HAH7BFfBPTWF9KUWmHMeBKexfJwqDO7hxdEhwVnTclImwH6F1n1l
         dzl/r3Zf/TtyQuur2bod2vCrUPHtzgJFnhsVN007+81E1KLVgcuPMUL5oATgdI0BU+8o
         9Tjg==
X-Gm-Message-State: AOJu0YztNM2Sxav6xBbyZzwzILuE0uaswhEMe6LqCL88PDBZhpeuKsd8
        BbOhYgdKwtCBB77cpc2CzxYiY34yd4vKs/F94pw12Q==
X-Google-Smtp-Source: AGHT+IHZQnoSTZyFKEeDjGAGUcLeLiFTjK6MEaV3VXgaIebW7/Or+MYLeDikbTpb2u47fwxuuXCl/psDeThixjU0I1s=
X-Received: by 2002:a50:f61b:0:b0:54c:794b:875b with SMTP id
 c27-20020a50f61b000000b0054c794b875bmr13467edn.1.1701806905505; Tue, 05 Dec
 2023 12:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20231205190951.67-1-yx.0xffff@gmail.com>
In-Reply-To: <20231205190951.67-1-yx.0xffff@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 Dec 2023 21:08:12 +0100
Message-ID: <CANn89iLibjjMhJqX_CA4gSDxpBuD9bytfW6LSCKM0fyDvv5K0A@mail.gmail.com>
Subject: Re: [PATCH] net: remove ___neigh_lookup_noref().
To:     YangXin <yx.0xffff@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 8:10=E2=80=AFPM YangXin <yx.0xffff@gmail.com> wrote:
>
> key_eq() and hash() are functions of struct neigh_table, so we just need =
to call tbl->key_eq() and tbl->hash(), instead of passing them in as parame=
ters.
>
> And if those two parameters were removed,  ___neigh_lookup_noref() would =
be pointless, so I replaced ___neigh_lookup_noref() with __neigh_lookup_nor=
ef().
>
> Signed-off-by: YangXin <yx.0xffff@gmail.com>
> ---
> Last time I comitted this patch, Mr Dumazet said "this might defeat inlin=
ing.".
> So I compiled kernel on my computer with defconfig, made sure that this p=
atch would not lead __neigh_lookup_noref() fail to inline.

Not sure how you checked, but I found the opposite.

This patch adds additional indirect function calls, with additional
RETPOLINE costs.

Look at ip_neigh_gw4() disassembly before/after your patch.
