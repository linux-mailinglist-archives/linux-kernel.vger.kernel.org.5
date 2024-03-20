Return-Path: <linux-kernel+bounces-109259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135F8816E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D461E28350B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759E6A358;
	Wed, 20 Mar 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XhquzrVl"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340D6A8A1;
	Wed, 20 Mar 2024 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957367; cv=none; b=Cgra1EH745cKbbKRT6psqChYOC8EeUtm784epoieS5LgoaK4SFXgNLpyZ/GD6Cn4aqMaDib/1FH3pNm8F6R1vaMMZvYYQriU9dYTYqe7Y8J13ckWYraorK/JsRDZKrdq4dexvkzuxiNd4LvcN89mY6N4MO78fJjqxobLPQRLYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957367; c=relaxed/simple;
	bh=2VHpZckDYwggt0viFPpLWnrwSWETw6cSwU8Fsj/dIZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLsUyPEsKhI8nSDbTEUSLtHHsjqADa+iqD9nJFKkHU++DcIvAxrjsFcsVeG6FB0EP8co9psYJA3sZiF2mKD0WZiFA/FhU/aIyW65+o/wdiN5aK54KTUQ/L+Htg1VaOB/kKHOHDTlpmyrlWP5wRTSUmj91PJpjm+9CHSCHQdTrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XhquzrVl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 588CD20B74C0;
	Wed, 20 Mar 2024 10:56:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 588CD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710957364;
	bh=GSoNqArKMCKb/omW7PWkQt9LnC6IqfBtlUrD7OiDlc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XhquzrVll8V4yPIhadN1PZioQCEBrauh/IsMnTXpkTsebaarVB3vu7vAkJx07bstl
	 0Hy/mr7/ZpnORwen/A2EgSuJp9rZIoN/jTWL6V0OI6hZGgyi9NQ3xXEd5oL3BTOIY+
	 pmYwLMpKLAkKgziTp+0adiOBNP+eBtMPfGokymP8=
Message-ID: <2e76fd2f-f116-4aea-aa6d-4b3feef1c31e@linux.microsoft.com>
Date: Wed, 20 Mar 2024 10:56:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v15 14/21] dm verity: consume root hash digest and
 signature data via LSM hook
To: Paul Moore <paul@paul-moore.com>, corbet@lwn.net, zohar@linux.ibm.com,
 jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>
 <657b73a0cf531fd4291a0f780d2fcf78@paul-moore.com>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <657b73a0cf531fd4291a0f780d2fcf78@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2024 4:00 PM, Paul Moore wrote:
> On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
>>
>> dm-verity provides a strong guarantee of a block device's integrity. As
>> a generic way to check the integrity of a block device, it provides
>> those integrity guarantees to its higher layers, including the filesystem
>> level.
>>
>> An LSM that control access to a resource on the system based on the
>> available integrity claims can use this transitive property of
>> dm-verity, by querying the underlying block_device of a particular
>> file.
>>
>> The digest and signature information need to be stored in the block
>> device to fulfill the next requirement of authorization via LSM policy.
>> This will enable the LSM to perform revocation of devices that are still
>> mounted, prohibiting execution of files that are no longer authorized
>> by the LSM in question.
>>
>> This patch adds two security hook calls in dm-verity to save the
>> dm-verity roothash and the roothash signature to the block device's
>> LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
>> which will be introduced in the next commit.
>>
>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>> ---
>> v2:
>>    + No Changes
>>
>> v3:
>>    + No changes
>>
>> v4:
>>    + No changes
>>
>> v5:
>>    + No changes
>>
>> v6:
>>    + Fix an improper cleanup that can result in
>>      a leak
>>
>> v7:
>>    + Squash patch 08/12, 10/12 to [11/16]
>>    + Use part0 for block_device, to retrieve the block_device, when
>>      calling security_bdev_setsecurity
>>
>> v8:
>>    + Undo squash of 08/12, 10/12 - separating drivers/md/ from
>>      security/ & block/
>>    + Use common-audit function for dmverity_signature.
>>    + Change implementation for storing the dm-verity digest to use the
>>      newly introduced dm_verity_digest structure introduced in patch
>>      14/20.
>>    + Create new structure, dm_verity_digest, containing digest algorithm,
>>      size, and digest itself to pass to the LSM layer. V7 was missing the
>>      algorithm.
>>    + Create an associated public header containing this new structure and
>>      the key values for the LSM hook, specific to dm-verity.
>>    + Additional information added to commit, discussing the layering of
>>      the changes and how the information passed will be used.
>>
>> v9:
>>    + No changes
>>
>> v10:
>>    + No changes
>>
>> v11:
>>    + Add an optional field to save signature
>>    + Move the security hook call to the new finalize hook
>>
>> v12:
>>    + No changes
>>
>> v13:
>>    + No changes
>>
>> v14:
>>    + Correct code format
>>    + Remove unnecessary header and switch to dm_disk()
>>
>> v15:
>>    + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
>>    + Remove unnecessary headers
>> ---
>>   drivers/md/dm-verity-target.c | 73 +++++++++++++++++++++++++++++++++++
>>   drivers/md/dm-verity.h        |  6 +++
>>   include/linux/dm-verity.h     | 12 ++++++
>>   include/linux/security.h      |  2 +
>>   4 files changed, 93 insertions(+)
>>   create mode 100644 include/linux/dm-verity.h
>>
>> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>> index bb5da66da4c1..e94cc6a755d5 100644
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
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
>> +
>> +static int verity_init_sig(struct dm_verity *v, const void *sig,
>> +			   size_t sig_size)
>> +{
>> +	v->sig_size = sig_size;
>> +	v->root_digest_sig = kmalloc(v->sig_size, GFP_KERNEL);
>> +	if (!v->root_digest)
>> +		return -ENOMEM;
> 
> Either you meant to copy @sig into @v->root_digest_sig and forgot to
> add the code for that, or we don't need to include @sig as a parameter
> to this function.  I'm guessing it is the former as it wouldn't make
> sense to even have dm_verity::root_digest_sig if we weren't stashing
> it here.
> 
> I'd also suggest looking at kmemdup() instead of a kmalloc()/memcpy()
> combo.
> 
Sorry, my mistake here. I must have thought I wrote kmemdup(). I will 
fix this.

>> +	return 0;
>> +}
>> +
>> +static void verity_free_sig(struct dm_verity *v)
>> +{
>> +	kfree(v->root_digest_sig);
>> +}
>> +#else
>> +
>> +static inline int verity_init_sig(struct dm_verity *v, const void *sig,
>> +				  size_t sig_size)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void verity_free_sig(struct dm_verity *v)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> 
> It's been a while since I looked at this patch in the patchset, so
> maybe I'm missing something, but in general we don't want CONFIG_XXX
> checks in the kernel, outside of security/, that are specific to a
> particular LSM (what happens when multiple LSMs need this?).  Please
> use CONFIG_SECURITY instead.
> 
>>   static void verity_dtr(struct dm_target *ti)
>>   {
>>   	struct dm_verity *v = ti->private;
>> @@ -1035,6 +1069,7 @@ static void verity_dtr(struct dm_target *ti)
>>   	kfree(v->salt);
>>   	kfree(v->root_digest);
>>   	kfree(v->zero_digest);
>> +	verity_free_sig(v);
>>   
>>   	if (v->tfm)
>>   		crypto_free_ahash(v->tfm);
>> @@ -1434,6 +1469,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>   		ti->error = "Root hash verification failed";
>>   		goto bad;
>>   	}
>> +
>> +	r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
>> +	if (r < 0) {
>> +		ti->error = "Cannot allocate root digest signature";
>> +		goto bad;
>> +	}
>> +
>>   	v->hash_per_block_bits =
>>   		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
>>   
>> @@ -1584,6 +1626,34 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
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
>> +	r = security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, &root_digest,
>> +				       sizeof(root_digest));
>> +	if (r)
>> +		return r;
>> +
>> +	return security_bdev_setintegrity(bdev,
>> +					  LSM_INTGR_DMV_SIG,
>> +					  v->root_digest_sig,
>> +					  v->sig_size);
> 
> What happens if the second call fails, should we clear the
> LSM_INTGR_DMV_ROOTHASH state in the LSM?
> 
Yes, we should also clear the ROOTHASH if the second failed. Probably we 
can pass NULL to security_bdev_setintegrity to clear it like

