Return-Path: <linux-kernel+bounces-12819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311681FA68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EB11F2289C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D2101D4;
	Thu, 28 Dec 2023 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EMk2cQCx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F70101C2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Subject:References:Cc:To:Message-ID:From:
	Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rtDkFjG4UEMR0PjUgaZp0uUgO7ggIMJp7j+YKLSw+8k=; b=EMk2cQCxOyGl3ud6E2QSBNpsyl
	YybtKOq0s6fvIEUSWx29MjsK/CAO3w8TnHPxITIoQBk+w5RyHRXbWeQ71GpjmYNwMig834VXmyIgF
	SPDABDCAyA3UkRQZLETn+mNQOo1xEfCTXw1rRoohNhEG9V3IFfqqpOptkj7h/CqHPnlYO0Y3dCu52
	k9ZfP0WaC7KPxabv3Rw40hR/xv/vRBhAbvSwgpamLokFaLJB68PW6UK+TDWPuf+nCEG8hNX98Ph5t
	10CbLOvUyaSybjlOqnqPle04j0DF+sjOFczcwjAwlN9KMmjsira17D/TeJPKCq5ya+Wgue8znJ/X9
	Ga4FcBHA==;
Received: from [2001:67c:1be8::200] (helo=rainloop.kapsi.fi)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jyri.sarha@iki.fi>)
	id 1rIuBc-008JHs-19;
	Thu, 28 Dec 2023 19:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Dec 2023 17:28:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: jyri.sarha@iki.fi
Message-ID: <7fee3509faf9d134db2f537dccacbc1adf284cce@iki.fi>
To: "Philipp Stanner" <pstanner@redhat.com>, "Jyri Sarha"
 <jyri.sarha@iki.fi>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: undefined
X-SA-Exim-Connect-IP: 2001:67c:1be8::200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-Spam-Level: 
Subject: Re: [PATCH] drm/tilcdc: request and mapp iomem with devres
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on mail.kapsi.fi)

December 22, 2023 at 1:52 PM, "Philipp Stanner" <pstanner@redhat.com mail=
to:pstanner@redhat.com?to=3D%22Philipp%20Stanner%22%20%3Cpstanner%40redha=
t.com%3E > wrote:

>=20
>=20tilcdc currently just ioremaps its iomem, without doing the (a bit mo=
re
> robust) request on the memory first. The devm_ functions provide a hand=
y
> way to both request and ioremap the memory with automatic cleanup.
>=20
>=20Replace the manual ioremap with the devm_ version.
>=20
>=20Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>
Tested-by: Jyri Sarha <jyri.sarha@iki.fi>

I'll apply this shortly to drm-misc-next.

Thanks,
Jyri

> ---
> drivers/gpu/drm/tilcdc/tilcdc_drv.c | 19 ++++---------------
> 1 file changed, 4 insertions(+), 15 deletions(-)
>=20
>=20diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_drv.c
> index 8ebd7134ee21..2ad3f44a6e2d 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -182,9 +182,6 @@ static void tilcdc_fini(struct drm_device *dev)
>  if (priv->clk)
>  clk_put(priv->clk);
>=20
>=20- if (priv->mmio)
> - iounmap(priv->mmio);
> -
>  if (priv->wq)
>  destroy_workqueue(priv->wq);
>=20
>=20@@ -201,7 +198,6 @@ static int tilcdc_init(const struct drm_driver *d=
drv, struct device *dev)
>  struct platform_device *pdev =3D to_platform_device(dev);
>  struct device_node *node =3D dev->of_node;
>  struct tilcdc_drm_private *priv;
> - struct resource *res;
>  u32 bpp =3D 0;
>  int ret;
>=20
>=20@@ -226,17 +222,10 @@ static int tilcdc_init(const struct drm_driver =
*ddrv, struct device *dev)
>  goto init_failed;
>  }
>=20
>=20- res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> - if (!res) {
> - dev_err(dev, "failed to get memory resource\n");
> - ret =3D -EINVAL;
> - goto init_failed;
> - }
> -
> - priv->mmio =3D ioremap(res->start, resource_size(res));
> - if (!priv->mmio) {
> - dev_err(dev, "failed to ioremap\n");
> - ret =3D -ENOMEM;
> + priv->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> + if (IS_ERR(priv->mmio)) {
> + dev_err(dev, "failed to request / ioremap\n");
> + ret =3D PTR_ERR(priv->mmio);
>  goto init_failed;
>  }
>=20
>=20--=20
>=202.43.0
>

