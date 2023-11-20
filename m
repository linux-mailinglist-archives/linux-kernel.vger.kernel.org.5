Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3E7F11EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjKTL0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjKTL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:26:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544069C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:26:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084de32db5so17828295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700479602; x=1701084402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81y0BUjxhYX0m+rbPWqRJ0OIC+UNbPoSMg340RJn51Q=;
        b=xSYdx8aDPPoFP0KdeeBaXe3zk0Un0+zUveMKx0hhCYgqWEkoUC/pGNG+9Dl1wYdW6U
         MfhfPrXd51u3HNZ6hbhAe1Ry58B/llAq7xdzeMh6/WUBj7rE8iuF40q6e/Gec5LFcrBF
         iYy8ElWKCglHB58RmSv41UsHJr878XlC+8hDrPaUDeDEB1KzyY6Q0oZK5Jzc6/g+VwzC
         OToXYEQrg/JsLh7Vkrvu8klXXe+p91T7vFnhx1X/cLAkhaypILFLvXpisJmQ63eX+eR6
         QK3dP/b2CQlKH5f66KQWJsi/gmTtSA065KWPgVD78985bnw9zWu0dyOU/AKO2qR6kTop
         Yvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479602; x=1701084402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81y0BUjxhYX0m+rbPWqRJ0OIC+UNbPoSMg340RJn51Q=;
        b=tQVIbXjTlGwX3e4grPnNTYUvPI/vK8B3CyfbJUenhwCCuW+rsCuf1E20DbW6igJZOB
         Spa2Mol1K9JQ0WMo9J8qggzWuzo9rNS+8FCQXarCEBXdLrSW4fr3cbkug08BBCkoc2me
         ILpNB4cjCC9swPRWdraSvKq37fJ1cGZts5ZV0Rnp2uLctmu9HEBeKa7zT6Ru5TQKi43D
         xXxx1K13vnq08Fu40T1ax4eXBey7vkfMAAOYmaHlYPGljJOlP7VKKYn6TaICNZzW9EPf
         dy4331Iq7QYbwzAQETZEx9GL4O7c57DqNsfztQJUwwQfb44lMKoJJZgfl0vJCvZLfNR6
         eE4Q==
X-Gm-Message-State: AOJu0YwpdGHk4ymES9W2XZsrSsDpWExe3ihxdRNMNY5KnHC20ZLz4GeI
        BO3/C711+QfWnMJU+QB6pGNl9w==
X-Google-Smtp-Source: AGHT+IH4w9GJxepzA7mbaASTzS/ffTp4zkm3iulaLsADbJXdCuK2ssYTf1uaq15/ecJlepInY14KZQ==
X-Received: by 2002:a05:600c:1394:b0:409:5d7d:b26d with SMTP id u20-20020a05600c139400b004095d7db26dmr4930617wmf.15.1700479601654;
        Mon, 20 Nov 2023 03:26:41 -0800 (PST)
Received: from [10.1.1.118] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c230100b003fefb94ccc9sm12860464wmo.11.2023.11.20.03.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:26:40 -0800 (PST)
Message-ID: <08e0126f8075711e7bd59ca4110c2817c905d5a9.camel@linaro.org>
Subject: Re: [PATCH] iommu: Avoid more races around device probe
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        lpieralisi@kernel.org, quic_zhenhuah@quicinc.com, jgg@nvidia.com
Date:   Mon, 20 Nov 2023 11:26:39 +0000
In-Reply-To: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, 2023-11-15 at 18:25 +0000, Robin Murphy wrote:
> It turns out there are more subtle races beyond just the main part of
> __iommu_probe_device() itself running in parallel - the
> dev_iommu_free()
> on the way out of an unsuccessful probe can still manage to trip up
> concurrent accesses to a device's fwspec. Thus, extend the scope of
> iommu_probe_device_lock() to also serialise fwspec creation and
> initial
> retrieval.
>=20
> Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Link:
> https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@=
quicinc.com/
> Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org> (using continuous
boot test loop)

