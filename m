Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4280F914
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377573AbjLLVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377567AbjLLVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:20:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFCED3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:20:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d30141d108so15823775ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416019; x=1703020819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4PtHmb7h7cjkMdU7+gili3cUJ8EUgY6EkxjVCjKgrI=;
        b=NYLUScjO2XHVuAXl4F9gnGJv8CZ+pd2VksCe+NeS5ye6KyDTjRizOhOX8j71SQY5Dy
         0Nz2H4LlieKUYxGIvH0QIB3Sl1p+Gd9xI+hRA5w1L/5HaekbPRUV3WLRRZ3mkWvPwipf
         2SDuc5LQM9k0R8tLoimKfPabW4WpUPaPp7G2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416019; x=1703020819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4PtHmb7h7cjkMdU7+gili3cUJ8EUgY6EkxjVCjKgrI=;
        b=aPX1o4l/SfcoKFYx47SYEukQrKo3jdymIOLq8Khf1uuWyIUK2X6Ob9VSef5bEqU8dy
         5ME96m48Vpo7N+NwiQMcr9vW5/lVQWXlzEVejS1Qt4PrYDROJBcinVAiqFXMzOpIFViz
         dPROXhq9696K1NBgJgXmJFZfx5jyloNYOTCZRXMVKbnF360nxVg74PE9J/UtolddWWzZ
         4SFQF7bSo7inhrlrd4kRcEYByBoyp7uYZPaGI4Yd5BEU+IhyVUoXTCFKp6j2qPphT6qO
         GtOP5PNPEdNfj/CAgMEa1kQ9CmkPC0+7BX9usS1HpkZkop1I3Y691x1RhRmeisTehRXB
         gdDQ==
X-Gm-Message-State: AOJu0YzxNQ2h9wfcCfX3VLMa/wmjLxLh3kFg/5UqAY1uw5Yv3s5kg0C6
        LzuHncyENgbVX3Qdgbq1e99xJA==
X-Google-Smtp-Source: AGHT+IFlDS2uaGb+KjVZJ4SyvoBSZrz/iRr5YDrQNhwh54rEmgWqvkqV+B1gwdtK5G+Q3dAMbqwDDQ==
X-Received: by 2002:a17:902:650f:b0:1d3:3a5d:d5d3 with SMTP id b15-20020a170902650f00b001d33a5dd5d3mr693274plk.19.1702416019386;
        Tue, 12 Dec 2023 13:20:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a170903249100b001cfbe348ca5sm9066719plw.187.2023.12.12.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:20:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>, Kees Cook <keescook@chromium.org>
Cc:     Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date:   Tue, 12 Dec 2023 13:19:39 -0800
Message-Id: <170241597608.164694.1762861756800879766.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205010.it.412-kees@kernel.org>
References: <20231130205010.it.412-kees@kernel.org>
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

On Thu, 30 Nov 2023 12:51:17 -0800, Kees Cook wrote:
> This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> too-short struct buffer when reading the string, by using the existing
> struct union.
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/
> 
> [...]

I'll put these in -next since there's been no more discussion on it.

Applied to for-next/hardening, thanks!

[1/2] qnx4: Extract dir entry filename processing into helper
      https://git.kernel.org/kees/c/49a85c02a189
[2/2] qnx4: Use get_directory_fname() in qnx4_match()
      https://git.kernel.org/kees/c/0a0fb20f5e08

Take care,

-- 
Kees Cook

