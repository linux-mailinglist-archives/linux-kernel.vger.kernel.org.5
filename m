Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870767A0C58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbjINSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjINSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168B11FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694715333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dy26rnYnSre5SG2YZYk/2IdgLmOT/zD6uaKbupR7dh4=;
        b=faRrvyW1I171qVWm5a5Uui6P1/S5Km19Z26Ooa/IfqBS+FRt9S6JIAIHEPjbBLDtIX01Iy
        cjE9hyJNIQEbfTbh7MxhUbQS+v1S0VAn8Eq4oFysJ15f4bEAYtuz81ZQSSVdgg84og3S3d
        5ySdjLTlRP46DONHeivs28xOt2q0Ris=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-dd1IvVOzPRiB5MXZiz8MkQ-1; Thu, 14 Sep 2023 14:15:31 -0400
X-MC-Unique: dd1IvVOzPRiB5MXZiz8MkQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401e1c55ddcso9936065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715330; x=1695320130;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy26rnYnSre5SG2YZYk/2IdgLmOT/zD6uaKbupR7dh4=;
        b=rNRhLHoje88BJcE6bVu/inDP5xfoQvz6d+8wv4tMFRvtKUaW8f7Spi57SF4BaxnlbB
         hRiX0zG79xje9hJE8d9mhu6fG1x3z9br6EvBYQibI0dMVGfpcUI3AIhgbJbtiL0xk2ER
         NhHflabQS1wTwAWGcHHDzN+gFMeU0wSh7eiUBq8lX1mvaXEuQZVq6Cu1NvrrUQdku7oz
         20BR7wPRzX1rMyxz8gd9O7l/3h+v6PjGkvBPngMCAr8rxP/Jqdo2/Jkc9DDAg/QkxqAX
         FsSNyq98PUEtJO9wWgOMTyBIHARUfsUIhQolKZQomjNXV3lPCwtbKnABtQxWQJZb66hh
         D76w==
X-Gm-Message-State: AOJu0YyqimxuON6qje2Ejb+tFEHtK6eetGGYewAoinnw18i9Pv2i6CVp
        qHPYszWWjajxQ8hzYMsVJR1DIWmqeyL8XPrbqWafLZGDAUjEchn6M43DSrGPJaigCie6XkKOvwi
        VkXJj2mHUR1X2DNDADHQ6NZN3
X-Received: by 2002:a7b:c849:0:b0:3fe:e8b4:436f with SMTP id c9-20020a7bc849000000b003fee8b4436fmr5681453wml.14.1694715330410;
        Thu, 14 Sep 2023 11:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF4/VHO9ItawVeRoyh64koWKwWeYA/G98YGxWIEMSTyHFtsg2Bl1IJBbt4F2rkWPnywStgDA==
X-Received: by 2002:a7b:c849:0:b0:3fe:e8b4:436f with SMTP id c9-20020a7bc849000000b003fee8b4436fmr5681435wml.14.1694715330029;
        Thu, 14 Sep 2023 11:15:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c22c400b00403b63e87f2sm2611719wmg.32.2023.09.14.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 11:15:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Store the HW buffer in the
 driver-private CRTC state
In-Reply-To: <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
References: <20230913052938.1114651-1-javierm@redhat.com>
 <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
Date:   Thu, 14 Sep 2023 20:15:29 +0200
Message-ID: <87zg1o4o5a.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

[...]

>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

