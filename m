Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95A7FB9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjK1MF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344268AbjK1MFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7236B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701173158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L29QgGwjvdfNyT695GVt3JRiDUaabKqIQtEMfmzN4Y8=;
        b=jI1+J0b0Kd0ItWZbbpZMnYxhaVcK5zayA/Eg30B0KCoY+1MIXLPwFYKzAtSsAUsdD+9JlK
        7xEs7NKu76X1HCr/oobxHpsUgmP7mvjf+HxLJ0s1A4XGnZkL3Mpp1UWjSLV5GJLzwWm4iR
        6WoDbzXp2Kku7cLfPCl73EtK/awanhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-E7QSwKniN1a9iwIGKWgr1A-1; Tue, 28 Nov 2023 07:05:57 -0500
X-MC-Unique: E7QSwKniN1a9iwIGKWgr1A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332e2f70092so3969539f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173156; x=1701777956;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L29QgGwjvdfNyT695GVt3JRiDUaabKqIQtEMfmzN4Y8=;
        b=s5iIQXofYEqHE9tfLNbt4PtTnrtdUvX4U0pHSjylopla4k0fV4MC8RnLb20/CGdcfE
         AreKWgzUbl/yuDacnSFg7n0iVNF5woH5Ciqi/WgNh1ixyx6viM8c2SUDr2IWpXAKRFef
         +FFP4k902PW/ZxNLRG02v+iY03uLJmdDuLqoVcCtb3ATdSI3eDA7goU5Ewy8qtqGVoms
         +7LK4Q3lEgLpbwGU/K6hyXMNP1dMmrGTQOIT0fSu0IP++Nb7dxthN1p9Lcq4ooBvzYwa
         Px3AFiu8Dv2gFu+8q4lvL3YGQ9LS5MYPIO0fZONnZxX3Spbf2wwsfBO4up8ZSuQR5j/d
         f7jg==
X-Gm-Message-State: AOJu0Ywe3HQiD/uzc/kdN67l+IiydXhPb9vlw5h2mqWbSLVWXMXR5ktE
        act+l+zwx2xAbZ9bKV55vC8FRAkZTDbcMbIPdvgYw/4QmLyoVqQwhZO4DxZiSwcQI1RspR/2VVu
        bO04nQMDUZWjcCak6QCikdeSa
X-Received: by 2002:a05:6000:11c7:b0:332:d413:b453 with SMTP id i7-20020a05600011c700b00332d413b453mr9824926wrx.18.1701173156216;
        Tue, 28 Nov 2023 04:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4E30b3yLIua79mw2Ny9rPA/606yDaFC+NJBY/hqMCE8tASwICAyywTAdKk1ENohBbnUxhBw==
X-Received: by 2002:a05:6000:11c7:b0:332:d413:b453 with SMTP id i7-20020a05600011c700b00332d413b453mr9824915wrx.18.1701173155897;
        Tue, 28 Nov 2023 04:05:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d6c65000000b00332f6202b82sm9267781wrz.9.2023.11.28.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:05:55 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dipam Turkar <dipamt1729@gmail.com>,
        maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, mairacanal@riseup.net, arthurgrillo@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dipam Turkar <dipamt1729@gmail.com>
Subject: Re: [PATCH v2] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
In-Reply-To: <20231110192452.734925-1-dipamt1729@gmail.com>
References: <20231110192452.734925-1-dipamt1729@gmail.com>
Date:   Tue, 28 Nov 2023 13:05:55 +0100
Message-ID: <8734wqccbg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dipam Turkar <dipamt1729@gmail.com> writes:

Hello Dipam,

> Introduce unit tests for the drm_mode_create_dvi_i_properties() function to ensure
> the proper creation of DVI-I specific connector properties.
>
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>

The test looks good to me but I would like Maxime to review before is merged.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

