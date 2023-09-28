Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938C7B26F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjI1VAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjI1VAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:00:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4631AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:00:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f4bc88f9fso133303077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695934845; x=1696539645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbFwM/92voxCByKfu/1wITwt000tJNxRi7kEB/SC7Qc=;
        b=H2+G2MD+PEIEb2V2k8j3dgkzuWLJsexJsMu/4f8iH8iLeIbTwmFUiMcCQHNgLebRMK
         3xyerAPShfMOWqUrLpreAFdhXJVVoaXzDWhwG/s0lzxDrW5wWhu2DMDPyb4cffaO3Bhe
         W2fvhr/QOrc8L8yyWdvCkI58BR9PPt6X44UT4Qi0YEhMciygVQw/5e3CRQYgkwj7BlJR
         FMMLlMZBOHs9Rn+wIXO1lS6fVV1DC7t7wTlTREERipqFmp0OOReuulBhxd/3POIIrYjX
         qXJE8pDL+jOsr8bBuzIX9udccFP1RaM+icIdq9EKEbb+m8u4g5aroP1H46TztaYn9iQV
         Cjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934845; x=1696539645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbFwM/92voxCByKfu/1wITwt000tJNxRi7kEB/SC7Qc=;
        b=BL2aTzB5Rzc3qOhga02eNxmt44Tc+pDyyWA2SNO41oXiAPrIkZROKiLXcRt/zhZTCg
         wXbbci1D+sPir+n7DKRpZ2wEdU4VX02paoxFl3mo1Vy2ZsDDEEIFntWo29QNXlblIiMQ
         6Dkvwemz18iOb0BDmw4eU286AY5lWhnjfdEUCdUKnkDHAQIQdXBnmBGeZedK49kUOyEH
         0oZqVLL+EkOB3zYevc09yI8o9gALeJy25EXly6oxpNWjXq0yGE2fVUYZTaBfifbeAjdQ
         lqD5mtkEzCmcPwiSJCMVbJlOCRg/ESpz+TlG3yhvDbVZNmw5zqlm5rJ4Lkcz+OQZOoSh
         Ty9Q==
X-Gm-Message-State: AOJu0Yz56FwtfT60Wzy1BZjtnCzfqVUn2uHz89LPK6CIANyfxVlCVvNg
        nq4R4EqpOUloL7fKXYn3CsX0k4+oZZZSpuuxY2rpWw==
X-Google-Smtp-Source: AGHT+IEUr2RY0numrh/unRcKjdyt9WCXXy0qWxQeZg4xxnGU6fd5QmIYLDl8xYnLHCD/vFvH41YcFe9+7tV4MkL6tog=
X-Received: by 2002:a25:730f:0:b0:d80:9ef:928e with SMTP id
 o15-20020a25730f000000b00d8009ef928emr2208149ybc.33.1695934844754; Thu, 28
 Sep 2023 14:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230928201421.2296518-1-mmaurer@google.com>
In-Reply-To: <20230928201421.2296518-1-mmaurer@google.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Thu, 28 Sep 2023 17:00:34 -0400
Message-ID: <CALNs47vqygCBPTOZQU11YFsWaeTmSX2ZOxSk495qq5uNSyd2Cw@mail.gmail.com>
Subject: Re: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 4:14=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> While GNU grep supports '\|' when in basic regular expression mode, not
> all grep implementations do (notably toybox grep, used to build the
> Android kernel, does not). Switching to grep -Ev enables extended
> regular expresions which includes support for the '|' operator.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>
