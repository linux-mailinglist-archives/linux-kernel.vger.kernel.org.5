Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419277FA5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjK0QJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjK0QJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:09:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303EFA7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:09:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07CBC433C8;
        Mon, 27 Nov 2023 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701101374;
        bh=u6iWdo/8a2a6pHkq5FkOccFiPiQNgIqfuW+dZLSH+jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCr5YsqSSE1eyQWuoDx7kB+6p0HXj51KWg3lgJj2xjaEa31UJr7oPSVFdfEGtUPFN
         LTh3RJQtSQdFIjByszyBFNUsCWycw8qIENRxJZ3BLpWWQocz3iMx1o/LjKJsa7Ygjm
         MgW38x9qRQqZepTeKXjYV66/LbzBTzUmW3jpdROIQ626dpnLNGaHXXu+JGdTz098WF
         Pcl95/5JfKYfHrF48s2CUXdxJpa+uqiyHBN8apQbWW2brUWNdEkmtL6sA921iCFfvb
         +a6hFgjOMy1b28yBX+7ccOLEh0ZN0K+GF+Y/wCzJHUp6m4K8/vuDaJFa9aUkw6XAIF
         5o/qdFqBREZ4w==
Date:   Mon, 27 Nov 2023 23:57:09 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Use asm-generic for {read,write}{bwlq} and their
 relaxed variant
Message-ID: <ZWS8VYwpsKoc56fV@xhacker>
References: <20231123142003.1759-1-jszhang@kernel.org>
 <20231127-swell-garnish-3f2104647aa0@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127-swell-garnish-3f2104647aa0@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:39:16AM +0000, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 10:20:03PM +0800, Jisheng Zhang wrote:
> > The asm-generic implementation is functionally identical to the riscv
> > version.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> This fails to build for nommu:
>   /tmp/tmp.ojumpiEgOt/arch/riscv/include/asm/timex.h:20:16: error: implicit declaration of function 'readq_relaxed' [-Werror=implicit-function-declaration]
>   /tmp/tmp.ojumpiEgOt/include/asm-generic/io.h:342:23: error: conflicting types for 'readq_relaxed'; have 'u64(const volatile void *)' {aka 'long long unsigned int(const volatile void *)'}
> 
>   Cheers,
>   Conor.

Hi,

Thanks for the report. I can reproduce the build error locally.
The problem is readl_relaxed usage in timex.h.

If include <asm/io.h> in timex.h, then we will meet issues which is
fixed by commit 0c3ac289.

If not include <asm/io.h>, then the readl_relaxed readq_relaxed
are not explictly declared as reported here.

I have two solutions:

solA: use __raw_readl and __raw_readq in timex, since I found other
architectures use the raw asm instructions for get_cycles()

solB: remove clint_time_val and export a function in timer-clint.c as below:
get_clint_cycles()
{
	readl_relaxed(clint_time_val);
}

then
#define get_cycles get_clint_cycles

Both solutions can solve the issues. which one is better?

Thanks in advance

