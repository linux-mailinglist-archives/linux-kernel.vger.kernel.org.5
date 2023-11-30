Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24F97FFE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377199AbjK3WBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377177AbjK3WBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:01:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955A1711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:01:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfc3f50504so13494975ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381671; x=1701986471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=BXMttHtilstQ1Pgl84rIJWvWUXYITk1NTityektpvf/XoZoUueRxx4vr466V1/1cxt
         D27nUjhnUDQ1csuQIah1d55MSvahy5LvOUvG1J7OG1h9LI+MOIdgRXRXUPNcqXMfdWpF
         l9wzdwD2o18IRFHirmRP0ZN4vyaSiTrO4AQqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381671; x=1701986471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=M04+YFzVtJBXcXra7aYr47BLLDwgvWh5bmI2xl8g4sQ196depbopWGvxnYVYeWIOpR
         nUTMNAUp2m2Vi8aZFHDg+T6U7o7xpz7X5LVaRWQfo9LyBNDEYIDyqitJ1XBHeFORDGMK
         0x8JZFBQ+iTXFhHAPm4cenaekC0kCgS04Q/YaxyBgtMsw0xfesZB7XJMXeXSjXeeY8fk
         f6Zno0pKfOgJoX81uevNdfWpRr+gJaJ/v5PR0GJmpWwMoYQLFJnw3joH5CxthUGjc7fX
         Vxvxn57RjiLIsJIL6XJm6KuA42sL3ScWZJNg7+vfr/0kAAkvO5csiypQvpH/y0pwg95N
         fAJw==
X-Gm-Message-State: AOJu0YwjQFEwobL3S7MHMI6o+ESGlm7RyPnVmQAHwJSIwakUgRvJ250B
        L0QVRxRSK/5A3J6QEuBtQExaEQ==
X-Google-Smtp-Source: AGHT+IGY5agfDsFxlB2k5UH8mpj8C0v/Uh2rRzfKYSgYUHnOdDJozZIQ756ghTwfc+TZrv+C9gsLzw==
X-Received: by 2002:a17:903:244e:b0:1cf:de3e:e4df with SMTP id l14-20020a170903244e00b001cfde3ee4dfmr15071465pls.58.1701381671024;
        Thu, 30 Nov 2023 14:01:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090270c300b001cf6783fd41sm1911702plt.17.2023.11.30.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:01:10 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 14:01:08 -0800
Message-Id: <170138166766.3649510.14295562251346849867.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
References: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 21:34:35 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's instead use strscpy() [2] as it guarantees NUL-termination on the
> destination buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvme-fc: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f62cacf390b7

Take care,

-- 
Kees Cook

