Return-Path: <linux-kernel+bounces-159119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2E8B29A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0942B23E46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA024154436;
	Thu, 25 Apr 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QzRFHDNM"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C7153801;
	Thu, 25 Apr 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076641; cv=none; b=pqDImpkrU10LEOOWQvYk9uo6AeVgU/uWSy9GXqZ/NTGQ8HVHGLTTudczVzXlFoEG+iQ+d0CJ7vdwh2C0pld4Oq/G9mse8vgskJrXZicMXaUGeGOp7UZ+qjOt1D/aDEKsm00umoyif/CdYA+CL8a99quBf2HchDVdW94dRreI+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076641; c=relaxed/simple;
	bh=08WPogXj9ccCunrIcH7Gsf5VsfCJT+2vSloyAfgVOpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6vxXiPbziu6LLIrSQOLXQjR7psCrTHUwvCdyOA4VPVg4m6W2ukEofQhfb4Z+abiBZErrbWpJ8E6dmpRkk3h6nLGQMgDMg4DxRWNCjF41lDOxKG0Gm/v1t/bL2KD9F/SnnVo6regPER9wdfvcI29bQB88MTy4x/SoyETGgcDcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QzRFHDNM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id E234E20FD4CE;
	Thu, 25 Apr 2024 13:23:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E234E20FD4CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714076638;
	bh=Ut792Bm4cIOYNOqotGiFt26HJ/65wP94SVse6cZs0cU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QzRFHDNMdopqkGKA5TUBtW0Vrr3/py/nBJLRMF/wnzbWNulqxJ+g+rYqSg6zSRn4u
	 yqOzz8YbPOQKDxvZ8OnHbTca+U6PA2Jycw+u/5fF4Z6Qg6OF0aUBky68HRJfknZSPc
	 F2+OF3hzpfon+VEwQmF4/xiOd8H7SpBuHHnSPphQ=
Message-ID: <6cf278b3-32f2-4665-be8d-ea6605f4318b@linux.microsoft.com>
Date: Thu, 25 Apr 2024 13:23:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/21] dm verity: consume root hash digest and expose
 signature data via LSM hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 eparis@redhat.com, paul@paul-moore.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-14-git-send-email-wufan@linux.microsoft.com>
 <20240425035647.GC1401@sol.localdomain>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240425035647.GC1401@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/2024 8:56 PM, Eric Biggers wrote:
> On Fri, Apr 12, 2024 at 05:55:56PM -0700, Fan Wu wrote:
>> dm verity: consume root hash digest and expose signature data via LSM hook
> 
> As in the fsverity patch, nothing is being "consumed" here.  This patch adds a
> supplier, not a consumer.  I think you mean something like: expose root digest
> and signature to LSMs.
> 
Thanks for the suggestion.

>> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>> index bb5da66da4c1..fbb83c6fd99c 100644
>> --- a/drivers/md/dm-verity-target.c
>> +++ b/drivers/md/dm-verity-target.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/scatterlist.h>
>>   #include <linux/string.h>
>>   #include <linux/jump_label.h>
>> +#include <linux/security.h>
>> +#include <linux/dm-verity.h>
>>   
>>   #define DM_MSG_PREFIX			"verity"
>>   
>> @@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
>>   	blk_limits_io_min(limits, limits->logical_block_size);
>>   }
>>   
>> +#ifdef CONFIG_SECURITY
>> +
>> +static int verity_init_sig(struct dm_verity *v, const void *sig,
>> +			   size_t sig_size)
>> +{
>> +	v->sig_size = sig_size;
>> +	v->root_digest_sig = kmemdup(sig, v->sig_size, GFP_KERNEL);
>> +	if (!v->root_digest)
>> +		return -ENOMEM;
> 
> root_digest_sig, not root_digest
> 
Thanks for pointing out!

>> +#ifdef CONFIG_SECURITY
>> +
>> +static int verity_finalize(struct dm_target *ti)
>> +{
>> +	struct block_device *bdev;
>> +	struct dm_verity_digest root_digest;
>> +	struct dm_verity *v;
>> +	int r;
>> +
>> +	v = ti->private;
>> +	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
>> +	root_digest.digest = v->root_digest;
>> +	root_digest.digest_len = v->digest_size;
>> +	root_digest.alg = v->alg_name;
>> +
>> +	r = security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, &root_digest,
>> +				       sizeof(root_digest));
>> +	if (r)
>> +		return r;
>> +
>> +	r = security_bdev_setintegrity(bdev,
>> +				       LSM_INT_DMVERITY_SIG_VALID,
>> +				       v->root_digest_sig,
>> +				       v->sig_size);
> 
> The signature is only checked if CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y, whereas
> this code is built whenever CONFIG_SECURITY=y.
> 
> So this seems like the same issue that has turned up elsewhere in the IPE
> patchset, where IPE is (apparently) happy with any signature, even one that
> hasn't been checked...
> 

Yes I do agree the second hook call should better depend on 
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y.

However, the current implementation does not happy with any signature.

In case of CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y, any signature 
provided to dm-verity will be checked against the configured keyring, 
the hook call won't be reached if the check failed. In case of no 
signature is provided and !DM_VERITY_IS_SIG_FORCE_ENABLED(), the hook 
will be called with signature value NULL.

In case of CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=n, signature won't be 
accepted by dm-verity. In addition, the whole support of dm-verity will 
be disabled for IPE because CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=n.

>> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
>> index 20b1bcf03474..89e862f0cdf6 100644
>> --- a/drivers/md/dm-verity.h
>> +++ b/drivers/md/dm-verity.h
>> @@ -43,6 +43,9 @@ struct dm_verity {
>>   	u8 *root_digest;	/* digest of the root block */
>>   	u8 *salt;		/* salt: its size is salt_size */
>>   	u8 *zero_digest;	/* digest for a zero block */
>> +#ifdef CONFIG_SECURITY
>> +	u8 *root_digest_sig;	/* digest signature of the root block */
>> +#endif /* CONFIG_SECURITY */
> 
> No, it's not a signature of the root block, at least not directly.  It's a
> signature of the root digest (the digest of the root block).
> 
>> diff --git a/include/linux/dm-verity.h b/include/linux/dm-verity.h
>> new file mode 100644
>> index 000000000000..a799a8043d85
>> --- /dev/null
>> +++ b/include/linux/dm-verity.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _LINUX_DM_VERITY_H
>> +#define _LINUX_DM_VERITY_H
>> +
>> +struct dm_verity_digest {
>> +	const char *alg;
>> +	const u8 *digest;
>> +	size_t digest_len;
>> +};
>> +
>> +#endif /* _LINUX_DM_VERITY_H */
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index ac0985641611..9e46b13a356c 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -84,7 +84,8 @@ enum lsm_event {
>>   };
>>   
>>   enum lsm_integrity_type {
>> -	__LSM_INT_MAX
>> +	LSM_INT_DMVERITY_SIG_VALID,
>> +	LSM_INT_DMVERITY_ROOTHASH,
>>   };
> 
> Shouldn't struct dm_verity_digest be defined next to LSM_INT_DMVERITY_ROOTHASH?
> It's the struct that's associated with it.
> 
> It seems weird to create a brand new header <linux/dm-verity.h> that just
> contains this one LSM related definition, when there's already a header for the
> LSM definitions that even includes the related value LSM_INT_DMVERITY_ROOTHASH.
> 
> - Eric

Yes they can just be in the same header. Thanks for the suggestion.

-Fan

