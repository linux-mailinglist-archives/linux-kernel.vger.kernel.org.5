Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB87C40D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjJJUIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjJJUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:08:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E113D48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:06:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qJ09qs5Gi0onIqJ09qavla; Tue, 10 Oct 2023 22:06:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696968413;
        bh=ztbpBpO2pXmGy4HQ32tzm/CpMzlQbXI1hy8IyrK/n2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SPUlWyBvKqDK5IXiYbEseSMc5bZ78JTJuP/3JYAN6kwTDalaKQq4RbAKvOSEP0ueG
         KZxRObMFwix3Xf+jZ3w6VRuRShlVOx4/iTUSMZcw0PtP2dCNERJSUkxbwPPn4H+uTL
         ibFj96ORVcJNvPeP/AI/vB63FYkCwlFbeN+uLgjFXnYt3WFKwWG+LX6uSfjR0KL7+h
         qPBHF9qPj7wvHJDS9r9UAN+Dsd5ybCXigG4zO2P1smcpA1um1ztKJszRAF9t5tUlzk
         GTHF4g1fValeq1TUaiY+XyMeGLhYItsBXp+r1OQzs3RaumwAyQhDJngKJPZjJYEPmt
         P0ZSvCkVcTmnA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Oct 2023 22:06:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7792f0ce-b6b4-4b20-9725-1792a888297f@wanadoo.fr>
Date:   Tue, 10 Oct 2023 22:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] misc: Add Nitro Secure Module driver
Content-Language: fr
To:     Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20231010191815.13641-1-graf@amazon.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231010191815.13641-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/10/2023 à 21:18, Alexander Graf a écrit :
> When running Linux inside a Nitro Enclave, the hypervisor provides a
> special virtio device called "Nitro Security Module" (NSM). This device
> has 3 main functions:
> 
>    1) Provide attestation reports
>    2) Modify PCR state
>    3) Provide entropy
> 
> This patch adds a driver for NSM that exposes a /dev/nsm device node which
> user space can issue an ioctl on this device with raw NSM CBOR formatted
> commands to request attestation documents, influence PCR states, read
> entropy and enumerate status of the device. In addition, the driver
> implements a hwrng backend.
> 
> Originally-by: Petre Eftime <petre.eftime@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---

...

