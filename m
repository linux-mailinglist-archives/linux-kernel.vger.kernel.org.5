Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4A7F46CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjKVMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbjKVMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78224D61
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700657399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
        b=LgKniuUK1qMEE26G4bb+UQyvZWVjzjQ+6Ao9XZrVnihGm44Tryt2u1WSXRSRTtBDGWf9Wm
        cFAV6kWmJPbehkpjIdm5joNSQaTNz2jTc4HklDFbvzKCA0eD2Iq2IjgdbghgGkO436hIxU
        zMBptiz0w6oa1Or9pwq6TwU11JR1+M0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-tLWeajtyOG28YUQdFtElSA-1; Wed, 22 Nov 2023 07:49:58 -0500
X-MC-Unique: tLWeajtyOG28YUQdFtElSA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c876d239e6so38371021fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657397; x=1701262197;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
        b=snec9iNRxzNcek7Akywi2iUsXfnkDn1SidiAsGPgjJkooixLDtYoHjKTdiPdrJPnOG
         SiVjUvgAF8PGwA8Tt1cXFHJSQlqQi4LiK4OCo/c01r2uQ4aW4lxXkyVxtRSYTEgioKZB
         YP7gd103El3LtFZuK5rOfX2lAQVVsRe87ezUaGx0szfYJrLpb2so8VuL2/ErP2GTOop7
         SnwNoEjgs3di+5ZQbAphQIB+uAb2ZffoYzlnS6mMLanf7jtM5S95WsTVsqCPUe6p3FrU
         3WN/1WT0ijZTNNVpmJdaRURg/6+zOudyTJmX4Ei5WGZlvYvxaE/u+XH6A2NPHQm4tM6P
         A6mA==
X-Gm-Message-State: AOJu0YzDIr4giZPtTWeUTMV997hF6UbSUjrl4PpZX6AgiJHZe9fVAl75
        yCge0uEBn8lMTUkOkQptHY9U2dgiABEDIHIOwHPK52+w80WqAzOpZYt4jHqiuZuUPdE+CiPZxt1
        SaUfg7tWlC7+765CUMueLBcrI
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id s2-20020a2e98c2000000b002c5213224f6mr1644883ljj.12.1700657397036;
        Wed, 22 Nov 2023 04:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjsqJ2SuGehTUxt/XdTWeav04muk69t7/+AFuoFYCMhKZg56Vp4jkvGQpcnN18Ay8LgHfnHQ==
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id s2-20020a2e98c2000000b002c5213224f6mr1644863ljj.12.1700657396682;
        Wed, 22 Nov 2023 04:49:56 -0800 (PST)
Received: from localhost ([90.167.94.248])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b0040775501256sm2103506wmb.16.2023.11.22.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:49:56 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Albert Esteve <aesteve@redhat.com>, Simon Ser <contact@emersion.fr>
Cc:     qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
        spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Date:   Wed, 22 Nov 2023 13:49:55 +0100
Message-ID: <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Esteve <aesteve@redhat.com> writes:

Hello,

[...]

>
>> > Mutter patch:
>> > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>>
>> Seems like this link is same as IGT? Copy-pasta fail maybe?
>>
>>
> Ah yes, my bad, this is the correct link:
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

The mutter chages are already in good shape and the MR has even be
approved by a mutter developer. Any objections to merge the series ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

