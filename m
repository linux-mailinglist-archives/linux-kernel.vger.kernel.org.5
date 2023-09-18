Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC27A422E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbjIRHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbjIRHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76218D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695021551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jJuO9DejLukgU1wcStY8CFd7ozDVd8lIMTfDSXmwzw=;
        b=TSwlknCvsHEoVgSNDKHaxmn7Nli4uRtlv7+rLBz6a307Ax5ano/GDqEsJnU1AGHOk8SbOK
        mB6x3LGQpisbGgENbxNa2I3KM6yQT7lHPQ+BbrAuNkwjWNwck6HeBKfDsYSc190LMvXZKt
        Se4IayR56JByyhP6EBcVW/YsvLzCiNs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Yrm33EQMM9GmK0-3aqP6ew-1; Mon, 18 Sep 2023 03:19:10 -0400
X-MC-Unique: Yrm33EQMM9GmK0-3aqP6ew-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fe49c6bb1so2435257f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021549; x=1695626349;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jJuO9DejLukgU1wcStY8CFd7ozDVd8lIMTfDSXmwzw=;
        b=X8RuYWDtCCriWOIr1oAm1+/k0dx/NRRDOcPi3kyUxqzHMwZBr6q7W86isZVsMRAfkG
         rh9WJ/xqujwatNToP55SQTrh9V/1xTSU3i34rgty1lFHgMKFUhYH/qKJVi0u6SCQxuA6
         ZeAJmb89sWJz6jZ/xKSWaOQQXherM1K7bxODuVRH8i4qd55EohAG9nwbEQb2KdAf04g8
         jbJd7rCRrrsXuFdfxc9jFwkTDxR52xfQdNtQlGon+CedFACr74mPR4eFafHtvrsBfAEc
         wll6rfhyJer8GNXFHiPUEa03aY/EHc+3CulrddmKeq/RKd4lkAmm23vJf8M/Jlsg8mpD
         PPBA==
X-Gm-Message-State: AOJu0YyUikNpDMn1K0Ga0jeRcrWKkzKCuPUakiUokI4vz0H6OuOv4LuW
        ubn96DTpXnTteeFQpHmvsmWnUtVg+wyPK8at7ilAF6RfSVLqy2fxTIvLw0DA9u89X6PacB6nIa5
        lsVAJu7bsRXdD/J0ewB2C+QNX
X-Received: by 2002:a5d:64e3:0:b0:321:5969:d465 with SMTP id g3-20020a5d64e3000000b003215969d465mr887840wri.65.1695021548986;
        Mon, 18 Sep 2023 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3MtgGPRsBh/wAWRyBIYIEDogHk4lMwlYiuzy3YndduPnhkLzO3H9Of13YjunrxAa2N2KUlg==
X-Received: by 2002:a5d:64e3:0:b0:321:5969:d465 with SMTP id g3-20020a5d64e3000000b003215969d465mr887828wri.65.1695021548689;
        Mon, 18 Sep 2023 00:19:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b0030647449730sm11723549wrs.74.2023.09.18.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:19:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
In-Reply-To: <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
Date:   Mon, 18 Sep 2023 09:19:07 +0200
Message-ID: <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
>> The driver uses a naming convention where functions for struct drm_*_funcs
>> callbacks are named ssd130x_$object_$operation, while the callbacks for
>> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
>> 
>> The idea is that this helper_ prefix in the function names denote that are
>> for struct drm_*_helper_funcs callbacks. This convention was copied from
>> other drivers, when ssd130x was written but Maxime pointed out that is the
>> exception rather than the norm.
>
> I guess you found this in my code. I want to point out that I use the 
> _helper infix to signal that these are callback for 
> drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. The 
> naming is intentional.
>

Yes, that's what tried to say in the commit message and indeed I got the
convention from drivers in drivers/gpu/drm/tiny. In fact I believe these
function names are since first iteration of the driver, when was meant to
be a tiny driver.

According to Maxime it's the exception rather than the rule and suggested
to change it, I don't really have a strong opinion on either naming TBH.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

