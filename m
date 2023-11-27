Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D637FA063
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjK0NLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjK0NLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:11:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0F10CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:11:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so17810a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701090681; x=1701695481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXQCTqnSRhLV4Sf7W+kGf5Qzm7pjsYDnMblRf36t77E=;
        b=k6HTrOqc+WzpAD8nABb/85Sw8puAIJ6tbpuwym0c9It4ib8DdMD2f3a/5J1Z/xtqxr
         xPPXU0j43VPh4FR/GNMCUvA8PA2ecn7jgz0XRnEkpnB+gzIymWukCKhncjVsQqfk9mVi
         bofVcUKUGBPVVTlSktqA4mOGd6pOnxp+oZ/9XnK1sRitppObdSG5IpI2n91mv8lmF2c8
         RMNwX8TnlQYx+QZa+ZYBhxi2+jgFT/hCvpTBDaJdDyevFeSDiAGM3H+kFaJPq5Ayc09r
         3bHsp1CyOkR+pB8wDxEbP7yUWDinpa2aYGzWdfRmMjwAiQsvOM5M9AhgtMYR+Q8OrsPL
         M54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701090681; x=1701695481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXQCTqnSRhLV4Sf7W+kGf5Qzm7pjsYDnMblRf36t77E=;
        b=c8sig1P5QBcxlIWo/DUnrE/eiglpJPaWasmVvBdPDeYMCWgoT849LKT4ezaqT/I2Wb
         OdG8Cie9VQmu1COrpE+XwKpcZlW3AtuFqo1yyTl1AKpWIjtqDOkQJMCwGzN1dyHYL8mj
         Ds6Wvzk4lGV1wCMnw6qLHHPrVyfsQVShIIUA24PCKnHcRrMjaDOqfP8+Qo0h721o0SSO
         kcZAFO40Ga4OKsYQpzc5NtkGhWrH7J3vRGgrj9PrKCx0oQeBKt/LQtmmdZ6KmRh7A4Im
         pNNVgrix8y862ABgGLMKwdBH1l9VXt5FruBMtrUBmL2LizG1la5U8ZlqCE3pMGzjUNk2
         I/Xg==
X-Gm-Message-State: AOJu0Yw3PfcVfZflJoTqU+mUAxNf7GJ4HTvaMFv8HuM7mls3umnQprGU
        HVp6zt72Q9AOrMQpRkMIf9mIt12owE0XWHpR///EKQ==
X-Google-Smtp-Source: AGHT+IHaHdoxNNJO97Rlc/s9fLfiRimoWf1RBvhtGks3S54kEDX6jrYUxw9CfaJeaLB7r37y7ymoRJs4z69BB5g3pIE=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr586395edb.1.1701090680910; Mon, 27 Nov
 2023 05:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20231122214447.675768-1-jannh@google.com> <1508421.1701075853@warthog.procyon.org.uk>
In-Reply-To: <1508421.1701075853@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Nov 2023 14:10:45 +0100
Message-ID: <CAG48ez11LLG5nccyfY0DpFoFFXbXkxbB9pZPL81EVkbkWW7EKA@mail.gmail.com>
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
To:     David Howells <dhowells@redhat.com>
Cc:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 27, 2023 at 10:04=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > +     /* same checks as in tls_sw_push_pending_record() */
>
> Wouldn't it be better to say what you're checking rather than referring o=
ff to
> another function that might one day disappear or be renamed?

Hm, maybe? My thought was that since this is kind of a special version
of what tls_sw_push_pending_record() does, it's clearer to refer to
sort of the canonical version of these checks. And if that ever
disappears or gets renamed or whatever, and someone misses the
comment, you'll still have git history to look at.

And if, in the future, someone decides to add more checks to
tls_sw_push_pending_record() for whatever reason, commenting it this
way will make it clearer that tls_sw_splice_eof() could potentially
require the same checks.
