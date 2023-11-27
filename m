Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD07FA6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjK0QjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjK0QjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:39:03 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB5FC6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:39:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507be298d2aso6044835e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701103148; x=1701707948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbaBvVs4jJomuZqndjy6yrs8VhBzsYpU6MK+yNn7wYo=;
        b=iP02GF5eKWdrEOLl75L3zMir44AgVKPu0jJSymY7S8h/X3xWdYWBxC3Ruxe8kReObY
         M1IpKQY5RmJ6RFVWA+tLJ9D87irdYaxGvBB0xBuAMQz4ctwDHMR3d3+Ts00OnXdzvwiV
         M7zdfOh5EK50IQ9ExTsD25xwxwssHKUOPcNT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701103148; x=1701707948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbaBvVs4jJomuZqndjy6yrs8VhBzsYpU6MK+yNn7wYo=;
        b=L+R2hc2crJQ34miLVCB/WxjT7iRtB+8rubLoo2LDMsbnVzUdj2dw+VrrFnn2tj69Ta
         +hRlcFCUnwiygocGSfZMFgtwGFA8R03lpW5NYMapW6tu+wJTOGJd3Wdwxy9fKhnVZAW8
         ztZpZSGJxhl9zabYxkA1oqIhJfTHyAzxNausI3ZBsegE0CD2uWxpIB3nl8s/6yVKtl/W
         O3aWoXkTlgcFyS5SeD/PmKWZ5mP9pUJJz77lXxJk3weDbAHQWsZ+/u26O6zah+g/uHfp
         Qo/6HwEcR1/O8KsQkJHDiCzaDFG4YUdnhSSwjRlWxB/xBCPfBILu6kocS7dKSzIC31v0
         BciQ==
X-Gm-Message-State: AOJu0Yy69L3Gdtchb6qJxV70QlJMgPnTLgLwdDwXzWwUIvzs+Zay1V5H
        +WweQvPVa5wsxXBcl5hXlOXi8pPvKBwR3nvh0xN9Zg==
X-Google-Smtp-Source: AGHT+IG1KaGzzgqkd/bVl0htNdKZU5Bn8cbei0/SCcALuzYLvd3G7A/NDsEbwNme3869KE8Y7hH9x4OGUsfYwhzFnkY=
X-Received: by 2002:a05:6512:3190:b0:50a:68f4:6361 with SMTP id
 i16-20020a056512319000b0050a68f46361mr9952921lfe.17.1701103148299; Mon, 27
 Nov 2023 08:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <ZWF76ALANQwP_9b1@google.com>
In-Reply-To: <ZWF76ALANQwP_9b1@google.com>
From:   Jonathan Denose <jdenose@chromium.org>
Date:   Mon, 27 Nov 2023 10:38:57 -0600
Message-ID: <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On Fri, Nov 24, 2023 at 10:45=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jonathan,
>
> On Mon, Sep 25, 2023 at 04:33:20PM -0500, Jonathan Denose wrote:
> > The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> > and dragging by tapping the touchpad or depressing the touchpad
> > do not work. Disabling PNP for controller setting discovery enables
> > click and drag without negatively impacting other touchpad features.
>
> I would like to understand more on how enabling PnP discovery for i8042
> affects the touchpad. Do you see it using different interrupt or IO
> ports? What protocol does the touchpad use with/without PnP? If the
> protocol is the same, do you see difference in the ranges (pressure,
> etc) reported by the device?
>
> Thanks.
>
> --
> Dmitry

Without PnP discovery the touchpad is using the SynPS/2 protocol, with
PnP discovery, the touchpad is using the rmi4 protocol. Since the
protocols are different, so are the ranges but let me know if you
still want to see them.

Can you tell me how to check the interrupt/IO ports? I'm not sure how
to do that.

Thanks,
Jonathan
