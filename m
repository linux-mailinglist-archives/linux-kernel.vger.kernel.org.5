Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E97F7020
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjKXJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:39:50 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF3D54
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:39:57 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cce3010367so15926987b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700818796; x=1701423596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8H5wgkG7B5BzheZ4ZvCgLtyGDS/xoXFDJfUCvqhL0U=;
        b=uEVLiLTrQQm2ABtQxxbZHX/oaIT1H7v3NBxWp8DymXauXBftnscQqfVGXQxhSomCWB
         E/5cYEiAwxnwL+vY1ECJNOQTTcE8mb8kDH5+2RuJCrqRybpRq3nqk5R8sInwpxrNNqtL
         S9/M/Arl2O2Jr6tz4AQdFzDw8PfSuuY19P2vTUVDVppqR9urVWjiWX8xHdTy626293aj
         Au0CuTiVFtbZVAmmREm9hOTbojET/Ficmor/dfsPfNblSHQqjfKojjJzTWU17XlESjo2
         R2CEGReh44zKpzUkiXYdHzL8it5jGL2JE7Nocr5VsFcwjYoe8vIgB/eBZnL7NgXQeF80
         KbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818796; x=1701423596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8H5wgkG7B5BzheZ4ZvCgLtyGDS/xoXFDJfUCvqhL0U=;
        b=HIA9uetoUPZOofc2EEJNExK673kUoq+DWEN/e3cy3jjBL8aybJ1i27eIGFB1cWfvtQ
         bdVIfTcL9FhZHAcD+zQCzTk+KyjPrU/nck/VApP7PvQN/WWOSiwD1i8+x+gqTWGOZPlw
         nK3a2WxPWNxKaTqSJnhTqhVG1jeJnfoi8dUqidcq3iOETKSErz8HXATUmcaZ8k6OGDqo
         BiKSfckb09B5qtGYdKa6TVPj2dZDKXJjnHfSrRORsWMdOkMuFWl2zASP5DBI03KzgU/c
         gu5nKGbhW/gyfmaCS319OXkohBPkvAcrKwFsbbHpIlt3xR/Q7L9FLGIe+fF6xa61+5gj
         sMEw==
X-Gm-Message-State: AOJu0YwGUwR1U0Gs3iQ6gsApM31g9ymziQaJTmoYLepEaZHUHd0SAtT0
        /oLPf5okTIVut9sPP0yOQLjKdjw0PpJHkKbA1Qhy5v7iG8up/K/y
X-Google-Smtp-Source: AGHT+IEs8cx8lksji9t2UQyL1PgEJlFxBFm7HDAYWPcKRjlRLhlZ6tpGb/ezhVwDiSZJ2LIESImZUSsgaTgbJZDjhtI=
X-Received: by 2002:a05:690c:2c0b:b0:5c6:4de5:168f with SMTP id
 eo11-20020a05690c2c0b00b005c64de5168fmr1651678ywb.10.1700818796617; Fri, 24
 Nov 2023 01:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20231121091107.5564-1-tychang@realtek.com>
In-Reply-To: <20231121091107.5564-1-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:39:45 +0100
Message-ID: <CACRpkdZpie+ccu0AoTOVvV0fA5C2u3hdorFVjbKEPT16RyifXw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: realtek: Fix logical error when finding descriptor
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 21, 2023 at 10:11=E2=80=AFAM Tzuyi Chang <tychang@realtek.com> =
wrote:

> The pin descriptor should be returned if the name has been found in the
> descriptor table. Remove the negation in the if statement for accurate
> retrieval.
>
> Fixes: e99ce78030db ("pinctrl: realtek: Add common pinctrl driver for Rea=
ltek DHC RTD SoCs")
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>

Patch applied for fixes!

Yours,
Linus Walleij
