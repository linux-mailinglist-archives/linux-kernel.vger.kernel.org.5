Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E00765800
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjG0Ptr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjG0Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:49:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C65F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:49:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2b60731so6367425ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690472985; x=1691077785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iec1tA2tN7YsHL2UtT5qbnottO1zoJA2OGnLpMcZvuU=;
        b=h8VbzFc8i5VWugtjre7Ih13tJEfBEMty2anZABmcmRbo/oRcHNuSjG/3oGALwViEa8
         PDFP9Km4TYg/CIAM/r6EKDUNMJwllaY5XlvUaaVJTq2xFBg5tbWXCovxB1+s1ryA+oeQ
         AEiR4Yh+4RPUs8tJW5E3cp2BFeanu76gR22Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472985; x=1691077785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iec1tA2tN7YsHL2UtT5qbnottO1zoJA2OGnLpMcZvuU=;
        b=NOBHC2hxhDZdvLsdKrlrHt+7+OEXhw3VjOV+/GUDeEJwBmM2N3SuxozEqjAt9OM5sd
         o1k91EnPrgey+SCOvWrD4YhKf5FLzcxtjmSisoWFJUh3oQ+4pqkLuHeeXmAZfRUOt93X
         2Uju85eVFvoYCeayOJhCgGtqksbY+7LbdPninyWn9USG+WcPFhVFYa5xkV5lTdtjyzBE
         SrKnoG/3JHcrBmKJawFTDI1D3jU4PLqMhjBjtijJDlCze8lb01BQdSo2UwGh/Qa0Ri9s
         Lc6LhQUsQGl+VuNadBwrp04gqUSHnBe8rCx5IWiZhpx0GV4f4AlfkmYYeFC3PXgxkPfN
         xYww==
X-Gm-Message-State: ABy/qLZejFifmG4l11urIIu0U9OVv23HrNuZln2+3sHPdCAqFMMdsTVC
        p99+ZYtZYfP+3R7GmNqPMDv96w==
X-Google-Smtp-Source: APBJJlEC3hFx8gs1VX29byCH65cvp+gxprSd7zK8+7DV5lzZGnByPLi/GGw56Wh11/4pCJ9VD+nB4g==
X-Received: by 2002:a17:903:181:b0:1b8:a389:4410 with SMTP id z1-20020a170903018100b001b8a3894410mr4900514plg.0.1690472984731;
        Thu, 27 Jul 2023 08:49:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001bb892a7a67sm1830680plf.1.2023.07.27.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:49:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_file: seq_show_option_n() is used for precise sizes
Date:   Thu, 27 Jul 2023 08:49:40 -0700
Message-Id: <169047297893.2399768.3235005834445433615.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726215957.never.619-kees@kernel.org>
References: <20230726215957.never.619-kees@kernel.org>
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


On Wed, 26 Jul 2023 14:59:57 -0700, Kees Cook wrote:
> When seq_show_option_n() is used, it is for non-string memory that
> happens to be printable bytes. As such, we must use memcpy() to copy the
> bytes and then explicitly NUL-terminate the result.
> 
> 

Applied, thanks!

[1/1] seq_file: seq_show_option_n() is used for precise sizes
      https://git.kernel.org/kees/c/630fdd592912

Best regards,
-- 
Kees Cook

