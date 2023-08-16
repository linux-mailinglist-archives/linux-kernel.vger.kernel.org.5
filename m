Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297A77EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbjHPUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346345AbjHPUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:50:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52331BE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564cd28d48dso4273309a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219054; x=1692823854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=650OmwVxQhOnYGaICLWTUamQxUV0K9BjBoiNw6Mvi7s=;
        b=AAhdz9azJ1oAOOf7r6f4aE3P1aLiAOHPnMq4+DxUb4yM5ajY/ucvivDufZJOxlboY7
         c3viPCAOkJ3YCxz2Vo8bORzF3++etXaHLM3oRt+Iqff9ZdAjX7OomlQdqVXASfnCjCDv
         suv0aqwPc6Snw44IkYnm91dUUOMnppOT8gbp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219054; x=1692823854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=650OmwVxQhOnYGaICLWTUamQxUV0K9BjBoiNw6Mvi7s=;
        b=iMkrg5ZIF0teFfSSgEAipL13MgKOSKjZjvWCT/YgWx/U5hV30ZXAH1L/3E8rmq3O/1
         CPR5dCW/vpInnc1uJZg+akK/RW17aCB0l8ms2Cr/5DLRl1y8UwBctlgLZNt8qItpp+1T
         Mn0a8QB+qUzb4MFIjnD6m1VBN2ynOCva/ltvE+UF2Mm8MwPe6qaj8zvR/8C+oI/wNSSP
         vnnRPfNPp/DWac/sDqMlDsImblULgvNz2h7Kewwm18GO2su0Pmr8GisaMvzor9gzo2X8
         PJ3p9gs0xrvmw6FQxAPpEcAMMTkFwuq2ildO+6Eoh1Qj4ttvAwxUYy21kHsjn8NwJw4H
         ixkQ==
X-Gm-Message-State: AOJu0YxRvm6yiVoRg5vF6OZ25X/rYjUsTBJCAnMZsSNxC84CzyLeIGKJ
        4kAZ64d+t/opJXjhGckBZpao9Q==
X-Google-Smtp-Source: AGHT+IEqIC8uFB+T2j6STILQqPVJdg+D16nCj/MBp4iSoxLRvdmCGlOHHpk8KX1MHi22npP0pNJQgg==
X-Received: by 2002:a05:6a20:a10e:b0:10f:52e2:49ec with SMTP id q14-20020a056a20a10e00b0010f52e249ecmr3698160pzk.53.1692219054128;
        Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x7-20020a63b207000000b0055386b1415dsm12394737pge.51.2023.08.16.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:50:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um: vector: refactor deprecated strncpy
Date:   Wed, 16 Aug 2023 13:50:50 -0700
Message-Id: <169221904769.1235632.10910494392812070923.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
References: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 18:22:30 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> In this case, we are able to drop the now superfluous `... - 1`
> instances because `strscpy` will automatically truncate the last byte by
> setting it to a NUL byte if the source size exceeds the destination size
> or if the source string is not NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um: vector: refactor deprecated strncpy
      https://git.kernel.org/kees/c/30bed99e0c63

Take care,

-- 
Kees Cook

