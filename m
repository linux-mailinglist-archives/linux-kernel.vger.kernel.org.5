Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B767ED522
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbjKOVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjKOVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:00:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04021FDB;
        Wed, 15 Nov 2023 12:59:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D51C433D9;
        Wed, 15 Nov 2023 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700081986;
        bh=cGbVOGrDBir77EpazpzYMNtu/vjZuZ+xwCpP4c+mNjE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=QXjkHzBV8aNvcErUZuxqfo4cSdxhQuEdcFH5/2XSvlrDdsF+O+tCXCUz3CrkVJz7L
         0D8AJz1jc5BQlWGPEJdjpXZSorMzOUWX8ycfttw3ZlCNvew0NplH11NgmQe3eJ8vD7
         Ec7kPiIY5O6vULChUallAi9zqmFsFdD8AZLkKtfJaIy3V4LsCT4OKDGzxtZt7DWDrE
         9QiHb/sERKYQdu/+vbJR0VOgwjLnsWxwCuzge75XSP7+G1syNuXfSU3pDsHLAi7iiM
         iPXksBS69hosBqHcsR4ecPZfrRJ1TAuRfknQFRm52VuJNH+6v8IoP4RuQEXftelxkQ
         GCDLTL0WHU/Jg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 22:59:40 +0200
Message-Id: <CWZORJV320UP.1NJD0AI5M6QZT@kernel.org>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 08/12] x86/sgx: Use a list to track to-be-reclaimed
 pages
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-9-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-9-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Change sgx_reclaim_pages() to use a list rather than an array for
> storing the epc_pages which will be reclaimed. This change is needed
> to transition to the LRU implementation for EPC cgroup support.
>
> When the EPC cgroup is implemented, the reclaiming process will do a
> pre-order tree walk for the subtree starting from the limit-violating
> cgroup.  When each node is visited, candidate pages are selected from
> its "reclaimable" LRU list and moved into this temporary list. Passing a
> list from node to node for temporary storage in this walk is more
> straightforward than using an array.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang<haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V6:
> - Remove extra list_del_init and style fix (Kai)
>
> V4:
> - Changes needed for patch reordering
> - Revised commit message
>
> V3:
> - Removed list wrappers
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 35 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index e27ac73d8843..33bcba313d40 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -296,12 +296,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
 *epc_page,
>   */
>  static void sgx_reclaim_pages(void)
>  {
> -	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> +	struct sgx_epc_page *epc_page, *tmp;
>  	struct sgx_encl_page *encl_page;
> -	struct sgx_epc_page *epc_page;
>  	pgoff_t page_index;
> -	int cnt =3D 0;
> +	LIST_HEAD(iso);
>  	int ret;
>  	int i;
> =20
> @@ -317,7 +316,7 @@ static void sgx_reclaim_pages(void)
> =20
>  		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
>  			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
> -			chunk[cnt++] =3D epc_page;
> +			list_move_tail(&epc_page->list, &iso);
>  		} else
>  			/* The owner is freeing the page. No need to add the
>  			 * page back to the list of reclaimable pages.
> @@ -326,8 +325,11 @@ static void sgx_reclaim_pages(void)
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> +	if (list_empty(&iso))
> +		return;
> +
> +	i =3D 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page =3D epc_page->owner;
> =20
>  		if (!sgx_reclaimer_age(epc_page))
> @@ -342,6 +344,7 @@ static void sgx_reclaim_pages(void)
>  			goto skip;
>  		}
> =20
> +		i++;
>  		encl_page->desc |=3D SGX_ENCL_PAGE_BEING_RECLAIMED;
>  		mutex_unlock(&encl_page->encl->lock);
>  		continue;
> @@ -349,27 +352,19 @@ static void sgx_reclaim_pages(void)
>  skip:
>  		spin_lock(&sgx_global_lru.lock);
>  		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
> -		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
> +		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
>  		spin_unlock(&sgx_global_lru.lock);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> -
> -		chunk[i] =3D NULL;
> -	}
> -
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> -		if (epc_page)
> -			sgx_reclaimer_block(epc_page);
>  	}
> =20
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> -		if (!epc_page)
> -			continue;
> +	list_for_each_entry(epc_page, &iso, list)
> +		sgx_reclaimer_block(epc_page);
> =20
> +	i =3D 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page =3D epc_page->owner;
> -		sgx_reclaimer_write(epc_page, &backing[i]);
> +		sgx_reclaimer_write(epc_page, &backing[i++]);

Couldn't you alternatively "&backing[--i]" and not reset i to zero
before the loop?

> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		sgx_epc_page_reset_state(epc_page);

BR, Jarkko
