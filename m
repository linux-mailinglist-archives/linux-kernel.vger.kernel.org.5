Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF07BEAE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378475AbjJITwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376628AbjJITwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:52:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E474A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:52:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8c05784so3710774b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881142; x=1697485942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=JWElXZGnI5Dho7NxO3SuCZkcyzvidcN5myX62MJIO7GAE7k8B6ISh9zNAImkmqz5nC
         1xTANb9oWsDi347SpprOLccVgJnpARsfMpKAbEuyADH40gX/KAifC3aX73ihxChP2gSn
         jh8qOYfcguBeYOrZ4cABpIKcqGhyCeSWqhDMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881142; x=1697485942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=Fz6/c45Wtu3c4ChKwT7xYgDEoIkMmcdQ40jlG2usWfa/bTyRjZSm17kHhLsBbUFv9v
         eCvVOJFG67oAyUVJGSjzVK1b204UEQ9dwu7nnSiY3NBz3vz3IttNKdFOHOKYbGD2vYVM
         gYTO6hV8lt0yhro1ix75BOaqeYbthA+M/NoKh2vllBukiYN/to+5BGMzXjKurhlCLAQl
         jq3ITrKp9lXbdPDMth1fxaE85NpfMkwAXn8+bY/qOyG6XYZAHSIY+XZDbWX9BglcZXPl
         NezqgEXg8j0A8Y1jmPE7mosuq6cSlIWbnEums2T4MK9cxbJ6GmR/yPQrmrEkZsvb4AcV
         tftA==
X-Gm-Message-State: AOJu0YzSrU9urlt8iVaAKsLqg2GOr5cw4SZOE1Mk8fZNcO/2HG7pWvaX
        Uu8pm3xglf5H0kVJJmFzH6M08g==
X-Google-Smtp-Source: AGHT+IGxomcr53n06/4wdgutrpZT4ccy1wmPL5cHdWAhB0pnoeCW+Oz5hR6WVVrKGNtF+Q44ODG3dA==
X-Received: by 2002:a17:90b:24a:b0:27c:e015:1160 with SMTP id fz10-20020a17090b024a00b0027ce0151160mr446092pjb.0.1696881142614;
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cu18-20020a17090afa9200b0027463889e72sm8693809pjb.55.2023.10.09.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:52:20 -0700
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
Subject: Re: [PATCH] net: dsa: qca8k: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091251.98B21057EF@keescook>
References: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:34:45PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! Yes, a happy ethtool_sprintf(&data, ...) replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
