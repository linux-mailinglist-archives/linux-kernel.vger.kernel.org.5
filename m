Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914087E6137
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjKHXyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:54:09 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EE2684
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:54:07 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cb7720579so56841cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699487647; x=1700092447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPIgicT0YMUOMCLT4uJCnLIAl30tMcwo5+OGAxGHlM4=;
        b=l9JlOwdT0X7bYXYYuUWSJqkLg7WXmdpZW3sQZAgQwfHmNbMMtO+0k0fbxcfT29Gaij
         yCSpSwa7CoPtayR9PQhaXgaIDpWA9jXXYffWEADS6u2L1nGVacZrlqfsJOGb3+xysMfF
         0+rNDMgBxC9R/MtPoEnYrB2MSBL8imUDWu0mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487647; x=1700092447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPIgicT0YMUOMCLT4uJCnLIAl30tMcwo5+OGAxGHlM4=;
        b=VGwRD69beRNn2qF0K+k9ofmP0a+91m16eQDmkPvD0P9e44NRpNpdhFP5kpfjNI8EOW
         n8Eb2Hw8ro2LDjl2T+Cwn6Npi7J2t+HRsx5X/WQdoR7gQ99+1kLiSxfyhYlofoSFkdXT
         KZxc9bd/qpfd1YgXyZeEHi09rDPLnFwxocydQf0q+nISB3zYs5xt6uKtK3BD3135POpp
         hY0ENL6vqJIZeTyJN124RgOn1nbQCJrPScSbnkoPJwhtY+kH51luITm7ehDTM18FF7fu
         YpP7XXFXLhpXzE0Y8PJhIfLw3nUiSpILfZWkmFPDm3LUsB+egug3iIMMv1xUe5a33wAB
         wAsQ==
X-Gm-Message-State: AOJu0YzTDu5SXijqwjNgEGn/fbTpE5AkxE4HR8L8OCiyICvPyHfdrxO9
        JzQXbjwsTke6DdOf+dEnxvGYsArqYmuz2UieXUy9ZQ==
X-Google-Smtp-Source: AGHT+IG4qLX1Jx8SA8MuAgG7xA6Bh7HIssCSJyRn56g2uu3bUzNa7Iw+LteeWg2Y5X9MaR+6Lm//UDZVnVDaFrkoEeE=
X-Received: by 2002:ac8:45c4:0:b0:417:944a:bcb2 with SMTP id
 e4-20020ac845c4000000b00417944abcb2mr119581qto.13.1699487646603; Wed, 08 Nov
 2023 15:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20231108182625.46563-1-alpernebiyasak@gmail.com>
In-Reply-To: <20231108182625.46563-1-alpernebiyasak@gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 8 Nov 2023 15:53:52 -0800
Message-ID: <CAODwPW8AJuWq5_5Ktb4bo=_2jUgzrUvntdmqh8Pb+bFbq+Txsg@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: framebuffer: Avoid invalid zero
 physical address
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chrome-platform@lists.linux.dev,
        Patrick Georgi <pgeorgi@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Samuel Holland <samuel@sholland.org>, coreboot@coreboot.org,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, if the kernel wanted to make use of coreboot display init on
those boards, it would have to reserve its own framebuffer space and
need to have at least enough of a driver for the display controller to
be able to tell it which address it picked. Until someone implements
that, erroring out for those cases makes sense.

Reviewed-by: Julius Werner <jwerner@chromium.org>
