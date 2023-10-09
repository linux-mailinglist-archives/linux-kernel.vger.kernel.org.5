Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14CA7BED89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378808AbjJIVqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378813AbjJIVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F8AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696887954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc+EooNjRuIGaZlba0n715rKNgOK/kSBjOsmerqWaRg=;
        b=Kteuzo78Fdw/9v4kPUy5f+XdPjhKiDUSD0F/8TFIu0Nz9gHiGJiOUtsbRDII87ychW4iGz
        VpVsVtlSjB2FoS4nPIfUiN0A6KBxww6t5PQDJp2Ec9htZiyy2L6upO4USiJi77QFrR1hxb
        kfVzV8gSbnsIUMlCHx9+WAjr32Pl3Jg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-XAsGdxN4O_y5v98ls9-4cA-1; Mon, 09 Oct 2023 17:45:51 -0400
X-MC-Unique: XAsGdxN4O_y5v98ls9-4cA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e1dc572fbeso8065409fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887950; x=1697492750;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc+EooNjRuIGaZlba0n715rKNgOK/kSBjOsmerqWaRg=;
        b=rtAJdy1P86FdDbwL9i8LjLS7xiX4N2ZYAEYqJuoAke5wlIWCkmTn+fCa+D3Z6t+od0
         q7EBhkTKPNTRbUBF8IJayzft397bM/7aIvtKNI1sh6XB7wBqOFqonoGKfEd0UQh9o0e9
         QSwZL2jPv77bNxehErxOYlIeeRJQwbFhO2YSfGtK72mItX6InlKp3nm6Fq3IAjDF0ZEV
         Zx0SOyS9E5p6zmqcQe7jzXi3jeIqiGDUatHhiAytJG1gAexjuPeJzywBFRR3JXVjqvy6
         6dRXGed0qDrnP02y59CkNL8uTGFh5xNHisNKsxllhlqtMHPf4N9rI1MwaxpR8m222iqG
         3oYw==
X-Gm-Message-State: AOJu0YyhT3Fo5poTyDzDKg8+NVueqrmxHgz7/foRV69svRX/D23mcUrK
        ddw3WJvcusEyc/2O09Cf/jC7hFJ5LivT6Cru4jb5Bb9RBhTsaNALfN+x6TNLFWVm0GGgo0qUW/2
        BstqSHAk9gM4Le8zs7VkqCZRw
X-Received: by 2002:a05:6870:f599:b0:1b0:2f63:4ff6 with SMTP id eh25-20020a056870f59900b001b02f634ff6mr18738570oab.1.1696887950711;
        Mon, 09 Oct 2023 14:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA4GSK6GSMuEXs3YrDvKAZYcLFQXhm0ZOhmAvnxNzzFaJM60xpMGR10412D3pre/KXhgfm7Q==
X-Received: by 2002:a05:6870:f599:b0:1b0:2f63:4ff6 with SMTP id eh25-20020a056870f59900b001b02f634ff6mr18738558oab.1.1696887950418;
        Mon, 09 Oct 2023 14:45:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id r6-20020a0c8d06000000b0065655bb349csm4188877qvb.141.2023.10.09.14.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:45:49 -0700 (PDT)
Message-ID: <2346aa93e2479f2ebd8849c5b2ead36a50ce43a0.camel@redhat.com>
Subject: Re: [PATCH] drm/i2c/ch7006: fix a possible null pointer dereference
From:   Lyude Paul <lyude@redhat.com>
To:     Ma Ke <make_ruc2021@163.com>, airlied@gmail.com, daniel@ffwll.ch,
        javierm@redhat.com, mripard@kernel.org,
        u.kleine-koenig@pengutronix.de, noralf@tronnes.org,
        tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Oct 2023 17:45:48 -0400
In-Reply-To: <20231007031712.3997144-1-make_ruc2021@163.com>
References: <20231007031712.3997144-1-make_ruc2021@163.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-07 at 11:17 +0800, Ma Ke wrote:
> In ch7006_encoder_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/gpu/drm/i2c/ch7006_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch700=
6_drv.c
> index 131512a5f3bd..27c2f02f5b43 100644
> --- a/drivers/gpu/drm/i2c/ch7006_drv.c
> +++ b/drivers/gpu/drm/i2c/ch7006_drv.c
> @@ -236,8 +236,10 @@ static int ch7006_encoder_get_modes(struct drm_encod=
er *encoder,
>  		    ~mode->valid_norms & 1<<priv->norm)
>  			continue;
> =20
> -		drm_mode_probed_add(connector,
> -				drm_mode_duplicate(encoder->dev, &mode->mode));
> +		struct drm_display_mode *encoder_mode;
> +		encoder_mode =3D drm_mode_duplicate(encoder->dev, &mode->mode);

I think the kernel prefers to have variable declaration at the top of the
scope, and as well: this breaks things because you don't add back the
drm_mode_probed_add() call.

> +		if (!mode)
> +			continue;
> =20
>  		n++;
>  	}

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

