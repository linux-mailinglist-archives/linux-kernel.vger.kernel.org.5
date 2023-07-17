Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9375609F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGQKiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGQKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108710CC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689590246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAOND3XFoeBzpxt7utZ9rsfxO8OWDZ7yDQwg3PKCQOQ=;
        b=YU4t1Vsfyeg3Z1Uf3pGORKjgUj0B2PBjX8ZtcKc1rwnPgAYcVwJXtAVhR3N3oWVLgad32Y
        vmGp0qOqKTp7GBsF4ppskB6nHJMIhEhCBwYVZhz8SKU53wcOfG0NWmBUbvzkcox0exdzLb
        798dxF2geHYSFJhvwNvRLEIqy0VxPvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-E_RNDO-QO-uLvN9CjpPXyQ-1; Mon, 17 Jul 2023 06:37:25 -0400
X-MC-Unique: E_RNDO-QO-uLvN9CjpPXyQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so23850085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689590243; x=1692182243;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAOND3XFoeBzpxt7utZ9rsfxO8OWDZ7yDQwg3PKCQOQ=;
        b=LlMupElhZ92HGB9hDxr/x4tZ6XQrv5QAmoRd3OT3kgngTbcFw61b/e6DsXcNgaxf9w
         NY14eHWHPqSfAwHm7LT/yXdpTyJu/Nn6kPQ5qU20rCCFxtyPqknMA2dw6Xp1Olt1yYrB
         2xq6NEz0yGloGfzKi08seJnb9cjjr2GkuMzDREWJwjtOkCx080zbAeknFyYsIGzBxp5k
         cmK29AsEGlS7R17WMcJrKau6ipOZn28tCNHQekH3KQ+JoMEdIdV4fgIXed0/qg4WrrpR
         OhMGlAbgRrPIEXC8UltAhOW2lHEbG9dnSYoL7Z03nRO90KDbanxv98O3AzIS7U/CKcmp
         +CLA==
X-Gm-Message-State: ABy/qLbLFeEBebq2tJ/MHTdL3aGtLvJ0h8zDmmiSUeDwDX2pN1YK53Od
        phO1izBUpgo0w3sC2KNaAuJtkE4S1j/J4+SAdOEW4Vdq3XudYHM0jis6qkHfRp2Mt0aK4STVlNV
        BlSNs7eHgwS8JSbVzfxjZVYAmQr0IvHy/
X-Received: by 2002:a7b:cc15:0:b0:3fb:403d:90c0 with SMTP id f21-20020a7bcc15000000b003fb403d90c0mr8309892wmh.39.1689590243736;
        Mon, 17 Jul 2023 03:37:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHga9WLAajLMiSdYXQpweT8nhUfXULga7jmGSba8vydxpTpZ4ubhM5a0Bu7OWViKKf9CnmmNg==
X-Received: by 2002:a7b:cc15:0:b0:3fb:403d:90c0 with SMTP id f21-20020a7bcc15000000b003fb403d90c0mr8309881wmh.39.1689590243466;
        Mon, 17 Jul 2023 03:37:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003fbc30825fbsm7609914wml.39.2023.07.17.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:37:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
In-Reply-To: <87h6q2kh6s.fsf@minerva.mail-host-address-is-not-set>
References: <20230713163213.1028952-1-javierm@redhat.com>
 <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
 <CAMuHMdVuLBTBymfEXDgHsDVavH6Ggq53fPep0T=dEWbztBWkjw@mail.gmail.com>
 <87h6q2kh6s.fsf@minerva.mail-host-address-is-not-set>
Date:   Mon, 17 Jul 2023 12:37:22 +0200
Message-ID: <87bkgaken1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
> Hello Geert and Thomas,
>
>> Hi Thomas,
>>
>> On Mon, Jul 17, 2023 at 10:48=E2=80=AFAM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
>
> [...]
>
>>>
>>> After some discussion on IRC, I'd suggest to allocate the buffer
>>> somewhere within probe. So it will always be there when the plane code =
runs.
>>>
>>> A full fix would be to allocate the buffer memory as part of the plane
>>> state and/or the plane's atomic_check. That's a bit more complicated if
>>> you want to shared the buffer memory across plane updates.
>>
>> Note that actually two buffers are involved: data_array (monochrome,
>> needed for each update), and buffer (R8, only needed when converting
>> from XR24 to R1).
>>
>> For the former, I agree, as it's always needed.
>> For the latter, I'm afraid it would set a bad example: while allocating
>> a possibly-unused buffer doesn't hurt for small displays, it would
>> mean wasting 1 MiB in e.g. the repaper driver (once it has gained
>> support for R1 ;^).
>>
>
> Maybe another option is to allocate on the struct drm_mode_config_funcs
> .fb_create callback? That way, we can get the mode_cmd->pixel_format and
> determine if only "data_array" buffer must be allocated or also "buffer".
>

Something like the following patch:

From 307bf062c9a999693a4a68c6740ec55b81f796b8 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 17 Jul 2023 12:30:35 +0200
Subject: [PATCH v2] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane

