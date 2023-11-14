Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F47EB070
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjKNNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjKNNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:02:03 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFEDD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:02:00 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5b499b18b28so64782497b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699966920; x=1700571720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iUh9bh4g34uEd8ne3mi/ZU8ueseqaQ4Cq4ajTU9LBk=;
        b=VwiI1fSiwC3wFoKPDg/O1vnRDWP5cgtGbrfie43ouTLfdw5gF+wWwKk0PxHV4W9yCr
         tzXwlgacJJG6WRIM/O/JCf1TB5W+HNBcKcJoYlv26A2ltCKrSmxFUoGCPcPGMwmLqKnM
         0x6XPbol7rH0gQrXPMN3yYfzj1n8u9rS42CwpTw12wCd/6llPlSeQooRrBnuDj7cLZ+n
         sG4Gi6movCw3F8RnfoVvzZOCnchB6WMWLu2TxMs3cJ4+FaSF3pP/UDklZfGe9a50yhlO
         PPP/r+puT33krN456TkX3AfCoDqK6GZnTXhaWWjjE1x/laOq91Z7+OG960hFPiBjNpxK
         Eaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966920; x=1700571720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iUh9bh4g34uEd8ne3mi/ZU8ueseqaQ4Cq4ajTU9LBk=;
        b=DiW5PBFAMZ6Nbb1g41iY2GEv0ho5OKHUWbayRMktIVre0QrkV8ymIk6d0smJVR6Ds3
         +YBgG/QCaB+fYpOSIELuckYd8NfsjYJsBnBcIrVXSawHIkS8SXIbZBzdEtKaIytPGfwt
         prdSDgYGFDB3xl+cA31ImdFNoWgb8g0w0NzGDYyGQ1b33v2MCQ3tRHVXwYYKj2zVHqg6
         TwkCB7phQWhvPwYrwKxQAxIYMnAanl8dnnrVEp9XjzDxyHcp/GdJyyL+uvAXGGheAJuw
         fe++2usgYWjYKZ1FubRypOxus5J3EHujC1R2N7usWH0ziTMpceykl+ubLobJEJNRpg9H
         D5Sw==
X-Gm-Message-State: AOJu0YzbmAln3tDPzcDCT89xwPlDXjtA/ycJ3sn00u+4OEgqiV1Icmh8
        CuZaJiEHJISXW3WJcrxLqC3KD+ir+BZHDEG6tHj4XA==
X-Google-Smtp-Source: AGHT+IEwiv+yUa6bXQUbd2NNRU+2d9nlZK9YjvigWUECwxlTDLOqpL3zemAMdzElEyhWah6jsD5lOqad+swtthrcxwc=
X-Received: by 2002:a81:5fc1:0:b0:589:fad6:c17c with SMTP id
 t184-20020a815fc1000000b00589fad6c17cmr11738976ywb.45.1699966919909; Tue, 14
 Nov 2023 05:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20231110102054.1393570-1-joychakr@google.com>
In-Reply-To: <20231110102054.1393570-1-joychakr@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:01:48 +0100
Message-ID: <CACRpkdZ9RHcHh4o5g62ywK0eQHpLZuGUF0Ud6jogk9Sfqe4krA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: runtime: Apply pinctrl settings if defined
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, manugautam@google.com,
        aniketmaurya@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:21=E2=80=AFAM Joy Chakraborty <joychakr@google.c=
om> wrote:

> Apply pinctrl state from  runtime framework device state transtion.
>
> Pinctrl states if defined in DT are bookmarked in device structures
> but they need to be explicitly applied from device driver callbacks
> which is boiler plate code and also not present in many drivers.
>
> If there is a specific order of setting pinctrl state with other driver
> actions then the device driver can choose to do it from its pm callbacks,
> in such a case this call will be a no-op from the pinctrl core framework
> since the desired pinctrl state would already be set.
>
> We could also add a Kconfig knob to enable/disable this, but I do not
> see a need to.
>
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

It has a certain beauty to it does it not!

The reason it wasn't done like this from the start was, if I recall correct=
ly,
that in some cases a device needs to do the pin control state switching
in a special sequence with other operations, that can not be reordered,
i.e.:

1. The pin control state change is not context-free.

2. The order of events, i.e. context, does not necessarily match the
     order that Linux subsystems happen to do things.

When looking through the kernel tree I don't see that people use
the sleep state and idle state much, so we could very well go
with this, and then expect people that need special-casing to name
their states differently.

What do people thing about that?

Yours,
Linus Walleij
