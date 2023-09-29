Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7667B3A37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjI2SrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2SrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:47:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250B19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d9cda925so11713458b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013241; x=1696618041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B/YVqRmwnwnjofPFkPb1kg3YwC85zFCP7AZplCHHHs=;
        b=egFyIH4tMQLiSk3zERdfp2i+69Jr9tkHWQjCiGv8ROMs7XO5dvsy1vZGHnNBe3MA1J
         BLXHK1auQkVIXqZYGRD6zqR4DS471TIvlE97VwdD9/bFhbjaQtRh7G75ASBosdgShXvY
         4D4iwZIafwaqiWIunGMc7BZXhySuimIfmigxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013241; x=1696618041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B/YVqRmwnwnjofPFkPb1kg3YwC85zFCP7AZplCHHHs=;
        b=CvCQ952XCuPuMJvJikJ5GQ2Nb7SaaKEIg77w4aZejbt6sLb/XIYL+f5M2ohFZIviiZ
         scxZp+wNfdqoEcgUjGPKRSf7BN/bE2Tb7v8qOqZnpb8EzFFzDv0uwRaw6T7+mIenBQmE
         l7QCkTzU05VeH+2VH4OH+IcKntTbZxio3Ofx/tX7165eIWEAVchIulVEzK54FwevC4Z8
         ZyTVQVe1s4ZIdJRPQ+aDN7ZoTGyI97kKdqq7a/ucSnb43tgYxTJSNnlzBbnWHda2uLpY
         cd23ymdMbGzWSjuFl/pxKBW3EbLXuuAS7f4vXy+W1u2kTSC+MJ50Qx4FEUHip3BL/VCT
         oPrg==
X-Gm-Message-State: AOJu0YwxKwzEoBQjM5QYJLGDJgurfs5JsMcd8wm11FcD94rI9zRJ+7tl
        3nRV2yhTgqB71M4nwtvSKv9HMg==
X-Google-Smtp-Source: AGHT+IH6WpxgrUtqqQpbxmNTMkjPMbWAuJV/XzgQXt1K55nnaoEQ0Cqa/md0a+9HUxYRpUTLUXZVmg==
X-Received: by 2002:a05:6a00:cd5:b0:693:4123:1f63 with SMTP id b21-20020a056a000cd500b0069341231f63mr5581677pfv.15.1696013241344;
        Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a637052000000b005646e6634dcsm1660796pgn.83.2023.09.29.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:47:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] HID: prodikeys: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:47:19 -0700
Message-Id: <169601323861.3010315.15027910683169033551.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
References: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 22:20:55 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] HID: prodikeys: refactor deprecated strncpy
      https://git.kernel.org/kees/c/31a602bd2f48

Take care,

-- 
Kees Cook