Geert reports that the following NULL pointer dereference happens for him
after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
plane update"):

    [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
    and format(R1   little-endian (0x20203152))
    Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
    Oops [#1]
    CPU: 0 PID: 1 Comm: swapper Not tainted
    6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
    epc : ssd130x_update_rect.isra.0+0x13c/0x340
     ra : ssd130x_update_rect.isra.0+0x2bc/0x340
    ...
    status: 00000120 badaddr: 00000000 cause: 0000000f
    [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
    [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
    [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
    [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
    [<c02f94fc>] commit_tail+0x190/0x1b8
    [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
    [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
    [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
    [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
    [<c02cd064>] drm_client_modeset_commit+0x34/0x64
    [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
    [<c0303424>] drm_fb_helper_set_par+0x38/0x58
    [<c027c410>] fbcon_init+0x294/0x534
    ...

The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
and this leads to drm_atomic_helper_commit_planes() attempting to commit
the atomic state for all planes, even the ones whose CRTC is not enabled.

Since the primary plane buffer is allocated in the encoder .atomic_enable
callback, this happens after that initial modeset commit and leads to the
mentioned NULL pointer dereference.

Fix this by allocating the buffers in the struct drm_mode_config_funcs
.fb_create, instead of doing it when the encoder is enabled.

Also, make a couple of improvements to the ssd130x_buf_alloc() function:

  * Make the allocation smarter to only allocate the intermediate buffer
    if the native R1 format is not used. Otherwise is not needed, since
    there is no XRGB8888 to R1 format conversion during plane updates.

  * Allocate the buffers as device managed resources, this is enough and
    simplifies the logic since there is no need to explicitly free them.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Move the buffers allocation to .fb_create instead of preventing atomic
  updates for disable planes.
- Don't allocate the intermediate buffer when using the native R1 format.
- Allocate buffers as device managed resources.

 drivers/gpu/drm/solomon/ssd130x.c | 54 +++++++++++++++++--------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ss=
d130x.c
index b8c90d507a35..615805a066de 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -146,38 +146,35 @@ static inline struct ssd130x_device *drm_to_ssd130x(s=
truct drm_device *drm)
 	return container_of(drm, struct ssd130x_device, drm);
 }
=20
-static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
+static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x, __u32 pixel_f=
ormat)
 {
 	unsigned int page_height =3D ssd130x->device_info->page_height;
 	unsigned int pages =3D DIV_ROUND_UP(ssd130x->height, page_height);
 	const struct drm_format_info *fi;
 	unsigned int pitch;
=20
-	fi =3D drm_format_info(DRM_FORMAT_R1);
-	if (!fi)
-		return -EINVAL;
+	/* If the native format is not used an intermediate buffer is needed */
+	if (pixel_format !=3D DRM_FORMAT_R1) {
+		fi =3D drm_format_info(DRM_FORMAT_R1);
+		if (!fi)
+			return -EINVAL;
=20
-	pitch =3D drm_format_info_min_pitch(fi, 0, ssd130x->width);
+		pitch =3D drm_format_info_min_pitch(fi, 0, ssd130x->width);
=20
-	ssd130x->buffer =3D kcalloc(pitch, ssd130x->height, GFP_KERNEL);
-	if (!ssd130x->buffer)
-		return -ENOMEM;
+		ssd130x->buffer =3D devm_kcalloc(ssd130x->dev, pitch, ssd130x->height,
+					       GFP_KERNEL);
+		if (!ssd130x->buffer)
+			return -ENOMEM;
+	}
=20
-	ssd130x->data_array =3D kcalloc(ssd130x->width, pages, GFP_KERNEL);
-	if (!ssd130x->data_array) {
-		kfree(ssd130x->buffer);
+	ssd130x->data_array =3D devm_kcalloc(ssd130x->dev, ssd130x->width, pages,
+					   GFP_KERNEL);
+	if (!ssd130x->data_array)
 		return -ENOMEM;
-	}
=20
 	return 0;
 }
=20
-static void ssd130x_buf_free(struct ssd130x_device *ssd130x)
-{
-	kfree(ssd130x->data_array);
-	kfree(ssd130x->buffer);
-}
-
 /*
  * Helper to write data (SSD130X_DATA) to the device.
  */
@@ -741,10 +738,6 @@ static void ssd130x_encoder_helper_atomic_enable(struc=
t drm_encoder *encoder,
 	if (ret)
 		goto power_off;
=20
-	ret =3D ssd130x_buf_alloc(ssd130x);
-	if (ret)
-		goto power_off;
-
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
=20
 	backlight_enable(ssd130x->bl_dev);
@@ -766,8 +759,6 @@ static void ssd130x_encoder_helper_atomic_disable(struc=
t drm_encoder *encoder,
=20
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
=20
-	ssd130x_buf_free(ssd130x);
-
 	ssd130x_power_off(ssd130x);
 }
=20
@@ -811,8 +802,21 @@ static const struct drm_connector_funcs ssd130x_connec=
tor_funcs =3D {
 	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
 };
=20
+static struct drm_framebuffer *ssd130x_fb_create(struct drm_device *dev, s=
truct drm_file *file,
+						 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(dev);
+	int ret;
+
+	ret =3D ssd130x_buf_alloc(ssd130x, mode_cmd->pixel_format);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return drm_gem_fb_create_with_dirty(dev, file, mode_cmd);
+}
+
 static const struct drm_mode_config_funcs ssd130x_mode_config_funcs =3D {
-	.fb_create =3D drm_gem_fb_create_with_dirty,
+	.fb_create =3D ssd130x_fb_create,
 	.atomic_check =3D drm_atomic_helper_check,
 	.atomic_commit =3D drm_atomic_helper_commit,
 };
--=20
2.41.0

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

