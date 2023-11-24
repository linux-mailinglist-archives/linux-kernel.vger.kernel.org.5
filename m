Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F07F7043
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbjKXJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345386AbjKXJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:42:44 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BA1703
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:42:47 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso1477964276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700818966; x=1701423766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvRqnRUWRFewJ1yAX+bnqQAx4yyEA89YIIAsTWMu6tE=;
        b=Uf9DKeHrbHwb15NXA/eFVlsGugk4qGwOIZiFmZno8OUo9ctbW7nbIHFlQUa00JM//1
         81L3VXn0RnaFlwpwOT0o8AYJBIrBmmKqQ2517hfAgGHV7EDfey5sK0ePPsC8viLuvnwY
         HOKrhvgr0lNnU3+ma9VRxQPuW9bim8kVaxlKkMCi9KOcHOIO5TwBVokZyaw9pzLZGA1f
         u2gH5CxLGORvM6GqZDktR6BMyHYHxi8zKRs2G3kqVbARFJhmi+Rd4UcUXaALvgN7//al
         CiRz9vpfFZV+HsQ/PM185T2S9dWXMb/JtGOQX/YDQ1/sUezR270ulryW4mzdG2Qjoa+H
         +IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818966; x=1701423766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvRqnRUWRFewJ1yAX+bnqQAx4yyEA89YIIAsTWMu6tE=;
        b=jc+K6LPclQJ0pFgV6QM0p3ULL1KLjiTCYQkloJmanLjNezzBW6mHWmuwikOt43/Bm9
         OiaA2W9ys2Qxyv9Hr0ZeYQaIzae5a36aOvAtVR2saF9O3hRwZGEZ2tefJEupv6ILx/Ww
         km0k7cP8UPV5vMjxGU+IRBuF7SjofIQHIbVsDllzATItgbOyaRPHHNyeGq5x7b8GJS6f
         NAOiizKTDGbCdFM77CUclgCdO7wSXZ/xYElvHIf7uId6qSgb82wYZU+IueT790o/XEKd
         PooYmLqnNEMkzEcaungPMbihC7m05JXA71x3xdU6f1giDstSbFCZp4eJ64QzUCY7zW+C
         qs3w==
X-Gm-Message-State: AOJu0YxK9dmIU4k02oA5MoDJ8F6RxkT9StCC6zud8noZXS60UXfpMllR
        f+FlHfGqSmWq73Is/6mLkAjsKN9E1vlRplskKa4XGQ==
X-Google-Smtp-Source: AGHT+IFyHi6ofsYMrVk1B+Dbc7BjO1/791M6O7w4Se/imKOkpVL2OEfLkYpCq4TxxkuqgvlJEoDku5P1gCq13JVPgIY=
X-Received: by 2002:a25:4286:0:b0:d9c:7b92:90b9 with SMTP id
 p128-20020a254286000000b00d9c7b9290b9mr1698446yba.14.1700818966072; Fri, 24
 Nov 2023 01:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20231115211209.1683449-1-william@wkennington.com>
In-Reply-To: <20231115211209.1683449-1-william@wkennington.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:42:35 +0100
Message-ID: <CACRpkda_WwKTBnZ4gWpWg0bQs10s-zv72b8gdY_HQ7+ryo_MFQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: npcm7xx: prevent glitch when setting the GPIO to
 output high
To:     "William A. Kennington III" <william@wkennington.com>
Cc:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        joel@jms.id.au, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:12=E2=80=AFPM William A. Kennington III
<william@wkennington.com> wrote:

> From: Tomer Maimon <tmaimon77@gmail.com>
>
> Enable GPIO output after setting the output value to prevent a glitch
> when pinctrl driver sets gpio pin to output high and the pin is in
> the default state (high->low->high).
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Signed-off-by: William A. Kennington III <william@wkennington.com>

Patch applied!

Yours,
Linus Walleij
