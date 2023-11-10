Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA67E7E85
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjKJRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345075AbjKJRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DE328BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699618265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fCuXz89goAk8Vt7qNUZu+b7kKfusXy0WvYDR11XmRk=;
        b=BtDnA1vfr4LpOiKWP73xgnG7lO91XjkBAmLrqZ6j1LzTc8tJxFLXw2jH8cvbBTAB6v2LLa
        3ocIG6gE59g4ng4AA+QZN+NDaI/LowhE2yRgD6OqBvSQeymmtwckfAOOh9tIyW8dA8+nOD
        KNesiZCjGKI7XB9lQY+QdhZgIuvFG/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-srq21eb7Oo2ItyjAE1l22Q-1; Fri, 10 Nov 2023 07:11:03 -0500
X-MC-Unique: srq21eb7Oo2ItyjAE1l22Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a48806258so1038835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618262; x=1700223062;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fCuXz89goAk8Vt7qNUZu+b7kKfusXy0WvYDR11XmRk=;
        b=k37xGeo07CulIFwKZpqzktutoghFFVVbEVODaPOUvhnPyB0YJVEadxY66j2ISbQA0A
         dtov5vTICT8M2XyrnWCTWfW2LWbNvHUionbcm2tbYkDq/Rqe2KjYhAznuCumeECUQKM0
         DTz5OxJlhfHfNB3FovJkoXL+44c8eJokQqzd0Wiitw+OH/KeRV1CfUiFXTK5SxtoAgHW
         fj5ZG5peq+4vjbwvQ+KbeBQV6C6fU7NvD0dXeJu/WZQCnFVduASIs6VUZCZFVco8yLxt
         pdGKRLTssGGFa+zjWXYAVM/yqzc3M1xePHoPEGhHrFmA+UYJlJWWqMmKq2VNPXZXJ0HY
         RUxw==
X-Gm-Message-State: AOJu0YyDuVVvxkUiyxYyWjI6aLYVN1mP2TIRA2ZlaCXugXnq9H3cb6q+
        GakVooCSNERREOCO3M4/YETPp/9TAFGaIybRa+NT9IlNBUpL11LY5GmUNhjj9zFqzT9XwPV1HAT
        kU+X1nXYQ/enCqUpzse5CofhM
X-Received: by 2002:a05:600c:190d:b0:408:4d0e:68b2 with SMTP id j13-20020a05600c190d00b004084d0e68b2mr6677895wmq.36.1699618262548;
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnQ+ojOf2ajiSmBmN3mG/STAgZbDHejKyB0rLbX5CDgW3NWQYnPG6aNRfVTdkRaPHIh/mwvQ==
X-Received: by 2002:a05:600c:190d:b0:408:4d0e:68b2 with SMTP id j13-20020a05600c190d00b004084d0e68b2mr6677880wmq.36.1699618262272;
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
Received: from localhost ([90.167.86.3])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c300a00b0040773c69fc0sm4867955wmh.11.2023.11.10.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
In-Reply-To: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
References: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
Date:   Fri, 10 Nov 2023 13:11:00 +0100
Message-ID: <87v8a9ajvv.fsf@minerva.mail-host-address-is-not-set>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
> dependencies into a positive list of supported architectures, which
> includes the IA64 architecture, but in the meantime, this architecture is
> removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
> architecture").
>
> Drop the reference to IA64 architecture in the dependency list of the
> VGA_CONSOLE config definition.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

