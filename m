Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52C75B250
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGTPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGTPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:19:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461552727
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:19:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so13711781fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689866340; x=1690471140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TfiF7Qn+rHGOgsaYz2UyOUxB3qdJrasp6G+WcSeqtA=;
        b=45fhlifF6v1d3ZyUsi1kC3ATh/3q6TqePAA258OsLMGwcYw7iA7CIikhCcu6Y3PQbl
         7bMiw05Dd/oUUElFvFezBx485JoMM1bz8n7r5eJhfFHaLewkTMDt+Ep3gzehjjzacwKs
         /+cbwlyX7RJ91At3389p6lg3xjBTvPRuUl6a9tKCpZX9/gm8e8BFLJWm84iMD1E/ejjT
         bT5gp5JH/BQ+j0AiSL4txJzMkhLn0pA9nLs0qQnnddSpBaipuTYfgA0UBi9IhtorYu93
         zsfkHjGGE2BsGsjjczhaj9Q7nyZzWGRtuPK7wdqhU0JsSQCTwviETuXpvCVmpCrO6+j6
         +2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866340; x=1690471140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TfiF7Qn+rHGOgsaYz2UyOUxB3qdJrasp6G+WcSeqtA=;
        b=ZS5QE9HekTrTrWcqrO+oSJ2k9f36TH9wDhxuhe4OXgACmHfuYgPFUEcQj02qwltD1j
         nKMsyC98TFVeBWCmD5KWgCrBjAM5sBgtxYUcPGNV1h5wao44uFJo4AV3jMvp7ET6jJGt
         mE6KhirKlG6uorJRP+m/3AQKFQ8ZjVsf+uKZ/B2H8ZJ7aLMKc4+8UeieEDiLap4R+u6q
         eCAo0pJmoVXkVlx7z/kNuiL49DbWXYnGHOz65ONMF0HH4QoMlfPxfP3Z5nvC+7dqgKVD
         CBu7euPQ5kYeBTLfVhckziDoMR6e9/aD6UAdoxxY0RrhJn7etBxyUsGWIe+LyfXu2e6a
         zHYQ==
X-Gm-Message-State: ABy/qLYCHZi9esZ34ExWgO4r4D1FBy75R0T3bPtdvWsdNjugfYk1ykW3
        vV84wlI99YGYdZPVQO4eLVKEE+vMspxj8n/9SeYxoACjMjU28PPb
X-Google-Smtp-Source: APBJJlHf1SKa59G27cQXDIDWbUR12EsQTDOby+CG1JeQpqn8MIsSXvPGyVTklxUbOVeAw++zblRfzduN6+coAIcoGh8=
X-Received: by 2002:a05:651c:92:b0:2b5:7fba:18ac with SMTP id
 18-20020a05651c009200b002b57fba18acmr2598533ljq.48.1689866340520; Thu, 20 Jul
 2023 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202046.150986-1-afd@ti.com>
In-Reply-To: <20230713202046.150986-1-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:18:47 +0200
Message-ID: <CAMRc=Mfjhn19u7R__OWpH8=iuOXKOzCvnYfCAoGQ+G2hODXrqQ@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pisosr: Use devm_gpiochip_add_data() to simplify
 remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:20=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>

Applied, thanks!

Bart
