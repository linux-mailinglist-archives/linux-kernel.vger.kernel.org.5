Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0476803E23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjLDTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjLDTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:12:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B2FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:13:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2424CC433C8;
        Mon,  4 Dec 2023 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701717182;
        bh=DF4i7VfdHFjU05wcCcPJaPR5JV0IOaDMnlYWyt6aCV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kxlpz/LKZoseZnQyZK0lBJrY0nGrMHNQAoj7u2HrMnoTEpfY67bSvSZxV6m5ZFvwY
         yZoC0pUuPgaWFZn94kG1Wr8E0atdjh2RrTTkB3nLGSbsD2U5kuzfl+tEo+BX8Kxc1Y
         LXcq5lfE4qDSZJ16h+IIxFKjyf+29xOILzUG6918=
Date:   Mon, 4 Dec 2023 11:13:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmytro Maluka <dmaluka@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option
Message-Id: <20231204111301.7e087b2f851b30121561e8fc@linux-foundation.org>
In-Reply-To: <20231204163254.2636289-1-dmaluka@chromium.org>
References: <20231204163254.2636289-1-dmaluka@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Dec 2023 17:32:54 +0100 Dmytro Maluka <dmaluka@chromium.org> wrote:

> Add an option to disable transparent hugepages by default, in line with
> the existing transparent_hugepage=never command line setting.
> 
> Rationale: khugepaged has its own non-negligible memory cost even if it
> is not used by any applications, since it bumps up vm.min_free_kbytes to
> its own required minimum in set_recommended_min_free_kbytes(). For
> example, on a machine with 4GB RAM, with 3 mm zones and pageblock_order
> == MAX_ORDER, starting khugepaged causes vm.min_free_kbytes increase
> from 8MB to 132MB.
> 
> So if we use THP on machines with e.g. >=8GB of memory for better
> performance, but avoid using it on lower-memory machines to avoid its
> memory overhead, then for the same reason we also want to avoid even
> starting khugepaged on those <8GB machines. So with
> CONFIG_TRANSPARENT_HUGEPAGE_NEVER we can use the same kernel image on
> both >=8GB and <8GB machines, with THP support enabled but khugepaged
> not started by default. The userspace can then decide to enable THP
> (i.e. start khugepaged) via sysfs if needed, based on the total amount
> of memory.
> 
> This could also be achieved with the existing transparent_hugepage=never
> setting in the kernel command line instead. But it seems cleaner to
> avoid tweaking the command line for such a basic setting.
> 
> P.S. I see that CONFIG_TRANSPARENT_HUGEPAGE_NEVER was already proposed
> in the past [1] but without an explanation of the purpose.
> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -859,6 +859,12 @@ choice
>  	  madvise(MADV_HUGEPAGE) but it won't risk to increase the
>  	  memory footprint of applications without a guaranteed
>  	  benefit.
> +
> +	config TRANSPARENT_HUGEPAGE_NEVER
> +		bool "never"
> +	help
> +	  Disabling Transparent Hugepage by default. It can still be

s/Disabling/Disable/

> +	  enabled at runtime via sysfs.
>  endchoice

The patch adds the config option but doesn't use it?
