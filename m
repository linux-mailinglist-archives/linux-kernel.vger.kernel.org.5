Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19480128C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379174AbjLASWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjLASWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:22:30 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84950F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:22:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso2106801b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454956; x=1702059756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mglnl7bfM6Y0YVkLlQ4iNPVutgU9A9KDI02bPJDXRE=;
        b=fl8/1gziK0fEyA+8IuBwnqNWzCEJqbEr81UIF8tzxxkmRxy26V/p47qn9zHKQv04P/
         6C3k1MdmxZYJmIQ15z9Cd7uNPWtDaH6y1RLxw8iVSko5K6MnZ6hjlW9bRhN/cw9Tkl9v
         2ovvpgxUlOBE3LzpN555PXVzNU3uIptEeulIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454956; x=1702059756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mglnl7bfM6Y0YVkLlQ4iNPVutgU9A9KDI02bPJDXRE=;
        b=JFLKf/Crx0UNX4nf9vsYxmXz2m/AA4OB+ZjZg0sS+yQW+bLcEddAWr7wYsl2gwsH4c
         YP/HHGYIO7XELd8NJTij+sBQyQNrKLczQOP3PDLBjg+LTso6pcLmaExnl32h9h/EFqlP
         iiX1lkFt0GIbim7Z/DF3cnnP69IZc74U3B36sMy+MEgtv3ei+KRjgN0tfbvMGrIccmku
         bO94gdJZgKSVd3EKNPcecuomxkpcOvWUSsZ7fLOpsjc0z+n4TWOHO1NaHMh4jXIOHXaK
         YyBEkuI08sR0d0gBCS3Y3B/HITrprWBCrytkAPZMmji/LvIR75pZ9OOjTZ1WRM0FlnTm
         Eylg==
X-Gm-Message-State: AOJu0YyZ+kT37LqKSS6xOkVsZL3U1+0B8SL6g905EHIVzkV74Y/bRUVc
        MjWnimszqA7QRUxPxNX+G+nYIw==
X-Google-Smtp-Source: AGHT+IGWAHYOF/izXvc1zLVxRIH/rhrsb5iI71mf7AC+4lN/W9r1fOGKIihcP48w13Ut6cfw0D8Qfw==
X-Received: by 2002:aa7:88cb:0:b0:6ce:a8b:15c6 with SMTP id k11-20020aa788cb000000b006ce0a8b15c6mr1809797pff.16.1701454956020;
        Fri, 01 Dec 2023 10:22:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b006be047268d5sm3413788pfe.174.2023.12.01.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:22:35 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:22:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <202312011021.FDB24FD0@keescook>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
 <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
 <20231130224334.1c1f08c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224334.1c1f08c9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:43:34PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 14:00:33 -0800 Kees Cook wrote:
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] net: mdio: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/3247bb945786
> 
> newer version of this was posted...

Hm, I didn't see anything land for this for the other with the same
subject. I've dropped both from my tree now.

Justin, can you chase down the mdio patches?

-- 
Kees Cook
