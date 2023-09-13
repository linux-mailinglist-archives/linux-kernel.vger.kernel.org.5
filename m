Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075479EB03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjIMO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjIMO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4700C98
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694615123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1FsUnDJXEh3xrup97UKPyi5G29wmRkoOl4jHD/nSRg=;
        b=MztE80sdUs8ioseXONKh5bUqbmfQRtTZYaVwbi0rZ6y3oFCgijxjbXgSSuBWiAtR7VwR0p
        p/K31gMOb9LjIrsD8+aG7WP1xOYDb7rorl/GxM1pzkgQtlS8wYSSEBTbUqFgoefxRF6FL+
        WwK8O1HtyiyKTgIaHBtB5hUqu7vjmJQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-a4_i2uhCPpiHg62EctD4og-1; Wed, 13 Sep 2023 10:25:22 -0400
X-MC-Unique: a4_i2uhCPpiHg62EctD4og-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4011fa32e99so51996965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615115; x=1695219915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1FsUnDJXEh3xrup97UKPyi5G29wmRkoOl4jHD/nSRg=;
        b=w2/WkY6T2IsMfgTwla5xTGHTPF4Z32pocJ8Yt+COw1OAiqa1FqHxRDu+lSnB/V1s04
         Ash9XayCQOuJxlDMtSSEbbhW6N6sz91ikUJwkWKRQ/9gY5zLval/lMVOpmD8+O730bPP
         Cy53wrd1b7S9EDszDGqDgLXM0/uQJXQeCLIRDVutvHM6IVXdHrCffOpwjI5dudJg2t8L
         dhTV91/JvYbt7UMMaF3UkO2E5T+xvG01QO7XOUZLa5XWbpRUx1wp/wxubxaEY7UgbtF4
         033cOTWgQ+ZewRDsFfwtVgzw/v7OoOAIkO13jCA5MAUuZnbZQx8eVFXbYIWYfsvbJ3qt
         OVGQ==
X-Gm-Message-State: AOJu0YxWLwkQgI963dfQUtR12D3ciI6Lcmaw7+eqdAlu1vCSJmwTJ3B6
        fdwP40z7E3m57Chp+Nngw63kpvn1SvAq9H32Zplb4OBk5Xzpr1c4Bf/hTe25PW4qPNrdpB4Vpn3
        bGT1wc9VbsV/GPBLOUuRXqWAO
X-Received: by 2002:a05:600c:3b10:b0:402:eab6:e704 with SMTP id m16-20020a05600c3b1000b00402eab6e704mr2127406wms.29.1694615115676;
        Wed, 13 Sep 2023 07:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN0t8yz3+zH7LDMFjVxmF3tnVkdjJhcoCATJjm6CztmjCnnjLfigAOYlLj+//qxaHPIO3cjg==
X-Received: by 2002:a05:600c:3b10:b0:402:eab6:e704 with SMTP id m16-20020a05600c3b1000b00402eab6e704mr2127388wms.29.1694615115372;
        Wed, 13 Sep 2023 07:25:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fe4ca8decdsm2186260wme.31.2023.09.13.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:25:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
In-Reply-To: <20230913113801.1901152-1-arnd@kernel.org>
References: <20230913113801.1901152-1-arnd@kernel.org>
Date:   Wed, 13 Sep 2023 16:25:14 +0200
Message-ID: <878r9a1779.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
>
> This problem frequently comes up in randconfig testing, with
> drivers failing to link because of a dependency on an optional
> feature.
>
> The Kconfig language for this is very confusing, so try to
> document it in "Kconfig hints" section.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for writing this since as you mention that Kconfig idiom is not
intuitive. The docs looks great to me!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

