Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71376803767
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjLDOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjLDOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:47:07 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A02135
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:47:11 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d74186170fso18281237b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701701230; x=1702306030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vucZ1p7lmrLTgOrAv8yDP9iwaoHQ9uGpar2Z2YYKFs=;
        b=XykgohPdN98MPrT/aD9Ahw5v0XrZDQ7GI7RiABqMLJkVH/MQCevD2rLKCn+qXQOd31
         /cAwXMSz5bYdysMRt5mMgl8xlkgUwLJlmKxW2pjhPmyuyIF8C2SLoT5rq6tZeaa/oSPz
         znKAlVGGL2Bs6/Z1b44FUQk5KL6JQHZWrZX35Oe6EDqLBAG6iLMguwUQNal76ZyiYU2G
         fzyj/PphdO7Y9vnxlg+HWN+W0S6qXb6pMPt4t36Lj5CoK/X8e3sAM47DjCHmM+gl9Yef
         yvQyZFcqTjIUqiRxWaTOheY9XPjBF762VsejWsporr2baORywN7BKgLZSVnGkp84EYxH
         iYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701230; x=1702306030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vucZ1p7lmrLTgOrAv8yDP9iwaoHQ9uGpar2Z2YYKFs=;
        b=ZW3ByXn00091+MpC3rbspN+LN4DAcDe+WXRl3OWmvwgndOKomib+l2URm9GILlxpvp
         BhIAmodxIUcSsTkHFwctMtCT3T6unBiLAYE45UmBrdXTKw1Mz7tQQm/OvMds2d5352mb
         LdIen5B0Us7q4X4p7929DYfRlJpjSdtdlGzIblFLyo2C5PF/pAt6nizurTTA1N0PdXr4
         N9hmn9OytwSfkSrH5TJAKjuIoNz8lvCJfJ94C/GTj11jF2BzH4iENparz9HeOQ3YlHQm
         483aW72hTaXyh/4hO5X5DY2crQ3t6AXHKzPA1Xs7Q3DSCVtTkgz752me5q5f9PzeiNuA
         W6TA==
X-Gm-Message-State: AOJu0YzcukTANAOLtG/6tU1ICbWfGA59JeFw7jN3ulQHE9P+kiycZf/Q
        kvRKWNVU32l7D3hpNeVyuuZFgEODvOylYTDXZkOVEg==
X-Google-Smtp-Source: AGHT+IHgXzWviSQW2d1SePNsoxk1BKBmHjrLPdI55ANyIj7rDYII0ZG16RM7of32E1ktEFD6/FELQXGdGyRD9bzJrGU=
X-Received: by 2002:a81:4426:0:b0:5d3:7ee5:d0db with SMTP id
 r38-20020a814426000000b005d37ee5d0dbmr2558189ywa.20.1701701230569; Mon, 04
 Dec 2023 06:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20231203032431.30277-1-mario.limonciello@amd.com> <20231203032431.30277-3-mario.limonciello@amd.com>
In-Reply-To: <20231203032431.30277-3-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 15:46:59 +0100
Message-ID: <CACRpkdZQ+q3meJkGc2j8QQhHtpdK6g69C5MVfXrqY4xy3bct1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: amd: Mask non-wake source pins with
 interrupt enabled at suspend
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Marcus Aram <marcus+oss@oxar.nl>,
        Mark Herbert <mark.herbert42@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 4:25=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> If a pin isn't marked as a wake source processing any interrupts is
> just going to destroy battery life.  The APU may wake up from a hardware
> sleep state to process the interrupt but not return control to the OS.
>
> Mask interrupt for all non-wake source pins at suspend. They'll be
> re-enabled at resume.
>
> Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
> Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I applied this patch (2/2) to the pin control tree for fixes.

Yours,
Linus Walleij
