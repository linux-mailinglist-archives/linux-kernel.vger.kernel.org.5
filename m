Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569E7EFB46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKQWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373BB8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700259530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xb+39jMBjIG9e9EUVeLvv86Ka0wZnTphGetSvGEJ6aE=;
        b=FvLlfoX/H39QIaZ7Q2zHOjy0Obd6MGlZJWZ8x0JwWEAlFqFXaGiAqc/Gef3iLA7ZTBXlWS
        XmgzTd34k4RBcq0jx897vBGMHKvaYmKDmfn/uXTRY0OSiXtK88GmugdjiMPwqnngVPGGpw
        9Tpu6WbJDqk1HgyiqQ4EMQVYB58BhRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-jiWzyY16M2Ga1T4v9PdpTw-1; Fri, 17 Nov 2023 17:18:48 -0500
X-MC-Unique: jiWzyY16M2Ga1T4v9PdpTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408524e2368so14416485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700259527; x=1700864327;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb+39jMBjIG9e9EUVeLvv86Ka0wZnTphGetSvGEJ6aE=;
        b=Mq2sA7MUVr5Pt0JzOaAijVvDCGX7+6L12gGVXrQF7wwUQ1q7alKVtG/1h97S4aeSAq
         Xx8XLGt4WdhZRGwDDdPz623MAwBlU+GZrpUGsO1aVK/JA+K6bIAdYFHcHnURFLcWsXxR
         VXYpm091FmvTkdGtDA+voKknvNiGAjQp0OwxETrBaShmZSUaATAjUFr+UE/0+UDk+fcx
         pwxSVdyrBMkB6RGqJ92ZkyiMUbC1yX1b4M0Plo5ZfFKHwwX9CzWruPirNaEn/Wnl6xW3
         NQ4/deaUrYXZdl/20FMTivuDbJYwDBPlfqKX1Hv9J4dYkxx9qyo2/eCcxP5V6GoPC4XL
         K2SQ==
X-Gm-Message-State: AOJu0YxDZPwX0C4mPMW8/lqCF/lNEQkdMLl3/d16w4nkCJXXwB25nZuN
        bwjEEw/Hos7YxfB7WmLAXd0A0lHG6mJIDebeBrqSzJQ0Rq3RX3gcSfJQdsw6CmKgsJShKmAvd41
        n90hMip/X36nQx3Gn866t935hw2UA1Gzi
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id u10-20020a05600c19ca00b003fe2b8c9f0bmr283581wmq.23.1700259527245;
        Fri, 17 Nov 2023 14:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1ki+IESh+gyMw/wvDuuRKAIdBZvjvrveHDpkuOxRGvzlqclzeFbtQ8juy0XxQQTk1lYkKRQ==
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id u10-20020a05600c19ca00b003fe2b8c9f0bmr283570wmq.23.1700259526834;
        Fri, 17 Nov 2023 14:18:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b004063cd8105csm8421532wmj.22.2023.11.17.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 14:18:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbdev: ssd1307fb: Change "solomon,page-offset"
 property default value
In-Reply-To: <ZVfX5Tw71cqKFJ83@smile.fi.intel.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231116180743.2763021-2-javierm@redhat.com>
 <ZVfX5Tw71cqKFJ83@smile.fi.intel.com>
Date:   Fri, 17 Nov 2023 23:18:45 +0100
Message-ID: <878r6w10sa.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Thu, Nov 16, 2023 at 07:07:38PM +0100, Javier Martinez Canillas wrote:
>> This is used to specify the page start address offset of the display RAM.
>> 
>> The value is used as offset when setting the page start address with the
>> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
>> 1 if the property is not present in the Device Tree.
>> 
>> But the datasheet mentions that the value on reset for the page start is a
>> 0, so it makes more sense to also have 0 as the default value for the page
>> offset if the property is not present.
>> 
>> In fact, using a default value of 1 leads to the display not working when
>> the fbdev is attached to the framebuffer console.
>> 
>> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
>
> Closes?

There's no report in a mailing list or bug tracker to reference.

> Fixes?
>

Since the default has been the same since the driver was merged,
it doesn't make that much sense for me to reference that commit.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

