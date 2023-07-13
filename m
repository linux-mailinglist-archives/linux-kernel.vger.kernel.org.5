Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4A75220D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjGMM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjGMM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0B30E0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689253096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uwx74rSXy8pjgm1EOfmT7jHESyUMqyYMrBtd4jx2+G8=;
        b=BGt2h90KVF6SqV7deC1PmXzEH2+1fO0H7J3auZRiExs9jsBl/C0PHi6Yu1sdapDctbIf9o
        nPMdndiSBpTgWLm0SHW3iRWrDZ+LbfjQuwFxT4VKYFG9TZXOTgodksO7c5PwU7vW8ySJnk
        Un6BlFNwUzSFRC9lXyHLIs7Fd8gspik=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-xBR-NW5iO-CKBQ-SxlJpmw-1; Thu, 13 Jul 2023 08:58:15 -0400
X-MC-Unique: xBR-NW5iO-CKBQ-SxlJpmw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b620465d0eso7015531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253093; x=1691845093;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwx74rSXy8pjgm1EOfmT7jHESyUMqyYMrBtd4jx2+G8=;
        b=Qs5ZXrbOLYhHs1DQlKnWjuKwwaMX8r28RGf5BBaTHff2Y6/AkFMhY+bYgjYuK+m2y8
         NNc5ObQcnK2hbI6Ftn/htHXEAa+1u3u1qP4cQFYBkXjTVucurGbY0wRcLc1497BBS1fm
         RZ524H7EE87+yIH6P2m9qsCD6LAHuvLY0SQlBjLBnWhNpoQGDi4ISIwEGTjdfbkezxLX
         SxPJCyaqdFcEtvSheCeQacaFtKP9NYTqhtg6iC/wUIKlZeuD7TxUHMb9rxDdFqizbV5o
         OdfPG8hvH2cus0bnZBRmcfeTzC73nehLW7gLWdxenJ9jlrJHGX2ZPy/4dKKWOfY857ee
         BBmQ==
X-Gm-Message-State: ABy/qLaQUyyu73aaK5W83qCvjYkFwdrlkCsg2HMLtvfYLiKuVl+2xNNV
        G+LEYcjZoydt+6+ZQoIdABZQasjTrbeNLkICF341I2ytOE51twWnBsUmrRprqWmBzYope32QIa2
        Nm1MGrqV6C1x8UJroK/TIkksa
X-Received: by 2002:a2e:3001:0:b0:2b6:d5af:1160 with SMTP id w1-20020a2e3001000000b002b6d5af1160mr1290236ljw.28.1689253093755;
        Thu, 13 Jul 2023 05:58:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFm2C7yhUB+sv8dQupl78E/GUF/Y55s1W9OAb8nY75TX1if5EG7D6nVCoOMAXn/+soKCixd+w==
X-Received: by 2002:a2e:3001:0:b0:2b6:d5af:1160 with SMTP id w1-20020a2e3001000000b002b6d5af1160mr1290229ljw.28.1689253093455;
        Thu, 13 Jul 2023 05:58:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fbe561f6a3sm18348182wmh.37.2023.07.13.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:58:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drm/ssd130x: Change pixel format used to compute the
 buffer size
In-Reply-To: <340afb94-9c08-46ef-0514-9da52162b45c@suse.de>
References: <20230713085859.907127-1-javierm@redhat.com>
 <340afb94-9c08-46ef-0514-9da52162b45c@suse.de>
Date:   Thu, 13 Jul 2023 14:58:12 +0200
Message-ID: <87ilaoge8r.fsf@minerva.mail-host-address-is-not-set>
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Am 13.07.23 um 10:58 schrieb Javier Martinez Canillas:
>> The commit e254b584dbc0 ("drm/ssd130x: Remove hardcoded bits-per-pixel in
>> ssd130x_buf_alloc()") used a pixel format info instead of a hardcoded bpp
>> to calculate the size of the buffer allocated to store the native pixels.
>> 
>> But that wrongly used the DRM_FORMAT_C1 fourcc pixel format, which is for
>> color-indexed frame buffer formats. While the ssd103x controllers don't
>> support different single-channel colors nor a Color Lookup Table (CLUT).
>
> Makes sense to me.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks Geert and Thomas for your review. I've fixed some typos that had in
my commit message and pushed this to drm-misc-next.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

