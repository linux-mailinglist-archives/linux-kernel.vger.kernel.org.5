Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD877EB00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbjHPUsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346264AbjHPUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A41BE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692218837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3IvmL0y1viiHXLAUyfip1yCYlhOkZ7NLyhRvcY+CDk=;
        b=FsUH+oiW3E50ApXcID/vYkII47qSeguEf4kg9k04Y644PtGQHVbYIM3RqVSDA554JAdl2w
        C73o9NWGLyOwjA0u018LeN7RYVX6dlPuDbVSTBSUkMej+TNoEwXaYhGWaNx1bZFZAaDTE8
        qZvk/CZYgYwb9ffcyPFn9iIRsTUuD6w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-bm5P9yeAPb-zRCWryskSQg-1; Wed, 16 Aug 2023 16:47:14 -0400
X-MC-Unique: bm5P9yeAPb-zRCWryskSQg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76d7a1b2a9eso38301785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218834; x=1692823634;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3IvmL0y1viiHXLAUyfip1yCYlhOkZ7NLyhRvcY+CDk=;
        b=UJndLX1fwHDvIc8NOZIREKcbqBaJ7qYhvpZhN5ox5KyXzaegQ55lonIimU627pmzvb
         MwLg8c2mhceMWPf2rgq6Zpbn5kmI1jL4AFZyNDcg4Pl6H0IOBsuYMrA484XXm2S+lycB
         M+Yu/uchhVECyHGBWR+IhMBQnqzb3qcGhc3n4RR08cYByEoyg/vMSaDWfKDEtloIKYdv
         Aqlf9LNLyP0R+tFlOu3KfqcssS3YpqrXiAKgk+e6u/N9C9ImWbCuwOpRs82DS2RbGEjR
         CmF/Emc8igORe+j+AkAD+firg/+V9lU9J3UKHq4raZlbgxSd2MoJRg1462OTvgEyM7ve
         f9hw==
X-Gm-Message-State: AOJu0YxIoNqTKZ4YEqu5BpCJkkM5yfklsO4F8uVW/dyEgnFJ31wSgFEC
        MSUkxzrDEEtSbdabbZvKfp0elxxBqplRDCvazfSF4g8Utoiu/VeyCjXav4EBVZY4chGKYVzimSr
        qpnP8IdfDmIqg/+/ZcrdjcqnN
X-Received: by 2002:a05:622a:1210:b0:403:e895:155b with SMTP id y16-20020a05622a121000b00403e895155bmr3853832qtx.34.1692218834031;
        Wed, 16 Aug 2023 13:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEey1QVl493qQLI7bMS4KR7ZC4Pq5U6vCDQZyZMtY+jGAPCQ+P+AzAMGob1aMDWpaV//+fi6g==
X-Received: by 2002:a05:622a:1210:b0:403:e895:155b with SMTP id y16-20020a05622a121000b00403e895155bmr3853816qtx.34.1692218833802;
        Wed, 16 Aug 2023 13:47:13 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c7d:5f00::feb? ([2600:4040:5c7d:5f00::feb])
        by smtp.gmail.com with ESMTPSA id w8-20020ac84d08000000b0040b8ba13701sm4735297qtv.52.2023.08.16.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:47:13 -0700 (PDT)
Message-ID: <a612e9d4560aa3827114339b1ea92f0181550eca.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling
 of nouveau_connector_create
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
        Takashi Iwai <tiwai@suse.de>
Date:   Wed, 16 Aug 2023 16:47:12 -0400
In-Reply-To: <20230814144933.3956959-1-kherbst@redhat.com>
References: <20230814144933.3956959-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2023-08-14 at 16:49 +0200, Karol Herbst wrote:
> We can't simply free the connector after calling drm_connector_init on it=
.
> We need to clean up the drm side first.
>=20
> It might not fix all regressions from 2b5d1c29f6c4 ("drm/nouveau/disp:
> PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"), but at least it
> fixes a memory corruption in error handling related to that commit.
>=20
> Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_=
crate.local/
> Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index a2e0033e8a260..622f6eb9a8bfd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1408,8 +1408,7 @@ nouveau_connector_create(struct drm_device *dev,
>  		ret =3D nvif_conn_ctor(&disp->disp, nv_connector->base.name, nv_connec=
tor->index,
>  				     &nv_connector->conn);
>  		if (ret) {
> -			kfree(nv_connector);
> -			return ERR_PTR(ret);
> +			goto drm_conn_err;
>  		}
> =20
>  		ret =3D nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",
> @@ -1426,8 +1425,7 @@ nouveau_connector_create(struct drm_device *dev,
>  			if (ret) {
>  				nvif_event_dtor(&nv_connector->hpd);
>  				nvif_conn_dtor(&nv_connector->conn);
> -				kfree(nv_connector);
> -				return ERR_PTR(ret);
> +				goto drm_conn_err;
>  			}
>  		}
>  	}
> @@ -1475,4 +1473,9 @@ nouveau_connector_create(struct drm_device *dev,
> =20
>  	drm_connector_register(connector);
>  	return connector;
> +
> +drm_conn_err:
> +	drm_connector_cleanup(connector);
> +	kfree(nv_connector);
> +	return ERR_PTR(ret);
>  }

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

