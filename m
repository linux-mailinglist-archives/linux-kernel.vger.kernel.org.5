Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5EB7FFAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjK3TLf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjK3TLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:11:34 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A610F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:11:40 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dafe04717baso1198457276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371500; x=1701976300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqnEbO79cZleai9aSzE143zTjq1kKLockn089TKU0g4=;
        b=R/Xccoolv67qh2mLbX6DkrReOYCtnRcxv8WEiV4jS605s9+fQX6LVcijyhguwJxvUA
         qQO8culS+r2IPNzWg9txOjQYeCW99TxrClbMAlt+gq1rjgpmoDDTN7lNIMYzoi+Wgf9y
         fOm4KkUNCwdTOCv2+dDv3VsPCHAodmWL4bsJLjay7oo2FSbdC8DxlMlrYrPEC9SQvF9F
         8NAhE7TdrnLPna3pwf0EHmlyI0LJDmhrQNFFn7a4oB6F9TvEOO+5hfJHnR5xoPAHxkKv
         wsH9TExXDAQtIdJ2e41Vm1tgihVkx+uimOLaUGb0XAL4ylZasUV8zllYvBgitjF0p2Dl
         +yQA==
X-Gm-Message-State: AOJu0YwypaX+7OKG+Gub/yKOCPfEnz5fL69RObnJsO/fncNyc0L+I7Qw
        XxEuqJpshKM/1N4lfWV3W5v9FXpiCAONRw==
X-Google-Smtp-Source: AGHT+IFYIwhI8Tji7oh5xuJBcSet6MfCU1grocxi9SaodL5wOuQ3nQe73qMu5zGV5kCNtvTJmxbQnA==
X-Received: by 2002:a25:be87:0:b0:d9b:3ed:41a5 with SMTP id i7-20020a25be87000000b00d9b03ed41a5mr20230553ybk.21.1701371499896;
        Thu, 30 Nov 2023 11:11:39 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id a1-20020a258701000000b00d9ace05037csm381559ybl.13.2023.11.30.11.11.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:11:39 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5cece20f006so14721767b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:11:39 -0800 (PST)
X-Received: by 2002:a0d:f281:0:b0:5d1:1bab:5902 with SMTP id
 b123-20020a0df281000000b005d11bab5902mr12533193ywf.15.1701371499118; Thu, 30
 Nov 2023 11:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org> <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
In-Reply-To: <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Nov 2023 20:11:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXd4ai5bDN4OktKDA_zS6+viDT=x2yFG=_ZbVpfLvGGgA@mail.gmail.com>
Message-ID: <CAMuHMdXd4ai5bDN4OktKDA_zS6+viDT=x2yFG=_ZbVpfLvGGgA@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Thu, Nov 30, 2023 at 7:55 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Nov 15, 2023 at 10:02 PM Rob Herring <robh@kernel.org> wrote:
> > +       cfg = device_get_match_data(&pdev->dev);
>
> This sounds good to me, but a couple notes:
>
>   - This could be `dev` since we have it, no?

Indeed.

>   - Orthogonally, should we just directly initialize `cfg` since now we can?

Yes we can, it would still fit on an 80-column punched card ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
