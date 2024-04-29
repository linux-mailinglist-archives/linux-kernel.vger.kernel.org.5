Return-Path: <linux-kernel+bounces-162323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957DB8B5961
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2547D28AF85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC074BE2;
	Mon, 29 Apr 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGFGarQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CF56B67;
	Mon, 29 Apr 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395869; cv=none; b=isIhaus5YHC/+a26aZDI5YBWo8ljdNFfRXMDprCu84L6x2NduAnHWV6blkBo7LKmOm62/W8JwqnZt1B4v4mxRHTFFvQQUz//oStosc9UBo0R9AXjUjRco++Itug9U+K4m1MFE4yIjFCfVgWLHVsrmneEWNfBnbHkUccZl9hy228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395869; c=relaxed/simple;
	bh=c3fItunN+3aoIUR27+cFPV/Tb+UIdZgpLt7R+jz4LQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=n1etK9XxR8ARLf85oN6t4m/5jdAW3ONTBJ5eZxP5lXZtVZgyRu4sR5BSV74sI0fLiG6k7UJuwfW2nM2zdk+NBwvU3oxQKmKcAmJThLJJyVwr7AoDNTkSPJ6Th5crUtVymdiClOSNFqA1ONSMhUnj2TgHk2rMqwnwTpEURQrHeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGFGarQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5968C113CD;
	Mon, 29 Apr 2024 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714395868;
	bh=c3fItunN+3aoIUR27+cFPV/Tb+UIdZgpLt7R+jz4LQc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nGFGarQHE06bJM5HUluRj30QKjfMHY5CU8aJSq7mseFjgcJJA5sqsufS+pZPif+Q6
	 V6Cz46udjj3aQcg1N2u2pP1GIpzE7rHz3mfLoC9JzCUnIIsr+cQmoLyLoI20RafjqJ
	 SGBwFbxhalG9RTgPC8/KknAn51uoIPc177tZ56TVorHRLikl17dKB8TUFdO5667/oL
	 oIyDsGAVlD3P8EgQ2NXbGkc/Lt0k4372TadpKdNdLsjmCjN0iZmF8wO+S/vOellXht
	 +zV+SLRiHsUNJNfLIbAWMMt0GbzxWjFTq9lqRGvv9nyrA+fEc3byeGFsUs+mP03wHc
	 XllrdtaYXPGFA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:04:24 +0300
Message-Id: <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>
Cc: <mona.vij@intel.com>, <kailun.qin@intel.com>, <stable@vger.kernel.org>,
 =?utf-8?q?Marcelina_Ko=C5=9Bcielnicka?= <mwk@invisiblethingslab.com>
Subject: Re: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread
 returns SIGBUS
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dmitrii Kuvaiskii" <dmitrii.kuvaiskii@intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
 <haitao.huang@linux.intel.com>, <reinette.chatre@intel.com>,
 <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
 <20240429104330.3636113-2-dmitrii.kuvaiskii@intel.com>
In-Reply-To: <20240429104330.3636113-2-dmitrii.kuvaiskii@intel.com>

On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> Two enclave threads may try to access the same non-present enclave page
> simultaneously (e.g., if the SGX runtime supports lazy allocation). The
> threads will end up in sgx_encl_eaug_page(), racing to acquire the
> enclave lock. The winning thread will perform EAUG, set up the page
> table entry, and insert the page into encl->page_array. The losing
> thread will then get -EBUSY on xa_insert(&encl->page_array) and proceed
> to error handling path.

And that path removes page. Not sure I got gist of this tbh.

> This error handling path contains two bugs: (1) SIGBUS is sent to
> userspace even though the enclave page is correctly installed by another
> thread, and (2) sgx_encl_free_epc_page() is called that performs EREMOVE
> even though the enclave page was never intended to be removed. The first
> bug is less severe because it impacts only the user space; the second
> bug is more severe because it also impacts the OS state by ripping the
> page (added by the winning thread) from the enclave.
>
> Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Linux
> fault handler so that no signal is sent to userspace, and (2) by
> replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that no
> EREMOVE is performed.

What is the collateral damage caused by ENCLS[EREMOVE]?

>
> Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized =
enclave")
> Cc: stable@vger.kernel.org
> Reported-by: Marcelina Ko=C5=9Bcielnicka <mwk@invisiblethingslab.com>
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 279148e72459..41f14b1a3025 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -382,8 +382,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_=
struct *vma,
>  	 * If ret =3D=3D -EBUSY then page was created in another flow while
>  	 * running without encl->lock
>  	 */
> -	if (ret)
> +	if (ret) {
> +		if (ret =3D=3D -EBUSY)
> +			vmret =3D VM_FAULT_NOPAGE;
>  		goto err_out_shrink;
> +	}
> =20
>  	pginfo.secs =3D (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_pag=
e);
>  	pginfo.addr =3D encl_page->desc & PAGE_MASK;
> @@ -419,7 +422,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_s=
truct *vma,
>  err_out_shrink:
>  	sgx_encl_shrink(encl, va_page);
>  err_out_epc:
> -	sgx_encl_free_epc_page(epc_page);
> +	sgx_free_epc_page(epc_page);

This ignores check for the page being reclaimer tracked, i.e. it does
changes that have been ignored in the commit message.

>  err_out_unlock:
>  	mutex_unlock(&encl->lock);
>  	kfree(encl_page);


BR, Jarkko

