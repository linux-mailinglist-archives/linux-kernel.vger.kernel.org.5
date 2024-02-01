Return-Path: <linux-kernel+bounces-47411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD6844DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7807C288FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692A812;
	Thu,  1 Feb 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbrgd0qG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35A37C;
	Thu,  1 Feb 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746454; cv=none; b=kzdJMc3A/yZnIzPyqi+O2QQIm+5zhXGLUuR1LVlm9Ma+LTSXOumHlMLOJonJrcQIygBvEVG2lsP/BzRKVVcvEFMKzp9DTPTZ7+e7ct0gN9toShPERcNOu9qV3fnqceFMQFoEyjAfmKoZlMS2O0N9NN4XB1C0h0S28QDkRYM3+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746454; c=relaxed/simple;
	bh=UYG+bMN6gA1Ij16eOnxlASAzV3Xla9f4HQGKMwAR6is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZ7PZY6/CT6ghbtpJaosZNSurINjBLW6jMW2sh7zNqY14pIUrKf6SvZWplcAbuZlbWCODgpP0zfHlf2apF78RxcR7OEyT+9aBYrVwAffaPrteHwjbiFYrIWgh7wScGXGgFPM11YIpA3phkyMqfpPfWvpbVn/GOam/CSHFwwCBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbrgd0qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2406AC433F1;
	Thu,  1 Feb 2024 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706746453;
	bh=UYG+bMN6gA1Ij16eOnxlASAzV3Xla9f4HQGKMwAR6is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tbrgd0qGQ82NEm2jHe0rpSSX9NBFwIaCQfe/P3IwOZW8ZYq4NJHN/ZRFwRQIvr7+I
	 sGdzVJdFfG7QiCH21lugyVCDqzf7SonMXoQsi3jq61YyWbd9RWweUHG1ssg0QnUAvC
	 peoIS3A1Y56J8pmHdCZnlmy9AvGQmG/Myq1oGnlNplYV7M4YnzGkXN1KpfDip8BZBZ
	 BK2ixEdJEgCvMylk8Ef9xHjnU0bKfsc1Vu5n/Ak7vavEDqfJkFZiKnnKJIZ2YwPs1m
	 amTu1JuwIl+M1pWqGBNGqKEOD++2B5x/KdCu3eS8xwtSxL4olZnLlYgWgIVR0Cc+fz
	 k/UPLUzb6ez+g==
Date: Wed, 31 Jan 2024 16:14:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
 <egallen@redhat.com>, <mschmidt@redhat.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jonathan Corbet" <corbet@lwn.net>,
 Veerasenareddy Burru <vburru@marvell.com>, "Satananda Burla"
 <sburla@marvell.com>, Shannon Nelson <shannon.nelson@amd.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Brett Creeley
 <brett.creeley@amd.com>, Andrew Lunn <andrew@lunn.ch>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver framework and
 device initialization
Message-ID: <20240131161406.22a9e330@kernel.org>
In-Reply-To: <20240129050254.3047778-2-srasheed@marvell.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
	<20240129050254.3047778-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 21:02:47 -0800 Shinas Rasheed wrote:
> +static int octep_vf_stop(struct net_device *netdev)
> +{
> +	struct octep_vf_device *oct = netdev_priv(netdev);
> +
> +	netdev_info(netdev, "Stopping the device ...\n");
> +
> +	/* Stop Tx from stack */
> +	netif_tx_stop_all_queues(netdev);

netif_tx_disable() stops queues, IIRC. You seem to stop them twice.

> +	netif_carrier_off(netdev);
> +	netif_tx_disable(netdev);

You haven't masked any IRQ or disabled NAPI. What prevents the queues
from getting restarted right after this call?

> +static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct octep_vf_device *oct = netdev_priv(netdev);
> +
> +	queue_work(octep_vf_wq, &oct->tx_timeout_task);
> +}

I don't see you canceling this work. What if someone unregistered
the device before it runs? You gotta netdev_hold() a reference.

> +err_register_dev:
> +err_mbox_version:
> +	octep_vf_delete_mbox(octep_vf_dev);
> +err_setup_mbox:
> +	octep_vf_device_cleanup(octep_vf_dev);
> +err_octep_vf_config:
> +	free_netdev(netdev);
> +err_alloc_netdev:
> +	pci_release_mem_regions(pdev);
> +err_pci_regions:
> +err_dma_mask:
> +	pci_disable_device(pdev);
> +	dev_err(&pdev->dev, "Device probe failed\n");
> +	return err;
> +}

Name the labels after what you're jumping to, please.
It's so much easier to make sure the code is correct that way.

> +static int __init octep_vf_init_module(void)
> +{
> +	int ret;
> +
> +	pr_info("%s: Loading %s ...\n", OCTEP_VF_DRV_NAME, OCTEP_VF_DRV_STRING);
> +
> +	/* work queue for all deferred tasks */
> +	octep_vf_wq = create_singlethread_workqueue(OCTEP_VF_DRV_NAME);

Is there a reason this wq has to be single threaded and different than
system queue? All you schedule on it in this series is the reset task.

> +	if (!octep_vf_wq) {
> +		pr_err("%s: Failed to create common workqueue\n",
> +		       OCTEP_VF_DRV_NAME);
> +		return -ENOMEM;
> +	}
> +
> +	ret = pci_register_driver(&octep_vf_driver);
> +	if (ret < 0) {
> +		pr_err("%s: Failed to register PCI driver; err=%d\n",
> +		       OCTEP_VF_DRV_NAME, ret);
> +		return ret;
> +	}
> +
> +	pr_info("%s: Loaded successfully !\n", OCTEP_VF_DRV_NAME);

One message when driver is loaded is probably fine, but two is really
pushing it. Please don't spam the logs.

> +	return ret;
> +}
-- 
pw-bot: cr

