Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0836E7B3AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjI2T20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjI2TVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5952FCC1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0ecb9a075so110441845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015281; x=1696620081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNsDO1TdEpCGLaLxGAq/gTTVsrbL7yU9yl9SCIkPcCY=;
        b=JG28XOl0oGwZTJwdjdwAkJ+nltGy2fy6gYOzfDBxmIWc3JTsoHXcGRmd+ntzS2vpu1
         4KdR7J2P4kVx8epzO6iU37KrqAE/+ab40fFry98HbfLwTZFOM9nZ080HNsECWN192Reg
         Y+OBOyKHTuC7TSOORuMpt4KuCJMGnUq/0Zak0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015281; x=1696620081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNsDO1TdEpCGLaLxGAq/gTTVsrbL7yU9yl9SCIkPcCY=;
        b=nvS/ggGEZha0VtRJ5gDinpqudQ2k8GgLpUcjAKGtEICKCs6v4yCShtoteDG/X4mEie
         mPbQtuT//TaY4qOjC/UZqKD+Jv4rYbL1XKnBQHwsJnxl54ibrg/LsVQ+Os54BYYeK2u/
         tm2u/iPFrIMuffl8FeVI/+dj3LjmHBqqhFvkss3lXaolbIQU3IXaP/loW3m8cOyAhDZC
         CpVo3Bv1REOOEF1ksyj9luB0Iy2PmpPA0HxWPuo0rfwppHN4iiv5OPDbqyDTLevCy9+2
         LFNcsad7KxU0y0vIzp7QpxI1ZiJQQmN+TaebOiH0vvpAs9C/eGvrwkjzhTZ0Cib+jM8v
         pKGQ==
X-Gm-Message-State: AOJu0YybZlGyHUo5xvsAh8WVrmImPHxMmQfxlNdcOkM63xhyUG8jQyTu
        pcIQ4mUWSFjfXjiKStJ7vFblTQ==
X-Google-Smtp-Source: AGHT+IFjyLlRRTeaeUecf9XWMNrkK0uGGpsZzK0vctMS8QPYI0ipJfXP8O++f7NHEfdRJEQBswkXCg==
X-Received: by 2002:a17:902:c409:b0:1c5:ea60:85c1 with SMTP id k9-20020a170902c40900b001c5ea6085c1mr6240720plk.12.1696015280740;
        Fri, 29 Sep 2023 12:21:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001b89b1b99fasm17247784pls.243.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: Annotate struct urb_priv with __counted_by
Date:   Fri, 29 Sep 2023 12:21:10 -0700
Message-Id: <169601526966.3013632.8979451725349830093.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195812.never.371-kees@kernel.org>
References: <20230915195812.never.371-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 12:58:16 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct urb_priv.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: Annotate struct urb_priv with __counted_by
      https://git.kernel.org/kees/c/a5683963b3f5

Take care,

-- 
Kees Cook

