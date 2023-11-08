Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649507E6063
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:20:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F5258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:20:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so170850b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699482033; x=1700086833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ1hcaLN1noh4tREmsI2g5hhvM418eJUYWFXPpc4QSk=;
        b=R4mblMM/lFBrfCoiJYigQ4XSIZRg21SU/64Jtcba5MCuJ0dq3KiFDgyCY6VoEayoOM
         t41KZO3aY1EmBoylPH+2ype4d1/LChbW5oE+fzg6G3sbgStaZEtUsgy5qeyrGNw83+WC
         BB82j3J1VO0l8wqmbRV+pzb0Cfdo4uI0gxrLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699482033; x=1700086833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ1hcaLN1noh4tREmsI2g5hhvM418eJUYWFXPpc4QSk=;
        b=KVG3n8sfG0LyYxEuIAF8YcqRcyJMVugmfmKbhPOMYQIwO1jZS9KW5HtRIgoKQWzqEs
         R+Py2L/mTrjEg2A6Y9Zx6HG+LJtPScJ9RcJ1olbBMa/rdSHDWqx46hYORO1ewMMsh0o3
         NrkmqoCI4b3p4jHedRfRqwurYzi2rInkzAqhFgkVzb0ZpkpiPSAZP9JvxTaOlbtkbcfG
         WU8KSG59ewSWjoqxN5/Px5ACdeSPSHAf4baCqSmY5gwBqH1N0W90IPab0UVNNu2BIzgE
         SUZ9/NqziXBt5B0cF6bQzz1m71Y9ft0xMzXB5Sb6idy0nPsqu+BPW9EUcTR7nRQ9B4Mi
         v5cg==
X-Gm-Message-State: AOJu0Yxnpygph5835NtGRIT7KMA++6Q/jG1xdkffmLBi+sznPTAZ9wXB
        U5w0tQZBlRR+apAWWBcAFokH5Q==
X-Google-Smtp-Source: AGHT+IG5gAsgBs+ScSP+4VbZi7IhKYcfr55p3oSUdrskmrLrClZK5XpSvBDFL78fhM0G+krrLBPWow==
X-Received: by 2002:a05:6a20:8e24:b0:16b:80d3:7f10 with SMTP id y36-20020a056a208e2400b0016b80d37f10mr3835996pzj.34.1699482032678;
        Wed, 08 Nov 2023 14:20:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a627908000000b006baa1cf561dsm9828173pfc.0.2023.11.08.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:20:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: randstruct: Only warn about true flexible arrays
Date:   Wed,  8 Nov 2023 14:20:18 -0800
Message-Id: <169948201624.633716.16405667177938568487.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104204334.work.160-kees@kernel.org>
References: <20231104204334.work.160-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Nov 2023 13:43:37 -0700, Kees Cook wrote:
> The randstruct GCC plugin tried to discover "fake" flexible arrays
> to issue warnings about them in randomized structs. In the future
> LSM overhead reduction series, it would be legal to have a randomized
> struct with a 1-element array, and this should _not_ be treated as a
> flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
> -fstrict-flex-arrays=3"). Disable the 0-sized and 1-element array
> discovery logic in the plugin, but keep the "true" flexible array check.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: randstruct: Only warn about true flexible arrays
      https://git.kernel.org/kees/c/1ee60356c2dc

Take care,

-- 
Kees Cook

