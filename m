Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9221A7B3A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjI2TVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjI2TVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509B1B8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so110624075ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015278; x=1696620078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilE7Vn1v/6L1xjJiSnZJWIX4iPYebLM1xUgfMUUBIXI=;
        b=l1xKYYCO0814xfitFFg3tTO2AT9+9UZgRImRulirJNri6/R8G48vt7MVrsxzwN/yb9
         yZcK5RIeg2Dnra8ZA5VYQ6jsSEfwkHjIdSx/M3JiS3KW6skKsLi+OoDS799kphCDvFul
         f55bYSu/I95TCgrsNLDFkV1d4tO7/oQKR06NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015278; x=1696620078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilE7Vn1v/6L1xjJiSnZJWIX4iPYebLM1xUgfMUUBIXI=;
        b=StutXhJQGU1mD57uA32qNTH5rnQZ+aESPGFHj5G7+/iOsWzA0RZMELDIjZsPVa7iyu
         /Jv3NkvXA4wOGOkuHLrOiS7Wt8JghuBlBn7PmxIbbDflETAEeFi14CUhC7RcnBdk5b2e
         qF/YAjNeSpQ3oF7yCTH4D+siSkZR2x8wdCGB0t7T7Dk4ZOUUgYeQbtrg+9VfN4wF1nRR
         Vy3uU/2RWTqADTrsLnPNK3aw7WqR0F//YoyPv+jFfB7mvPepqSDGVUFOziE+/gCyTHdI
         B91YlbuXmUJlhPOCMSg2Gb6NBfOrLJNojPuFrqPS17f3YK4eFrxr2zHQK5nsn6y2iMRP
         DkSw==
X-Gm-Message-State: AOJu0Yxs5v0jtUgsBnr/ts3BM6s556o0RlQtZQc+QUfDUR/SRVWCjov1
        mpFFUL5Au5PPkyy52DlAMhdglw==
X-Google-Smtp-Source: AGHT+IF0tQMM6MXJc6XxNKRi0sTdKpt1DN5cZbXrTlB5Mp1e+iC1EFDxKCNZm0dE3mY+fujU5z55eQ==
X-Received: by 2002:a17:902:e549:b0:1c3:d07f:39f7 with SMTP id n9-20020a170902e54900b001c3d07f39f7mr5943508plf.62.1696015278370;
        Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c5f62a639asm13455348plg.196.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     John Keeping <john@keeping.me.uk>, Peter Chen <peter.chen@nxp.com>,
        Hulk Robot <hulkci@huawei.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Will McVicker <willmcvicker@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Annotate struct f_midi with __counted_by
Date:   Fri, 29 Sep 2023 12:21:12 -0700
Message-Id: <169601526970.3013632.470911371867487341.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195938.never.611-kees@kernel.org>
References: <20230915195938.never.611-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 12:59:39 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct f_midi.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: gadget: f_midi: Annotate struct f_midi with __counted_by
      https://git.kernel.org/kees/c/cfe2af2d553f

Take care,

-- 
Kees Cook

