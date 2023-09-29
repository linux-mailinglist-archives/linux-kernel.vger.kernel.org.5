Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AA7B3A35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjI2SqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjI2SqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:46:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6E1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:46:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so130076315ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013177; x=1696617977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa0jeuOHt4Ygw+vX2a1/F/6PlmjBYIo0hM9//kmfJYU=;
        b=H4bNxhoX5k64IHNur9UQuAolyRs/rPBIr1qCZqFo+FXihIHN35W1DQQw8ns0QX9lvS
         yTSHSpW8vpWpjCe14WQtadyZlXKQp3+cjKLuG3Smvb6u6+NcPV6Fe0eGwiNhb65VKwTM
         XTt4sExupCa1969zkbPyJh8OPjhKwaKKP8G2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013177; x=1696617977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa0jeuOHt4Ygw+vX2a1/F/6PlmjBYIo0hM9//kmfJYU=;
        b=l5Zw4Z7Sp0k6C8L/z5w6jTHQ8qekBTktajXCAQH0IWN95vjXEjfT6c2aWfP1ejvvrp
         LzRCLpwK1J6VN4YohZqZ1EtGosjg2pR8wEOOYsgp2GHBsgdi2beO9zwJbAXXyniByfjF
         JfQpv2yzSTh//A2KDtVMFiBjtG8pmjDKddi2YcLydYKlTivmojyFFGCMuInrchZIdchu
         4kyTFfm+o8Xn6uVWs4bYVP7iq4beKh+pS2lIkKAdxdUKxEpdXcTLH2G93i4usQzCSnzH
         m+1lTuIPBJqytBP12q0XsCWF3acDlJrL0h2KxmRWxMfMmGn4XlgIPYOktPxVoVl3+m9x
         tsow==
X-Gm-Message-State: AOJu0YzHj7K1FgxwwA+gYw+LZevzC7m4uT42BD9MdNmkPBjM8li/az96
        +HHPrrOQtzdCLCH+SUWTRYDVdkDzXd0K0zypKNA=
X-Google-Smtp-Source: AGHT+IFaIItATlDRNYtcD9NZzG6YXArn5AX8jrSe1vJMwigpZOnGOphSVTghcOXwMrz7Aid2q4S5sw==
X-Received: by 2002:a17:902:c115:b0:1bf:4a1f:2b57 with SMTP id 21-20020a170902c11500b001bf4a1f2b57mr4844128pli.13.1696013176804;
        Fri, 29 Sep 2023 11:46:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001bc6e6069a6sm17300448plk.122.2023.09.29.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:46:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: bpmp: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:46:14 -0700
Message-Id: <169601317381.3009991.4885445233179317899.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
References: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 19:38:44 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> It seems like the filename stored at `namevirt` is expected to be
> NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] firmware: tegra: bpmp: refactor deprecated strncpy
      https://git.kernel.org/kees/c/5a4b8c16f53f

Take care,

-- 
Kees Cook

