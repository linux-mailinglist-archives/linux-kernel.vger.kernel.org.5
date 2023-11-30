Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8F7FFE28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377088AbjK3V77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377048AbjK3V75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:59:57 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CA1710
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c194b111d6so1209100a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381604; x=1701986404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=LzHmNT7T9OxxOb1QquTvMGrKV7wO0Sg+X8fJAEm9yzvP8KnKNb3CA4s2nDgc8XBwBL
         wbAnybflvTHmu607/EUPJZjvJsmGVUdEBFA46dSLXI/RJo48n8Y/NsYGqhB2tRXVMeNE
         4xM44BLmBeptCJw0drtptkUFx+WIgaFzGWQ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381604; x=1701986404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=aqIZGA10boPjw7eIGAaz42rzbvKzXpfIMImIXXCD7uaPK6IhivEHVINm0aw9l/tEGk
         gVfllKmx3sN6Izbo34a3U6e0tGAyEvn0SdFgwdKf4oo5Qc5tGpmeoa6c0gTFGsXhf+SQ
         DsZ3mshiqXcAireP3wCsBI244JS2FYLay/GYviywzQU9wO32tk7fPouOwnQsGVkn1DYH
         n+V5EcQOcHJbvi38zjy1ubv8OZi4dzGCF93HoshnHt+ff8GFydFUQhPrCAa9f4phbD5w
         lN4Mn83YigxqGqqrvyh0SSwGM/W89lhzYBbLzUp1jJe5Gne6wGpbgBX0FzFiF77g7lri
         56uw==
X-Gm-Message-State: AOJu0Yz12PYvFJxP/s0CN7Lriksw+Z0BjXPCUcqq+cvewx4aqHrQOykA
        0+HxIgaQlknwWiYdSFcIzKmTrA==
X-Google-Smtp-Source: AGHT+IFFUtQvkutbCzwEJYcxjo8NsuSrn4mGmVkHUogFLPx4tF/QDvpCKAlGy1xHzlefkRb9ZtgYRA==
X-Received: by 2002:a17:90b:4c4d:b0:285:9a33:258d with SMTP id np13-20020a17090b4c4d00b002859a33258dmr22743450pjb.44.1701381603922;
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001cfd2c5ae6fsm180457plb.25.2023.11.30.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
Date:   Thu, 30 Nov 2023 13:59:58 -0800
Message-Id: <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023 18:56:50 +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
      https://git.kernel.org/kees/c/f1c7720549bf

Take care,

-- 
Kees Cook

