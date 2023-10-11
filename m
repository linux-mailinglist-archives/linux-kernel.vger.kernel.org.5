Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80587C6115
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjJKXaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJKXaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:30:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671DBA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:30:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c735473d1aso3150355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697067006; x=1697671806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JtGjh26Eni4OZxnKSlnsIiPe2l0EQ4vE2Am58DZ21c=;
        b=CauAA/ejXBWZG2MIAjZtObMjsRoq+C7c849zbwIGEbbH0eFA/4/8TmRmkG8K6dqH94
         ZZlsqHFxXaCmKihb2vtlgWN5wAAJICwazDHJItEhPitV1o6KAsKx/ZPSY1KI6YYxMCJz
         XFP7iUKFnPUp3ZSSUDtN5lIfRKy+O/kLrLYJVPS7ZhNgl7qSoo/c/lFw1Ia4YHSeeVbx
         bUcTpO2XDyA4fou3HYLrYL0zG1oKMAWyNYgbG82AAQ2uWcKpbm+Ypw10DycQug9872cj
         fSYn3dX+SqD//Ta0vXezeiPZkmowhTb+7DuPlE+zIkdjUr7CLNxjUsPmy5Z8GRvztakH
         tU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067006; x=1697671806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JtGjh26Eni4OZxnKSlnsIiPe2l0EQ4vE2Am58DZ21c=;
        b=C/3BGQkgd/KxzgAD7ayp9qH+JbxZLUVZk/zZnz9StzETvNuFE0+NeHV2PnPuQe4Wck
         5T2zizzvFDRKf6lWO+7MdoVxX5PoksaKgE8CUaluC8viJ2ppTs+GaGPFQb3svgHQ9atu
         dr7NPWDm7laPJ6QCLep2njr6xK3uTCQPGtzmMqAnDwizdMGSY7Lqt7wGcO2OBI8/qSGX
         lFtkJm45QbCIrj7LDt0uCkGn5F9Cnorry0pPe6cl54aoA3/8eXFcGkPKFmXPmnexZ6rk
         bv4bL3o7D4q8M6b2kkGZWJHdvwmoZapUkOW7jQg0IRiDnQn8neaukXWlhdN0FCF7lqjJ
         L0fw==
X-Gm-Message-State: AOJu0Yw5Ozy9x6vhg+5GD/Q4YliZj7a47YIvZnb0xdW+wkV6Pkfv3da2
        NaAe6GXrSKw2WxTOS/9aXX8x+Q==
X-Google-Smtp-Source: AGHT+IEV8H5TPcuvOmSF7vUA4QdCpSp7vHMQFvfV9/tCGGpqvYhz4EcKkmpBt6ew0dUnQElfDl19sw==
X-Received: by 2002:a17:902:c1c4:b0:1c9:c3a7:f96d with SMTP id c4-20020a170902c1c400b001c9c3a7f96dmr5257434plc.62.1697067005872;
        Wed, 11 Oct 2023 16:30:05 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001c9cb2fb8d8sm427832plb.49.2023.10.11.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:30:05 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:30:03 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231011163003.32036b28@hermes.local>
In-Reply-To: <20231011222026.4181654-3-florian.fainelli@broadcom.com>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-3-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 15:20:26 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

>  enum {
>  	IFLA_DSA_UNSPEC,
> -	IFLA_DSA_MASTER,
> +	IFLA_DSA_CONDUIT,
> +	/* Deprecated, use IFLA_DSA_CONDUIT insted */
> +	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
>  	__IFLA_DSA_MAX,
>  };

minor nit s/insted/instead/

I don't know if it would be acceptable in the kernel UAPI but what
we did in DPDK for similar situation to cause warning on use of deprecated value.



/**
 *  Macro to mark macros and defines scheduled for removal
 */
#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
#define RTE_PRAGMA(x)  _Pragma(#x)
#define RTE_PRAGMA_WARNING(w) RTE_PRAGMA(GCC warning #w)
#define RTE_DEPRECATED(x)  RTE_PRAGMA_WARNING(#x is deprecated)
#else
#define RTE_DEPRECATED(x)
#endif

...
#define RTE_DEV_WHITELISTED \
	RTE_DEPRECATED(RTE_DEV_WHITELISTED) RTE_DEV_ALLOWED
#define RTE_DEV_BLACKLISTED \
	RTE_DEPRECATED(RTE_DEV_BLACKLISTED) RTE_DEV_BLOCKED
