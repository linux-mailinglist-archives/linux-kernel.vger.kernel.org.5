Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37C7D5D17
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbjJXVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJXVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B310E0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c02adeefso3940888b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182349; x=1698787149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=cRjSaLQJUrwa4AUcp31Zy8L/hLnp9LV1jJM3rtfxSp0iEh6TzfZywczgLftJcAe6O6
         P5DKVganNb5q4f8FiSyxdqlDhwvzrNVx4epmbJfnTLEQ1LmZTOFzUdCa7AKIrqzFnJl1
         qPciOj0QsJ8/02Ht8xDTcHk6dFCrjSCosrVcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182349; x=1698787149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=kZUmZDkCSgEUPJdxmgNVj7X+cbFwpa9C6auGcxBlhoKLFCEdV7jPv4izZr7iB2STlN
         CDR2Gx87Dmx4a59A7B21FTD3SIaY1bORh4OFPrNcFxWJRKahkU2N4EdKTFjmIa1OOUYy
         Xx6CKiWfrs7muBsUv+LjYvhRteDHA0yFiUJlsypZcPpockhOylhlAyUSyELwrn+enyXJ
         pUSyIz3QBOE5GIksXJaZpqTsUvn0kHwEXWKLE8osxhDzXON+Pnjn8ntVM4YRxaFeFv/s
         vUMJkrU2zsuAm0kPlCZ0CHhKShk1TfQ2+nGbYe1ggk8ruwWvD5jyAiG1BSTX8KouHubC
         V/lg==
X-Gm-Message-State: AOJu0YwdeJNoBN68X5f+qDX9qhbzsZ3fzj6FYCSgxurJGryJ2QBSIAtl
        RIyKwpEBEoBDunpIJRnL/q/Txw==
X-Google-Smtp-Source: AGHT+IF4UsUe/MDsFLT/6RmYo+0oZquyT6z1OqAlchXeQRBB10Ec2lC3ifsU5XaSGoCtW52NqTVUcA==
X-Received: by 2002:a05:6a00:850:b0:68e:46d2:e331 with SMTP id q16-20020a056a00085000b0068e46d2e331mr13120074pfk.23.1698182348738;
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79dc5000000b006bd2bbbaf49sm8079331pfq.122.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ima: Add __counted_by for struct modsig and use struct_size()
Date:   Tue, 24 Oct 2023 14:18:48 -0700
Message-Id: <169818232961.2100071.16281003220296579350.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSRaDcJNARUUWUwS@work>
References: <ZSRaDcJNARUUWUwS@work>
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

On Mon, 09 Oct 2023 13:52:45 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
> annotation has effect, and flex-array member `raw_pkcs7` can be properly
> bounds-checked at run-time.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ima: Add __counted_by for struct modsig and use struct_size()
      https://git.kernel.org/kees/c/68a8f644575b

Take care,

-- 
Kees Cook

