Return-Path: <linux-kernel+bounces-96124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B202875769
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5EB1F22504
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7AF13667C;
	Thu,  7 Mar 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MAMYP+T6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268741A88;
	Thu,  7 Mar 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840643; cv=none; b=uDCt9xplHTjukexDLWeQo+YTaHLrIbIV8V7XKesWGGFn9Ym+M6S72dkx8Y7g250sS4c7rjY5UmOR0+r6GzBmgp0zt0fliEjSySFEG6jluDeWwuwgIP7f3PlgrdaV8E5mmeozkkLCbWd2FdGsqOPIMU5iNpb8J4dyvEJWbWCBF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840643; c=relaxed/simple;
	bh=0r8UL8ZcWqbBY/wcw5i6wu14ZSkyb4B36TrZLeugQ50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=MqKTmn1VUA0cNfDOj4y5ABFtDb8FaJgSnK81enhicGWu+au7bvy0UtL2amy1f8RpoYeCyWq3tfm4FFcMxutAagrwr+2Baz2pHlzQsOXaqX6Jq9r2qdaH2yNHwSLT/CtSJQyqNdAS+u1qwcIc/sRXxBkWBTNWy7gDA6ivKg4TabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MAMYP+T6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427JX943007277;
	Thu, 7 Mar 2024 19:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dz/LK0oKCNFT3pqvDhAD9y9SZ5Y0YYpB7DXx6vOfKcg=;
 b=MAMYP+T6jNNfy0ZYcv8qxjJ/zwsenJIXIaq/xrvyDFIuOOsrXVyq70CASm7PlMmUaq2i
 6h7TTLPODVe3/DIl4zosC5Ox8SR3UszNIf3+rShdmSzNq0Hfszb7y0dNOGQHxxZI6QMA
 AfAUf7nO4lCoFZrejo5TBlf9PVE7IjGlt6suAIpQDFOvi09p3bde+hlYGdpBVZ6O803o
 CX9Qw3IkjmWtG0DjoQpSKReW9Qfzu3FaSPTxA8eOF0rCwRD3Z5rfvcvq/I2aKh17yu9+
 aE0KNJrE3Xjiom4b+rhv7EtppqIyZ2dCWzjMOcw9oPf9EmVCzEtzZieZCKKTyqx+EeTU DA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqku405fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:43:19 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427JdNdE022062;
	Thu, 7 Mar 2024 19:43:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqku405fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:43:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427JHi7G026228;
	Thu, 7 Mar 2024 19:43:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep7syj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:43:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427JhFHf46793012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 19:43:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AA5358056;
	Thu,  7 Mar 2024 19:43:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFEC05803F;
	Thu,  7 Mar 2024 19:43:13 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.222])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 19:43:13 +0000 (GMT)
Message-ID: <031d4ff2bf0c04df5f4094989b94f7ce3e3e73f6.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 3/8] ima: Add digest_cache policy keyword
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 07 Mar 2024 14:43:13 -0500
In-Reply-To: <20240214143525.2205481-4-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H-19w-xu1gDUvQ08KtcG3WvDA2iL6oiJ
X-Proofpoint-GUID: 9yT7vcAu3jVDEoyKX19QWgW5BDKHEBG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070139

On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the 'digest_cache=' policy keyword, to enable the usage of digest
> caches for specific IMA actions and purposes.
> 
> At the moment, it accepts only 'content' as value, as digest caches can be
> only used only for measurement and appraisal of file content. In the
> future, it might be possible to use them for file metadata too.

At least from this patch, it is unclear why 'digest_cache' requires an option.  
The usage - measure, appraise - is based on 'action'.  From an IMA perspective,
does the file content make a difference?  And if it did, then file 'data' would
parallel file 'metadata'.

Without having to pass around "digest_cache_mask" would simplify this patch.

Mimi

