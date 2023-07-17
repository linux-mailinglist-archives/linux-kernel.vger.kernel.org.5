Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33563756C87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGQSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8299;
        Mon, 17 Jul 2023 11:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF71F611E9;
        Mon, 17 Jul 2023 18:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D4C433C8;
        Mon, 17 Jul 2023 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689620016;
        bh=MJ+3g/By8w8uqFVuPWUmEVk3gER9FDbhho5+chT2JB4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=mzcQNFn4zTUv1psOAgofMF0FP4j0vc5sfZec2W5u3AvU1paHyr1IVmCTYo2f1uxh6
         R48jm/4L4JsZ5ARR72PKp016hza7C7BBijP3AZnIVuX0/OZgP61Z+qNk4lZgrbqtqi
         KZultOvIcvsz09OaOyTLDHewYwygvwRnSA+aosHQMe1CB/tW/UE8UATkLXVQlOGrKY
         E/W9OO20WDlq2Isfu13Ww4LSQ40GHwu4cfrR4cUlPYnSzCLPh2lv4VLh9gWEuVaSxg
         PLS2BGO9vdZiffi/XoJrjJPZvpRcSA10eo8NX7+DKUmCP+qIC66IboBahm9SIwv2Er
         /Xpw6OUlTy3pA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 18:53:31 +0000
Message-Id: <CU4OB1RHGF50.1X9C9BVY4XM42@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <kristen@linux.intel.com>, <seanjc@google.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230717181732.84039-1-haitao.huang@linux.intel.com>
In-Reply-To: <20230717181732.84039-1-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 17, 2023 at 6:17 PM UTC, Haitao Huang wrote:
> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
> cgroup worker) may reclaim the SECS EPC page for an enclave and set
> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
> the SGX #PF handler without checking for NULL and reloading.
>
> Fix this by checking if SECS is loaded before EAUG and load it if it was
> reclaimed.
>
> Fixes: 5a90d2c3f5ef8 ("x86/sgx: Support adding of pages to an initialized=
 enclave")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 25 ++++++++++++++++++++-----
>  arch/x86/kernel/cpu/sgx/main.c |  4 ++++
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 2a0e90fe2abc..d39e502bb7b0 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -235,6 +235,16 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx=
_encl_page *encl_page,
>  	return epc_page;
>  }
> =20
> +static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
> +{
> +	struct sgx_epc_page *epc_page =3D encl->secs.epc_page;
> +
> +	if (!epc_page) {
> +		epc_page =3D sgx_encl_eldu(&encl->secs, NULL);
> +	}

remove curly braces

> +	return epc_page;
> +}
> +
>  static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  						  struct sgx_encl_page *entry)
>  {
> @@ -248,11 +258,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(st=
ruct sgx_encl *encl,
>  		return entry;
>  	}
> =20
> -	if (!(encl->secs.epc_page)) {
> -		epc_page =3D sgx_encl_eldu(&encl->secs, NULL);
> -		if (IS_ERR(epc_page))
> -			return ERR_CAST(epc_page);
> -	}
> +	epc_page =3D sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page))
> +		return ERR_CAST(epc_page);
> =20
>  	epc_page =3D sgx_encl_eldu(entry, encl->secs.epc_page);
>  	if (IS_ERR(epc_page))
> @@ -339,6 +347,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_=
struct *vma,
> =20
>  	mutex_lock(&encl->lock);
> =20
> +	epc_page =3D sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page)) {
> +		if (PTR_ERR(epc_page) =3D=3D -EBUSY)
> +			vmret =3D  VM_FAULT_NOPAGE;
> +		goto err_out_unlock;
> +	}
> +
>  	epc_page =3D sgx_alloc_epc_page(encl_page, false);
>  	if (IS_ERR(epc_page)) {
>  		if (PTR_ERR(epc_page) =3D=3D -EBUSY)
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 166692f2d501..4662a364ce62 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -257,6 +257,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page =
*epc_page,
> =20
>  	mutex_lock(&encl->lock);
> =20
> +	/* Should not be possible */
> +	if (WARN_ON(!(encl->secs.epc_page)))
> +		goto out;
> +
>  	sgx_encl_ewb(epc_page, backing);
>  	encl_page->epc_page =3D NULL;
>  	encl->secs_child_cnt--;
> --=20
> 2.25.1

BR, Jarkko
