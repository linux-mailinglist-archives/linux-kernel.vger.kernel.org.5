Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37957BCC90
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbjJHGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43958C6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696746062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKDLVNxVS0wQgCZnWdWwS5zdRpPBL6HalxkdKXdcEh4=;
        b=hGlhncY0mUKYoGyJFh/R8QNRxNIgbEjl7HaBd4gmPPx4QHnNCEaoHjC57AuxN3lRIafmsg
        6SaHwUqmMeG/+0aic+Ze/tMoGiMUDFgP3wk3Lo2UgE+CExTH0vrBl/R64adLvvAv168RQa
        cOsU6Q6P3IhjRycmNNJicC4wdL2PdaA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-6d9dK5idPG-jOzcJhsgUgA-1; Sun, 08 Oct 2023 02:21:00 -0400
X-MC-Unique: 6d9dK5idPG-jOzcJhsgUgA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b822f5c156so292993566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 23:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746059; x=1697350859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKDLVNxVS0wQgCZnWdWwS5zdRpPBL6HalxkdKXdcEh4=;
        b=rO5ZkFFBTL3Zc91qaq0IUM9i23sVrqs9WqujARXpjlPpq3Cah3lC5s4ludaE/TQCI1
         Q7WZKORelXpnhJmQCkR8Gn2jcbIJju4Sj3L3jBuH22J6Am14nC+nmEnQmqDf1+aV5pN/
         Kw+FZQqyDC727AOBOyrkHntDmJQtU+KHhR85qqmGaKZ63bqcVKhpN5becvoYKYKi1Jfj
         0sq35jjhowQkSefqnHC7iaffkkcViFcHK7iOWvxbNjziIDiuiBqzUEN7KRkMVSG7V69a
         gPo1XRxK7xu0gI1qpWbWX3O91zsSHJTIkfKIsr8LZd9i8bz/bmg0j1g0r3Q3jt6kcAkw
         favQ==
X-Gm-Message-State: AOJu0YybF1ZEgil0eWw6UC4D29VgHlHml/N92lmkGFFot5Okp77gDzUC
        CexsbfisaU0vzRE98w/z8pDqvABFYTR39Rt2Ch8ENJ0Fdm3eHyuHomk6REaAmLgGxDDkQDcfmT6
        wACw1IV+IF3Lhcnpw9b7TGpXFZ9lHePOb
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id b12-20020a17090630cc00b009a1c4473c62mr10678221ejb.49.1696746059018;
        Sat, 07 Oct 2023 23:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpvMnKszWWkkwnrbOuBpbfloweqFCsNJDHdJxFmnTAiCFUad0nFa5rNSeZrN5P/IlhovO8GA==
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id b12-20020a17090630cc00b009a1c4473c62mr10678213ejb.49.1696746058722;
        Sat, 07 Oct 2023 23:20:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00997cce73cc7sm5122922eja.29.2023.10.07.23.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:20:58 -0700 (PDT)
Date:   Sun, 8 Oct 2023 02:20:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008022022-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100643-tricolor-citizen-6c2d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Greg should I merge it or do you intend to merge all these patches?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index df7869537ef1..0ddd4b8abecb 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -134,7 +134,6 @@ static DEFINE_MUTEX(vduse_lock);
>  static DEFINE_IDR(vduse_idr);
>  
>  static dev_t vduse_major;
> -static struct class *vduse_class;
>  static struct cdev vduse_ctrl_cdev;
>  static struct cdev vduse_cdev;
>  static struct workqueue_struct *vduse_irq_wq;
> @@ -1528,6 +1527,16 @@ static const struct kobj_type vq_type = {
>  	.default_groups	= vq_groups,
>  };
>  
> +static char *vduse_devnode(const struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> +}
> +
> +static const struct class vduse_class = {
> +	.name = "vduse",
> +	.devnode = vduse_devnode,
> +};
> +
>  static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>  {
>  	int i;
> @@ -1638,7 +1647,7 @@ static int vduse_destroy_dev(char *name)
>  	mutex_unlock(&dev->lock);
>  
>  	vduse_dev_reset(dev);
> -	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  	idr_remove(&vduse_idr, dev->minor);
>  	kvfree(dev->config);
>  	vduse_dev_deinit_vqs(dev);
> @@ -1805,7 +1814,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  
>  	dev->minor = ret;
>  	dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> -	dev->dev = device_create_with_groups(vduse_class, NULL,
> +	dev->dev = device_create_with_groups(&vduse_class, NULL,
>  				MKDEV(MAJOR(vduse_major), dev->minor),
>  				dev, vduse_dev_groups, "%s", config->name);
>  	if (IS_ERR(dev->dev)) {
> @@ -1821,7 +1830,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  
>  	return 0;
>  err_vqs:
> -	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  err_dev:
>  	idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> @@ -1934,11 +1943,6 @@ static const struct file_operations vduse_ctrl_fops = {
>  	.llseek		= noop_llseek,
>  };
>  
> -static char *vduse_devnode(const struct device *dev, umode_t *mode)
> -{
> -	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> -}
> -
>  struct vduse_mgmt_dev {
>  	struct vdpa_mgmt_dev mgmt_dev;
>  	struct device dev;
> @@ -2082,11 +2086,9 @@ static int vduse_init(void)
>  	int ret;
>  	struct device *dev;
>  
> -	vduse_class = class_create("vduse");
> -	if (IS_ERR(vduse_class))
> -		return PTR_ERR(vduse_class);
> -
> -	vduse_class->devnode = vduse_devnode;
> +	ret = class_register(&vduse_class);
> +	if (ret)
> +		return ret;
>  
>  	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
>  	if (ret)
> @@ -2099,7 +2101,7 @@ static int vduse_init(void)
>  	if (ret)
>  		goto err_ctrl_cdev;
>  
> -	dev = device_create(vduse_class, NULL, vduse_major, NULL, "control");
> +	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
>  	if (IS_ERR(dev)) {
>  		ret = PTR_ERR(dev);
>  		goto err_device;
> @@ -2141,13 +2143,13 @@ static int vduse_init(void)
>  err_wq:
>  	cdev_del(&vduse_cdev);
>  err_cdev:
> -	device_destroy(vduse_class, vduse_major);
> +	device_destroy(&vduse_class, vduse_major);
>  err_device:
>  	cdev_del(&vduse_ctrl_cdev);
>  err_ctrl_cdev:
>  	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
>  err_chardev_region:
> -	class_destroy(vduse_class);
> +	class_unregister(&vduse_class);
>  	return ret;
>  }
>  module_init(vduse_init);
> @@ -2159,10 +2161,10 @@ static void vduse_exit(void)
>  	destroy_workqueue(vduse_irq_bound_wq);
>  	destroy_workqueue(vduse_irq_wq);
>  	cdev_del(&vduse_cdev);
> -	device_destroy(vduse_class, vduse_major);
> +	device_destroy(&vduse_class, vduse_major);
>  	cdev_del(&vduse_ctrl_cdev);
>  	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
> -	class_destroy(vduse_class);
> +	class_unregister(&vduse_class);
>  }
>  module_exit(vduse_exit);
>  
> -- 
> 2.42.0

