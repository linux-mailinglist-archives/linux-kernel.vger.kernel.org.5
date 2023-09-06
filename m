Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E77938FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjIFJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjIFJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488341717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693994044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tzibQVke0hKt8IOTav8MFtlZQ2trxpBqLxq9f+UJCg=;
        b=DZqbRuUv+SPvtnAMaMjts4/10xZzY942HPltd0Bx0Zn6Ld42v0IwC751dUVMO7KRz9NgHI
        qG9F8J3SCtY9i8MC0+IBGx/lpUtxH9hhwIQcQuCHBqRhbb59N48evAJQqAExSUG5d6Lq35
        nDn0057OHeHBsiA0oJzd92YUnpwgSM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-189Phx_BO9KiHLZ7nqFDMw-1; Wed, 06 Sep 2023 05:54:03 -0400
X-MC-Unique: 189Phx_BO9KiHLZ7nqFDMw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso1796658f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994042; x=1694598842;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tzibQVke0hKt8IOTav8MFtlZQ2trxpBqLxq9f+UJCg=;
        b=ikpBTRAUvKqSGIcFn3oHTgWWKtSgPAePcPTqy0/fBV/BeWFqoJHidYYHFdAd63OiBL
         D3mgRkVsVb2OazpR2xnBeTIyRlJ9wrTnKRVOUI+QEzv+AAQFW+heDdlEtqa4tdszYUMf
         4Hfa/fr5Klr7c/TTb7DZ8HiVK0CpnWP9PM3f+CTbGJY0AgYpfifwrexg5+j3Qb1hd5kq
         N85m6AkmOb6J2yXgiliaHsBesJeh2VnR5kw7DYp3Z4k09BiurbCi/4KB/dgR7G5OAnhp
         6t7dH9jseqaIhvScHcm0Zt6oG7n49dAvxyWfpFWixsHGmvX3U6FV5dzx3NDbUF+t/SpY
         diyw==
X-Gm-Message-State: AOJu0YxMl5/re1cPfCEmZMsWHCxhSbPLfEz3bSuwledBUoVdxKZDd4DD
        DxyTad8c9pj/SnnTOZncVVXk9beUu4PUyUZHC9OAnwsd81u49cOR0tFYj0pbsHWynn9/bV7lEkr
        3LoPpNzbeenCFkcyzd4DaiH8c
X-Received: by 2002:adf:f512:0:b0:31a:d871:7ae7 with SMTP id q18-20020adff512000000b0031ad8717ae7mr1954035wro.29.1693994042095;
        Wed, 06 Sep 2023 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgP7ciy8RiRDljW7l6SGuO/N0itwoSv2n3TNrlmpxaanZjeoaWxrwp9lqX4hZlX6Ivt08wqQ==
X-Received: by 2002:adf:f512:0:b0:31a:d871:7ae7 with SMTP id q18-20020adff512000000b0031ad8717ae7mr1954025wro.29.1693994041793;
        Wed, 06 Sep 2023 02:54:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0031433443265sm14238423wrb.53.2023.09.06.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:54:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/7] fbdev/mmp/mmpfb: Do not display boot-up logo
In-Reply-To: <20230829142109.4521-3-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-3-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:54:00 +0200
Message-ID: <87ledj4og7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The fbcon module takes care of displaying the logo, if any. Remove
> the code form mmpfb. If we want to display the logo without fbcon,

s/form/from

> we should implement this in the fbdev core code.
>

The commit message says the same than patch #1 but the driver will behave
differently right? That is, won't only show the logo when fbcon is not
enabled but unconditionally? So the logo will be duplicated when fbcon is
enabled?

If I understood that correctly, probably you should mention that in the
commit message since removing the fb_show_logo() will make the driver to
behave correctly.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

