Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8E7DE7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjKAWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKAWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:00:14 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E8318A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:59:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5afabb23900so4036527b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698875986; x=1699480786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVhslCqemjL4H5fKdlNl1e+NcivavOEThICSKqY5Y80=;
        b=cmIsomgQHciFGGroiszS8HKBzWFtpTz3CboIfubUMLvpFukWFM/SADG/jG4DQpz07G
         5UK7ctktBZAXpBbBLYuI9NaZ08fqGEzNhpq7ZHziEUgbY5ooJymeLre0/LJ4q0ipYACm
         CQkIDg0bOHikEBPcjXMbYYdkllMQfXuetgP6amWr18bdKpNY2Z6RVKZ0VZy51gnZ/4GY
         14Z4EWe3hFtJSXGFTlfHt2fFA0rk/5+OC1wMbx1SsEEJJ6nRTcq5P8/B8IINiX+R81ZS
         vxcGHWkgK8up4ueqfI8+kMH/R7qD7iD2rUZP58y+WxJBXcAtFXw6J3BSI75wiZZYs/bE
         HIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875986; x=1699480786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVhslCqemjL4H5fKdlNl1e+NcivavOEThICSKqY5Y80=;
        b=lbAQQiYFDv7faPhMA8+XV0Je6niRw1Ew/yN45Ht2pqItT2zuzXyNt7oXT3acq4e7U+
         IpENjawcFbJkAZpI2nAxqDUXf79GOmsdhUW0v/pijR7HLj1xNiGWaBh8m3z5Vn3hyb9d
         z96oMfSTCWKyygo7ugWz+kTQFN92CU3yuOoG1pn6XEH/EZqBw0pAfcm3+4xdZ0H6ciwn
         73btniXYwNfWiz0CUaRJ9wgLG8A8Td+1KGl3XckVtDcIaZRZOFibfew0aPRe8jEtDi9J
         As2y5c8XM0oWzVxdsqKqmPhW6pruWglxOG3wZEKck1O5Iu/GgV/UJFxkM99jCRilhqXv
         uckw==
X-Gm-Message-State: AOJu0Yzz2j3L8nzBu7sCXfa+PVopQmKJM6X3faLjnd9yAyr3PyqVfTCP
        PmRahVdU4HCg7PNrcMMsn06lwdWYWP4HfqJ43x+hTQ==
X-Google-Smtp-Source: AGHT+IEAWmjNqaDpKBud9HrA9LIsvsu2nlmPn06W+S7UDg40Xj5L8fVbe+zmZDO+ieP9R7C8NC/ofzJENFuj1vQi8/g=
X-Received: by 2002:a81:aa0b:0:b0:5ae:8539:5630 with SMTP id
 i11-20020a81aa0b000000b005ae85395630mr18109564ywh.4.1698875986043; Wed, 01
 Nov 2023 14:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231030175854.12675-1-rwahl@gmx.de>
In-Reply-To: <20231030175854.12675-1-rwahl@gmx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Nov 2023 22:59:34 +0100
Message-ID: <CACRpkdZ2CXiNsnh_VxAy0OK+s_=cDqP8k0PVmNiL4QJ+mMZ+GQ@mail.gmail.com>
Subject: Re: [PATCH] stacktrace: check whether task has a stack before saving it
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ronald Wahl <ronald.wahl@raritan.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 6:59=E2=80=AFPM Ronald Wahl <rwahl@gmx.de> wrote:

> I encountered a crash on ARM32 when trying to dump the stack of some
> zombie process. This is caused by a missing check whether the task
> actually has a valid stack. This commit adds this check.
>
> Commit 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> introduced this check for platforms that define CONFIG_ARCH_STACKWALK
> but ARM32 is not one of them.
>
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

Looks correct to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
