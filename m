Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D8784980
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjHVSnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjHVSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:43:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF290CD1;
        Tue, 22 Aug 2023 11:43:43 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id 446E12126CC3; Tue, 22 Aug 2023 11:43:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 446E12126CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692729823;
        bh=arqNRg4wGatPNmrOhmdLvrj5EQchfmRIhWqAHl91U0w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=USX9khdcae7ZtgomjbVEMycgzJuC6NfFuEMyPxCgFxapYjTRfNBYOdA2EnLzaSe1s
         De2s6IIV6D7/w9litwf5V4341STar4r5AfY0faKCZELCijvgsfoBtDqnORhQyn+7x+
         dZO+2KCaXYXAbqEQK503bglwrrytkHPdR79/3Pnk=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 416C430705C5;
        Tue, 22 Aug 2023 11:43:43 -0700 (PDT)
Date:   Tue, 22 Aug 2023 11:43:43 -0700 (PDT)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>
cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
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
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
In-Reply-To: <7c8945be-2549-ee79-fbdf-4870eca6f908@acm.org>
Message-ID: <184a97f5-1ad1-6efc-bc7b-b41fce6f2773@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com> <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <7c8945be-2549-ee79-fbdf-4870eca6f908@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart,

sorry for not replying earlier, as I am very new to NVMe/UFS spec and was 
figuring out few details about them.

> On 7/21/23 18:40, Shyam Saini wrote:
>>  +config RPMB
>>  +	tristate "RPMB partition interface"
>>  +	help
>>  +	  Unified RPMB partition interface for RPMB capable devices such as
>>  +          eMMC and UFS. Provides interface for in kernel security
>>  controllers to
>>  +	  access RPMB partition.
>>  +
>>  +	  If unsure, select N.
>
> Please also mention NVMe.

Sure,
> Please change the word "partition" into "unit" to avoid confusion with the 
> concept "LBA range partition".

sure, in next iteration

>>  +static DEFINE_IDA(rpmb_ida);
>
> How are accesses to this IDA serialized?

I will look into that.

>>  +/**
>>  + * rpmb_get_capacity() - returns the capacity of the rpmb device
>>  + * @rdev: rpmb device
>>  + *
>>  + * Return:
>>  + * *        capacity of the device in units of 128K, on success
>>  + * *        -EINVAL on wrong parameters
>>  + * *        -EOPNOTSUPP if device doesn't support the requested operation
>>  + * *        < 0 if the operation fails
>>  + */
>
> Why in units of 128 KiB?

I think UFS/eMMC RPMB spec suggests size of RPMB multiple of 128K
and NVMe spec suggests RPMB Data Area to be multiple of 128K as well.

>>  +/**
>>  + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent
>>  device
>>  + * @parent: parent device of the rpmb device
>>  + * @target: RPMB target/region within the physical device
>>  + *
>>  + * Return: NULL if there is no rpmb device associated with the parent
>>  device
>>  + */
>
> Can an NVMe controller have multiple RPMB units? From the NVMe specification: 
> "The controller may support multiple RPMB targets."

That we have to figure, I see NVMe device can have upto 7 RPMB
targets/units

> Can rpmb_dev_find_by_device() be used if multiple RPMB units are associated 
> with a single controller?

That's not finalised yet, but we some ideas from Optee folks on the other 
replies.

>>  +/**
>>  + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
>>  + * @dev: storage device of the rpmb device
>>  + * @target: RPMB target/region within the physical device
>>  + * @ops: device specific operations
>>  + *
>>  + * Return: a pointer to rpmb device
>>  + */
>>  +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
>>  +				   const struct rpmb_ops *ops)
>>  +{
>>  +	struct rpmb_dev *rdev;
>>  +	int id;
>>  +	int ret;
>>  +
>>  +	if (!dev || !ops)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->program_key)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->get_capacity)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->get_write_counter)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->write_blocks)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->read_blocks)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>>  +	if (!rdev)
>>  +		return ERR_PTR(-ENOMEM);
>>  +
>>  +	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
>>  +	if (id < 0) {
>>  +		ret = id;
>>  +		goto exit;
>>  +	}
>>  +
>>  +	mutex_init(&rdev->lock);
>>  +	rdev->ops = ops;
>>  +	rdev->id = id;
>>  +	rdev->target = target;
>>  +
>>  +	dev_set_name(&rdev->dev, "rpmb%d", id);
>>  +	rdev->dev.class = &rpmb_class;
>>  +	rdev->dev.parent = dev;
>>  +
>>  +	rpmb_cdev_prepare(rdev);
>>  +
>>  +	ret = device_register(&rdev->dev);
>>  +	if (ret)
>>  +		goto exit;
>>  +
>>  +	rpmb_cdev_add(rdev);
>>  +
>>  +	dev_dbg(&rdev->dev, "registered device\n");
>>  +
>>  +	return rdev;
>>  +
>>  +exit:
>>  +	if (id >= 0)
>>  +		ida_simple_remove(&rpmb_ida, id);
>>  +	kfree(rdev);
>>  +	return ERR_PTR(ret);
>>  +}
>
> How is user space software supposed to map an NVMe RPMB target ID to an RPMB 
> device name?

I am not sure, this driver aims to provide in kernel RPMB access APIs, 
user space support may be added later on, but i will look if the current 
RFC version has any implication on future user-space support.

>>  +MODULE_AUTHOR("Intel Corporation");
>
> Shouldn't this be the name of a person instead of the name of a company?
>

Thanks, I will address that in next iteration.

Please keep posted your reviews and feedback.

Best Regards,
Shyam
