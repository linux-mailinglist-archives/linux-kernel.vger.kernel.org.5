Return-Path: <linux-kernel+bounces-89312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69386EE26
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28751C21BFD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11A3D64;
	Sat,  2 Mar 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEQVqEC5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1531384
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346992; cv=none; b=IKJKHcsCqlifxfMMN0ByFIUFfaI7SwODlEj2pg9d7QQ8ZIQFfWpkt1R8oG7eVY8CA9cBux8TzMl6VlN21gtAc2Ym1RRS3/+sT+KKrtoe98Q3pSAhwS2cxqWaOANMav08PqlEgpsNuI3Ppwr4mPQYU/cIlcDL/NML5WQ/FiQpLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346992; c=relaxed/simple;
	bh=h85jpT5VMKAmcwx8xjty1pBSWn4rm7EQTJbenc1Kkn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMP91d4ZzsOhQ235gglkZXWa2oZVz6NLCvnvJongM/SoEf2fRS2bdnUaLEksKPWRQC5676wNcys7pUGDM3IOJ9hQvzzXaamFzsyXXi8TvgbFJJc1CeBC/qtKB0680fkWqvgWGBYmd00N9UrSB3fpWDhKPl5zxxQEXc6x42AhpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEQVqEC5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513298d6859so2420749e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 18:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709346989; x=1709951789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5POyl/4677bPTPLA6iBYKpbwNy+pWBIIcesnixttt5A=;
        b=AEQVqEC5nf1iFueyyhc+O04VZuj1elvrxJeWGCkza2zAoM3MiztoDLOPi5f/n/2wR6
         hC9efIkyjB7iv4lLdIcGLLvROmqid3hM6rZ6RCcyPwhGgRxY8dQwHbxHRCHsYEeYSPGQ
         cHxmNXWZp1W12cv1ddVUHBrTg50IrObQdpxXcy4pSVkK4Pdv0jmex+I85mwhpv11wiKe
         qqe883ElcA/L3lNJeCwknscbzUHOiyviS0yslp3Z/flE8or51RrQJ45RVoEExzgtVU72
         rwnx87KlApWEeGBzfrkVZm3ADStVPpujkAThgSmdzKcc9/8inwGY1WKRsvcUP2Cmqk0R
         UbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709346989; x=1709951789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5POyl/4677bPTPLA6iBYKpbwNy+pWBIIcesnixttt5A=;
        b=SIwGDbHXpRryhqtAop7IRnW+uchArp2cTeNslNH59t1Q1BIngeIt8bkEivSnpyVpKi
         lc+2H7AGWmoGEHMGJlfA01S+rhoAFUKj5WRnEEsGaV/rEZ2dFkse9NKsGnmxVctVQ54C
         ZR4p0gSYFHxh5YPXpUxGF6v+kpZZAf0OQOFNs08NvpcPs2bliYer9Ba/arehSeb9seg1
         /WkFrJ+gkWO6ahQvDUCCTpKX+Mpysnp4DWYNddIe5A4HP033tu/3+wTgzCJ+6xBjn9by
         YxzaoHxFJEAb8TvBSArXe53YYDY9LREo7vumhp+YnAFb9cz6UA8Py3h8+4ucjkzLwQIb
         wlcA==
X-Forwarded-Encrypted: i=1; AJvYcCXH7ZaycuCNnTS5nI+sr7R3Kj+3dIDpmFT5LjAkOR2tyvlreHYUcypUKasrhSpA5FG9s+4lv0v4z4NucbO1NymXFHOFxQZ2MlHxDY2F
X-Gm-Message-State: AOJu0Yw9W5z7ZrAN9tcyOncGQ+VUe1lF7E7lehhcI7/e9OMBsjOvNnKk
	UlWBXfckRvv9MeaXwMui9Ki/Dwn4+NrJ94AWfuwZm0ablNz5tLLanbBRra3rvVQE9hM0jX6WA0B
	pj9fPEF+zhhUuDQTSF+ClZUattcekaeC5wqAing==
X-Google-Smtp-Source: AGHT+IHXwCc1btbgWjvxQYTUfULNjSSVQiId0NmekC+LhMs5EOmKYO9wVZMGd6O430V2MhOPIxRmQzaxlI79b0yDRl4=
X-Received: by 2002:a05:6512:78d:b0:512:d575:4745 with SMTP id
 x13-20020a056512078d00b00512d5754745mr2199873lfr.1.1709346988970; Fri, 01 Mar
 2024 18:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122073903.24406-1-baolu.lu@linux.intel.com> <20240122073903.24406-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 2 Mar 2024 10:36:17 +0800
