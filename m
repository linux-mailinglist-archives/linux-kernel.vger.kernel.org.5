Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6B7B3A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjI2TPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2TPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:15:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBE1AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c434c33ec0so112265445ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014904; x=1696619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMR6LUwPftHKv0r5/Li6NluEAeTRiPtbXaPEQ4+PpRg=;
        b=UBVYx32GUgxii2P9VeGDr1XxGqw9do4g2/tM3vjpNC9nG0EjDE7tes9gRDeaZHKBu4
         vp/hpV3A98dMo62Yzx1vECGtQPuK3Nv3gnvw5cEFwMGP9gwVXJI2GuLKMMLElp7+edWi
         1mpveEyxLXzmsn2Llw8qGt8RBDcp/y/f4Fpuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014904; x=1696619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMR6LUwPftHKv0r5/Li6NluEAeTRiPtbXaPEQ4+PpRg=;
        b=jsDCw4tDEetV7/nrK9ZPP4QzaahlgyejcE+rxnq07W/5Nfvu90K/oXDLCCg1pCwYUc
         QX8LiyPy+6Lkx38nvv8EA4Mgfvc8Y5ETuLeY+q6gKON1NCYwyp1LLb7acTZTS4I43jJE
         //RMg06TH30wKoArEitS30OXDMG+8RQlgT/jrePKqJq0z5g5IqNTxQ9xuGsxlLiofiPX
         mYUAiuMtq9IkDGsC4kPC7dw8hlL93S6ZOrXPIWrLRJEtYBdRagZuvGF0Fz2hRq52k+B3
         ZIg1Wl3InMI3JlfoxrArhzb9FHLvZk6ctUocg7QUl4zdeDW52nJobuAJcNr0dh5HqFPg
         1K9A==
X-Gm-Message-State: AOJu0YxcfNa3SD7Ln1fl6HGLLMBLMraJ371svQk5Ie4rdx/kfufUxO28
        YmJjFFhN+rdv8PtBW8WuLuHEyA==
X-Google-Smtp-Source: AGHT+IEBopBak8B7MGmd1sJZ3Lf8ZG5V73oh21Tehv4+8J8dAWg7SRzxgWm5FohLg5EVdZWMSxbroA==
X-Received: by 2002:a17:90a:f2c1:b0:279:47d0:d923 with SMTP id gt1-20020a17090af2c100b0027947d0d923mr439775pjb.17.1696014904230;
        Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a2ac600b0027360359b70sm1974742pjg.48.2023.09.29.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:15:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: atm: Use size_add() in call to struct_size()
Date:   Fri, 29 Sep 2023 12:15:01 -0700
Message-Id: <169601489954.3012131.16051231116010521718.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQSuboEIhvATAdxN@work>
References: <ZQSuboEIhvATAdxN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:20:14 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] usb: atm: Use size_add() in call to struct_size()
      https://git.kernel.org/kees/c/13f1a60fe04f

Take care,

-- 
Kees Cook

