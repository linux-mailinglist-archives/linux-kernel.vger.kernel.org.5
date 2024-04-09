Return-Path: <linux-kernel+bounces-136606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E689D615
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723B21C21907
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCFE839E6;
	Tue,  9 Apr 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fVvPcU0Z"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6882D9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656616; cv=none; b=JSWSMV8AnGb0VKc0Ya8sGJQZPmV0iD6ysBAA3PPkU0FMS7ajUoXVdRD68P1PPQm5HncDG044krYCNUUxWZW3w8C66YG8LQuRfxKORBYXAQU8bdXGFbBEYpEkkKzglEbhC56p2Cbw8SxsYXxwQu9Hz/qzWu5VcTfo+yRNn+YVQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656616; c=relaxed/simple;
	bh=23riWL0Gd60rPfm/N+Bksf6fpUnyFPCyw8iYZCSbqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXrjRVu8FFDLX8kBK//yqsVoRk4MCMyKtKxPubHkvDegkl4rPeEDFYyPNRywvpJv5xM5t+yBZcpKCm+CXEL42cPunRiEm3dk5WBuuxuJ7wni0a2cumVWUflvyOv4aCwPRzuuGvfuDjC9lLOxQHv5iuZoLI8TulcsigME/XUYSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fVvPcU0Z; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712656605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OQGIdks+efdOpe57pVeyT82POjXjytrYc+w+BN9nedU=;
	b=fVvPcU0ZviY6wU5aXzWT4UeS8viYIYGU0mWzvHF1X2n/f+bF8S+ISZm9gb4wyjzelg4JNjFUVE9oL1sqfa4Hfz6OA2ljl8pKzEwjjjX3T0XR34feP9awzBgwYvyS3az+nb+XCI3nXLxvRRRTqrnQSlUrCcCJVOxDa2b5SS9VuHc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4E4QQU_1712656603;
Received: from 30.221.146.5(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4E4QQU_1712656603)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 17:56:44 +0800
Message-ID: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
Date: Tue, 9 Apr 2024 17:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vp_vdpa: don't allocate unused msix vectors
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: angus.chen@jaguarmicro.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20240409013020-mutt-send-email-mst@kernel.org>
 <20240409085818.1242-1-yuxue.liu@jaguarmicro.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240409085818.1242-1-yuxue.liu@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/9 下午4:58, lyx634449800 写道:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware msi or msix resources as well as system
> IRQ resources.
>
> When conducting performance testing using testpmd in the
> guest os, it was found that the performance was lower compared
> to directly using vfio-pci to passthrough the device
>
> In scenarios where the virtio device in the guest os does
> not utilize interrupts, the vdpa driver still configures
> the hardware's msix vector. Therefore, the hardware still
> sends interrupts to the host os. Because of this unnecessary
> action by the hardware, hardware performance decreases, and
> it also affects the performance of the host os.
>
> Before modification:(interrupt mode)
>   32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>   33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>   34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>   35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(interrupt mode)
>   32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
>   33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
>   34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
>
> Before modification:(virtio pmd mode for guest os)
>   32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>   33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>   34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>   35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(virtio pmd mode for guest os)
>   32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
>
> To verify the use of the virtio PMD mode in the guest operating
> system, the following patch needs to be applied to QEMU:
> https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.com
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> V4: Update the title and assign values to uninitialized variables
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
>
>   drivers/vdpa/virtio_pci/vp_vdpa.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index df5f4a3bccb5..74bc8adfc7e8 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,7 +160,14 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>   	struct pci_dev *pdev = mdev->pci_dev;
>   	int i, ret, irq;
>   	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int vectors = 0;
> +	int msix_vec = 0;
> +
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback)
> +			vectors++;
> +	}
> +	vectors++;
>   
>   	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>   	if (ret != vectors) {
> @@ -173,9 +180,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>   	vp_vdpa->vectors = vectors;
>   
>   	for (i = 0; i < queues; i++) {
> +		if (!vp_vdpa->vring[i].cb.callback)
> +			continue;
> +
>   		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>   			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -		irq = pci_irq_vector(pdev, i);
> +		irq = pci_irq_vector(pdev, msix_vec);
>   		ret = devm_request_irq(&pdev->dev, irq,
>   				       vp_vdpa_vq_handler,
>   				       0, vp_vdpa->vring[i].msix_name,
> @@ -185,21 +195,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>   				"vp_vdpa: fail to request irq for vq %d\n", i);
>   			goto err;
>   		}
> -		vp_modern_queue_vector(mdev, i, i);
> +		vp_modern_queue_vector(mdev, i, msix_vec);
>   		vp_vdpa->vring[i].irq = irq;
> +		msix_vec++;
>   	}
>   
>   	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
>   		 pci_name(pdev));
> -	irq = pci_irq_vector(pdev, queues);
> +	irq = pci_irq_vector(pdev, msix_vec);
>   	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>   			       vp_vdpa->msix_name, vp_vdpa);
>   	if (ret) {
>   		dev_err(&pdev->dev,
> -			"vp_vdpa: fail to request irq for vq %d\n", i);
> +			"vp_vdpa: fail to request irq for config, ret %d\n", ret);
>   			goto err;
>   	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>   	vp_vdpa->config_irq = irq;
>   
>   	return 0;

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

