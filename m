Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F27B3A54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjI2TAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2TAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:00:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916601B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5c91bec75so110567255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014014; x=1696618814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=HmUFAh0zkPL1XTlG3DZ98Lpg/V1SZuEoX3aE4Kq4pkbqrC/H5wIzMA5Ey8VsHEKpWi
         yVIgAWX00Y05jmBg31jtYE0BWtl1wsLbgOvemDcQMYAbhvOv2CroSlN2gc/aC1DsIZvx
         S5UPmWcHXmwWMUaXbAqPSB6V5YPgKaXCe/rr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014014; x=1696618814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=kJ2UC8illnDrYkcsAbcrYgXhmOoc5SnWayYtAuP58lp4xTwu5LQyPXi8bRYvqE4MU0
         So4opLxOIPoD5JtLKu1cN8AL1NzgMuVS6nSTWsLRroFOe3pk9EhCBDBymqDP1P5Mwhb5
         OR1R0IY1r3Vwj+hsdm1xRxhOdrqQ0Lw++/cVqy3rUweo1twlchSQrwYN4PvcJtWvWoVc
         SSDBcvriSS/NGpc392Dlmh0W4o6mPinh7OvVR0JUtcwIC0SdMTcQK8e3at1yS27GxPEU
         sfcTL7FxFobbMHrdwwP9ns9y0nPKj5fsh1QBEAC9yiPfs2uDZxbTvD9yL24Cc6GGU5/G
         dB9A==
X-Gm-Message-State: AOJu0Yw13X+lpR5GWXO/7xwOaeIwNT6d9BmFG091F/r5mtJS5y2ZrXMr
        14jCfb6rNkNlAwwmTu4r68qZLg==
X-Google-Smtp-Source: AGHT+IFalx0Un4U0EyJJTXitS7mv7fMxN2PPC27u8ial/BdekWtfArKvqJ9zOOkHTfSVfLFaLHHVqg==
X-Received: by 2002:a17:902:da86:b0:1c6:bb3:29e6 with SMTP id j6-20020a170902da8600b001c60bb329e6mr5492246plx.16.1696014014059;
        Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c73d829fb0sm3014497plb.32.2023.09.29.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:00:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 12:00:05 -0700
Message-Id: <169601400133.3011505.5557490241780172507.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
References: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
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

On Mon, 18 Sep 2023 07:47:29 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We've already calculated bounds, possible truncation with '\0' or '\n'
> and manually NUL-terminated. The situation is now just a literal byte
> copy from one buffer to another, let's treat it as such and use a less
> ambiguous interface in memcpy.
> 
> [...]

Applied to for-next/hardening, thanks! (Subject updated...)

Take care,

-- 
Kees Cook