> +static int nsm_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +{
> +	struct nsm *nsm = hwrng_to_nsm(rng);
> +	struct device *dev = &nsm->vdev->dev;
> +	struct nsm_msg *msg;
> +	int rc = 0;
> +
> +	/* NSM always needs to wait for a response */
> +	if (!wait)
> +		return 0;
> +
> +	msg = devm_kzalloc(dev, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;

Why use devm_ here? It is freed in all cases...

> +
> +	rc = fill_req_get_random(nsm, &msg->req);
> +	if (rc != 0)
> +		goto out;
> +
> +	rc = nsm_sendrecv_msg(nsm, msg);
> +	if (rc != 0)
> +		goto out;
> +
> +	rc = parse_resp_get_random(nsm, &msg->resp, data, max);
> +	if (rc < 0)
> +		goto out;
> +
> +	dev_dbg(dev, "RNG: returning rand bytes = %d", rc);
> +out:
> +	devm_kfree(dev, msg);

..., so kfree would be just fine as well.

> +	return rc;
> +}
> +
> +static long nsm_dev_ioctl(struct file *file, unsigned int cmd,
> +	unsigned long arg)
> +{
> +	void __user *argp = u64_to_user_ptr((u64)arg);
> +	struct nsm *nsm = file_to_nsm(file);
> +	struct device *dev = &nsm->vdev->dev;
> +	struct nsm_msg *msg;
> +	struct nsm_raw raw;
> +	int r = 0;
> +
> +	if (cmd != NSM_IOCTL_RAW)
> +		return -EINVAL;
> +
> +	if (_IOC_SIZE(cmd) != sizeof(raw))
> +		return -EINVAL;
> +
> +	/* Allocate message buffers to device */
> +	r = -ENOMEM;
> +	msg = devm_kzalloc(dev, sizeof(*msg), GFP_KERNEL);

Why use devm_ here? It is freed in all cases...

> +	if (!msg)
> +		goto out;
> +
> +	/* Copy user argument struct to kernel argument struct */
> +	r = -EFAULT;
> +	if (copy_from_user(&raw, argp, _IOC_SIZE(cmd)))
> +		goto out;
> +
> +	/* Convert kernel argument struct to device request */
> +	r = fill_req_raw(nsm, &msg->req, &raw);
> +	if (r)
> +		goto out;
> +
> +	/* Send message to NSM and read reply */
> +	r = nsm_sendrecv_msg(nsm, msg);
> +	if (r)
> +		goto out;
> +
> +	/* Parse device response into kernel argument struct */
> +	r = parse_resp_raw(nsm, &msg->resp, &raw);
> +	if (r)
> +		goto out;
> +
> +	/* Copy kernel argument struct back to user argument struct */
> +	r = -EFAULT;
> +	if (copy_to_user(argp, &raw, sizeof(raw)))
> +		goto out;
> +
> +	r = 0;
> +
> +out:
> +	devm_kfree(dev, msg);

..., so kfree would be just fine as well.

> +	return r;
> +}

...

> +/* Handler for probing the NSM device */
> +static int nsm_device_probe(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct nsm *nsm;
> +	int rc;
> +
> +	nsm = devm_kzalloc(&vdev->dev, sizeof(*nsm), GFP_KERNEL);
> +	if (!nsm)
> +		return -ENOMEM;
> +
> +	vdev->priv = nsm;
> +	nsm->vdev = vdev;
> +
> +	rc = nsm_device_init_vq(vdev);
> +	if (rc) {
> +		dev_err(dev, "queue failed to initialize: %d.\n", rc);
> +		goto err_init_vq;
> +	}
> +
> +	mutex_init(&nsm->lock);
> +	init_waitqueue_head(&nsm->wq);
> +
> +	/* Register as hwrng provider */
> +	nsm->hwrng = (struct hwrng) {
> +		.read = nsm_rng_read,
> +		.name = "nsm-hwrng",
> +		.quality = 1000,
> +	};
> +
> +	rc = devm_hwrng_register(&vdev->dev, &nsm->hwrng);
> +	if (rc) {
> +		dev_err(dev, "RNG initialization error: %d.\n", rc);
> +		goto err_hwrng;
> +	}
> +
> +	/* Register /dev/nsm device node */
> +	nsm->misc = (struct miscdevice) {
> +		.minor	= MISC_DYNAMIC_MINOR,
> +		.name	= "nsm",
> +		.fops	= &nsm_dev_fops,
> +		.mode	= 0666,
> +	};
> +
> +	rc = misc_register(&nsm->misc);
> +	if (rc) {
> +		dev_err(dev, "misc device registration error: %d.\n", rc);
> +		goto err_misc;
> +	}
> +
> +	return 0;
> +
> +err_misc:
> +	hwrng_unregister(&nsm->hwrng);

Is it needed? devm_hwrng_register() is used.

> +err_hwrng:
> +	vdev->config->del_vqs(vdev);
> +err_init_vq:
> +	kfree(nsm);

'nsm' is devm_kzalloc()'ed, so this is a double free.

> +	return rc;
> +}
> +
> +/* Handler for removing the NSM device */
> +static void nsm_device_remove(struct virtio_device *vdev)
> +{
> +	struct nsm *nsm = vdev->priv;
> +
> +	hwrng_unregister(&nsm->hwrng);

Is it needed? devm_hwrng_register() is used.

> +
> +	vdev->config->del_vqs(vdev);
> +	misc_deregister(&nsm->misc);
> +	list_del(&nsm->node);

When is it list_add()'ed?
The 'node' field seems unused.

CJ

> +}

...

