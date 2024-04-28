Return-Path: <linux-kernel+bounces-161597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C88B4E71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674142811AC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7335ABE49;
	Sun, 28 Apr 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqC775yD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FB2F44;
	Sun, 28 Apr 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341879; cv=none; b=B4oUjhmCwA2FXwUMEmvEr3LQEiMOu1EeVTDYlao0lZpAxsUJzlyG16JhRXkSBErgt/WKm1MPpUxJn6n+tw91JPCvA8yS5e4dQY5OEWoJkJg7XmMjQZc3d5WpvYNcYlpITAv28v33T9I2nWah4AVzcNXq5H1wmWF0X+ZXHlqVI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341879; c=relaxed/simple;
	bh=0Ly7cHFlyzio2wCMajL5nR7Rf5uPn+KU9ictpXiYFhg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UHd4Wlbcs+NjKeI5nIa5CRVUD5+syiIXOMrBSLotRLkhFuJo1dAnY5eYFeBFs/fgM63cJtyilUzn/pggPBNIxg/cmWduBMQEhMnZx7QDHE8ZPO7Pl7tMjbsZmi5TyHLgYQnE3r7RQ6c6mkj0jvJiSJMH2nKZc/5Aq3qppB9zTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqC775yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEECC113CC;
	Sun, 28 Apr 2024 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341879;
	bh=0Ly7cHFlyzio2wCMajL5nR7Rf5uPn+KU9ictpXiYFhg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IqC775yDus6+E5sBnVaIzEYhWdD8auFmKKfL6L+zloRSRtwW4/2AIbWvryIaCi+ub
	 xOuFaO64Qyp0bwF8YFamuMvSvwZHyIPc+jZPvNGElEsN5tlJ1ZOS/4DM3bfcCxx/WG
	 rmYYv+H+Af5fh2SIIjnB0lwhXy1jQ4kCBazX7YBjtogyaO4Q9l7RusS9x1g9Ie6jvZ
	 wPO32yDH52gf8EIHdz2JMg2pxhuYnYN3QHdoBZ3o8SQY3bicUvfm4FvFpxhBTHFNw5
	 eADNkuFkpN4R9DQ59zsWL9/QoNG2k0m6RD4tV8xblJnlneJZGutEyI02ndQD4bet0k
	 NY95tyB3rFkUA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 01:04:36 +0300
Message-Id: <D0W3H5HUGFN4.3177ULGJRYA8@kernel.org>
Cc: <reinette.chatre@intel.com>, =?utf-8?b?5YiY5Y+MKOi9qeWxuSk=?=
 <ls123674@antgroup.com>
Subject: Re: [RFC PATCH v2 1/1] x86/sgx: Explicitly give up the CPU in
 EDMM's ioctl() to avoid softlockup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bojun Zhu" <zhubojun.zbj@antgroup.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240426141823.112366-1-zhubojun.zbj@antgroup.com>
 <20240426141823.112366-2-zhubojun.zbj@antgroup.com>
In-Reply-To: <20240426141823.112366-2-zhubojun.zbj@antgroup.com>

On Fri Apr 26, 2024 at 5:18 PM EEST, Bojun Zhu wrote:
> EDMM's ioctl()s support batch operations, which may be
> time-consuming. Try to explicitly give up the CPU as the prefix
> operation at the every begin of "for loop" in
> sgx_enclave_{ modify_types | restrict_permissions | remove_pages}
> to give other tasks a chance to run, and avoid softlockup warning.
>
> Additionally perform pending signals check as the prefix operation,
> and introduce sgx_check_signal_and_resched(),
> which wraps all the checks.
>
> The following has been observed on Linux v6.9-rc5 with kernel
> preemptions disabled(by configuring "PREEMPT_NONE=3Dy"), when kernel
> is requested to restrict page permissions of a large number of EPC pages.
>
>     ------------[ cut here ]------------
>     watchdog: BUG: soft lockup - CPU#45 stuck for 22s!
>     ...
>     RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
>     ...
>     Call Trace:
>      sgx_ioctl
>      __x64_sys_ioctl
>      x64_sys_call
>      do_syscall_64
>      entry_SYSCALL_64_after_hwframe
>     ------------[ end trace ]------------
>
> Signed-off-by: Bojun Zhu <zhubojun.zbj@antgroup.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 40 +++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index b65ab214bdf5..e0645920bcb5 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -365,6 +365,20 @@ static int sgx_validate_offset_length(struct sgx_enc=
l *encl,
>  	return 0;
>  }
> =20
> +/*
> + * Check signals and invoke scheduler. Return true for a pending signal.
> + */
> +static bool sgx_check_signal_and_resched(void)
> +{
> +	if (signal_pending(current))
> +		return true;
> +
> +	if (need_resched())
> +		cond_resched();
> +
> +	return false;
> +}
> +
>  /**
>   * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PA=
GES
>   * @encl:       an enclave pointer
> @@ -432,16 +446,13 @@ static long sgx_ioc_enclave_add_pages(struct sgx_en=
cl *encl, void __user *arg)
>  		return -EINVAL;
> =20
>  	for (c =3D 0 ; c < add_arg.length; c +=3D PAGE_SIZE) {
> -		if (signal_pending(current)) {
> +		if (sgx_check_signal_and_resched()) {
>  			if (!c)
>  				ret =3D -ERESTARTSYS;
> =20
>  			break;
>  		}
> =20
> -		if (need_resched())
> -			cond_resched();
> -
>  		ret =3D sgx_encl_add_page(encl, add_arg.src + c, add_arg.offset + c,
>  					&secinfo, add_arg.flags);
>  		if (ret)
> @@ -746,6 +757,13 @@ sgx_enclave_restrict_permissions(struct sgx_encl *en=
cl,
>  	secinfo.flags =3D modp->permissions & SGX_SECINFO_PERMISSION_MASK;
> =20
>  	for (c =3D 0 ; c < modp->length; c +=3D PAGE_SIZE) {
> +		if (sgx_check_signal_and_resched()) {
> +			if (!c)
> +				ret =3D -ERESTARTSYS;
> +
> +			goto out;
> +		}
> +
>  		addr =3D encl->base + modp->offset + c;
> =20
>  		sgx_reclaim_direct();
> @@ -913,6 +931,13 @@ static long sgx_enclave_modify_types(struct sgx_encl=
 *encl,
>  	secinfo.flags =3D page_type << 8;
> =20
>  	for (c =3D 0 ; c < modt->length; c +=3D PAGE_SIZE) {
> +		if (sgx_check_signal_and_resched()) {
> +			if (!c)
> +				ret =3D -ERESTARTSYS;
> +
> +			goto out;
> +		}
> +
>  		addr =3D encl->base + modt->offset + c;
> =20
>  		sgx_reclaim_direct();
> @@ -1101,6 +1126,13 @@ static long sgx_encl_remove_pages(struct sgx_encl =
*encl,
>  	secinfo.flags =3D SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
> =20
>  	for (c =3D 0 ; c < params->length; c +=3D PAGE_SIZE) {
> +		if (sgx_check_signal_and_resched()) {
> +			if (!c)
> +				ret =3D -ERESTARTSYS;
> +
> +			goto out;
> +		}
> +
>  		addr =3D encl->base + params->offset + c;
> =20
>  		sgx_reclaim_direct();

I think Dave's suggestions make sense, so unfortunately needs yet
another spin.=20

BR, Jarkko

