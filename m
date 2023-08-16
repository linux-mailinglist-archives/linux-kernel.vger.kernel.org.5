Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9177EB39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbjHPVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbjHPVBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:01:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3B2711
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:01:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b2beae166so3061694a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219679; x=1692824479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tueXu0Ns+Bnh4f2pFBmSiDXwjez31Lg3bE/m1p/Z7F8=;
        b=h4cypbZYEWuj6qfKg7BYlroI0Rq4iT9ZorXDMReDLbo9Wu+H21+QzHnh6cn+uH7FUH
         m5V6a0iKZYYt87hSYYjH4w5codj5mGYhURlwquaQ2fLaO+V47hqsxsbbhePO+MorB7XS
         d5+G+FTLYfTttycSUwBFJbf4BSCr7mVis1t/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219679; x=1692824479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tueXu0Ns+Bnh4f2pFBmSiDXwjez31Lg3bE/m1p/Z7F8=;
        b=AzkISdj5lFnBV2LnXLV7DG3M6TzS0VcKTnHwg7IuKFuZeNw5LkW8Zg9FQ1JShvjxCV
         1BQHTF1JM2VH0K8lja2UMqokmgJqa/llnBMJpbdwcwyriGLQpjjvfIuOBnpYl6EEAA8O
         dUhFannVNR7WwSaxP4CFP7OUOKwMA8NHxfyPwIZxO0ECYCDpiw4dZ4IL8tgm25bC/P8y
         xxbBRb6FnvjdWLB2m6uDGiOTw7WLEoq1S9lF1+ePQyiHEf9Lcty8YesY6F0VNckMKgs0
         KNIM5MlAAOon8C2dLxA7Nv3tz2XT3pvL6BbqNPri2/VFNZveyVZg7aG/WZwga0d1cJ3n
         2HIw==
X-Gm-Message-State: AOJu0Yw940R5cltN8YoIUUCuV00UCRAQT/h/AHDcQIxiWRQ4TPpEZrhD
        HKi04O/qLfZjouLExSHahBB+hQ==
X-Google-Smtp-Source: AGHT+IEoTqsAY9X4d8zG8oJVSKdkfpXWnoDJkiEA4AHkAlofDdq5E5GGVkNjWu2cpshxXS33CUofZw==
X-Received: by 2002:a17:90a:f40d:b0:263:287e:3991 with SMTP id ch13-20020a17090af40d00b00263287e3991mr2358405pjb.22.1692219678711;
        Wed, 16 Aug 2023 14:01:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090aea9200b00263f41a655esm161046pjz.43.2023.08.16.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:01:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] um: refactor deprecated strncpy to memcpy
Date:   Wed, 16 Aug 2023 14:01:14 -0700
Message-Id: <169221967233.1236805.5075481446836951537.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
References: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 18:19:32 +0000, Justin Stitt wrote:
> Use `memcpy` since `console_buf` is not expected to be NUL-terminated
> and it more accurately describes what is happening with the buffers
> `console_buf` and `string` as per Kees' analysis [1].
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion [2].
> 
> This change now makes it more clear what this code does and that
> `console_buf` is not expected to be NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um: refactor deprecated strncpy to memcpy
      https://git.kernel.org/kees/c/be8dffa04de3

Take care,

-- 
Kees Cook

