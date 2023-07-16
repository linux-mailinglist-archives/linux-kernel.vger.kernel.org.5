Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195075574A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGPVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGPVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:09:15 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC9E4B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:09:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ccc462deca6so1596965276.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689541753; x=1692133753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCEUaKTw0USB6po20NzuaniDL11J92pg4MyMRkZkqoQ=;
        b=FxMQKSpH3KFIaRhkN3OYkfG7ElzSnssg/zFSWXqxyYZ6b7iH+856H5wltcDBG2gvr7
         3JjDe7k+nsll1OzOWGRsmYaUlJqvTZv4LWB+59WWgKil2C3rbHhDkRh0c6w5Vzq86q00
         OOUy0tNncooPTk/TDkU763ICBaWdwfVRnYcqjUasTvAuVwXZgeK5AzDL14kg7kGqkH8m
         bdOPetEKf3+gX1xzjyNGsVkipW48JAAxeW+DRwg/FVOVfM4wEeVelRLQOgxQKzx+njFW
         sQ4yb5lNhMYojUU3Mq41i5gj/+cZsnZW8KkOPlurkdBypcn7jVMz949ZuMIZvT2SYdqH
         VHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541753; x=1692133753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCEUaKTw0USB6po20NzuaniDL11J92pg4MyMRkZkqoQ=;
        b=OhwrZWDsspO6rKVKtm7f2iZjjwatIz50IoI/Wn/ysvcFvSsahx5W3Avrk7leVnW5rb
         rrn17UnmUYjh+KJ/GWlCAlfx3+KJX3jKQKEitkHPMnx/6eem3k584JbP8piES9QHLd0A
         Hlb4CjsMli99dwsqJiwRjMRyW2fFnmTMm+OVb+X212MFTEOasVitmZ/9X4y+IJ+1mlKn
         AYP44ZpJkvjSdsSLK550Hl2pnqk7F7TuQUQMx6mqZIKAKn8YKbbxk7axoJxHy64eK3Pe
         Bx61udx5ebkBdoW8/D0EdpLydRHKF0Y8X3limLjXu8k4GcEts5n4J9RsmE+5tTj/9Ivv
         AQ8Q==
X-Gm-Message-State: ABy/qLb7J9gqNakPUwSjAoFRpyS2pGaiZn6o0XovrxSvx4l1odhv/IDA
        GGyx83MPaKF6J7u/PwZvgf1AzR7Q/q+Rs8PEQA0/6ofCjyqVMD1b
X-Google-Smtp-Source: APBJJlF4Ah3LfGxe2NfdzIlKjKDyGT1Pjw0qor5qSsnjJq+SRixw8kIJIIIvUO9qxfA/RuFEOkge0Q0X5eN9oBKTTD0=
X-Received: by 2002:a81:730b:0:b0:56f:eaef:9d40 with SMTP id
 o11-20020a81730b000000b0056feaef9d40mr13956898ywc.46.1689541753208; Sun, 16
 Jul 2023 14:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230704124742.9596-1-frank.li@vivo.com>
In-Reply-To: <20230704124742.9596-1-frank.li@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:09:02 +0200
Message-ID: <CACRpkdYej2TBOFTKWZbp3rAARyDq=RVmx=eNR_48XsEUipbLAw@mail.gmail.com>
Subject: Re: [PATCH 1/4] pinctrl: berlin: as370: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Yangtao,

On Tue, Jul 4, 2023 at 2:48=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

All 4 patches applied, nice cleanups!

Yours,
Linus Walleij
