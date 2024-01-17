Return-Path: <linux-kernel+bounces-29466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAEF830EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3381DB21443
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8025637;
	Wed, 17 Jan 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5HjRR86"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314C2561B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527267; cv=none; b=CQhPyymrYk+9yWxYLNZIz9DLeinKklXok7fcSeGz8npDhehA0uGosqKxNoFkSJCrxJ4DI0LH1Jr4cU4dN0FUdRI3Mi2Xqn8cZyAyINo7iamwiJHWAnQ8dDzxPJKepYzPs7zoSxvCgG9cEeoA1Fbi03eQ8RsLTte/RZWSQF6QxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527267; c=relaxed/simple;
	bh=yKFL3U0ucTT7ccDTPkWssK1XjF/G3m6zhD25FG7kZvk=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=TX0mdyaIQBjhJEshwcO4Pksx97Pucqfwe12ukrzufMBJBMR8nkMhP6V77ynOFzKUsaWuJMEvnHRnvFc7qC6ziHlcIopIzPS9/IWAo4D9owF03w8meVS3VAuvJRvmB/IiqyDS7AIDQx5w79deKbmyqJufoAJ0R282sCx0Jv7pwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5HjRR86; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705527264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=503l6S460toHyonsq12VcMMml/sPGb5kqwdWGMCKzPM=;
	b=Z5HjRR86V4OmWFk+igq+WFZoJjGU07b1R2qS0U3zFLActEVo1cdRvQCs8xUkfDaSpiyzXj
	aoFQTe6SuI1WQtrCv6ubMZau7pIN5doWQK6O0qIY9+piuYHtOdsUPK+O3S1Dlr9KmyjvYc
	Q576j83CTkVct5dfmX9/MImnS5jiYKA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-9P_wPstkO4qjXfJb99x1-A-1; Wed, 17 Jan 2024 16:34:22 -0500
X-MC-Unique: 9P_wPstkO4qjXfJb99x1-A-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6dde6d74d57so9876121a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705527262; x=1706132062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=503l6S460toHyonsq12VcMMml/sPGb5kqwdWGMCKzPM=;
        b=CxWD2yWPXZeKRoWA3aUS5i1BslyewMrDXF12SYhhVTq+4HZXLCk9NbBKueozeOJkAe
         HpvADYHY9DhA92uab6bHQe+ZIYmRgi1v9+QHnoFWSnjTNUfRsY8y4SI6LCQUlje9srXu
         U2sj0bE/JgGTHXl+s4PbMEcTCFXF5Ctj8UI+gZ+L6a/2PsQu89mT5d4vkGwPPrOJY0Qj
         kCEg5X8l26T0ogGP7nbtT+pCv4W8oq8yOroud8zw7ZgCRRf3RVsHZrj7EZcIkT9+VRgo
         TbcU5uO72HpidEcFv4CT2WDOeLtzr6O/0rDKFmvrV9sMPO6qO3F5DQNHXtxCZgTN5fGP
         ML7Q==
X-Gm-Message-State: AOJu0YwFSM0B44rrDCvfJwH3r4m1CXn91S9OkywZo3JpOoLStL47+DGF
	ROxNvzanLEZCxL+AP/YIovfobabsGMmu1r/+hI94bGLoOJmNzmJagP1daMBYBvDSlnitNiStiij
	RuIGN7zlJmc4ibe/w8/R+PMqa8FVIAPK1
X-Received: by 2002:a9d:5f0f:0:b0:6e0:acf2:f041 with SMTP id f15-20020a9d5f0f000000b006e0acf2f041mr8359049oti.7.1705527261843;
        Wed, 17 Jan 2024 13:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkkNhph9xnzbIqzHj5cxQhQU2TNdH9OIcZiD7SK7GKOqiaaL7d8d8JUODLQYBFoQZZywNZSQ==
X-Received: by 2002:a9d:5f0f:0:b0:6e0:acf2:f041 with SMTP id f15-20020a9d5f0f000000b006e0acf2f041mr8359027oti.7.1705527261615;
        Wed, 17 Jan 2024 13:34:21 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id g3-20020a9d6483000000b006d7eaaa65a4sm38157otl.71.2024.01.17.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:34:20 -0800 (PST)
Date: Wed, 17 Jan 2024 14:34:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <eric.auger@redhat.com>, <brett.creeley@amd.com>, <horms@kernel.org>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
 <anuaggarwal@nvidia.com>, <mochs@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16 2/3] vfio/pci: implement range_intesect_range to
 determine range overlap
Message-ID: <20240117143418.5696b00e.alex.williamson@redhat.com>
In-Reply-To: <20240115211516.635852-3-ankita@nvidia.com>
References: <20240115211516.635852-1-ankita@nvidia.com>
	<20240115211516.635852-3-ankita@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 21:15:15 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Add a helper function to determine an overlap between two ranges.
> If an overlap, the function returns the overlapping offset and size.
> 
> The VFIO PCI variant driver emulates the PCI config space BAR offset
> registers. These offset may be accessed for read/write with a variety
> of lengths including sub-word sizes from sub-word offsets. The driver
> makes use of this helper function to read/write the targeted part of
> the emulated register.
> 
> This is replicated from Yishai's work in
> https://lore.kernel.org/all/20231207102820.74820-10-yishaih@nvidia.com

The virtio-vfio-net changes have been accepted, so this will need to be
rebased on the vfio next branch or v6.8-rc1 when Linus comes back
online to process the pull request.  The revised patch should
consolidate so that virtio-vfio-pci also uses the new shared function.

As noted by Rahul, the name should be updated to align with the
vfio-pci-core namespace.  Kerneldoc would also be a nice addition since
this is a somewhat complicated helper.  Thanks,

Alex

> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Tested-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 28 ++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h      |  6 ++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 7e2e62ab0869..b77c96fbc4b2 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1966,3 +1966,31 @@ ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  
>  	return done;
>  }
> +
> +bool range_intersect_range(loff_t range1_start, size_t count1,
> +			   loff_t range2_start, size_t count2,
> +			   loff_t *start_offset,
> +			   size_t *intersect_count,
> +			   size_t *register_offset)
> +{
> +	if (range1_start <= range2_start &&
> +	    range1_start + count1 > range2_start) {
> +		*start_offset = range2_start - range1_start;
> +		*intersect_count = min_t(size_t, count2,
> +					 range1_start + count1 - range2_start);
> +		*register_offset = 0;
> +		return true;
> +	}
> +
> +	if (range1_start > range2_start &&
> +	    range1_start < range2_start + count2) {
> +		*start_offset = 0;
> +		*intersect_count = min_t(size_t, count1,
> +					 range2_start + count2 - range1_start);
> +		*register_offset = range1_start - range2_start;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(range_intersect_range);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index d478e6f1be02..8a11047ac6c9 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -133,4 +133,10 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  			       void __iomem *io, char __user *buf,
>  			       loff_t off, size_t count, size_t x_start,
>  			       size_t x_end, bool iswrite);
> +
> +bool range_intersect_range(loff_t range1_start, size_t count1,
> +			   loff_t range2_start, size_t count2,
> +			   loff_t *start_offset,
> +			   size_t *intersect_count,
> +			   size_t *register_offset);
>  #endif /* VFIO_PCI_CORE_H */


