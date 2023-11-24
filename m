Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462EB7F76BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjKXOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKXOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57671FD4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700836965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/pi8w6/WijyPjt6aPj0xPcMBW60wKYF9Ml5rCWYt0U=;
        b=ZZCj1z3gz8ySTu9xGpIPch3DdhLd05oouM+EWkMAJ99pIVaJ/uPqJBT87SyONltoymJUmn
        b3fEvINh1t1ZcXscLwo6VjZmKEkdyvHuMy86kxvWUax+hCyNzJ8TcYF35o6mgSFu9a/lnn
        Cw7bLX4I85Zvm09mBj1S843eM5ci1Vc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-EfLUNPkFPXiADLmWbQJCcQ-1; Fri, 24 Nov 2023 09:42:43 -0500
X-MC-Unique: EfLUNPkFPXiADLmWbQJCcQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332e71b8841so551871f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836961; x=1701441761;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/pi8w6/WijyPjt6aPj0xPcMBW60wKYF9Ml5rCWYt0U=;
        b=eKjuFMXTsLjvdHbkIdpjJ8/rTRskX2RELmXWs4hajWhzv1aZkHd7mKUXcHcHwxwKtS
         hONRMwB7F+QYlygO1Ll1Blxu4Qg4PnHFyfZqC/1vQ1cP+W/8ylnLbEMlgniCFqi6qcmY
         mxPwtkQC9OcrrD834wAJe4/1IgCLhLUb2BD39muvxD5oE0BmXf/uqK49bgTr3xoV0a+4
         D6gtgtniR4u3jnhD/eGuFQrIZdzFHHh2YTi/CGi8YZ5bWhdHetrIrt7lbF4bvupFQtW+
         XzS7QtUaRosKzpchFo0o087Z3fkz9YqNeGqovIyqmZFoqNO9tHKzRAOFNqltABVbyiHX
         TQfw==
X-Gm-Message-State: AOJu0Yy3yN640++1ZhY7UxT6mgVZWV+njsBTDsZ8VS6udn6o8EKXgAJj
        c9We8lbAnkv3g2WEslT9V1Od/UQ3KpSclvKUNrw95aQcdGhlJ2TzEhn+aUO86L3rn4hn8rJVwAS
        MxZLFT8SuwMaPSTxFW75XzoFO1UN34/FQ0t0AhHU4gM3pdVzjwfhZp3bvEM2JgipmBcNC7lvbme
        Tuz+HPbs3+
X-Received: by 2002:a5d:66d1:0:b0:331:3c1f:b94b with SMTP id k17-20020a5d66d1000000b003313c1fb94bmr2312270wrw.6.1700836961584;
        Fri, 24 Nov 2023 06:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb9V9v8SZQGN7fIWFWH3GRjooaAzuc2Aw0JD0xHBxjeAnsUuYv6FgvkSaM+Z/yReNVL78ccQ==
X-Received: by 2002:a5d:66d1:0:b0:331:3c1f:b94b with SMTP id k17-20020a5d66d1000000b003313c1fb94bmr2312234wrw.6.1700836961142;
        Fri, 24 Nov 2023 06:42:41 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q1-20020a5d6581000000b00331a55d3875sm4455226wru.38.2023.11.24.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 06:42:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Zack Rusin <zackr@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: Re: [PATCH v4 0/5] drm: Allow the damage helpers to handle buffer
 damage
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
Date:   Fri, 24 Nov 2023 15:42:40 +0100
Message-ID: <87edgfcivz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Hello,
>
> This series is to fix an issue that surfaced after damage clipping was
> enabled for the virtio-gpu by commit 01f05940a9a7 ("drm/virtio: Enable
> fb damage clips property for the primary plane").
>
> After that change, flickering artifacts was reported to be present with
> both weston and wlroots wayland compositors when running in a virtual
> machine. The cause was identified by Sima Vetter, who pointed out that
> virtio-gpu does per-buffer uploads and for this reason it needs to do
> a buffer damage handling, instead of frame damage handling.
>
> Their suggestion was to extend the damage helpers to cover that case
> and given that there's isn't a buffer damage accumulation algorithm
> (e.g: buffer age), just do a full plane update if the framebuffer that
> is attached to a plane changed since the last plane update (page-flip).
>
> It is a v4 that addresses issues pointed out by Sima Vetter in v3:
>
> https://lists.freedesktop.org/archives/dri-devel/2023-November/431409.html
>
> Patch #1 adds a ignore_damage_clips field to struct drm_plane_state to be
> set by drivers that want the damage helpers to ignore the damage clips.
>
> Patch #2 fixes the virtio-gpu damage handling logic by asking the damage
> helper to ignore the damage clips if the framebuffer attached to a plane
> has changed since the last page-flip.
>
> Patch #3 does the same but for the vmwgfx driver that also needs to handle
> buffer damage and should have the same issue (although I haven't tested it
> due not having a VMWare setup).
>
> Patch #4 adds to the KMS damage tracking kernel-doc some paragraphs about
> damage tracking types and references to links that explain frame damage vs
> buffer damage.
>
> Finally patch #5 adds an item to the DRM todo, about the need to implement
> some buffer damage accumulation algorithm instead of just doing full plane
> updates in this case.
>
> Because commit 01f05940a9a7 landed in v6.4, the first 2 patches are marked
> as Fixes and Cc stable.
>
> I've tested this on a VM with weston, was able to reproduce the issue
> reported and the patches did fix the problem.
>
> Best regards,
> Javier
>
> Changes in v4:
> - Refer in ignore_damage_clips kernel-doc to "Damage Tracking Properties"
>   KMS documentation section (Sima Vetter).
> - Add another paragraph to "Damage Tracking Properties" section to mention
>   the fields that drivers with per-buffer upload target should check to set
>   drm_plane_state.ignore_damage_clips (Sima Vetter).
> - Reference the &drm_plane_state.ignore_damage_clips and the damage helpers
>   in the buffer damage TODO entry (Sima Vetter).
>
> Changes in v3:
> - Fix typo in the kernel-doc (Simon Ser).
> - Add a paragraph explaining what the problem in the kernel is and
>   make it clear that the refeference documents are related to how
>   user-space handles this case (Thomas Zimmermann).
>
> Changes in v2:
> - Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
>   .atomic_check, instead of having different helpers (Thomas Zimmermann).
> - Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
> - Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
>
> Javier Martinez Canillas (5):
>   drm: Allow drivers to indicate the damage helpers to ignore damage
>     clips
>   drm/virtio: Disable damage clipping if FB changed since last page-flip
>   drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
>   drm/plane: Extend damage tracking kernel-doc
>   drm/todo: Add entry about implementing buffer age for damage tracking
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

