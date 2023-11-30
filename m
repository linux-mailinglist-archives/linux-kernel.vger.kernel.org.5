Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996E7FFE20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377067AbjK3V71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjK3V70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:59:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550A1710
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfafe3d46bso14212005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381572; x=1701986372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2djO/hdtCxAj05SEfvtxt5bZ+8AqtE0qahmFssCkkc=;
        b=djT7O9N6REoqSZVNeKNk7HsbcgKR1m7xBCj0NavMtLIS9E00YVcNGXA6O2IiRRKaiN
         xpa/umUXDGc/H0mhg99SuIRh8BpFdQNVt3wRyKK51FJu7SrRuPWAmP/HUHdJIFHXCsJO
         YbbJhA+Z4FtvVPYXykHP7DGn2TNKq5nQL+m1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381572; x=1701986372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2djO/hdtCxAj05SEfvtxt5bZ+8AqtE0qahmFssCkkc=;
        b=eLaUjm55c2B5ew1E7tJqB/beLUUMw1EiWxZNQudrCGnV9KwbJSen9sCOzlt6M1llap
         mxl9aJTvf2hb8NtckMwPRvGWf1MNQza2Eu1nzq3vR0jie+VWMu0nTM+23nE+us2c89qB
         LcrvBtqoCAJ2ru4hHmIaGglE6dDix0/qr8u1uUIWNL4A1ic4hISL2sCN1fVps5Oo46m8
         g2lz9CjzifgxGatDfE73xl91kXi9IWYSN9PKgq0exVSTVStclFs1+Dpqsbm9EbLsWXMT
         LL+MBQBzmjRRUnzDzJ+N8PtDSqobR5pGhxKTiyT7aoXoVvLybDzHfT2ADJ8fXidKzFwO
         bYWw==
X-Gm-Message-State: AOJu0Yw11B9HVFj1YWTh/ZLvZhVJBZPkqHiFUkPR3LkXaGkoupMOH8fU
        2pnr5eETpOanIC9FUS2e46xQ1w==
X-Google-Smtp-Source: AGHT+IHXL7uU6vw5k8AVrhFvY+svGvoQDBSX/vpE7HPes6CB4/gBu3LXDtFLard2ILDOkQ1JOieQdQ==
X-Received: by 2002:a17:902:ab86:b0:1cf:bdc4:bb43 with SMTP id f6-20020a170902ab8600b001cfbdc4bb43mr16177885plr.54.1701381572319;
        Thu, 30 Nov 2023 13:59:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001d04c097d32sm329328plb.270.2023.11.30.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] HID: uhid: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 13:59:24 -0800
Message-Id: <170138156214.3648538.12067944211375143947.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003-strncpy-drivers-hid-uhid-c-v2-1-6a501402581e@google.com>
References: <20231003-strncpy-drivers-hid-uhid-c-v2-1-6a501402581e@google.com>
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

On Tue, 03 Oct 2023 21:01:58 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] HID: uhid: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/d4011f6817ae

Take care,

-- 
Kees Cook

