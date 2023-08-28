Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDA78A99A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjH1KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjH1KFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:05:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C58C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:05:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693217104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llI1bC4UzeF1tVpvR70IMRjfXqcAoAEBqzcLWKtWhGI=;
        b=iCwoszyg4aUkMhKh03Et0dqmSC8BLO6k7Yg1lqNFGeEIIprCrs1F3ANsGfN8oEaCep4kjd
        /bEGnTCgCMT7VFfmyireMxzZZ3T1kgL2VZRvEso+F1+YFEMc8E0Gs5ilMZ4LYJVydLSx0R
        JpJLDGGPai11L6LYmWGjIQzm3xPQ9lovEy/W43ibhDW7LZYWQ80xpDZdrR/jkcOlkNn613
        tUz0PtgD92TrP7JjrkNSih9vpBrKSs/LBx7IwXohdkSmqpcWW3YPdo2kYsWv+oD1gqCuJZ
        quiLTxP/CTI9b02rQS+nzHC46SBtdJdLOQZ1YiRdhmYCfvmH8PwSunSmS7WS3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693217104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llI1bC4UzeF1tVpvR70IMRjfXqcAoAEBqzcLWKtWhGI=;
        b=nJzkC/3ohbsu3iEeb8BjQ42XMWxfH2kuvG31ItxyKrzZMmCKTEP2a1fN37zSXu7iH1FG02
        ATwKHIRwXRphsRBA==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com>
Date:   Mon, 28 Aug 2023 12:05:03 +0200
Message-ID: <87r0nn8ots.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prateek!

On Mon, Aug 28 2023 at 11:37, K. Prateek Nayak wrote:
> On 8/14/2023 2:24 PM, Thomas Gleixner wrote:
>
> Since these enums come from the description of level type of CPUID leaf
> 0x1f, can we have a short description clarifying what each signify. This
> will also help clarify the mappings for AMD's extended CPUID leaf
> 0x80000026 (specifically for CCX and CCD level types). I had following
> in my mind:

Makes sense.

>  	TOPO_MODULE_DOMAIN,
> +	/*
> +	 * If exists, represents a group of tiles within
> +	 * an instance of the next domain
> +	 *
> +	 * On Intel: This level contains a group of Tile
> +	 * type as described by CPUID leaf 0x1f
> +	 *
> +	 * On AMD: This is the group of "Complex" type
> +	 * instances as described by CPUID leaf
> +	 * 0x8000_0026
> +	 */
>  	TOPO_TILE_DOMAIN,
> +	/*
> +	 * If exists, represents a group of dies within an
> +	 * instance of the next domain
> +	 *
> +	 * On Intel: This level contains group of Die
> +	 * type as described by CPUID leaf 0x1f
> +	 *
> +	 * On AMD: This is the group of "CCD (Die)"
> +	 * type instances as described by CPUID leaf
> +	 * 0x8000_0026
> +	 */
>  	TOPO_DIE_DOMAIN,
> +	/*
> +	 * If exists, represents a group of packages
> +	 * within the root domain
> +	 */
>  	TOPO_PKG_DOMAIN,
> +	/* Topmost domain with a singular instance */
>  	TOPO_ROOT_DOMAIN,
>  	TOPO_MAX_DOMAIN,
>  };

Now this begs the obvious question what the actual meaning of these
domains is and what's their relevance for the kernel.

It's probably undisputed what SMT/CORE mean and what their relevance is.
The PKG/DIE domains are pretty clear too.

Now we have:

    MODULE      (Intel only)

    TILE        Intel, AMD names it "Complex"

So here are the questions:

   - is TILE to "Complex" the proper mapping?

   - which information is conveyed by MODULE and TILE?

   - Are these really different between AMD and Intel or is this some
     naming convention issue which needs to be resolved?

Thanks,

        tglx

