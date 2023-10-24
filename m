Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE387D5D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjJXVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjJXVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC410CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b6f4c118b7so4088643b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182345; x=1698787145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z44BPeMtE2kACzCzizrt3sSV/gaHEispvl8DNfLTFYw=;
        b=TIwa1Q7X3jjYVUJNeubx/TLG21qBuyU/zU+FucIySGmdWBABnr2q3jmvATXm6Rb+XN
         kK40MgjdpuwcNx4ZEKuz5OtQklHK2GOydJfpef+F7f9b/C6PGlZLAIzYa17Ye4j7pLF/
         qpefgOmGI71QvMciI2kOOCOJN+IcChKulKSGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182345; x=1698787145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z44BPeMtE2kACzCzizrt3sSV/gaHEispvl8DNfLTFYw=;
        b=pgcSayNcM3TikXoUtSKN6zNgPxBKw6O1U3T44daIEjJ6efZTXOeVjQGqaPgIvFiYE3
         /x6qDWPE2UnIOhKzS7OQ0IaBb6dKBCpJfZjvDvfL155CaWUvWcqZGmpyRsVAI1q8y2G7
         P+j5dYP4duSgqEuXwxWpha2NxG0mP3YGZEZhqp+Bqz69DNspPnW043FzFPRNSOYy7WxR
         zmKqMApJqEaZPvj2KB/c3ysHIWs3waMvZwEnJntY9DcfHQ8ZCM+BvZW4Z+yeFKExzijK
         snxjjTJ3vIvuUEaSuDD6eG7MbWczSmG8FwF73shGyYJM0Kw9EtWJ4e1AKXVRHdaTpVmS
         2c5w==
X-Gm-Message-State: AOJu0Ywc8QBjpU2Q9kGAJrm49DnwQZNtHlWIfnoEUTuX0wZIyba8Lk9a
        W8HRU/DQDyH5qrZzm89vaL8qgWNb32bVPHKxC54=
X-Google-Smtp-Source: AGHT+IExcAVhyp7VZm2kE7JqtYW/LVhoC5XB1bnP/53gqyGSRDMgUiZJp81JNdO0o7sPap5EOURDnA==
X-Received: by 2002:a05:6a00:1595:b0:6be:22db:7a13 with SMTP id u21-20020a056a00159500b006be22db7a13mr11429436pfk.25.1698182345417;
        Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79a4c000000b006bf536bcd23sm6081290pfj.161.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
Date:   Tue, 24 Oct 2023 14:18:52 -0700
Message-Id: <169818232969.2100071.1483595444634836042.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
References: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
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

On Mon, 25 Sep 2023 07:06:03 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `lc` is already zero-allocated:
> |       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
> ... as such, any future NUL-padding is superfluous.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm log userspace: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f8cff5441800

Take care,

-- 
Kees Cook

