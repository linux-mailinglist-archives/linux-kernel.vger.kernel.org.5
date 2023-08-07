Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CC7730DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHGVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHGVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:02:24 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137710FF;
        Mon,  7 Aug 2023 14:02:21 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso32024815ad.2;
        Mon, 07 Aug 2023 14:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442141; x=1692046941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4TsMm2M6+p2Ae4GV6s1bQ264mBlKjFh+NTJb4KrZa0=;
        b=Tp3YqnnupVFieGQecJQ8K+ngp1uSUMSvNfXymCiXEVV3j4pOcXLUTrhy1A9xiwj+uf
         TwWZMFSVNIE+Cmmk3QUxleBLY6OVE2115RGyV0sOVdhx06f/UzTDPWFeKrlTKg33Uh7e
         IZKAo1IJcm4m5zSBNG3Qa/0SwghGn/zoIB4GVl3uk+hAWkuHw/+b7UBHLty2w8JclvFS
         rW623Dstz6f/yhGUDfMUOZU/VDiGbKVRuRoq8NGG7p9t1gr/SZ4XGxQ3X/1BUdvGqZPY
         dkUMxYp0hC8tIgHqtVxY4ROdwWcbxSHpo+nq0dbf7G4k+B3zOXLi1d8ByRDTy15Zg821
         rJGg==
X-Gm-Message-State: AOJu0Yw3MkxYcVCWMwoISWEao2klvsjW5MMhTbW8sEMv6noMtw9Xb/8P
        7By6Bkx2gmVEw4D2WBoKAlE=
X-Google-Smtp-Source: AGHT+IHlEPhVGdTO53KNTBE5DZUnn2qohUMKtw2SH1yp2hFE6JfkUV+67ka1RBq5XYtamaCpQHQX4Q==
X-Received: by 2002:a17:902:ea0d:b0:1bb:b30e:4364 with SMTP id s13-20020a170902ea0d00b001bbb30e4364mr10713334plg.39.1691442141018;
        Mon, 07 Aug 2023 14:02:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3aca:8f43:1895:4b6c? ([2620:15c:211:201:3aca:8f43:1895:4b6c])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001bc676df6a9sm3499656plb.132.2023.08.07.14.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 14:02:20 -0700 (PDT)
Message-ID: <7c8945be-2549-ee79-fbdf-4870eca6f908@acm.org>
Date:   Mon, 7 Aug 2023 14:02:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
Content-Language: en-US
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-scsi@vger.kernel.org,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 18:40, Shyam Saini wrote:
> +config RPMB
> +	tristate "RPMB partition interface"
> +	help
> +	  Unified RPMB partition interface for RPMB capable devices such as
> +          eMMC and UFS. Provides interface for in kernel security controllers to
> +	  access RPMB partition.
> +
> +	  If unsure, select N.

Please also mention NVMe.

Please change the word "partition" into "unit" to avoid confusion with 
the concept "LBA range partition".

> +static DEFINE_IDA(rpmb_ida);

How are accesses to this IDA serialized?

> +/**
> + * rpmb_get_capacity() - returns the capacity of the rpmb device
> + * @rdev: rpmb device
> + *
> + * Return:
> + * *        capacity of the device in units of 128K, on success
> + * *        -EINVAL on wrong parameters
> + * *        -EOPNOTSUPP if device doesn't support the requested operation
> + * *        < 0 if the operation fails
> + */

Why in units of 128 KiB?

> +/**
> + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
> + * @parent: parent device of the rpmb device
> + * @target: RPMB target/region within the physical device
> + *
> + * Return: NULL if there is no rpmb device associated with the parent device
> + */

Can an NVMe controller have multiple RPMB units? From the NVMe 
specification: "The controller may support multiple RPMB targets."

Can rpmb_dev_find_by_device() be used if multiple RPMB units are 
associated with a single controller?

> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @target: RPMB target/region within the physical device
> + * @ops: device specific operations
> + *
> + * Return: a pointer to rpmb device
> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
> +				   const struct rpmb_ops *ops)
> +{
> +	struct rpmb_dev *rdev;
> +	int id;
> +	int ret;
> +
> +	if (!dev || !ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->program_key)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->get_capacity)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->get_write_counter)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->write_blocks)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->read_blocks)
> +		return ERR_PTR(-EINVAL);
> +
> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto exit;
> +	}
> +
> +	mutex_init(&rdev->lock);
> +	rdev->ops = ops;
> +	rdev->id = id;
> +	rdev->target = target;
> +
> +	dev_set_name(&rdev->dev, "rpmb%d", id);
> +	rdev->dev.class = &rpmb_class;
> +	rdev->dev.parent = dev;
> +
> +	rpmb_cdev_prepare(rdev);
> +
> +	ret = device_register(&rdev->dev);
> +	if (ret)
> +		goto exit;
> +
> +	rpmb_cdev_add(rdev);
> +
> +	dev_dbg(&rdev->dev, "registered device\n");
> +
> +	return rdev;
> +
> +exit:
> +	if (id >= 0)
> +		ida_simple_remove(&rpmb_ida, id);
> +	kfree(rdev);
> +	return ERR_PTR(ret);
> +}

How is user space software supposed to map an NVMe RPMB target ID to an 
RPMB device name?

> +MODULE_AUTHOR("Intel Corporation");

Shouldn't this be the name of a person instead of the name of a company?

Thanks,

Bart.
