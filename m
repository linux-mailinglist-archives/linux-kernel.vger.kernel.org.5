Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92CD78CEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjH2VQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbjH2VQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2FCED
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693343582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+GUVbCk86qh5EQhmd6PqgeyLWByDTt+LjF9LcbM2Qk=;
        b=R7n371AdYqTSTCSFCEZHjPid2ubhaX3LCNTYdV5zJ/XEH2Qac4R54Vb9HWcF2zvSdg8ilk
        TypEG/vPNYamHaNufQhLT220XS9K26uUggKKEUyRh37HT8c9SiKEdMTEfZLXwWctgMaC8w
        7mOaG0AvNKY2uZar0FbVZCZRpRvMEFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Aa-jEXfNPHqlxORDYO3izQ-1; Tue, 29 Aug 2023 17:12:59 -0400
X-MC-Unique: Aa-jEXfNPHqlxORDYO3izQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so72627f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693343578; x=1693948378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+GUVbCk86qh5EQhmd6PqgeyLWByDTt+LjF9LcbM2Qk=;
        b=BtkZakrDjC1p/Vqwug8CvjM3zLcqjpHGKtGN0C0meNoBGcOXTiIVa9O6EbGroHHQW0
         +RSJRXdBecApGjWLDzqAX27bRKQcoVb7yk0XnGnM4fCaUEmxFA3tRGp4b5gp+ctyjuNp
         cfPHokggAuAlKAykhhyublQVaA+uESF7LIaQiyDYRN5ar/oeSSL+fztlGLQCygkI2Xi0
         mhVhx5tUsLUtFMD0SH4yxJ/HApJM0W+UNALvwiJe3I8QpCSuRJ6U9sM6frao01xpaEYp
         3vN3iSKvlAwDtkvTMDH9/rC6K3pDhe3DBtVM+8ntDKeUI49QsaTYPJGq68R2cyDtuPgm
         Wt3g==
X-Gm-Message-State: AOJu0YxLFm3nhlCe4bfJI1djqw14TlPUu4UjEQ5blAymYG67kqBea4Tq
        B+A2nbK4PLydaREo6XaYhHNbvl01qU6DsycxjGIB1GMTXoitItmvPVYQdegJI2T6v/t79Emlt4z
        8ksZEmbBHRlpCCDDKVZ5VIunE
X-Received: by 2002:adf:e54f:0:b0:319:7ec8:53ba with SMTP id z15-20020adfe54f000000b003197ec853bamr246339wrm.14.1693343578540;
        Tue, 29 Aug 2023 14:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbYAzItfIpAHRZHGuf/sij5R/jrO6m8qBFwVYhGmG9FXiUVA+MnWStuS6opJ/GGpZlcmJh1w==
X-Received: by 2002:adf:e54f:0:b0:319:7ec8:53ba with SMTP id z15-20020adfe54f000000b003197ec853bamr246325wrm.14.1693343578190;
        Tue, 29 Aug 2023 14:12:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6-20020adfd086000000b003179b3fd837sm14792695wrh.33.2023.08.29.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:12:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <87ttsite67.fsf@minerva.mail-host-address-is-not-set>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <d5f342b5382653c1f1fb72dbedb783f9ea42416e.1692888745.git.geert@linux-m68k.org>
 <87ttsite67.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 29 Aug 2023 23:12:57 +0200
Message-ID: <877cpdd02u.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> The native display format is monochrome light-on-dark (R1).
>> Hence add support for R1, so monochrome applications not only look
>> better, but also avoid the overhead of back-and-forth conversions
>> between R1 and XR24.
>>
>> Do not allocate the intermediate conversion buffer when it is not
>> needed, and reorder the two buffer allocations to streamline operation.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> v2:
>>   - Rework on top op commit 8c3926367ac9df6c ("drm/ssd130x: Use
>>     shadow-buffer helpers when managing plane's state") in drm/drm-next.
>>     Hence I did not add Javier's tags given on v1.
>>   - Do not allocate intermediate buffer when not needed.
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Tested-by: Javier Martinez Canillas <javierm@redhat.com>

> -- 
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