Message-ID: <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with iommufd_hw_pgtable
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 15:46, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> When allocating a user iommufd_hw_pagetable, the user space is allowed to
> associate a fault object with the hw_pagetable by specifying the fault
> object ID in the page table allocation data and setting the
> IOMMU_HWPT_FAULT_ID_VALID flag bit.
>
> On a successful return of hwpt allocation, the user can retrieve and
> respond to page faults by reading and writing the file interface of the
> fault object.
>
> Once a fault object has been associated with a hwpt, the hwpt is
> iopf-capable, indicated by fault_capable set to true. Attaching,
> detaching, or replacing an iopf-capable hwpt to an RID or PASID will
> differ from those that are not iopf-capable. The implementation of these
> will be introduced in the next patch.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 11 ++++++++
>  include/uapi/linux/iommufd.h            |  6 +++++
>  drivers/iommu/iommufd/fault.c           | 14 ++++++++++
>  drivers/iommu/iommufd/hw_pagetable.c    | 36 +++++++++++++++++++------
>  4 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 52d83e888bd0..2780bed0c6b1 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -293,6 +293,8 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
>  struct iommufd_hw_pagetable {
>         struct iommufd_object obj;
>         struct iommu_domain *domain;
> +       struct iommufd_fault *fault;
> +       bool fault_capable : 1;
>  };
>
>  struct iommufd_hwpt_paging {
> @@ -446,8 +448,17 @@ struct iommufd_fault {
>         struct wait_queue_head wait_queue;
>  };
>
> +static inline struct iommufd_fault *
> +iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +       return container_of(iommufd_get_object(ucmd->ictx, id,
> +                                              IOMMUFD_OBJ_FAULT),
> +                           struct iommufd_fault, obj);
> +}
> +
>  int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
>  void iommufd_fault_destroy(struct iommufd_object *obj);
> +int iommufd_fault_iopf_handler(struct iopf_group *group);
>
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c32d62b02306..7481cdd57027 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
>   *                                the parent HWPT in a nesting configuration.
>   * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
>   *                                   enforced on device attachment
> + * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
> + *                             valid.
>   */
>  enum iommufd_hwpt_alloc_flags {
>         IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>         IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
> +       IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
>  };
>
>  /**
> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>   * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>         __u32 __reserved;
>         __u32 data_type;
>         __u32 data_len;
> +       __u32 fault_id;
>         __aligned_u64 data_uptr;
>  };
>  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 9844a85feeb2..e752d1c49dde 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -253,3 +253,17 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
>
>         return rc;
>  }
> +
> +int iommufd_fault_iopf_handler(struct iopf_group *group)
> +{
> +       struct iommufd_hw_pagetable *hwpt = group->cookie->domain->fault_data;
> +       struct iommufd_fault *fault = hwpt->fault;
> +
> +       mutex_lock(&fault->mutex);
> +       list_add_tail(&group->node, &fault->deliver);
> +       mutex_unlock(&fault->mutex);
> +
> +       wake_up_interruptible(&fault->wait_queue);
> +
> +       return 0;
> +}
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 3f3f1fa1a0a9..2703d5aea4f5 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,15 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>
> +static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
> +{
> +       if (hwpt->domain)
> +               iommu_domain_free(hwpt->domain);
> +
> +       if (hwpt->fault)
> +               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
> +}
> +
>  void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
>  {
>         struct iommufd_hwpt_paging *hwpt_paging =
> @@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
>                                          hwpt_paging->common.domain);
>         }
>
> -       if (hwpt_paging->common.domain)
> -               iommu_domain_free(hwpt_paging->common.domain);
> -
> +       __iommufd_hwpt_destroy(&hwpt_paging->common);
>         refcount_dec(&hwpt_paging->ioas->obj.users);
>  }
>
> @@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
>         struct iommufd_hwpt_nested *hwpt_nested =
>                 container_of(obj, struct iommufd_hwpt_nested, common.obj);
>
> -       if (hwpt_nested->common.domain)
> -               iommu_domain_free(hwpt_nested->common.domain);
> -
> +       __iommufd_hwpt_destroy(&hwpt_nested->common);
>         refcount_dec(&hwpt_nested->parent->common.obj.users);
>  }
>
> @@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>         struct iommufd_hw_pagetable *hwpt;
>         int rc;
>
> -       if (flags || !user_data->len || !ops->domain_alloc_user)
> +       if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
> +           !user_data->len || !ops->domain_alloc_user)
>                 return ERR_PTR(-EOPNOTSUPP);
>         if (parent->auto_domain || !parent->nest_parent)
>                 return ERR_PTR(-EINVAL);
> @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>         refcount_inc(&parent->common.obj.users);
>         hwpt_nested->parent = parent;
>
> -       hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
> +       hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
>                                               parent->common.domain, user_data);

Why remove flags? typo or any reason?
arm_smmu_domain_alloc_user  can not get flags from the user app.
User should set IOMMU_HWPT_FAULT_ID_VALID, right?

Thanks

