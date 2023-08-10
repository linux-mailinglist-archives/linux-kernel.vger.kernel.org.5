Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17FD7772C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjHJIUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjHJIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:20:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B4E2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:20:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d6041e9e7d6so603781276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691655629; x=1692260429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5GKYauNUMZicu+wlrLRBQHY+wytfPoNLxgflI00fTQ=;
        b=BaOpIHHy68kHwluqlaz8yEsgtcIDXCE1/lkuVjyCY89BfGDSm9iz2HqZAG1eXZBzxp
         DpTjlipnt0EapLf60Oz6Mkft9wc9ObOZf0+UiIsQC8b8ODVd5AMTPHyj6Xn52tX6qrIt
         Sd2aSlltBEz0xfHxWdBMe/ZYk8XXI5cb2SUTWaTvvTJO7V4XNB+xC2WIOjfSu+OdK9/4
         alg1zTkat3ZHiDyWCN3JGwcvPRdUGIE0JkvE0bukh//64AgFYNiOtBfQPO/aWVNv18dK
         H1KyrQEdlH3WUvRviVK+2mCJuwSIK9yV1WoU+jPo4Kdp2jZF4ygmflEkcui44/zPcDxi
         SoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655629; x=1692260429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5GKYauNUMZicu+wlrLRBQHY+wytfPoNLxgflI00fTQ=;
        b=UwBERfYpk6lpyQ9nc4nqpnhnlRBS4+Z2MGBZSJS2hX4OwhUQSfxpeDX2GA8gDsVNyV
         WoWT/il0Pknk3eSTILJH/yXHaTbERvuwAUt/qRd2fnjWIJC2NwC5aevkgHwdlwKSVDgS
         kPzltmEhRq5pD8EzpkmEVPm+AfvmSguMn/eEWfrtwXAxxatZXPRMqehstQtXYp4CL8ce
         FQtK36YlWRqUnNMP2N2YR4EszJkKrylXxQBOxekEYWd9H1kzvox3YTchrh/6aCX962A/
         GX1CHR3LUybxHQPEsioW63B62DoARzvoU8/O9wHbREX+CUcS4Xg42mgVJhEdPmGC0KM3
         KR6g==
X-Gm-Message-State: AOJu0YzvkdY0HmdMg0wL8oVULB+aLEEmUF4++stkS93KUrXImtXwOVMT
        jLtoGh1sKDWC5A9nKGchQTLIr1ba9BRnvbsBe8fu/4roq+sx9BfU
X-Google-Smtp-Source: AGHT+IGFn+/z2hQT9C83PrTd1l9nQhxoLEm7UnpyXA12J8UQrzpy6TaOVVAaxMKwCfPxNwSTB49zI+JQaZMbxy1IPX8=
X-Received: by 2002:a25:dfd4:0:b0:d0e:6c9b:b9f2 with SMTP id
 w203-20020a25dfd4000000b00d0e6c9bb9f2mr2567679ybg.12.1691655629165; Thu, 10
 Aug 2023 01:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230724144108.2582917-1-ruanjinjie@huawei.com>
In-Reply-To: <20230724144108.2582917-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:20:18 +0200
Message-ID: <CACRpkdbp_hDKu3BCruip=6+MjgLD_=HvFvgx-p9VgGV5MA9iPA@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: ste_dma40: Add missing IRQ check in d40_probe
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     vkoul@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, srinidhi.kasagar@stericsson.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:40=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com>=
 wrote:

> From: ruanjinjie <ruanjinjie@huawei.com>
>
> Check for the return value of platform_get_irq(): if no interrupt
> is specified, it wouldn't make sense to call request_irq().
>
> Fixes: 8d318a50b3d7 ("DMAENGINE: Support for ST-Ericssons DMA40 block v3"=
)
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
