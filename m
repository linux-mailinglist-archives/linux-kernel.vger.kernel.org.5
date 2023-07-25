Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72676042E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGYAmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGYAmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:42:15 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3751FC7;
        Mon, 24 Jul 2023 17:41:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d074da73c7dso3389054276.1;
        Mon, 24 Jul 2023 17:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690245688; x=1690850488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck2gPt/GWb2IT8kwdAXJEumr0Z41D+yrr47h4Niis78=;
        b=GS9RiTPG9gjUu8M0FDtBhpWkvhtG6ytNbZ7RlLTMFiENwwbRBp5SzRYu4MvyH3/t1S
         fm4HSqcdHTDmOaR9+x0CdJ7GRcsPoa58LOBc7jEhu3LaWq/kYXdQ/ZTEroEnrLKdmnCq
         qE5ae1KBa0CYKT8ekV07CDGVYqec+DW1bU02Orpcdajm4XbDNyyHkf5xf6b5HTvjJhty
         AZ6TYwNRNYS+UHW/eaM+pK2OvEUPxzOGH1bv2SkleUB7jKU/5D4krTEbMgTYG3i9ytYR
         7ZFHbfYNMDf9X5sBQRUKnCEBrXuYIk3hu/+U/4uPVaTIpUWzGkAyKP35SLpSp5xInreN
         rVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690245688; x=1690850488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck2gPt/GWb2IT8kwdAXJEumr0Z41D+yrr47h4Niis78=;
        b=NkBh3Sx7VEHtyhc/Ph2KpKAv6QbABkE2x4jLTA4eFbLIAK3KBYa5VLB7CXgaSkvtGH
         9odHwtUz0dcAsoJ4wGKMJnlDqObX/IXAPUvX1P7uxARoNmgpg9jQup+aUkSKWAxWW4BI
         F2aCcdIfaMgk53YyhtU5t63us38HihO6a8j5YnzdkLF/pfKIb9sYb88YcxhZY9zO46nl
         bkvoe6tN2WlxsrIrhKFT6IxiS6qL4wvOSdDYYoRBlpqn0J1krT81qEIp/j2vH7nwup2U
         pwBdUQAt6sV8XRcCaNEELnX5gy0qErcRjAqFHpQRLkLMf4KZ4qitDuPFaEjJzprOvSVU
         t2EA==
X-Gm-Message-State: ABy/qLZWTy6Fqw7vggHJpEiyGUjtA+scfasjmkF8Ab8mpMZ/4CFtrB5a
        9CiXmdIVU3MW7JWN8ANMxUiXk+XGuHIkXmdjq7k=
X-Google-Smtp-Source: APBJJlEz6zgI2H6UG/ubA5eG0+QEmJmxv3HNhm2B2AsFJ80tiVCMMYGL8Z6P6hNoWmdi+WWj4onGcQfMZCzTw6CpP48=
X-Received: by 2002:a25:500b:0:b0:d09:3ad7:a090 with SMTP id
 e11-20020a25500b000000b00d093ad7a090mr7961791ybb.56.1690245688165; Mon, 24
 Jul 2023 17:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230724131741.954624-1-james.clark@arm.com>
In-Reply-To: <20230724131741.954624-1-james.clark@arm.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Jul 2023 02:41:16 +0200
Message-ID: <CANiq72nJP+i10CZysua0QU=V=Cn=jdnLuV8KOqm6_NNFdg9S3w@mail.gmail.com>
Subject: Re: [PATCH] scripts/kallsyms: Fix build failure by setting errno
 before calling getline()
To:     James Clark <james.clark@arm.com>
Cc:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 3:18=E2=80=AFPM James Clark <james.clark@arm.com> w=
rote:
>
> This fixes the following build failure if scripts/kallsyms launches with
> a non-zero errno value:

The code change sounds good to me, but could you please describe the
situation where you found the build failure?

Cheers,
Miguel
