Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF05782762
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHUKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHUKue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A6D9;
        Mon, 21 Aug 2023 03:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B40061268;
        Mon, 21 Aug 2023 10:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E86C433C8;
        Mon, 21 Aug 2023 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692615031;
        bh=SPB6C11Uq6IBmODhz1ZaVF0nV+d6zvnkOtu10TQzw8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9oXYT6xk2iU9QEK4wTM8puxmfwHa0hQRnd8db3TuM983S7rfDeuNhBcZnpU+2r7R
         dszWy/fX3K4/1VAoqYJ+OAARMq/TgIx94IcPgjwoqVg7pPH7Uy0iygmtg0BtZy/mNh
         LyDHFsiBHGdnDEXa92exbljx9GGCjlSExcfy/cAZDuYnTq+vMLK1g0dRNZyZjfpGip
         nZ0rOevjtoK9Jwwzgvh4gmc2YVJQ8hyfFqHSSKH1ysGVrgNvfZG0IVSeHDSz39+XLs
         iF0qGzpNA5ZA+9WnUKaH+tSj+94Mc9FEGrnzW8dk7TtH0dah157rYosA3ErZDdki7N
         lb0DWkq2jQKhA==
Date:   Mon, 21 Aug 2023 11:50:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Message-ID: <20230821105025.GB19469@willie-the-truck>
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 06:22:12PM +0800, Shuai Xue wrote:
> When a process tries to access a page that is already offline

How does this happen?

> the kernel will send a sigbus signal with the BUS_MCEERR_AR code. This
> signal is typically handled by a registered sigbus handler in the
> process. However, if the process does not have a registered sigbus
> handler, it is important for end users to be informed about what
> happened.
> 
> To address this, add an error message similar to those implemented on
> the x86, powerpc, and parisc platforms.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  arch/arm64/mm/fault.c  | 2 ++
>  arch/parisc/mm/fault.c | 5 ++---
>  arch/x86/mm/fault.c    | 3 +--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3fe516b32577..38e2186882bd 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
>  		unsigned int lsb;
>  
> +		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> +		       current->comm, current->pid, far);
>  		lsb = PAGE_SHIFT;
>  		if (fault & VM_FAULT_HWPOISON_LARGE)
>  			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));

Hmm, I'm not convinced by this. We have 'show_unhandled_signals' already,
and there's plenty of code in memory-failure.c for handling poisoned pages
reported by e.g. GHES. I don't think dumping extra messages in dmesg from
the arch code really adds anything.

Will
