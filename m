Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139675DBBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGVKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGVKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9AA270B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690021768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZLRLDZZbasI3kPxd2PCiFXEwaPIuFeJBoo7oz3+UCU=;
        b=L+Z8Nckt+AdjdqgwjCi546sn5umpiv7BRWlxmwgiVjcYec0FWUTRG3RE+UByNk1LSvs/uR
        E8Bv/8mXYX0mmSF9vjj+tBrbriPkuqbJ251HpRzNiT374BNVxZMe57PDaERN0YfBzchc7Q
        7tWVWq2/sWzNpw3z566pI3CFPRMezhE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-wtLpiUYNPqCjgM1Q4mqXiw-1; Sat, 22 Jul 2023 06:29:27 -0400
X-MC-Unique: wtLpiUYNPqCjgM1Q4mqXiw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31443e13f9dso1445454f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690021766; x=1690626566;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLRLDZZbasI3kPxd2PCiFXEwaPIuFeJBoo7oz3+UCU=;
        b=jEgoR4i6hF15/aT6CqtiyUcNYPT0FFJoD9atwon7ti+WVIZIl8cVBTxK4DKtNviMxN
         iH3I3ZqjYDNkmUy9zQ8ZFOdIwi3DNIiwKroYTpjzvxJDlsiFI/KTtY+oHdGNajY8FUyJ
         m8NAaJR5hJll9gNjefAKj8ZsmJ7gN8swMuNDE5DGjlR5nlZa9mp0wODdVa7qJ+pJ6Ylv
         YgkzSJHQ5/L6dabkiATnt6ArQBIBeAykJLPYUfo9WStW3nM6QbcNF57a8TCBka38OsR6
         5i0gwOrLa1mopxvoCGjs9tj4EGzonQMODeQSWj24Uz/JgTxmYsG9ZMH+UhC1ROIQolLN
         EXeg==
X-Gm-Message-State: ABy/qLaUYG/v90S/MzyAHErgJs2/EPIJJs1yKJVJkVWaSJ6fGGcHux4E
        CBgTRe2ijZ7WmgT6Pd/CawFQ0jvwcLiX/CZ1/sdJlGFqcmTyST/2Ug0uNm1OCJ++zIOeEKqlc28
        3eYJRyiO3wg9JWlbJ6xpeFl/AE/xnqsnJLnlXuWhTiUdykd6bQzLAnNDwBbPb044JA+kKpISUMO
        S0Pab89ZUM
X-Received: by 2002:a5d:594c:0:b0:317:49a2:1f89 with SMTP id e12-20020a5d594c000000b0031749a21f89mr442347wri.1.1690021766020;
        Sat, 22 Jul 2023 03:29:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0CW3cuTzgVY3orLwkAx2H5NfB4jIEo8bf4kpoNIbZm8TlKtXSwhP5qmSJP+CHTVpIhD+K5A==
X-Received: by 2002:a5d:594c:0:b0:317:49a2:1f89 with SMTP id e12-20020a5d594c000000b0031749a21f89mr442306wri.1.1690021765546;
        Sat, 22 Jul 2023 03:29:25 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d690a000000b00316fc844be7sm6553821wru.36.2023.07.22.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 03:29:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 0/4] Allow disabling all native fbdev drivers and
 only keeping DRM emulation
In-Reply-To: <20230719081544.741051-1-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
Date:   Sat, 22 Jul 2023 12:29:24 +0200
Message-ID: <87h6pwtf23.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> This patch series splits the fbdev core support in two different Kconfig
> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> be disabled, while still having the the core fbdev support needed for the
> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> disabling all fbdev drivers instead of having to be disabled individually.
>

Pushed to drm-misc (drm-misc-next). Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

