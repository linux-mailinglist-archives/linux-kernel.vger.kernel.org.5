Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB107D5D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjJXVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbjJXVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5310CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso165070b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182347; x=1698787147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDKEq+UzkLbktaOBRai2+Qm6LcjSkYjkBAqlnZqYEVI=;
        b=knxjII8W0iGYcUZP6qUoVa2OUh6ZXl2ayvFiMLN49emdB36L/C0t1ML2SaXQ011OGF
         LSyYerPirJW1WWCV6o7TQC6X7DDv9u9LQZqLGb2AG+j0zEoHYlpxtfK00e0wr5RdqbiT
         IVQCKQulf5UtdaK3/EeL5vWzHJ1QpGrSV48gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182347; x=1698787147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDKEq+UzkLbktaOBRai2+Qm6LcjSkYjkBAqlnZqYEVI=;
        b=GO/3lRJjqZGdBK3ruZ85E02CJAlIMsNSgtpaUhtxTBXdLEDLk7SNf8W8xRrriKKJQK
         GCZ7u+PMmUVN9AGUCy0vsJgYDdmCEnQeglt3zYdF4jTq4ljWpuVba6UK0RyC9ZCF5qTT
         WatDtsu6j15PF7CErtHOYAmID/ox36dRkr/dX2hnkHRG/coL+r2Sxfdtp6JM3aF8S7XS
         G1MV5x0cbERVAQwzFP7ACBUsXELSOiHYa+3f76vBMk0dUesHbE6EtPIu9Jj02dUFXXRx
         Ac/y4iUxtoYGg2UggfZtz3JG+dF3PM+beQbhv6Z09Sxs4vlBpoOCnSL7LvHTymM9AYF7
         LmGQ==
X-Gm-Message-State: AOJu0Yy+SkrGypwWqpGf/TrhhXiceep8aQTPSqnhSuv7OTz1eUmhLmiX
        p668dXALmgKqQClYtnqX5FsYlOYHJ1icysmDgTM=
X-Google-Smtp-Source: AGHT+IEvp8+akJziYautCeWt0MqbrrbJAP2OWIZTlVnOA+AA8K+nsGqzNoYKMslhlIfV7znTpZ+few==
X-Received: by 2002:a05:6a00:1d11:b0:6b3:80f8:7e91 with SMTP id a17-20020a056a001d1100b006b380f87e91mr21893779pfx.9.1698182346679;
        Tue, 24 Oct 2023 14:19:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b0069309cbc220sm7994225pfb.121.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm cache metadata: replace deprecated strncpy with strscpy
Date:   Tue, 24 Oct 2023 14:18:49 -0700
Message-Id: <169818232968.2100071.6650937049148310025.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
References: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
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

On Mon, 25 Sep 2023 06:13:12 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It seems `cmd->policy_name` is intended to be NUL-terminated based on a
> now changed line of code from Commit (c6b4fcbad044e6ff "dm: add cache
> target"):
> |       if (strcmp(cmd->policy_name, policy_name)) { // ...
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm cache metadata: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/5d9bc443188f

Take care,

-- 
Kees Cook

