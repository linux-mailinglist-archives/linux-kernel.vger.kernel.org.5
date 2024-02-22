Return-Path: <linux-kernel+bounces-76866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C543D85FDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5343B2BF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB65150996;
	Thu, 22 Feb 2024 16:20:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9ED14C5AB;
	Thu, 22 Feb 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618841; cv=none; b=oRKgwCg2inBma8LL4UWDu/z3ZpDPgipg/53j8ouvozf9E6SBkZmwLfGLg872DX6SMg+y8IhBD7FOwt9HJWLPBps4I3XKrF4GgM8d4f7lU7Cwx2cZPd5B5XakP0vREKVvD+CNmyeeX/VPpQePeirvYBOevh4enI9LFFG/iZMvY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618841; c=relaxed/simple;
	bh=UdFFYeFEOQVobcAFYsC55L06VIgirSJdLSfyANEWoNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fESDhasxUCtM9gz3RxJM6A0Wj/iGLwYX/qYUNyhgm7wYQf0PB3cJVkjOi4vtlI4tAF2olClVpJCy7gE24mQZVEM85cN1iA52S0GaZdmwRhU9E32azULYuKuaCxlSN7X+MEdKVWIuCHhoYfOMJsckvpWuv8+tuu2QEKGp1f/ItYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E41E3DA7;
	Thu, 22 Feb 2024 08:21:15 -0800 (PST)
Received: from [10.57.12.193] (unknown [10.57.12.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51A53F762;
	Thu, 22 Feb 2024 08:20:35 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jens.wiklander@linaro.org, sumit.garg@linaro.org, corbet@lwn.net,
 sudeep.holla@arm.com, gyorgy.szing@arm.com
Subject: Re: [PATCH 2/3] tee: tstee: Add Trusted Services TEE driver
Date: Thu, 22 Feb 2024 17:20:33 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <D4EFA956-1E7B-4DDD-AC0A-D2F3217D46F0@arm.com>
In-Reply-To: <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
References: <20240213145239.379875-1-balint.dobszay@arm.com>
 <20240213145239.379875-3-balint.dobszay@arm.com>
 <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Krzysztof,

Thanks for the feedback.

On 15 Feb 2024, at 9:59, Krzysztof Kozlowski wrote:

> On 13/02/2024 15:52, Balint Dobszay wrote:
>> The Trusted Services project provides a framework for developing and
>> deploying device Root of Trust services in FF-A Secure Partitions. The
>> FF-A SPs are accessible through the FF-A driver, but this doesn't
>> provide a user space interface. The goal of this TEE driver is to make
>> Trusted Services SPs accessible for user space clients.
>>
>> All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
>> by TS. A TS SP can host one or more services, a service is identified by
>> its service UUID. The same type of service cannot be present twice in
>> the same SP. During SP boot each service in an SP is assigned an
>> interface ID, this is just a short ID to simplify message addressing.
>> There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TEE
>> device is registered for each TS SP. This is required since contrary to
>> the generic TEE design where memory is shared with the whole TEE
>> implementation, in case of FF-A, memory is shared with a specific SP. A
>> user space client has to be able to separately share memory with each SP
>> based on its endpoint ID.
>>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>
>
>> +static int tstee_probe(struct ffa_device *ffa_dev)
>> +{
>> +	struct tstee *tstee;
>> +	int rc;
>> +
>> +	ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
>> +
>> +	if (!tstee_check_rpc_compatible(ffa_dev))
>> +		return -EINVAL;
>> +
>> +	tstee = kzalloc(sizeof(*tstee), GFP_KERNEL);
>> +	if (!tstee)
>> +		return -ENOMEM;
>> +
>> +	tstee->ffa_dev = ffa_dev;
>> +
>> +	tstee->pool = tstee_create_shm_pool();
>> +	if (IS_ERR(tstee->pool)) {
>> +		rc = PTR_ERR(tstee->pool);
>> +		tstee->pool = NULL;
>> +		goto err;
>
> Is it logically correct to call here tee_device_unregister()?

As Jens mentioned it doesn't cause any issues. But I see you point, it's
not logically correct. I'll refactor this.

>> +	}
>> +
>> +	tstee->teedev = tee_device_alloc(&tstee_desc, NULL, tstee->pool, tstee);
>> +	if (IS_ERR(tstee->teedev)) {
>> +		rc = PTR_ERR(tstee->teedev);
>> +		tstee->teedev = NULL;
>> +		goto err;
>> +	}
>> +
>> +	rc = tee_device_register(tstee->teedev);
>> +	if (rc)
>> +		goto err;
>> +
>> +	ffa_dev_set_drvdata(ffa_dev, tstee);
>> +
>> +	pr_info("driver initialized for endpoint 0x%x\n", ffa_dev->vm_id);
>
> Don't print simple probe success messages. Anyway all prints in device
> context should be dev_*.

Okay, I'll remove this.

>> +
>> +	return 0;
>> +
>> +err:
>> +	tstee_deinit_common(tstee);
>> +	return rc;
>> +}
>> +
>> +static void tstee_remove(struct ffa_device *ffa_dev)
>> +{
>> +	tstee_deinit_common(ffa_dev->dev.driver_data);
>> +}
>> +
>> +static const struct ffa_device_id tstee_device_ids[] = {
>> +	/* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
>> +	{ TS_RPC_UUID },
>> +	{}
>> +};
>> +
>> +static struct ffa_driver tstee_driver = {
>> +	.name = "arm_tstee",
>> +	.probe = tstee_probe,
>> +	.remove = tstee_remove,
>> +	.id_table = tstee_device_ids,
>> +};
>> +
>> +static int __init mod_init(void)
>> +{
>> +	return ffa_register(&tstee_driver);
>> +}
>> +module_init(mod_init)
>> +
>> +static void __exit mod_exit(void)
>> +{
>> +	ffa_unregister(&tstee_driver);
>> +}
>> +module_exit(mod_exit)
>> +
>> +MODULE_ALIAS("arm-tstee");
>
> Why do you need this alias? I don't see MODULE_DEVICE_TABLE, so how this
> bus handles module loading?

You're right, the alias is not needed, I'll remove it.
Regarding MODULE_DEVICE_TABLE, AFAIK this mechanism is currently not
supported for the arm_ffa bus type. Maybe Sudeep can chime in on this?

Regards,
Balint

