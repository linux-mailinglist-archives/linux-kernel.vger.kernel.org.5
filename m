Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFB79ED20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjIMPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjIMPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:34:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108ECE;
        Wed, 13 Sep 2023 08:34:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E459FC433C7;
        Wed, 13 Sep 2023 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619273;
        bh=FvxkLd6D1TxrLaDuydPO2/euKdIhuMpxjEI0FPnCSTg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=RBWmfVtFihX1hca4KWQ8YDrkOXLreIsiXL4FzecvebvyboVwuodeVMLYpzGzk8SQf
         75XW1kirCE+Xw5Mof0rQEnQwuGWSxAjMtPZmQhOV6F0JJKJXa9XrL3bIz5n6QPoMk4
         9babZFLM10mroKonA1nNdKiQG+BO2GUocFHF8VkfxFcGrvIehBqCFjCOSTEtR28So8
         WsaLg9EDT/3DcyuyYaOwWBd7rFPK3OiTqbsVgoH8N/k0vT1FUt+VikW0WhFxgUthPz
         FnJhxH2kF5Z2rSeifkO6GeGm5Z63EPS9ahLlB5RhwK87CfMBoGRmHOZf+N6InMXcyz
         swmhh1QbAastw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:34:28 +0300
Message-Id: <CVHWE8HC4SHA.FU2XVIXN6WB7@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 12/18] x86/sgx: Add EPC OOM path to forcefully
 reclaim EPC
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-13-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-13-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Introduce the OOM path for killing an enclave with a reclaimer that is no
> longer able to reclaim enough EPC pages. Find a victim enclave, which
> will be an enclave with only "unreclaimable" EPC pages left in the
> cgroup LRU lists. Once a victim is identified, mark the enclave as OOM
> and zap the enclave's entire page range, and drain all mm references in
> encl->mm_list. Block allocating any EPC pages in #PF handler, or
> reloading any pages in all paths, or creating any new mappings.
>
> The OOM killing path may race with the reclaimers: in some cases, the
> victim enclave is in the process of reclaiming the last EPC pages when
> OOM happens, that is, all pages other than SECS and VA pages are in
> RECLAIMING_IN_PROGRESS state. The reclaiming process requires access to
> the enclave backing, VA pages as well as SECS. So the OOM killer does
> not directly release those enclave resources, instead, it lets all
> reclaiming in progress to finish, and relies (as currently done) on
> kref_put on encl->refcount to trigger sgx_encl_release() to do the
> final cleanup.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Updates for patch reordering and typo fixes.
>
> V3:
> - Rebased to use the new VMA_ITERATOR to zap VMAs.
> - Fixed the racing cases by blocking new page allocation/mapping and
> reloading when enclave is marked for OOM. And do not release any enclave
> resources other than draining mm_list entries, and let pages in
> RECLAIMING_IN_PROGRESS to be reaped by reclaimers.
> - Due to above changes, also removed the no-longer needed encl->lock in
> the OOM path which was causing deadlocks reported by the lock prover.
> ---
>  arch/x86/kernel/cpu/sgx/driver.c |  27 +-----
>  arch/x86/kernel/cpu/sgx/encl.c   |  48 ++++++++++-
>  arch/x86/kernel/cpu/sgx/encl.h   |   2 +
>  arch/x86/kernel/cpu/sgx/ioctl.c  |   9 ++
>  arch/x86/kernel/cpu/sgx/main.c   | 140 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/sgx.h    |   1 +
>  6 files changed, 200 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/d=
river.c
> index 262f5fb18d74..ff42d649c7b6 100644
> --- a/arch/x86/kernel/cpu/sgx/driver.c
> +++ b/arch/x86/kernel/cpu/sgx/driver.c
> @@ -44,7 +44,6 @@ static int sgx_open(struct inode *inode, struct file *f=
ile)
>  static int sgx_release(struct inode *inode, struct file *file)
>  {
>  	struct sgx_encl *encl =3D file->private_data;
> -	struct sgx_encl_mm *encl_mm;
> =20
>  	/*
>  	 * Drain the remaining mm_list entries. At this point the list contains
> @@ -52,31 +51,7 @@ static int sgx_release(struct inode *inode, struct fil=
e *file)
>  	 * not exited yet. The processes, which have exited, are gone from the
>  	 * list by sgx_mmu_notifier_release().
>  	 */
> -	for ( ; ; )  {
> -		spin_lock(&encl->mm_lock);
> -
> -		if (list_empty(&encl->mm_list)) {
> -			encl_mm =3D NULL;
> -		} else {
> -			encl_mm =3D list_first_entry(&encl->mm_list,
> -						   struct sgx_encl_mm, list);
> -			list_del_rcu(&encl_mm->list);
> -		}
> -
> -		spin_unlock(&encl->mm_lock);
> -
> -		/* The enclave is no longer mapped by any mm. */
> -		if (!encl_mm)
> -			break;
> -
> -		synchronize_srcu(&encl->srcu);
> -		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
> -		kfree(encl_mm);
> -
> -		/* 'encl_mm' is gone, put encl_mm->encl reference: */
> -		kref_put(&encl->refcount, sgx_encl_release);
> -	}
> -
> +	sgx_encl_mm_drain(encl);
>  	kref_put(&encl->refcount, sgx_encl_release);
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index bf0ac3677ca8..85b6f218f029 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -453,6 +453,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>  	if (unlikely(!encl))
>  		return VM_FAULT_SIGBUS;
> =20
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		return VM_FAULT_SIGBUS;
> +
>  	/*
>  	 * The page_array keeps track of all enclave pages, whether they
>  	 * are swapped out or not. If there is no entry for this page and
> @@ -651,7 +654,8 @@ static int sgx_vma_access(struct vm_area_struct *vma,=
 unsigned long addr,
>  	if (!encl)
>  		return -EFAULT;
> =20
> -	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags))
> +	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags) ||
> +	    test_bit(SGX_ENCL_OOM, &encl->flags))
>  		return -EFAULT;
> =20
>  	for (i =3D 0; i < len; i +=3D cnt) {
> @@ -776,6 +780,45 @@ void sgx_encl_release(struct kref *ref)
>  	kfree(encl);
>  }
> =20
> +/**
> + * sgx_encl_mm_drain - drain all mm_list entries
> + * @encl:	address of the sgx_encl to drain
> + *
> + * Used during oom kill to empty the mm_list entries after they have bee=
n
> + * zapped. Or used by sgx_release to drain the remaining mm_list entries=
 when
> + * the enclave fd is closing. After this call, sgx_encl_release will be =
called
> + * with kref_put.
> + */
> +void sgx_encl_mm_drain(struct sgx_encl *encl)
> +{
> +	struct sgx_encl_mm *encl_mm;
> +
> +	for ( ; ; )  {
> +		spin_lock(&encl->mm_lock);
> +
> +		if (list_empty(&encl->mm_list)) {
> +			encl_mm =3D NULL;
> +		} else {
> +			encl_mm =3D list_first_entry(&encl->mm_list,
> +						   struct sgx_encl_mm, list);
> +			list_del_rcu(&encl_mm->list);
> +		}
> +
> +		spin_unlock(&encl->mm_lock);
> +
> +		/* The enclave is no longer mapped by any mm. */
> +		if (!encl_mm)
> +			break;
> +
> +		synchronize_srcu(&encl->srcu);
> +		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
> +		kfree(encl_mm);
> +
> +		/* 'encl_mm' is gone, put encl_mm->encl reference: */
> +		kref_put(&encl->refcount, sgx_encl_release);
> +	}
> +}
> +
>  /*
>   * 'mm' is exiting and no longer needs mmu notifications.
>   */
> @@ -847,6 +890,9 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_=
struct *mm)
>  	struct sgx_encl_mm *encl_mm;
>  	int ret;
> =20
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		return -ENOMEM;
> +
>  	/*
>  	 * Even though a single enclave may be mapped into an mm more than once=
,
>  	 * each 'mm' only appears once on encl->mm_list. This is guaranteed by
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index 831d63f80f5a..47792fb00cee 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -39,6 +39,7 @@ enum sgx_encl_flags {
>  	SGX_ENCL_DEBUG		=3D BIT(1),
>  	SGX_ENCL_CREATED	=3D BIT(2),
>  	SGX_ENCL_INITIALIZED	=3D BIT(3),
> +	SGX_ENCL_OOM		=3D BIT(4),

Given how the constants are named before maybe SGX_ENCL_NO_MEMORY would
be more obvious.

>  };
> =20
>  struct sgx_encl_mm {
> @@ -125,5 +126,6 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_e=
ncl *encl,
>  					 unsigned long addr);
>  struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
>  void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)=
;
> +void sgx_encl_mm_drain(struct sgx_encl *encl);
> =20
>  #endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index 8c23bb524674..1f65c79664a2 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -421,6 +421,9 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl=
 *encl, void __user *arg)
>  	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
>  		return -EINVAL;
> =20
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		return -ENOMEM;
> +
>  	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
>  		return -EFAULT;
> =20
> @@ -606,6 +609,9 @@ static long sgx_ioc_enclave_init(struct sgx_encl *enc=
l, void __user *arg)
>  	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
>  		return -EINVAL;
> =20
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		return -ENOMEM;
> +
>  	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
>  		return -EFAULT;
> =20
> @@ -682,6 +688,9 @@ static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
>  	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
>  		return -EINVAL;
> =20
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		return -ENOMEM;
> +
>  	return 0;
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index f3a3ed894616..c8900d62cfff 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -621,6 +621,146 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	atomic_long_inc(&sgx_nr_free_pages);
>  }
> =20
> +static bool sgx_oom_get_ref(struct sgx_epc_page *epc_page)
> +{
> +	struct sgx_encl *encl;
> +
> +	if (epc_page->flags & SGX_EPC_OWNER_PAGE)
> +		encl =3D epc_page->encl_page->encl;
> +	else if (epc_page->flags & SGX_EPC_OWNER_ENCL)
> +		encl =3D epc_page->encl;
> +	else
> +		return false;
> +
> +	return kref_get_unless_zero(&encl->refcount);
> +}
> +
> +static struct sgx_epc_page *sgx_oom_get_victim(struct sgx_epc_lru_lists =
*lru)
> +{
> +	struct sgx_epc_page *epc_page, *tmp;
> +
> +	if (list_empty(&lru->unreclaimable))
> +		return NULL;
> +
> +	list_for_each_entry_safe(epc_page, tmp, &lru->unreclaimable, list) {
> +		list_del_init(&epc_page->list);
> +
> +		if (sgx_oom_get_ref(epc_page))
> +			return epc_page;
> +	}
> +	return NULL;
> +}
> +
> +static void sgx_epc_oom_zap(void *owner, struct mm_struct *mm, unsigned =
long start,
> +			    unsigned long end, const struct vm_operations_struct *ops)
> +{
> +	VMA_ITERATOR(vmi, mm, start);
> +	struct vm_area_struct *vma;
> +
> +	/**
> +	 * Use end because start can be zero and not mapped into
> +	 * enclave even if encl->base =3D 0.
> +	 */
> +	for_each_vma_range(vmi, vma, end) {
> +		if (vma->vm_ops =3D=3D ops && vma->vm_private_data =3D=3D owner &&
> +		    vma->vm_start < end) {
> +			zap_vma_pages(vma);
> +		}
> +	}
> +}
> +
> +static bool sgx_oom_encl(struct sgx_encl *encl)
> +{
> +	unsigned long mm_list_version;
> +	struct sgx_encl_mm *encl_mm;
> +	bool ret =3D false;
> +	int idx;
> +
> +	if (!test_bit(SGX_ENCL_CREATED, &encl->flags))
> +		goto out_put;
> +
> +	/* Done OOM on this enclave previously, do not redo it.
> +	 * This may happen when the SECS page is still UNRECLAIMABLE because
> +	 * another page is in RECLAIM_IN_PROGRESS. Still return true so OOM
> +	 * killer can wait until the reclaimer done with the hold-up page and
> +	 * SECS before it move on to find another victim.
> +	 */
> +	if (test_bit(SGX_ENCL_OOM, &encl->flags))
> +		goto out;
> +
> +	set_bit(SGX_ENCL_OOM, &encl->flags);
> +
> +	do {
> +		mm_list_version =3D encl->mm_list_version;
> +
> +		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
> +		smp_rmb();
> +
> +		idx =3D srcu_read_lock(&encl->srcu);
> +
> +		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
> +			if (!mmget_not_zero(encl_mm->mm))
> +				continue;
> +
> +			mmap_read_lock(encl_mm->mm);
> +
> +			sgx_epc_oom_zap(encl, encl_mm->mm, encl->base,
> +					encl->base + encl->size, &sgx_vm_ops);
> +
> +			mmap_read_unlock(encl_mm->mm);
> +
> +			mmput_async(encl_mm->mm);
> +		}
> +
> +		srcu_read_unlock(&encl->srcu, idx);
> +	} while (WARN_ON_ONCE(encl->mm_list_version !=3D mm_list_version));
> +
> +	sgx_encl_mm_drain(encl);
> +out:
> +	ret =3D true;
> +
> +out_put:
> +	/*
> +	 * This puts the refcount we took when we identified this enclave as
> +	 * an OOM victim.
> +	 */
> +	kref_put(&encl->refcount, sgx_encl_release);
> +	return ret;
> +}
> +
> +static inline bool sgx_oom_encl_page(struct sgx_encl_page *encl_page)
> +{
> +	return sgx_oom_encl(encl_page->encl);
> +}
> +
> +/**
> + * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
> + * @lru:	LRU that is low
> + *
> + * Return:	%true if a victim was found and kicked.
> + */
> +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
> +{
> +	struct sgx_epc_page *victim;
> +
> +	spin_lock(&lru->lock);
> +	victim =3D sgx_oom_get_victim(lru);
> +	spin_unlock(&lru->lock);
> +
> +	if (!victim)
> +		return false;
> +
> +	if (victim->flags & SGX_EPC_OWNER_PAGE)
> +		return sgx_oom_encl_page(victim->encl_page);
> +
> +	if (victim->flags & SGX_EPC_OWNER_ENCL)
> +		return sgx_oom_encl(victim->encl);
> +
> +	/*Will never happen unless we add more owner types in future */
> +	WARN_ON_ONCE(1);
> +	return false;
> +}
> +
>  static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  					 unsigned long index,
>  					 struct sgx_epc_section *section)
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index e210af77f0cf..3818be5a8bd3 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -176,6 +176,7 @@ void sgx_reclaim_direct(void);
>  void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)=
;
>  int sgx_drop_epc_page(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> +bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
> =20
>  void sgx_ipi_cb(void *info);
> =20
> --=20
> 2.25.1

BR, Jarkko