> The 'digest_cache=' keyword can be specified for the subset of IMA hooks
> listed in ima_digest_cache_func_allowed().
> 
> POLICY_CHECK has been excluded for measurement, because policy changes must
> be visible in the IMA measurement list. For appraisal, instead, it might be
> useful to load custom policies in the initial ram disk (no security.ima
> xattr).
> 
> Add the digest_cache_mask member to the ima_rule_entry structure, and set
> the flag IMA_DIGEST_CACHE_MEASURE_CONTENT if 'digest_cache=content' was
> specified for a measure rule, IMA_DIGEST_CACHE_APPRAISE_CONTENT for an
> appraise rule.
> 
> Propagate the mask down to ima_match_policy() and ima_get_action(), so that
> process_measurement() can make the final decision on whether or not digest
> caches should be used to measure/appraise the file being evaluated.
> 
> Since using digest caches changes the meaning of the IMA measurement list,
> which will include only digest lists and unknown files, enforce specifying
> 'pcr=' with a non-standard value, when 'digest_cache=content' is specified
> in a measure rule.
> 
> This removes the ambiguity on the meaning of the IMA measurement list.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  Documentation/ABI/testing/ima_policy  |  5 +-
>  security/integrity/ima/ima.h          | 10 +++-
>  security/integrity/ima/ima_api.c      |  6 ++-
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/ima/ima_main.c     |  8 +--
>  security/integrity/ima/ima_policy.c   | 70 ++++++++++++++++++++++++++-
>  6 files changed, 89 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy
> b/Documentation/ABI/testing/ima_policy
> index 22237fec5532..be045fb60530 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,7 +29,7 @@ Description:
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[digest_type=] [template=] [permit_directio]
>  				[appraise_type=] [appraise_flag=]
> -				[appraise_algos=] [keyrings=]
> +				[appraise_algos=] [keyrings=] [digest_cache=]
>  		  base:
>  			func:=
> [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
> @@ -77,6 +77,9 @@ Description:
>  			For example, "sha256,sha512" to only accept to appraise
>  			files where the security.ima xattr was hashed with one
>  			of these two algorithms.
> +			digest_cache:= [content]
> +			"content" means that the digest cache is used only
> +			for file content measurement and/or appraisal.
>  
>  		  default policy:
>  			# PROC_SUPER_MAGIC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c9140a57b591..deee56d99d6f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -43,6 +43,10 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10
> };
>  
>  #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>  
> +/* Digest cache usage flags. */
> +#define IMA_DIGEST_CACHE_MEASURE_CONTENT	0x0000000000000001
> +#define IMA_DIGEST_CACHE_APPRAISE_CONTENT	0x0000000000000002
> +
>  /* current content of the policy */
>  extern int ima_policy_flag;
>  
> @@ -367,7 +371,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode
> *inode,
>  		   const struct cred *cred, u32 secid, int mask,
>  		   enum ima_hooks func, int *pcr,
>  		   struct ima_template_desc **template_desc,
> -		   const char *func_data, unsigned int *allowed_algos);
> +		   const char *func_data, unsigned int *allowed_algos,
> +		   u64 *digest_cache_mask);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>  			    void *buf, loff_t size, enum hash_algo algo,
> @@ -398,7 +403,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode
> *inode,
>  		     const struct cred *cred, u32 secid, enum ima_hooks func,
>  		     int mask, int flags, int *pcr,
>  		     struct ima_template_desc **template_desc,
> -		     const char *func_data, unsigned int *allowed_algos);
> +		     const char *func_data, unsigned int *allowed_algos,
> +		     u64 *digest_cache_mask);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flags(void);
> diff --git a/security/integrity/ima/ima_api.c
> b/security/integrity/ima/ima_api.c
> index b37d043d5748..87e286ace43c 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const unsigned
> char *filename,
>   * @template_desc: pointer filled in if matched measure policy sets template=
>   * @func_data: func specific data, may be NULL
>   * @allowed_algos: allowlist of hash algorithms for the IMA xattr
> + * @digest_cache_mask: Actions and purposes for which digest cache is allowed
>   *
>   * The policy is defined in terms of keypairs:
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
> @@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode
> *inode,
>  		   const struct cred *cred, u32 secid, int mask,
>  		   enum ima_hooks func, int *pcr,
>  		   struct ima_template_desc **template_desc,
> -		   const char *func_data, unsigned int *allowed_algos)
> +		   const char *func_data, unsigned int *allowed_algos,
> +		   u64 *digest_cache_mask)
>  {
>  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>  
> @@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode
> *inode,
>  
>  	return ima_match_policy(idmap, inode, cred, secid, func, mask,
>  				flags, pcr, template_desc, func_data,
> -				allowed_algos);
> +				allowed_algos, digest_cache_mask);
>  }
>  
>  static bool ima_get_verity_digest(struct ima_iint_cache *iint,
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 3497741caea9..27ccc9a2c09f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -81,7 +81,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode
> *inode,
>  	security_current_getsecid_subj(&secid);
>  	return ima_match_policy(idmap, inode, current_cred(), secid,
>  				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
> -				NULL, NULL, NULL);
> +				NULL, NULL, NULL, NULL);
>  }
>  
>  static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *iint)
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 18285fc8ac07..e3ca80098c4c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -232,7 +232,7 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	 */
>  	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
>  				mask, func, &pcr, &template_desc, NULL,
> -				&allowed_algos);
> +				&allowed_algos, NULL);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
>  			    func == MMAP_CHECK_REQPROT) &&
>  			   (ima_policy_flag & IMA_MEASURE));
> @@ -489,11 +489,11 @@ static int ima_file_mprotect(struct vm_area_struct *vma,
> unsigned long reqprot,
>  	inode = file_inode(vma->vm_file);
>  	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
> -				&pcr, &template, NULL, NULL);
> +				&pcr, &template, NULL, NULL, NULL);
>  	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				 current_cred(), secid, MAY_EXEC,
>  				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
> -				 NULL);
> +				 NULL, NULL);
>  
>  	/* Is the mmap'ed file in policy? */
>  	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
> @@ -972,7 +972,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>  		security_current_getsecid_subj(&secid);
>  		action = ima_get_action(idmap, inode, current_cred(),
>  					secid, 0, func, &pcr, &template,
> -					func_data, NULL);
> +					func_data, NULL, NULL);
>  		if (!(action & IMA_MEASURE) && !digest)
>  			return -ENOENT;
>  	}
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c
> index 7cfd1860791f..4ac83df8d255 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -122,6 +122,7 @@ struct ima_rule_entry {
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these
> keyrings */
>  	struct ima_rule_opt_list *label; /* Measure data grouped under this
> label */
>  	struct ima_template_desc *template;
> +	u64 digest_cache_mask;	/* Actions and purposes for which digest cache
> is allowed */
>  };
>  
>  /*
> @@ -726,6 +727,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum
> ima_hooks func)
>   * @template_desc: the template that should be used for this rule
>   * @func_data: func specific data, may be NULL
>   * @allowed_algos: allowlist of hash algorithms for the IMA xattr
> + * @digest_cache_mask: Actions and purposes for which digest cache is allowed

Purpose 
>   *
>   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>   * conditions.
> @@ -738,7 +740,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode
> *inode,
>  		     const struct cred *cred, u32 secid, enum ima_hooks func,
>  		     int mask, int flags, int *pcr,
>  		     struct ima_template_desc **template_desc,
> -		     const char *func_data, unsigned int *allowed_algos)
> +		     const char *func_data, unsigned int *allowed_algos,
> +		     u64 *digest_cache_mask)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -783,6 +786,9 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode
> *inode,
>  		if (template_desc && entry->template)
>  			*template_desc = entry->template;
>  
> +		if (digest_cache_mask)
> +			*digest_cache_mask |= entry->digest_cache_mask;
> +
>  		if (!actmask)
>  			break;
>  	}
> @@ -859,6 +865,30 @@ static int ima_appraise_flag(enum ima_hooks func)
>  	return 0;
>  }
>  
> +static bool ima_digest_cache_func_allowed(struct ima_rule_entry *entry)
> +{
> +	switch (entry->func) {
> +	case NONE:
> +	case FILE_CHECK:
> +	case MMAP_CHECK:
> +	case MMAP_CHECK_REQPROT:
> +	case BPRM_CHECK:
> +	case CREDS_CHECK:
> +	case FIRMWARE_CHECK:
> +	case POLICY_CHECK:
> +	case MODULE_CHECK:
> +	case KEXEC_KERNEL_CHECK:
> +	case KEXEC_INITRAMFS_CHECK:
> +		/* Exception: always add policy updates to measurement list! */
> +		if (entry->action == MEASURE && entry->func == POLICY_CHECK)
> +			return false;
> +
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void add_rules(struct ima_rule_entry *entries, int count,
>  		      enum policy_rule_list policy_rule)
>  {
> @@ -1073,7 +1103,7 @@ enum policy_opt {
>  	Opt_digest_type,
>  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_label, Opt_digest_cache, Opt_err
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -1122,6 +1152,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_template, "template=%s"},
>  	{Opt_keyrings, "keyrings=%s"},
>  	{Opt_label, "label=%s"},
> +	{Opt_digest_cache, "digest_cache=%s"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -1245,6 +1276,18 @@ static bool ima_validate_rule(struct ima_rule_entry
> *entry)
>  	if (entry->action != MEASURE && entry->flags & IMA_PCR)
>  		return false;
>  
> +	/* New-style measurements with digest cache cannot be on default PCR. */
> +	if (entry->action == MEASURE &&
> +	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT)) {
> +		if (!(entry->flags & IMA_PCR) ||
> +		    entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX)
> +			return false;
> +	}
> +
> +	/* Digest caches can be used only for a subset of the IMA hooks. */
> +	if (entry->digest_cache_mask && !ima_digest_cache_func_allowed(entry))
> +		return false;
> +
>  	if (entry->action != APPRAISE &&
>  	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
>  			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
> @@ -1881,6 +1924,26 @@ static int ima_parse_rule(char *rule, struct
> ima_rule_entry *entry)
>  						 &(template_desc->num_fields));
>  			entry->template = template_desc;
>  			break;
> +		case Opt_digest_cache:
> +			ima_log_string(ab, "digest_cache", args[0].from);
> +
> +			result = -EINVAL;
> +
> +			if (!strcmp(args[0].from, "content")) {
> +				switch (entry->action) {
> +				case MEASURE:
> +					entry->digest_cache_mask |=
> IMA_DIGEST_CACHE_MEASURE_CONTENT;
> +					result = 0;
> +					break;
> +				case APPRAISE:
> +					entry->digest_cache_mask |=
> IMA_DIGEST_CACHE_APPRAISE_CONTENT;
> +					result = 0;
> +					break;
> +				default:
> +					break;
> +				}
> +			}
> +			break;
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
>  			result = -EINVAL;
> @@ -2271,6 +2334,9 @@ int ima_policy_show(struct seq_file *m, void *v)
>  		seq_puts(m, "digest_type=verity ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
>  		seq_puts(m, "permit_directio ");
> +	if ((entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT) ||
> +	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_APPRAISE_CONTENT))
> +		seq_puts(m, "digest_cache=content ");
>  	rcu_read_unlock();
>  	seq_puts(m, "\n");
>  	return 0;


