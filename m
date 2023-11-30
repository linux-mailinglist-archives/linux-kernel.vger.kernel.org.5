Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B27FFE25
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377008AbjK3V7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjK3V7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:59:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731610DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cdcef8b400so1464844b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381584; x=1701986384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+MjKIfeA6c7V+SkVK7ESwNu4zKp4IlbbMa3hRtTv3E=;
        b=N2/jxy/CKVwt902heLKJ/9RkwWIO9NF5/UWrAhqO2YzddpXpIr089+xPHNARO4wj0d
         Xt1g9n0Gs7fuNnNEGNYYKinblwJozKqfB31UPWP/01ogmvDUiosP+4SB3yBmuFvBttRc
         8/tLblPYi+DEweOrleF+tSH6qbRfbv06dkdYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381584; x=1701986384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+MjKIfeA6c7V+SkVK7ESwNu4zKp4IlbbMa3hRtTv3E=;
        b=Fl1aIe9hTjO1Eok9FeALvIr9CSGLSiULevNnJWBYzD05JvFKjPJoU4LuaKzBWZUu6K
         OqpE3Sby4wdkr1asqn4AKhDgibXPNkG3idJ5SoRSphwhuapfz6k8FGKA778fcfRenHcD
         EXUEtsPLfyPswXofOgRWoB/3fpkpmiJEZt8JrY9GxKggHRBlUfIjXWvwzsq/479rSKXU
         0gDs4kpuoRfkP2Jj0VSJ9SasWnJ6y1MiZ+dyvJATiTwE7n2Fsol1WjJRO9qk1eutjg6G
         7WAJ1gWNgUcnmNRwAoMoaF0esOMfyIdPEyGnezuJsR3ueR9W4a4R0fNOMbWQuWhR6Nl0
         fEmQ==
X-Gm-Message-State: AOJu0Yza6i1JtUM8cDmgRs3CuSAJIZ9iVMZlgk58Z3s4RBiciFdUAzeB
        MDSjXLj7AGUpeV4DE1pNOQS1A42/fYdSfHwdx2w=
X-Google-Smtp-Source: AGHT+IHnOCwCjzZBfKxzRTjC4fQ8XP/8fQObomS+nCckrMFuuQt1ZNZTYjBCrPSpglsbSfTmpIMqEQ==
X-Received: by 2002:a05:6a00:2d95:b0:6cd:dece:b73d with SMTP id fb21-20020a056a002d9500b006cddeceb73dmr6204554pfb.18.1701381584754;
        Thu, 30 Nov 2023 13:59:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79d05000000b006cbcd08ed56sm1683994pfp.56.2023.11.30.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Gurucharan G <gurucharanx.g@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] i40e: Annotate struct i40e_qvlist_info with __counted_by
Date:   Thu, 30 Nov 2023 13:59:37 -0800
Message-Id: <170138157431.3648624.12161951188288893323.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003231838.work.510-kees@kernel.org>
References: <20231003231838.work.510-kees@kernel.org>
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

On Tue, 03 Oct 2023 16:18:38 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct i40e_qvlist_info.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] i40e: Annotate struct i40e_qvlist_info with __counted_by
      https://git.kernel.org/kees/c/da2e08d4630a

Take care,

-- 
Kees Cook

