Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078DF77EDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbjHPXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347189AbjHPXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:32:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AAE12720;
        Wed, 16 Aug 2023 16:32:00 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id 32840211F61A; Wed, 16 Aug 2023 16:31:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32840211F61A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692228719;
        bh=J6mAVcuDUUkGCq7a0/n68XNrg34IWu48uqF8U0WpAm0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UAHmt4NDP8ojpDlHQ7mmfTrBhz6yBDALkfRASJl8rpxed90SBL69nHszacBg/ijpD
         +3t4AODe3l90DjlPAMRZIM1J8sHzttOHyMRb+ZBcNobzelIn2ll8NU26zPrwK0UfUb
         Oh8xeqwChGFhBkCGk3AF8bWMPEqMUJDD1i7Bzf8o=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 2C00230705BA;
        Wed, 16 Aug 2023 16:31:59 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:31:59 -0700 (PDT)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
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
In-Reply-To: <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
Message-ID: <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com> <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-1707973189-1692228719=:10222"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-1707973189-1692228719=:10222
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Ulf,

> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> <shyamsaini@linux.microsoft.com> wrote:
>>
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>> originally proposed by [2]Thomas Winkler ]
>>
>> A number of storage technologies support a specialised hardware
>> partition designed to be resistant to replay attacks. The underlying
>> HW protocols differ but the operations are common. The RPMB partition
>> cannot be accessed via standard block layer, but by a set of specific
>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>> partition provides authenticated and replay protected access, hence
>> suitable as a secure storage.
>>
>> The initial aim of this patch is to provide a simple RPMB Driver which
>> can be accessed by Linux's optee driver to facilitate fast-path for
>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>
>> A TEE device driver can claim the RPMB interface, for example, via
>> class_interface_register(). The RPMB driver provides a series of
>> operations for interacting with the device.
>
> I don't quite follow this. More exactly, how will the TEE driver know
> what RPMB device it should use?

I don't have complete code to for this yet, but i think OP-TEE driver
should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
specific implementation for RPMB operations.

Linux optee driver can handle RPMB frames and pass it to RPMB subsystem

[1] U-Boot has mmc specific implementation

I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
CFG_RPMB_FS_DEV_ID=1 for /dev/mmcblk1rpmb, but in case if a
system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
should be declared as secure storage and optee should access that one 
only.

Sumit, do you have suggestions for this ?


>>
>>   * program_key - a one time operation for setting up a new device
>>   * get_capacity - introspect the device capacity
>>   * get_write_counter - check the write counter
>>   * write_blocks - write a series of blocks to the RPMB device
>>   * read_blocks - read a series of blocks from the RPMB device
>>
>> The detailed operation of implementing the access is left to the TEE
>> device driver itself.
>>
>> The framing details and HW specific bits (JDEC vs NVME frames) are
>> left to the lower level TEE driver to worry about.
>>
>> Without kernel fast path to RPMB access doesn't work when IMA try to
>> extend ftpm's PCR registers.
>>
>> This fast-path would require additional work in linux optee driver and
>> as well as in MMC driver.
>>
>> [1] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
>> [2] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
>> [3] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
>>
>
> [...]
>
>> +/**
>> + * rpmb_dev_find_device() - return first matching rpmb device
>> + * @data: data for the match function
>> + * @match: the matching function
>> + *
>> + * Return: matching rpmb device or NULL on failure
>> + */
>> +static
>> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
>> +                                     int (*match)(struct device *dev,
>> +                                                  const void *data))
>> +{
>> +       struct device *dev;
>> +
>> +       dev = class_find_device(&rpmb_class, NULL, data, match);
>> +
>> +       return dev ? to_rpmb_dev(dev) : NULL;
>> +}
>> +
>> +struct device_with_target {
>> +       const struct device *dev;
>> +       u8 target;
>> +};
>> +
>> +static int match_by_parent(struct device *dev, const void *data)
>> +{
>> +       const struct device_with_target *d = data;
>> +       struct rpmb_dev *rdev = to_rpmb_dev(dev);
>> +
>> +       return (d->dev && dev->parent == d->dev && rdev->target == d->target);
>> +}
>> +
>> +/**
>> + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
>> + * @parent: parent device of the rpmb device
>> + * @target: RPMB target/region within the physical device
>> + *
>> + * Return: NULL if there is no rpmb device associated with the parent device
>> + */
>> +struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target)
>> +{
>> +       struct device_with_target t;
>> +
>> +       if (!parent)
>> +               return NULL;
>> +
>> +       t.dev = parent;
>> +       t.target = target;
>> +
>> +       return rpmb_dev_find_device(&t, match_by_parent);
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_find_by_device);
>
> Is this what the TEE driver would be calling to find the rpmb device/partition?

yes, that's the idea.

>> +
>> +/**
>> + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
>> + * @rdev: the rpmb device to unregister
>> + * Return:
>> + * *        0 on success
>> + * *        -EINVAL on wrong parameters
>> + */
>> +int rpmb_dev_unregister(struct rpmb_dev *rdev)
>> +{
>> +       if (!rdev)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&rdev->lock);
>> +       rpmb_cdev_del(rdev);
>
> I can't find the function above. I guess it should be included as a
> part of the patch too?

Sorry for the confusion, this is leftover from original version
Will be removed in next iteration.

>> +       device_del(&rdev->dev);
>> +       mutex_unlock(&rdev->lock);
>> +
>> +       rpmb_dev_put(rdev);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
>
> [...]
>
>> +/**
>> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
>> + * @dev: storage device of the rpmb device
>> + * @target: RPMB target/region within the physical device
>> + * @ops: device specific operations
>> + *
>> + * Return: a pointer to rpmb device
>> + */
>> +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
>> +                                  const struct rpmb_ops *ops)
>> +{
>> +       struct rpmb_dev *rdev;
>> +       int id;
>> +       int ret;
>> +
>> +       if (!dev || !ops)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->program_key)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->get_capacity)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->get_write_counter)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->write_blocks)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->read_blocks)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>> +       if (!rdev)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
>> +       if (id < 0) {
>> +               ret = id;
>> +               goto exit;
>> +       }
>> +
>> +       mutex_init(&rdev->lock);
>> +       rdev->ops = ops;
>> +       rdev->id = id;
>> +       rdev->target = target;
>> +
>> +       dev_set_name(&rdev->dev, "rpmb%d", id);
>> +       rdev->dev.class = &rpmb_class;
>> +       rdev->dev.parent = dev;
>> +
>> +       rpmb_cdev_prepare(rdev);
>
> Ditto.

same as my last comment
>> +
>> +       ret = device_register(&rdev->dev);
>> +       if (ret)
>> +               goto exit;
>> +
>> +       rpmb_cdev_add(rdev);
>
> Ditto.

same as above.

>> +
>> +       dev_dbg(&rdev->dev, "registered device\n");
>> +
>> +       return rdev;
>> +
>> +exit:
>> +       if (id >= 0)
>> +               ida_simple_remove(&rpmb_ida, id);
>> +       kfree(rdev);
>> +       return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_register);
>> +
>
> [...]
>


[1] https://source.denx.de/u-boot/u-boot/-/commit/4853ad3e13e21462a86e09caee4ea27ae68e764b

Best Regards,
Shyam
--656392-1707973189-1692228719=:10222--
