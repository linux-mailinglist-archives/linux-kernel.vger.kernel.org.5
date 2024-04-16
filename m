Return-Path: <linux-kernel+bounces-146948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06898A6D69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D41B23DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93C12D1FA;
	Tue, 16 Apr 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="bBebSiys"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC612C52E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276565; cv=none; b=c/FPoWMEu8Rp88EcHkIy59zodppZelYCtB/aYm+ARu91quP36ZQmOl1rn4eQHHFG8OEYi0eXTCXwQ19WK3w7/UKJwPzzlLUWFeaRGeXGPhSgMBo9FM5xuX6zOEoj9dZ3fVSuVcRzs/n+YgHabThXfyfGRAJeIi4U565FMdhjPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276565; c=relaxed/simple;
	bh=gc2+h75Enyy26DK2PxKy8NrJ/zAd9qAwocb2ISpTevc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwzSqH32xutm58t0zPkr5Lm46WSEdPNDxakI7fhcLD1aO8FnNhcbg8jXMZBMmnyeZbWwZDHHj7M3uHVrtrDNhBqVtU0TawvLYBDvMY6aDLSy3nmdVrOOksxnT6x1tKlzYeWDO+/Z4OqTEvwmpHSI/9BfLrOfF2x4J25HUTyPn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=bBebSiys; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d620408f8so345001385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1713276560; x=1713881360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyD7CJia6dqQdPW0B5XtV/th76QRRg/WSyHypuuA1Ic=;
        b=bBebSiys+Dd/Mgbc8vUunoMMozVpR4k/ZlrxKNgojViLPDo6ZPUibKm3FJQBTm1zih
         bgCzWbMafFp7nPszPgtXEjN3Q5EZ546TR8WKm3n7ZIwxX3UC9tQn3qm0dijMrO6oRJRv
         f4UEKHH2ftVEP6Kxk7ouja814Um/UDgmgCCxx/ogODveX2PAO0xzd3jnJZ6+QGqFz/UR
         BRDrb0bzgqUcjC4EfteuOpOp2oLVg+9/ercrAA3bLAv+1KnwJE5nUXV8Au38G5CFDFYP
         rUQTB0+fN2+0pVg1gIuyuF6wxOrR9xJBrBHLiQFulY6q0XGCuUYOjSXAGXjnsucD7NIp
         kjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276560; x=1713881360;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyD7CJia6dqQdPW0B5XtV/th76QRRg/WSyHypuuA1Ic=;
        b=cgbmMvoxnEReZtsOPPTGlat0d0wu1A90DPZImsF3SfzjxgIfCBkCPMC4ZfxDT4hHii
         4Bp6dRlTgGP0g9xZpsRgDZW7DspxDVgx6YCXGgdhRBshJ2pCDuW0e04VkNKaFGT3V8bU
         srmx7wmgcEFl6qFyJs+F5CLa6DXIdNwtUK2yoEcYwreQ8OxWsat1nrW0OfUsNX4yRe5F
         14X7DqKmtMne6pduEBulslHlcz85gzuL0nB5/ZdXNQD6gPOy6spHg3DFn5OQBNXnftPL
         J/KC6zjqiwiLm99w3cIT/ZStCLH5lrswImZKWOFJJ3V+NVmvmky4twD2wi3JCRkrkRFQ
         lwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnADECZanwoMNVskvnFFPwtdsgLlBBxkMlWXZG7bHJdR2LryJTWXeg8jSmjKAuZUh7PqSd0usAh067Ne4dPavVj1JRwO/M1yWUfIrC
X-Gm-Message-State: AOJu0Yx6Q2z9WoP+LMMKJXVVMfkdW03NhTUEBIN2P5J6V8lIijrhyaTz
	0e1pJyOw+lvXF8WUBeW9S3f07/Q3sfxEcNR58AmnROUYOcCUndCnvJv1rJ2WpEk=
X-Google-Smtp-Source: AGHT+IHTZXOlhLzrZJKOCo7oGobPLBHBqfpA1Y9jlLfjJ81O6tnjovWTxBF2SvorngJtfMN3Z4Hm+g==
X-Received: by 2002:ad4:44a7:0:b0:69f:f2ae:cad6 with SMTP id n7-20020ad444a7000000b0069ff2aecad6mr1244518qvt.11.1713276560547;
        Tue, 16 Apr 2024 07:09:20 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id dd10-20020ad4580a000000b0069b563d5d8fsm6128137qvb.20.2024.04.16.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:09:20 -0700 (PDT)
Message-ID: <70733fe5c919527796bd3d9735ced522bcdd7a25.camel@ndufresne.ca>
Subject: Re: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Shawn Sung <shawn.sung@mediatek.com>, Chun-Kuang Hu
	 <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Date: Tue, 16 Apr 2024 10:09:19 -0400
