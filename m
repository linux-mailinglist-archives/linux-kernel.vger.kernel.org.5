Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EEE783DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHVK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHVK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832A1B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692699978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrXOdRSU5C9qBy5SkHRFVcr2LcH7Loe7+3Mc49K5WKA=;
        b=UFP/AIt61lr0oAw/yoVyoMtGIo0WYJP2jdhYDIkpMn1IEeriGPQWUB7fheG7S0ZHl3EMB4
        nXUIO3RKT+inyngklQMfZGlb7ObQcTaCGxcSzEqPQ2zu/UiJVjXeJDid5qp8G3F4X6EoF8
        notYD3CwiU+nWlgFLe93+8HLPQ94Qfw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-6AQ5q9xkMJC3pvv3BsDWxg-1; Tue, 22 Aug 2023 06:26:17 -0400
X-MC-Unique: 6AQ5q9xkMJC3pvv3BsDWxg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe661c0323so28610025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699976; x=1693304776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrXOdRSU5C9qBy5SkHRFVcr2LcH7Loe7+3Mc49K5WKA=;
        b=gUQpL4oCJqLF050Yej8BSjpVap0jb6y+CvnQ3mYYbo2bNiwrRgXWptuBL2lkwFlPH5
         9JTnahV+61g/mo7nSHzX/l4Qw6kJQerjIBPGaBPAcMfE8hU1LuqjuYgRXk3fNtacsCWS
         YycI9d3q74qof5p53rMMV49QBirvGk/7cbLq0z2MuUjF4fgtgJXK4CXjEDpu4vEGdU2f
         J0zcXBK3wJNlpTBfr9KfuO9FZBsTCSug6SrFRYicpOGRLCLwLJD5yTRxB2xjhaopYjVV
         FPZsHw5PLqnn9Rsjfk7uksj/vtUDEuFQLmXa3t0GTRgqARpN4PJbO5R9ZA1OCT8WVbZO
         NfqA==
X-Gm-Message-State: AOJu0YzoK25+sBI81Du+wr8qmc5cZELwKnnah6vXsKUa8Xrath2Zqhu3
        bSM+T2W6Xx41PaOqf5peE2H3Y5NwX47K1UgRwcsvCXaTc+BK2ek/jSzq1FIT6xAkbpr0AvpmvSY
        BY0cY05vjMLnb71FPHRveFBCQ
X-Received: by 2002:a1c:7508:0:b0:3fe:dc99:56ea with SMTP id o8-20020a1c7508000000b003fedc9956eamr6746659wmc.19.1692699976317;
        Tue, 22 Aug 2023 03:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF05DZBRpnuiPX8UW4R+VHjobHFk2uaAIDMsXbKz/q/OuYSx6LA05xEWWVMjowEHsCG1aX/iQ==
X-Received: by 2002:a1c:7508:0:b0:3fe:dc99:56ea with SMTP id o8-20020a1c7508000000b003fedc9956eamr6746644wmc.19.1692699975977;
        Tue, 22 Aug 2023 03:26:15 -0700 (PDT)
Received: from toolbox ([2001:9e8:89b6:500:ebf6:f095:1c69:67b4])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c040c00b003fe2397c17fsm19005449wmb.17.2023.08.22.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:26:15 -0700 (PDT)
Date:   Tue, 22 Aug 2023 12:26:14 +0200
From:   Sebastian Wick <sebastian.wick@redhat.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pierre-eric.pelloux-prayer@amd.com,
        Randy Dunlap <rdunlap@infradead.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH v7] drm/doc: Document DRM device reset expectations
Message-ID: <20230822102614.GB110557@toolbox>
References: <20230818200642.276735-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818200642.276735-1-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:06:42PM -0300, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> 
> ---
> 
> v7 changes:
>  - s/application/graphical API contex/ in the robustness part (Michel)
>  - Grammar fixes (Randy)
> 
> v6: https://lore.kernel.org/lkml/20230815185710.159779-1-andrealmeid@igalia.com/
> 
> v6 changes:
>  - Due to substantial changes in the content, dropped Pekka's Acked-by
>  - Grammar fixes (Randy)
>  - Add paragraph about disabling device resets
>  - Add note about integrating reset tracking in drm/sched
>  - Add note that KMD should return failure for contexts affected by
>    resets and UMD should check for this
>  - Add note about lack of consensus around what to do about non-robust
>    apps
> 
> v5: https://lore.kernel.org/dri-devel/20230627132323.115440-1-andrealmeid@igalia.com/
> ---
>  Documentation/gpu/drm-uapi.rst | 77 ++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..3694bdb977f5 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,83 @@ for GPU1 and GPU2 from different vendors, and a third handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
>  
> +Device reset
> +============
> +
> +The GPU stack is really complex and is prone to errors, from hardware bugs,
> +faulty applications and everything in between the many layers. Some errors
> +require resetting the device in order to make the device usable again. This
> +section describes the expectations for DRM and usermode drivers when a
> +device resets and how to propagate the reset status.
> +
> +Device resets can not be disabled without tainting the kernel, which can lead to
> +hanging the entire kernel through shrinkers/mmu_notifiers. Userspace role in
> +device resets is to propagate the message to the application and apply any
> +special policy for blocking guilty applications, if any. Corollary is that
> +debugging a hung GPU context require hardware support to be able to preempt such
> +a GPU context while it's stopped.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to perform
> +it as needed. Usually a hang is detected when a job gets stuck executing. KMD
> +should keep track of resets, because userspace can query any time about the
> +reset status for a specific context. This is needed to propagate to the rest of
> +the stack that a reset has happened. Currently, this is implemented by each
> +driver separately, with no common DRM interface. Ideally this should be properly
> +integrated at DRM scheduler to provide a common ground for all drivers. After a
> +reset, KMD should reject new command submissions for affected contexts.
> +
> +User Mode Driver
> +----------------
> +
> +After command submission, UMD should check if the submission was accepted or
> +rejected. After a reset, KMD should reject submissions, and UMD can issue an
> +ioctl to the KMD to check the reset status, and this can be checked more often
> +if the UMD requires it. After detecting a reset, UMD will then proceed to report
> +it to the application using the appropriate API error code, as explained in the
> +section below about robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep a graphical API context working after a reset is if
> +it complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. However,
> +there is no guarantee that the app will use such features correctly, and a
> +userspace that doesn't support robust interfaces (like a non-robust
> +OpenGL context or API without any robustness support like libva) leave the
> +robustness handling entirely to the userspace driver. There is no strong
> +community consensus on what the userspace driver should do in that case,
> +since all reasonable approaches have some clear downsides.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
> +interface tells if a reset has happened, and if so, all the context state is
> +considered lost and the app proceeds by creating new ones. There's no consensus
> +on what to do to if robustness is not in use.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
> +This error code means, among other things, that a device reset has happened and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting causes of resets
> +--------------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, it's
> +really useful for driver developers to learn more about what caused the reset in
> +the first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.
> +
>  .. _drm_driver_ioctl:
>  
>  IOCTL Support on Device Nodes

Acked-by: Sebastian Wick <sebastian.wick@redhat.com>

> -- 
> 2.41.0
> 

