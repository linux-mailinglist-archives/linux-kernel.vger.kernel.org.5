Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273B7C4377
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjJJWH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJJWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:07:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A498;
        Tue, 10 Oct 2023 15:07:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so10255932a12.1;
        Tue, 10 Oct 2023 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975674; x=1697580474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXx3w5BSoIVSQ7iH1K6Lgpzn2VlNVeUa2WnXu+R0kHc=;
        b=Sv04KydxsQ9DgsQZ00i3OqAsQuobelx5KbCyBoE4/tBUkDzHfx3ldFOBEjC/IZy4Z7
         su/A0VK6I08IKHAcAtylPHQRAbDflb+zWaA0wMuLDaNTPGDu11FNzyUV5QIFgB4Oj3G0
         Zoh81W3MPBWdlann5ifz2TzJJtJNUNrgHMe2PB1wXatqazRT5ZjmD03zoX8gipyzPsjk
         KFY+/kLW5O8G4F840DUo8xYuoMzgJdCu0YM62K5yVmqdgm2YupH4yelLFMDtZKO0TR6U
         h9kOEKcR0f0GCe3Q67QXzbVKvTD33RMNPkRAt3+Ie4SCEt/wkcOkbdUXRChjYshKra9K
         wkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975674; x=1697580474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXx3w5BSoIVSQ7iH1K6Lgpzn2VlNVeUa2WnXu+R0kHc=;
        b=lIlvOq0pgJsovHwLMO8oxklbNgKaHJVdZD+7TQmu9v6YaCEAZbapU0pkLoGOdF12be
         DOEAFEQNeUV9OE5lw4FwTPpKTB7ISRLS2CfHyNzmJPyIbCBOcOObURCCjqv14UmAM56m
         v2X/Avhkj0GOfeBVjjtFWGm+A+t5+kqTPONC3cQbnJmeviXTQMw7Tx+Gwt30oPR/QQZu
         w5DDTIYE9xkjjVd1RFGz/ibzIPu5Ln0MdYL537DeenrEGEjpQghQFJJC63uO5i6gXcaw
         6lAjOsJ4RYoUQpOVRmkRVMKPYOhHp4kJ2REPoQ4i3lMhRkIRBLuIMwI+wW7mmNTPZScW
         VO2w==
X-Gm-Message-State: AOJu0Ywdey6rfbmAKINlXZ1Vd5slS9uYXe0dDVzfwYZ4hLh7+6QaaSCH
        pAUHOLYwEX2wNZ00EFIpuCv5gh01RnuO/A==
X-Google-Smtp-Source: AGHT+IFRaQDN8750tFvJKXssbKd1xoi5zH7pPFBB0pQAZ34iYlG5yrabkS3BKTNhhxILikMHvIGYEw==
X-Received: by 2002:a05:6402:c94:b0:53b:307b:3969 with SMTP id cm20-20020a0564020c9400b0053b307b3969mr11489399edb.7.1696975674316;
        Tue, 10 Oct 2023 15:07:54 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a26-20020a50e71a000000b00537963f692esm8186772edn.0.2023.10.10.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:07:54 -0700 (PDT)
Date:   Wed, 11 Oct 2023 01:07:51 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Message-ID: <20231010220751.z2ql7ef6pmflhdyt@skbuf>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:43:59PM +0000, Justin Stitt wrote:
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
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