In-Reply-To: <20240403102701.369-2-shawn.sung@mediatek.com>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
	 <20240403102701.369-2-shawn.sung@mediatek.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=mQGiBEUQN0MRBACQYceNSezSdMjx7sx6gwKkMghrrODgl3B0eXBTgNp6c431IfOOEsdvkoOh1kwoYcQgbg4MXw6beOltysX4e8fFWsiRkc2nvvRW9ir9kHDm49MkBLqaDjTqOkYKNMiurFW+gozpr/lUW15QqT6v68RYe0zRdtwGZqeLzX2LVuukGwCg4AISzswrrYHNV7vQLcbaUhPgIl0D+gILYT9TJgAEK4YHW+bFRcY+cgUFoLQqQayECMlctKoLOE69nIYOc/hDr9uih1wxrQ/yL0NJvQCohSPyoyLF9b2EuIGhQVp05XP7FzlTxhYvGO/DtO08ec85+bTfVBMV6eeY4MS3ZU+1z7ObD7Pf29YjyTehN2Dan6w1g2rBk5MoA/9nDocSlk4pbFpsYSFmVHsDiAOFje3+iY4ftVDKunKYWMhwRVBjAREOByBagmRau0cLEcElpf4hX5f978GoxSGIsiKoDAlXX+ICDOWC1/EXhEEmBR1gL0QJgiVviNyLfGJlZWnPjw6xhhmtHYWTDxBOP5peztyc2PqeKsLsLWzAr7RDTmljb2xhcyBEdWZyZXNuZSAoQi4gU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPohgBBMRAgAgBQJFlCyOAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQcVMCLawGqBwhLQCgzYlrLBj6KIAZ4gmsfjXD6ZtddT8AoIeGDicVq5WvMHNWign6ApQcZUihtElOaWNvbGFzIER1ZnJlc25lIChCLiBTYy4gSW5mb3JtYXRpcXVlKSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY28udWs+iGIEExECACIFAkuzca8CGwMGCwkIBwMCBhUIAgkKCwQWA
 gMBAh4BAheAAAoJEHFTAi2sBqgcQX8An2By6LDEeMxi4B9hUbpvRnzaaeNqA J9Rox8rfqHZnSErw9bCHiBwvwJZ77QxTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29tPohiBBMRAgAiBQJNzZzPAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHLlxAKCYAGf4JL7DYDLs/188CPMGuwLypwCfWKc9DorA9f5pyYlD5pQo6SgSoiC0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPohiBBMRAgAiBQJVwNwgAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHCZ4AJ0QwU6/G4c7h9CkMBT9ZxGLX4KSnQCgq0P7CX7hv/M7HeyfMFZe8t3vAEW0RE5pY29sYXMgRHVmcmVzbmUgKEIuIFNjLiBJbmZvcm1hdGlxdWUpIDxuaWNvbGFzZEBibHVlc3RyZWFrdGVjaC5jb20+iGAEExECACAFAkZjGzoCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHBl7AJ0d2lrzshMmJaik/EaDEakzEwqgxQCg0JVZMZm9gRfEou1FvinuZxwf/mu0R05pY29sYXMgRHVmcmVzbmUgKEIgU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAdXNoZXJicm9va2UuY2E+iGAEExECACAFAkUQN0MCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHPTnAJ0WGgJJVspoctAvEcI00mtp5WAFGgCgr+E7ItOqZEHAs+xabBgknYZIFPW5Ag0ERRA3UhAIAJ0rxl2HsVg/nSOAUt7U/T/W+RKzVAlD9orCB0pRVvyWNxSr8MHcH
 mWCxykLuB34ouM4GuDVRKfGnqLzJRBfjs7Ax9K2FI3Odund9xpviLCt1jFC0K XL04RebrFT7xjDfocDaSLFvgxMVs/Jr2/ckKPId1oKvgYgt/o+MzUabKyFB8wIvq4GMtj3LoBKLCie2nCaSt7uVUt6q2t5bNWrd3lO6/mWn7YMc5Hsn33H9pS0+9szw6m3dG08eMKNueDlt72QxiYl2rhjzkT4ltKEkFgYBdyrtIj1UO6eX+YXb4E1rCMJrdjBSgqDPK1sWHC7gliy+izr+XTHuFwlfy8gBpsAAwUIAJJNus64gri4HAL632eqVpza83EphX1IuHzLi1LlMnQ9Tm7XKag46NhmJbOByMG33LwBsBdLjjHQSVkYZFWUifq+NWSFC/kqlb72vW8rBAv64+i3QdfxK9FWbweiRsPpvuHjJQuecbPDJpubLaxKbu2aqLCN5LuHXvdQr6KiXwabT+OJ9AJAqHG7q4IEzg4RNUVn9AS6L8bxqMSocjqpWNBCY2efCVd/c6k4Acv6jXu+wDAZEbWXK+71uaUHExhigBYBpiHGrobe32YlTVE/XEIzKKywhm/Hkn5YKWzumLte6xiD9JhKabmD7uqIvLt2twUpz4BdPzj0dvGlSmvFcaaISQQYEQIACQUCRRA3UgIbDAAKCRBxUwItrAaoHJLyAKDeS3AFowM3f1Y3OFU6XRCTKK2ZhwCfT/7P9WDjkkmiq5AfeOiwVlpuHtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 03 avril 2024 =C3=A0 18:26 +0800, Shawn Sung a =C3=A9crit=C2=A0=
:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>=20
> Add DRM_MTK_GEM_CREATE_ENCRYPTED flag to allow user to allocate

Is "ENCRYPTED" a proper naming ? My expectation is that this would hold dat=
a in
a PROTECTED memory region but that no cryptographic algorithm will be invol=
ved.

Nicolas

> a secure buffer to support secure video path feature.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  include/uapi/drm/mediatek_drm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/drm/mediatek_drm.h b/include/uapi/drm/mediatek_=
drm.h
> index b0dea00bacbc4..e9125de3a24ad 100644
> --- a/include/uapi/drm/mediatek_drm.h
> +++ b/include/uapi/drm/mediatek_drm.h
> @@ -54,6 +54,7 @@ struct drm_mtk_gem_map_off {
> =20
>  #define DRM_MTK_GEM_CREATE		0x00
>  #define DRM_MTK_GEM_MAP_OFFSET		0x01
> +#define DRM_MTK_GEM_CREATE_ENCRYPTED	0x02
> =20
>  #define DRM_IOCTL_MTK_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + \
>  		DRM_MTK_GEM_CREATE, struct drm_mtk_gem_create)


