Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8732757044
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGQXK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGQXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:10:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE41737
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:09:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6689430d803so3386292b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689635369; x=1692227369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LJRpX9BQRcnRZ4qNWQ1ZNevNO5mzOeeGL9byAJD1T8=;
        b=BiRPnvAr7CA5e/biQEptT4E5/Qc8BcclNzdXTPPL8kvgNiKrVxF81vn2DySDxTq2JH
         CBFRSHTJyOzbrE6CdhR8EbkYtS/9LzB9fJTqeskFqJNRD1tKvNWEzs8EjgBMF3EC5Coa
         M9odoRm7VdOGj1siXn7c8FC20gqbNnFonrKT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689635369; x=1692227369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LJRpX9BQRcnRZ4qNWQ1ZNevNO5mzOeeGL9byAJD1T8=;
        b=Huv1huiL99Nt/r142pRZiWhbNGSMeRJQLKH38Hq/oFutYNlHO9HVNaSIR0krwMPzJM
         WZkXn3IEkpkwpltOuAYH6VGjpTmoj73nfuSH1Yo8GiGFfnTCxNQw4dfROWzqwyssEmFx
         igtOBixbSgRS78eWUuPxEzpTIzJrwccMnQtLe4fd45JuX+Mu8Jk4IpgZepnPBnjUy2WW
         DPdjpgpt1G00KDhnI9TdFfXyN4VscteI89b9ydfQFaG9URAX1VTqPRx2ywKPctwjdK/1
         nMW/vDG35v0ThoDkoqDnmtitEp+gX3tLoHnXleJluVD+IY2UF8GlMQDGPp1QYksIIBsc
         jNlw==
X-Gm-Message-State: ABy/qLbI+klXgX+MfHu2m/vXo/IFya8HpKg30B3J0fw3Hlm85tNvNkl+
        CZLOuwJxPZ1udTie/x27kp8PM08JLNYDCLlrq+g=
X-Google-Smtp-Source: APBJJlH8OZ5YpKHFtnEw6yDvI6gMyQqbjgOR3cNNNnUxomZTMpB5GsGnkLkksNhvkz6WUNt7PuvNEg==
X-Received: by 2002:a05:6a00:2405:b0:64a:2dd6:4f18 with SMTP id z5-20020a056a00240500b0064a2dd64f18mr13128789pfh.13.1689635368693;
        Mon, 17 Jul 2023 16:09:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79144000000b00666d7ef2310sm309336pfi.94.2023.07.17.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 16:09:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Date:   Mon, 17 Jul 2023 16:09:23 -0700
Message-Id: <168963536094.1395996.315062356944871422.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
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


On Mon, 17 Jul 2023 12:33:32 +0300, Andy Shevchenko wrote:
> Privided seq_show_option_n() macro breaks build with -Werror
> and W=1, e.g.:
> 
> In function ‘strncpy’,
>     inlined from ‘ocfs2_show_options’ at fs/ocfs2/super.c:1520:3:
> include/linux/fortify-string.h:68:33: error: ‘__builtin_strncpy’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
>    68 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> include/linux/fortify-string.h:151:16: note: in expansion of macro ‘__underlying_strncpy’
>   151 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied, thanks!

[1/1] seq_file: Replace strncpy()+nul by strscpy()
      https://git.kernel.org/kees/c/c30417b20f49

Best regards,
-- 
Kees Cook

