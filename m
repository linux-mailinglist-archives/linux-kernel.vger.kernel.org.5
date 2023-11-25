Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4B7F8C33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjKYP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjKYP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E34EA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700927886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUDe/htmzQcjOjFQ655hGBsTMxov6jQj5H0/eizQxuY=;
        b=I68NXCmDHfFk8Jns+8UUaiF+HGSLDiJS/4OfQT0H2QvAO2PMV/Vvo96NLs4gKMlJljHqeS
        KVzhRkypvqw2kmk1WBXyINuwuIQrvCe/FsHMmlnrv2uL+9tIgtOh2lEPYpKNJjtUsUzCsx
        TxkxU0H7AxzDrDyTJNNdsD+xVJK2gHs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-PcsJqFGmNXWiUc_k0Z90Xg-1; Sat,
 25 Nov 2023 10:58:02 -0500
X-MC-Unique: PcsJqFGmNXWiUc_k0Z90Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD59A1C04B4C;
        Sat, 25 Nov 2023 15:58:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE6B35028;
        Sat, 25 Nov 2023 15:57:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 25 Nov 2023 16:56:56 +0100 (CET)
Date:   Sat, 25 Nov 2023 16:56:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florent Revest <revest@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Stefan Roesch <shr@devkernel.io>,
        Andy Chiu <andy.chiu@sifive.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, rongtao@cestc.cn
Subject: Re: [PATCH] prctl: Get private anonymous memory region name
Message-ID: <20231125155651.GA23245@redhat.com>
References: <tencent_977CBF8E8CA6234A1B740A35655D5D7EAA0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_977CBF8E8CA6234A1B740A35655D5D7EAA0A@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25, Rong Tao wrote:
>
> +static int prctl_get_vma(unsigned long opt, unsigned long addr,
> +			 unsigned long buf, unsigned long arg)
> +{
> +	struct mm_struct *mm = current->mm;
> +	const char __user *u_buf;
> +	int error;
> +
> +	switch (opt) {
> +	case PR_GET_VMA_ANON_NAME:
> +		const struct anon_vma_name *anon_name = NULL;
> +
> +		u_buf = (const char __user *)buf;
> +		error = 0;
> +
> +		mmap_read_lock(mm);
> +		anon_name = madvise_get_anon_name(mm, addr);
> +		if (!anon_name) {
> +			mmap_read_unlock(mm);
> +			error = -EFAULT;

may be another error code makes sense to distinguish this case from
the copy_to_user() failure?

> +			break;
> +		}
> +
> +		if (copy_to_user((char __user *)u_buf, anon_name->name,
> +				 strlen(anon_name->name) + 1))
> +			error = -EFAULT;

and I guess you can simplify this code a bit,

		anon_name = madvise_get_anon_name(...);
		if (!anon_name || copy_to_user(...))
			error = -EFAULT;
		
		mmap_read_unlock(mm);
		anon_vma_name_put(anon_name); // safe if anon_name == NULL;

> +const struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
> +						  unsigned long start)
> +{
> +	struct vm_area_struct *vma;
> +	struct anon_vma_name *anon_name;
> +
> +	vma = find_vma(mm, start);
> +	if (vma) {
> +		anon_name = anon_vma_name(vma);
> +		if (anon_name) {
> +			anon_vma_name_get(anon_name);
> +			return anon_name;
> +		}
> +	}
> +
> +	return NULL;

Again, afaics this can be simplified,

	struct anon_vma_name *anon_name = NULL;

	vma = find_vma(mm, start);
	if (vma) {
		anon_name = anon_vma_name(vma);
		anon_vma_name_get(anon_name);
	}

	return anon_name;

Oleg.