I like that this is easily back-portable to 6.1, thanks for this patch
:-)

Cheers,
Andr=C3=A9


> ---
>=20
> This is my idea of a viable fix, since it does not need a 700-line
> diffstat to make the code do what it was already *trying* to do
> anyway.
> This stuff should fundamentally not be hanging off driver probe in
> the
> first place, so I'd rather get on with removing the underlying
> brokenness than waste time and effort polishing it any further.
>=20
> =C2=A0drivers/acpi/scan.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> =C2=A0drivers/iommu/iommu.c=C2=A0=C2=A0=C2=A0 | 20 ++++++++++----------
> =C2=A0drivers/iommu/of_iommu.c | 12 +++++++++---
> =C2=A0include/linux/iommu.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A04 files changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fa5dd71a80fa..02bb2cce423f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1568,17 +1568,22 @@ static const struct iommu_ops
> *acpi_iommu_configure_id(struct device *dev,
> =C2=A0	int err;
> =C2=A0	const struct iommu_ops *ops;
> =C2=A0
> +	/* Serialise to make dev->iommu stable under our potential
> fwspec */
> +	mutex_lock(&iommu_probe_device_lock);
> =C2=A0	/*
> =C2=A0	 * If we already translated the fwspec there is nothing left
> to do,
> =C2=A0	 * return the iommu_ops.
> =C2=A0	 */
> =C2=A0	ops =3D acpi_iommu_fwspec_ops(dev);
> -	if (ops)
> +	if (ops) {
> +		mutex_unlock(&iommu_probe_device_lock);
> =C2=A0		return ops;
> +	}
> =C2=A0
> =C2=A0	err =3D iort_iommu_configure_id(dev, id_in);
> =C2=A0	if (err && err !=3D -EPROBE_DEFER)
> =C2=A0		err =3D viot_iommu_configure(dev);
> +	mutex_unlock(&iommu_probe_device_lock);
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * If we have reason to believe the IOMMU driver missed the
> initial
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f17a1113f3d6..e0c962648dde 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -485,11 +485,12 @@ static void iommu_deinit_device(struct device
> *dev)
> =C2=A0	dev_iommu_free(dev);
> =C2=A0}
> =C2=A0
> +DEFINE_MUTEX(iommu_probe_device_lock);
> +
> =C2=A0static int __iommu_probe_device(struct device *dev, struct list_hea=
d
> *group_list)
> =C2=A0{
> =C2=A0	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
> =C2=A0	struct iommu_group *group;
> -	static DEFINE_MUTEX(iommu_probe_device_lock);
> =C2=A0	struct group_device *gdev;
> =C2=A0	int ret;
> =C2=A0
> @@ -502,17 +503,15 @@ static int __iommu_probe_device(struct device
> *dev, struct list_head *group_list
> =C2=A0	 * probably be able to use device_lock() here to minimise
> the scope,
> =C2=A0	 * but for now enforcing a simple global ordering is fine.
> =C2=A0	 */
> -	mutex_lock(&iommu_probe_device_lock);
> +	lockdep_assert_held(&iommu_probe_device_lock);
> =C2=A0
> =C2=A0	/* Device is probed already if in a group */
> -	if (dev->iommu_group) {
> -		ret =3D 0;
> -		goto out_unlock;
> -	}
> +	if (dev->iommu_group)
> +		return 0;
> =C2=A0
> =C2=A0	ret =3D iommu_init_device(dev, ops);
> =C2=A0	if (ret)
> -		goto out_unlock;
> +		return ret;
> =C2=A0
> =C2=A0	group =3D dev->iommu_group;
> =C2=A0	gdev =3D iommu_group_alloc_device(group, dev);
> @@ -548,7 +547,6 @@ static int __iommu_probe_device(struct device
> *dev, struct list_head *group_list
> =C2=A0			list_add_tail(&group->entry, group_list);
> =C2=A0	}
> =C2=A0	mutex_unlock(&group->mutex);
> -	mutex_unlock(&iommu_probe_device_lock);
> =C2=A0
> =C2=A0	if (dev_is_pci(dev))
> =C2=A0		iommu_dma_set_pci_32bit_workaround(dev);
> @@ -562,8 +560,6 @@ static int __iommu_probe_device(struct device
> *dev, struct list_head *group_list
> =C2=A0	iommu_deinit_device(dev);
> =C2=A0	mutex_unlock(&group->mutex);
> =C2=A0	iommu_group_put(group);
> -out_unlock:
> -	mutex_unlock(&iommu_probe_device_lock);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -573,7 +569,9 @@ int iommu_probe_device(struct device *dev)
> =C2=A0	const struct iommu_ops *ops;
> =C2=A0	int ret;
> =C2=A0
> +	mutex_lock(&iommu_probe_device_lock);
> =C2=A0	ret =3D __iommu_probe_device(dev, NULL);
> +	mutex_unlock(&iommu_probe_device_lock);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -1822,7 +1820,9 @@ static int probe_iommu_group(struct device
> *dev, void *data)
> =C2=A0	struct list_head *group_list =3D data;
> =C2=A0	int ret;
> =C2=A0
> +	mutex_lock(&iommu_probe_device_lock);
> =C2=A0	ret =3D __iommu_probe_device(dev, group_list);
> +	mutex_unlock(&iommu_probe_device_lock);
> =C2=A0	if (ret =3D=3D -ENODEV)
> =C2=A0		ret =3D 0;
> =C2=A0
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 157b286e36bf..c25b4ae6aeee 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -112,16 +112,20 @@ const struct iommu_ops
> *of_iommu_configure(struct device *dev,
> =C2=A0					=C2=A0=C2=A0 const u32 *id)
> =C2=A0{
> =C2=A0	const struct iommu_ops *ops =3D NULL;
> -	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +	struct iommu_fwspec *fwspec;
> =C2=A0	int err =3D NO_IOMMU;
> =C2=A0
> =C2=A0	if (!master_np)
> =C2=A0		return NULL;
> =C2=A0
> +	/* Serialise to make dev->iommu stable under our potential
> fwspec */
> +	mutex_lock(&iommu_probe_device_lock);
> +	fwspec =3D dev_iommu_fwspec_get(dev);
> =C2=A0	if (fwspec) {
> -		if (fwspec->ops)
> +		if (fwspec->ops) {
> +			mutex_unlock(&iommu_probe_device_lock);
> =C2=A0			return fwspec->ops;
> -
> +		}
> =C2=A0		/* In the deferred case, start again from scratch */
> =C2=A0		iommu_fwspec_free(dev);
> =C2=A0	}
> @@ -155,6 +159,8 @@ const struct iommu_ops *of_iommu_configure(struct
> device *dev,
> =C2=A0		fwspec =3D dev_iommu_fwspec_get(dev);
> =C2=A0		ops=C2=A0=C2=A0=C2=A0 =3D fwspec->ops;
> =C2=A0	}
> +	mutex_unlock(&iommu_probe_device_lock);
> +
> =C2=A0	/*
> =C2=A0	 * If we have reason to believe the IOMMU driver missed the
> initial
> =C2=A0	 * probe for dev, replay it to get things in order.
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ec289c1016f5..6291aa7b079b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -845,6 +845,7 @@ static inline void dev_iommu_priv_set(struct
> device *dev, void *priv)
> =C2=A0	dev->iommu->priv =3D priv;
> =C2=A0}
> =C2=A0
> +extern struct mutex iommu_probe_device_lock;
> =C2=A0int iommu_probe_device(struct device *dev);
> =C2=A0
> =C2=A0int iommu_dev_enable_feature(struct device *dev, enum
> iommu_dev_features f);

