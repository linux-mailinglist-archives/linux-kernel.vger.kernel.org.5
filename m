Return-Path: <linux-kernel+bounces-53031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B0A849FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD782850D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69644C6F;
	Mon,  5 Feb 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfcYOYvS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F340BF2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151418; cv=none; b=C+CLNZIUA3hMc6Dt5kWaZ3tsINORKC0ZGZOF9aF3b3PiBNBsSj+ZlmMTnDoZKyW8GKRhIf2h2sUU02SOkewyOJuo03bqkZ6V5qhi8j0hYEMaMlwlMt+T7ihGlT6czPElPraqzuJtJiryger7L88Glrkeg/r8eWyTYhAsLKdnOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151418; c=relaxed/simple;
	bh=U/7TW3OSEZ6qhrwVPvN+Z5zX92htnPgIigRf5YEJMiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDGSb2DfI8M8iCHUbf335oxzPu/n/5R89jKHYHYQhOgLb07W0v/KaF1CSNBdQc257NLkEymJuFJIND8A6i4nGwwaFFOYRbFJymewwgqhhEAzYaitJTV0nzSy/Ev0Xi+FXuK7WRv56PUV9ULTVYTg4wFs7KigM0LJS1aH45sok5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfcYOYvS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707151415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eXP+XOU0IwSKfk9/shij3ieifTghjGjp9NYVzTL26w=;
	b=QfcYOYvSjRYLsLz/s87UjQoVBW+KqeiZ6IhJXhX5WIQVjxhKsS3IHI/lZCBuCgmOD2xFU3
	V1V8DNjbDB5xE9YGLe+hM1oolNiSRNsHF5DsPPIueHmkzxdfN7CzWUq1qPe0aiNFQAV6TM
	VXAarZnZZPUEiEsj0uBKdEzVVHxbVDo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-7EUMOe_ANmeO79CSj6r2Sw-1; Mon, 05 Feb 2024 11:43:33 -0500
X-MC-Unique: 7EUMOe_ANmeO79CSj6r2Sw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf863c324dso309965039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151413; x=1707756213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eXP+XOU0IwSKfk9/shij3ieifTghjGjp9NYVzTL26w=;
        b=s0em/8Fw2jfLxTQWJQ6sfpHq34npQatermZrvl6B1KYvbx46rKKJVbxnOFKTW88zlg
         dyhKKECxe2TrvG77DMPWxag2UaSNNka5PvSEIiy1oMcsUfBm/GoccxHC0hy6xEdetS+M
         iQwr70D2Gx+2eQ9lSZr1V/17TvKkddNfbuqBKLd7o9NMgJKlGcDQb62XP3Yk7UtbF5D2
         Bkfb9yLRw/rvoPtAUThb+Kqy8vyPH9JHM1f8AQo9gaLPv2oFtZwv4PdozdEi6ZIudwdP
         OjXi6MoFlgsSEGU/wexW46iVR/eklrBr2wp4S4vX0BBPlQB+hwYTbtPyxNnIAOh7IYfL
         T/Pg==
X-Gm-Message-State: AOJu0YzxU/PdZ6cXFJsRH16QplOlet999Gm5U6QKZrl1ZDba3uBpSYgr
	xF37abFy8PptPVa4LkyPfuY4L7O67108P+t1+Y5AfwaDU+WrX/bxrDaKwrb9mMz/NaA8OfytyXW
	CR1/u/udN4HemR4+OSUaOF3iLzSEWNblCT7NiZWBpFJ73cMBPLHNlS8uJGujc9A==
X-Received: by 2002:a05:6e02:164e:b0:360:628e:659f with SMTP id v14-20020a056e02164e00b00360628e659fmr200862ilu.5.1707151413050;
        Mon, 05 Feb 2024 08:43:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtaN4sEtvX2yaCb3cjEWCzbhiFSIYee5cINdZg+zrkrji5H3Ahcz7txIlReM70s7z7FBdE2g==
X-Received: by 2002:a05:6e02:164e:b0:360:628e:659f with SMTP id v14-20020a056e02164e00b00360628e659fmr200841ilu.5.1707151412753;
        Mon, 05 Feb 2024 08:43:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU9nO84Ymt1SJKhzCuTL1objeZ5SSsE27RlJtvPYNi8r42f5mWWmIrH7Zn1RORfSf3iRjRG0nVdtbSdQV2aZkDLX91MB+PO7viz93UWxdXlN+MR6yyWU2BfxH1kyh3r1CppHdrXdbMzwqmnUYwyZe2ePeQBEw3iTWZNHIWSt/CCCId4cmjIcUAhyLhd74ujVHh1MNm84xYNdlCIP5okWpTEtJ5suECt02cKBKxITe8sQ26Snldjn31xRJVWYssCIewwB6l23QD5m4cFoyDJHIBLkBvw23emfyWQRjL2dz8J77lcbt0pE8A9QDgMfzTfNQk+IZh/FHYS
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id g19-20020a056638061300b004713ae4c62asm34884jar.46.2024.02.05.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:43:32 -0800 (PST)
Date: Mon, 5 Feb 2024 09:43:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Emily Deng <Emily.Deng@amd.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <Jerry.Jiang@amd.com>, <Andy.Zhang@amd.com>, <HaiJun.Chang@amd.com>,
 <Monk.Liu@amd.com>, <Horace.Chen@amd.com>, <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH 1/2] PCI: Add VF reset notification to PF's VFIO user
 mode driver
Message-ID: <20240205094330.59ca4c0a.alex.williamson@redhat.com>
In-Reply-To: <20240205071538.2665628-1-Emily.Deng@amd.com>
References: <20240205071538.2665628-1-Emily.Deng@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 15:15:37 +0800
Emily Deng <Emily.Deng@amd.com> wrote:

> VF doesn't have the ability to reset itself completely which will cause the
> hardware in unstable state. So notify PF driver when the VF has been reset
> to let the PF resets the VF completely, and remove the VF out of schedule.
> 
> How to implement this?
> Add the reset callback function in pci_driver
> 
> Implement the callback functin in VFIO_PCI driver.
> 
> Add the VF RESET IRQ for user mode driver to let the user mode driver
> know the VF has been reset.

The solution that already exists for this sort of issue is a vfio-pci
variant driver for the VF which communicates with an in-kernel PF
driver to coordinate the VF FLR with the PF driver.  This can be done
by intercepting the userspace access to the VF FLR config space region.

This solution of involving PCI-core and extending the vfio-pci interface
only exists for userspace PF drivers.  I don't see that facilitating
vendors to implement their PF drivers in userspace to avoid upstreaming
is a compelling reason to extend the vfio-pci interface.  Thanks,

Alex
 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/pci/pci.c   | 8 ++++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..aca937b05531 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4780,6 +4780,14 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *pf_dev;
> +
> +	if (dev->is_virtfn) {
> +		pf_dev = dev->physfn;
> +		if (pf_dev->driver->sriov_vf_reset_notification)
> +			pf_dev->driver->sriov_vf_reset_notification(pf_dev, dev);
> +	}
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..4fa31d9b0aa7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -926,6 +926,7 @@ struct pci_driver {
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> +	void  (*sriov_vf_reset_notification)(struct pci_dev *pf, struct pci_dev *vf);
>  	const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;


