Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC17EBA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjKNXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjKNXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:17:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2CD6;
        Tue, 14 Nov 2023 15:17:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDD5C433C8;
        Tue, 14 Nov 2023 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700003866;
        bh=KB3X/TgdZDL/2SrctEZtbC9ABrG1q5tejZewZjojaG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I2FtgASHqT0NQ8pvMyoHDKY0L776FVzQEP+8MaG5h3awzZ83eZZkVJ5tDMyqMY0jb
         uNf09+vkik6GFj+3lMsunyHL6E+r2LTs8yQweYL9C7/V0/hHwRijTrIX+w/vU+Tbus
         VWm/hOguMarPwLXKltXgnv9nM3o8N2knOblTYH/4=
Date:   Tue, 14 Nov 2023 15:17:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, ebiederm@xmission.com,
        takahiro.akashi@linaro.org
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-Id: <20231114151745.e77ed504b3fce325f54ec08e@linux-foundation.org>
In-Reply-To: <20231114091658.228030-2-bhe@redhat.com>
References: <20231114091658.228030-1-bhe@redhat.com>
        <20231114091658.228030-2-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 17:16:57 +0800 Baoquan He <bhe@redhat.com> wrote:

> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code to load kernel, initrd etc when
> preparing kexec reboot.
>
> ...
>
> +/*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res, *rams;
> +	int rams_size = 16, i;
> +	unsigned long flags;
> +	int ret = -1;
> +
> +	/* create a list */
> +	rams = kvcalloc(rams_size, sizeof(struct resource), GFP_KERNEL);
> +	if (!rams)
> +		return ret;
> +
> +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	i = 0;
> +	while ((start < end) &&
> +		(!find_next_iomem_res(start, end, flags, IORES_DESC_NONE, &res))) {
> +		if (i >= rams_size) {
> +			/* re-alloc */
> +			struct resource *rams_new;
> +			int rams_new_size;
> +
> +			rams_new_size = rams_size + 16;
> +			rams_new = kvcalloc(rams_new_size, sizeof(struct resource),
> +					    GFP_KERNEL);

kvrealloc()?

> +			if (!rams_new)
> +				goto out;
> +
> +			memcpy(rams_new, rams,
> +					sizeof(struct resource) * rams_size);
> +			kvfree(rams);
> +			rams = rams_new;
> +			rams_size = rams_new_size;
> +		}
> +
> +		rams[i].start = res.start;
> +		rams[i++].end = res.end;
> +
> +		start = res.end + 1;
> +	}
> +
> +	/* go reverse */
> +	for (i--; i >= 0; i--) {
> +		ret = (*func)(&rams[i], arg);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	kvfree(rams);
> +	return ret;
> +}
> +
>  /*
>   * This function calls the @func callback against all memory ranges, which
>   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> -- 
> 2.41.0
