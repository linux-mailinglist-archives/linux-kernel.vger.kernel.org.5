Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBE7C45C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjJJX6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJJX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:58:19 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE2B99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:58:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c646b5028dso4119380a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982296; x=1697587096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOb3GWppFGUQUo6fDVKv/7BVVJ3kmc+fs0b3MYzsoHo=;
        b=MNV0Y+cvtkfIb8P5OLrIntPSq+CZzdI+ENcqpvT5vQRX5QnU7q7e0QZ30G6hjAZJVZ
         IkSsLh3zl77N+MiaBPRB3MPo9L28AR9Dm1Vs3MoWFIdPKwKdqVzVx/8Ar+BUxYin3cj4
         nVQx1vfzYowHReeA48KQXXqRm7yrNaRzGdi2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982296; x=1697587096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOb3GWppFGUQUo6fDVKv/7BVVJ3kmc+fs0b3MYzsoHo=;
        b=Tl4b0OWAz5+SZZPBcg6S+zg1xbJ2dxFceEocklEgqHt22Jiuvif9aR+9Tvwx3kVsHn
         +C4DSa4wwIdzEvTmAF1KncSTsgrLWUmC3V8kkZX38vLpg1bNBaS5N36tY8KrTZXwbaGa
         vLkUrXO/Lf38LRlpUYjj5Sc4ktj6nce1L5lqCRhh1azw3xok5GFlqk+v3a6MyuTxnE31
         E+M6KFrygnwox+zRpDi+P7KJNGXM6F1B+mHUmazrKCHo7wVMq4KGJrVQw0o7KMDWCgcZ
         C0kA3dPjeSIkX62R5J/+9Em82Xt6ae0YT6dOQ37+uMqHJnRgwGFhnuPN06CsIHm5FzEI
         oFHQ==
X-Gm-Message-State: AOJu0YyKKudsQEmaK3L6zx4K2NgKajP2LDm34TTk+toy91pAI3g0RIYQ
        0O7sLJmmqjrnZL9ypaXm6VSNyQ==
X-Google-Smtp-Source: AGHT+IFpqAZvTTfdymMa3R5nbAmknFwysoqVA/dwXwkjpL1QCgv8PmS1IKni1deEEaUquQKaMJYecw==
X-Received: by 2002:a05:6830:1da7:b0:6b9:4d79:e08a with SMTP id z7-20020a0568301da700b006b94d79e08amr19908023oti.32.1696982296583;
        Tue, 10 Oct 2023 16:58:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b00565e96d9874sm9441495pgf.89.2023.10.10.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:58:16 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:58:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310101658.84E1C724@keescook>
References: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:32:35PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> This change could result in misaligned strings when if(cnt) fails. To
> combat this, use ternary to place empty string in buffer and properly
> increment pointer to next string slot.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Nice; much more readable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
