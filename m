Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40217E9C84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjKMM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC3171A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699880240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEEW3XcoHB1VZUo6+U7UmEZpZHFHm8rW7krXF/G2wlo=;
        b=MYKWsRyNpfyzORUqB3RRo3ufFJ5ETTTdfkDWDMfbGh5zDiah9mQk9pgy9bR79e2+1vUx8E
        oL4BzbdzZMU7JBj9Tapc/ArTn5ijAaTmqELD4Y8qqUmhajMS8fvfwp7ULY3fjn91BJxyKH
        +OrYLlfZ9u5PPJrWs7BhOPiXRA5ZGT4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-1W9hCOwiNDa96zI88_vJlw-1; Mon, 13 Nov 2023 07:57:19 -0500
X-MC-Unique: 1W9hCOwiNDa96zI88_vJlw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32fbe5c7b9dso2969300f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699880238; x=1700485038;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEEW3XcoHB1VZUo6+U7UmEZpZHFHm8rW7krXF/G2wlo=;
        b=Un3vvbylsJZRKAOJVoKpUF8BS3Fu1IMCH2kl8ksZmn8tckcBYdzJ+hyUZpkDSJn1yb
         7nJZ81ACufu9K2+Wyce9Xx4pOvhPE3bvYC6nV1TBSs+ewvknmyPeHLwOonp1GdSkOb1o
         /PxeIVmppZIfKRac5TY3OeOkuKM+lnFWZ7kLzidvyQsA8TTjxv4M3ZIX9iMB8MLAusAM
         XJKSnkRSeIRm9dpS4wSqJPfbzsNCyGDr41rjkU64iGFn9PHw3FSc9CyTmkEn03s7c4cC
         xEhVsY0BYFTbFtGi8neJaTsiabE7U9kkgcfFcwaRrZTv+kDttaZYbeDY8hmo4N/38Zr/
         W9pw==
X-Gm-Message-State: AOJu0Yx9eWGW+Npk+pRamaM9WSYFketWlFDg5lFYpuZe+m66G1IFfh7L
        wwBNLrv8FbU11snXtOV8AlHWyCXYJUQUSFW6L2RojC4diLH8pA5vs3kTBMGrH73Y+5pa6FwCo5b
        8qx+uGTFsY+exLP3Wg6pCFrvgCR+dUo4/
X-Received: by 2002:a5d:6486:0:b0:32f:89ce:f66b with SMTP id o6-20020a5d6486000000b0032f89cef66bmr6690289wri.10.1699880237845;
        Mon, 13 Nov 2023 04:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvU+wcl912JE3I6ry5f8WGalZEQtNXVee4MgWE9m4W+nSgpYWlK++Na50Jp1k5l+5FVCg/Vw==
X-Received: by 2002:a5d:6486:0:b0:32f:89ce:f66b with SMTP id o6-20020a5d6486000000b0032f89cef66bmr6690272wri.10.1699880237501;
        Mon, 13 Nov 2023 04:57:17 -0800 (PST)
Received: from localhost ([90.167.95.115])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm5403122wrf.77.2023.11.13.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:57:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andrew Worsley <amworsley@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CA+Y=x3khfKx_oQYABMSCAPOEuDWyZ+MyTHK=JufH8fC-m6z7Xw@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <9f3d3c8d-fbf1-485b-9c2a-4d442733954d@suse.de>
 <CA+Y=x3khfKx_oQYABMSCAPOEuDWyZ+MyTHK=JufH8fC-m6z7Xw@mail.gmail.com>
Date:   Mon, 13 Nov 2023 13:57:16 +0100
Message-ID: <8734x9steb.fsf@minerva.mail-host-address-is-not-set>
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

Andrew Worsley <amworsley@gmail.com> writes:

Hello Andrew,

> On Mon, 13 Nov 2023 at 20:18, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Am 13.11.23 um 09:51 schrieb Javier Martinez Canillas:
>> > Some DT platforms use EFI to boot and in this case the EFI Boot Services
>> > may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
>> > queried by the Linux EFI stub to fill the global struct screen_info data.
>> >

[...]

>
> I applied the patch and just the simpledrm driver is probed (the efifb is not):
>
> grep -i -E 'drm|efifb' --color -C3 dmesg-6.5.0-asahi-00780-gf5aadc85a34d.txt
> [    2.621433] systemd-journald[276]: varlink-21: Changing state
> idle-server \xe2\x86\x92 pending-disconnect
> [    2.621437] systemd-journald[276]: varlink-21: Changing state
> pending-disconnect \xe2\x86\x92 processing-disconnect
> [    2.621439] systemd-journald[276]: varlink-21: Changing state
> processing-disconnect \xe2\x86\x92 disconnected
> [    2.878828] [drm] Initialized simpledrm 1.0.0 20200625 for
> bd58dc000.framebuffer on minor 0
> [    2.909764] Console: switching to colour frame buffer device 160x50

Great, thanks for testing. The patch works then as expected. Can I get
your Tested-by then ?

>
> I am wondering if the drm_aperture_remove_framebuffers() shouldn't be
> called in the probe function anyway
> as it ends up overriding the efifb one as wanted and handles the case
> the simpledrm (CONFIG_DRM_SIMPLEDRM)
> is not present.
> Perhaps there is an accepted principle that such kernels *should* fail
> to set up a FB?
>

We were talking with Thomas that the sysfb design seems to be reaching its
limits and need some rework but currently you either need some driver that
matches the "simple-framebuffer" device that is registered by OF or won't
get an early framebuffer in the system.

That could be either simpledrm or simplefb. But if a DT has a device node
for "simple-framebuffer", how can the OF core know if there is a driver to
match that device? And same for any other device defined in the DTB.

It's similar on platforms that use sysfb to register the device (e.g: x86)
since either "simple-framebuffer" is registered (if CONFIG_SYSFB_SIMPLEFB
is enabled) or "efi-framebuffer" (if CONFIG_SYSFB_SIMPLEFB is disabled).

That means CONFIG_SYSFB_SIMPLEFB=y and CONFIG_DRM_SIMPLEDRM disabled won't
work either, even if CONFIG_FB_EFI=y which is the case you are mentioning.

What I think that doesn't make sense is to remove conflicting framebuffers
from drivers that can only handle firmware provided framebuffers. As said
in the other thread, drm_aperture_remove_framebuffers() is only meant for
native DRM drivers.

> Andrew
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

