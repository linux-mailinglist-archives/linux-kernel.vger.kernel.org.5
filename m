Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB317D61BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJYGg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA1B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698215765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QCkYDGehxxNqzt09gBv9p4n2vFS1oLTgsSq6IkVxVA=;
        b=igv14hXTzhXBj+kQIbD95LOo+eSUr0XWPNaUf56q6ulS0wpH0GRiSn563rg3KvrPkRRQDh
        2TJMBmwVNS6CvEew3TbbSs1k1dZBz9PSCSvuLjNEX75X2HM8dU7TBWZTJkkhTvsI0ihSk3
        idv/pNc8qwHdNrr7kIrQs1lN4amNHtE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-dHTYqzaCN5WjEvYnOEmQMA-1; Wed, 25 Oct 2023 02:36:02 -0400
X-MC-Unique: dHTYqzaCN5WjEvYnOEmQMA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f5b22e806so111464f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698215761; x=1698820561;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QCkYDGehxxNqzt09gBv9p4n2vFS1oLTgsSq6IkVxVA=;
        b=gb4qjvsigGVk3q0n3SG/NiK7bqve32GcyP8Sxdbaaqe0qWdWN9B4ev2gQE3/9kApn7
         HUyP3Een7u7mdxXQiWq9Na8PlTlahWqg3Td9rKGsftqaURlnlGvbmZnJfzki2Uw4zJR2
         3XRJIoKRHI2FhoE3uAK4K9v9qu+YCfohxQqBo/a1wSKNZZLjSEqilzY9SrMbyiWeB8zz
         nWIRDZM+De62K5VSN2+MYOe5fxJhR/7CTg1t3amGoVfIaHhx+QUF5f80EHRiv+AoTB36
         DAIuo0NbU3yjyWkZbwfvafUOVPidhQRzarADhspyDKEy2pD0glcjemHIO48lW5VqFU5h
         Rn2g==
X-Gm-Message-State: AOJu0Yx8qMIJA3KnMWDIyVzln91gylPcV1NokZydR6wzJg42ILZyN1zz
        ILKvKqfOoyxUh3k7Vx/0FkKJPFmDBvLyFOqJgo/I2sr45QmN2HYzKTMLt/prS+Lv6BveGqMKPxd
        mDlipZwRWhl6OgVFg5G512Af2
X-Received: by 2002:adf:f64a:0:b0:32d:a49c:dfd0 with SMTP id x10-20020adff64a000000b0032da49cdfd0mr9244588wrp.64.1698215761758;
        Tue, 24 Oct 2023 23:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5pjp6+UGcNGf+pR7eCaZquF6TdQK9ic+pGsGfXKq7QOOQ0Jp5pQG5o2Uq/SY5UVuq/3Y74g==
X-Received: by 2002:adf:f64a:0:b0:32d:a49c:dfd0 with SMTP id x10-20020adff64a000000b0032da49cdfd0mr9244562wrp.64.1698215761437;
        Tue, 24 Oct 2023 23:36:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d534e000000b0032710f5584fsm11318664wrv.25.2023.10.24.23.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:36:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Michael Banack <banackm@vmware.com>,
        Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc:     linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>, mombasawalam@vmware.com,
        iforbes@vmware.com, Jonathan Corbet <corbet@lwn.net>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, ppaalanen@gmail.com,
        spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        linux-kernel@vger.kernel.org, krastevm@vmware.com
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot properties
In-Reply-To: <1bbee4ad-79fe-4968-0edc-3eee34ad5972@vmware.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-10-aesteve@redhat.com>
 <87h6mh10zg.fsf@minerva.mail-host-address-is-not-set>
 <1bbee4ad-79fe-4968-0edc-3eee34ad5972@vmware.com>
Date:   Wed, 25 Oct 2023 08:36:00 +0200
Message-ID: <87a5s79pkf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Banack <banackm@vmware.com> writes:

Hello Michael,

> Yes, that patch should be:
>
> Signed-off-by: Michael Banack <banackm@vmware.com>
>

Great, thanks for the confirmation.

> --Michael Banack
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

