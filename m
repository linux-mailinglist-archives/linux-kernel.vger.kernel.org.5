Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236377EB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbjHPU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbjHPU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:59:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC12711
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:59:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc3d94d40fso58846665ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219556; x=1692824356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGgwWTf/nLP2TlwAmP1MWgMzO0RJqkyJNjk5XF286w=;
        b=da09eNAHkWEo/pEOng7AkizliA/xPdjEjR4w1hWOr6cprU1HJasY8mlRG3X5jlWYpR
         TQDai+S04x09MlFWQVCyVt7TvTg1NKjygAq0L4ybvBKX1MYRtaJyrZl/Er9T6P7t0k6G
         VQXoEBwVTI+LCFVKl9WnKuSx+eCIgamm9s9+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219556; x=1692824356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGgwWTf/nLP2TlwAmP1MWgMzO0RJqkyJNjk5XF286w=;
        b=JjFZy+wwQa8U4j8IGEtTNcvU0RHbqjjbfIKREKn79cZBWUMdQUMnPs4zuj6ehSztfq
         CHbr1fBKBjKKsuzRHgFMkPFIu8o5bliU9XEISM4hXEHE5UZEPM/WTbbmJkgUhFmFsnbd
         04d4shiYc2Fb98UyF5Loqb4oKZQJDd78k8UBP5sCCvi3hk6f9fZA3Eu+RN5Yoigo67G8
         fUOgD9t4FlhWGusUbRVljbtNiECnBnVb2uBoTAj8b6g609npHaIjm40289VE6fmbXvOV
         fXDqYVjuw+LgxGShdi1aEJlSdyEv2HWiHPtsqQgNoaBNQkcD6OpK5TRys3d6aevEMvbw
         5rNQ==
X-Gm-Message-State: AOJu0YzgB8UuM7FYF49y4lxjm0036GSwjq2MT+Jje4wK361WFqQ7l5kv
        pKQxLQYP+X5h+RJe///YmrFa4g==
X-Google-Smtp-Source: AGHT+IFScTCnLhDPzkRADw5u9zcBAk0sLroO3CH7he7HPI1WAHYwTrUUwVGAXpnxTWUxsTPr96Os9w==
X-Received: by 2002:a17:903:11d1:b0:1bb:cf4e:ccd with SMTP id q17-20020a17090311d100b001bbcf4e0ccdmr4098212plh.28.1692219556713;
        Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001b8c6662094sm13505194plz.188.2023.08.16.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: ptrace: Restore syscall skipping and restart while tracing
Date:   Wed, 16 Aug 2023 13:59:08 -0700
Message-Id: <169221954681.1236522.6821211749332698917.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 12:54:17 -0700, Kees Cook wrote:
> Fix tracing on arm since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall:
> always store thread_info->abi_syscall"). This was seen with the broken
> seccomp tests "syscall_errno", "syscall_faked", and "syscall_restart".

Applied to for-next/seccomp, thanks!

[1/2] ARM: ptrace: Restore syscall restart tracing
      https://git.kernel.org/kees/c/cf007647475b
[2/2] ARM: ptrace: Restore syscall skipping for tracers
      https://git.kernel.org/kees/c/4697b5848bd9

Take care,

-- 
Kees Cook