security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, NULL, 0);

-Fan
>> +}
>> +
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> 
> See my comments about CONFIG_SECURITY above.  In fact, I would suggest
> moving this up into that part of the file so you only need one #ifdef
> block relating to CONFIG_SECURITY.
> 
> I would also recommend making a dummy function so we can get rid of
> the conditional compilation in @verity_target below.  For example:
> 
>    #ifdef CONFIG_SECURITY
>    static int verity_finalize(struct dm_target *ti)
>    {
>      /* real implementation */
>    }
>    #else
>    static int verity_finalize(struct dm_target *ti)
>    {
>      return 0;
>    }
>    #endif /* CONFIG_SECURITY */
> 
>>   static struct target_type verity_target = {
>>   	.name		= "verity",
>>   	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
>> @@ -1596,6 +1666,9 @@ static struct target_type verity_target = {
>>   	.prepare_ioctl	= verity_prepare_ioctl,
>>   	.iterate_devices = verity_iterate_devices,
>>   	.io_hints	= verity_io_hints,
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
>> +	.finalize	= verity_finalize,
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>>   };
>>   module_dm(verity);
> 
> If you create a dummy verity_finalize() function like above you can
> get rid of the #ifdef checks.
> 
>> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
>> index 20b1bcf03474..6a5b8df5bafd 100644
>> --- a/drivers/md/dm-verity.h
>> +++ b/drivers/md/dm-verity.h
>> @@ -43,6 +43,9 @@ struct dm_verity {
>>   	u8 *root_digest;	/* digest of the root block */
>>   	u8 *salt;		/* salt: its size is salt_size */
>>   	u8 *zero_digest;	/* digest for a zero block */
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
>> +	u8 *root_digest_sig;	/* digest signature of the root block */
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>>   	unsigned int salt_size;
>>   	sector_t data_start;	/* data offset in 512-byte sectors */
>>   	sector_t hash_start;	/* hash start in blocks */
>> @@ -56,6 +59,9 @@ struct dm_verity {
>>   	bool hash_failed:1;	/* set if hash of any block failed */
>>   	bool use_bh_wq:1;	/* try to verify in BH wq before normal work-queue */
>>   	unsigned int digest_size;	/* digest size for the current hash algorithm */
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
>> +	unsigned int sig_size;	/* digest signature size */
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>>   	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
>>   	enum verity_mode mode;	/* mode for handling verification errors */
>>   	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
> 
> See the previous comments about CONFIG_SECURITY.
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
>> index eaff8868766a..60b40b523d57 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -84,6 +84,8 @@ enum lsm_event {
>>   };
>>   
>>   enum lsm_intgr_type {
>> +	LSM_INTGR_DMV_SIG,
>> +	LSM_INTGR_DMV_ROOTHASH,
>>   	__LSM_INTGR_MAX
>>   };
>>   
>> -- 
>> 2.44.0
> 
> --
> paul-moore.com

