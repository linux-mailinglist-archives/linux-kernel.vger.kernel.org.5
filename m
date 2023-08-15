Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7477CFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbjHOQM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbjHOQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AEB13E;
        Tue, 15 Aug 2023 09:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E940E64DEE;
        Tue, 15 Aug 2023 16:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16064C433C8;
        Tue, 15 Aug 2023 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692115970;
        bh=N3OM+clUa6koI6lGjQiHjHyRvH37l0zus4518nO+E10=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kBD6aRCww6QnLx/rsU4KOMW6CAq1bwVClHVVTzB1NWX4qtMrx2YzWryIPIjwL5Ks6
         MJLQU6DxP8I9bOo6AqFofCHp26tQxPEA/HPWiI2hORuvG30zP8j8jR+CKH1kdfqASK
         piwANskal1t91lFVp/NgrC7vrL8YqlxIAWCoI5IsUiE9fQwgtHWebNZGDmi0jevokt
         cK2P7BCEZI3LIY7fJLbQ3nmlDaQC86ArrFw2yKHL6WZZzD4SIvPGfKOkYMDIG6wlMT
         NDaLFYYYmP1Zrg3D8O7DmKlwmtSN6SBXu6xYwKbdEqgD5CkoQQXyaEgFHaYd9UC4Z9
         7FKgXPmZAm9vg==
Message-ID: <ed79681e-ecd1-3129-5ad1-2965e2cd42b5@kernel.org>
Date:   Tue, 15 Aug 2023 09:12:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARC: avoid unwanted gcc optimizations in atomic
 operations
To:     Pavel.Kozlov@synopsys.com, linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vgupta@kernel.org,
        stable@vger.kernel.org
References: <20230815151136.2220588-1-kozlov@synopsys.com>
Content-Language: en-US
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230815151136.2220588-1-kozlov@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 08:11, Pavel.Kozlov@synopsys.com wrote:
> From: Pavel Kozlov<pavel.kozlov@synopsys.com>
>
> Notify a compiler about write operations and prevent unwanted
> optimizations. Add the "memory" clobber to the clobber list.
>
> An obvious problem with unwanted compiler optimizations appeared after
> the cpumask optimization commit 596ff4a09b89 ("cpumask: re-introduce
> constant-sized cpumask optimizations").
>
> After this commit the SMP kernels for ARC no longer loads because of
> failed assert in the percpu allocator initialization routine:
>
> percpu: BUG: failure at mm/percpu.c:2981/pcpu_build_alloc_info()!
>
> The write operation performed by the scond instruction in the atomic
> inline asm code is not properly passed to the compiler. The compiler
> cannot correctly optimize a nested loop that runs through the cpumask
> in the pcpu_build_alloc_info() function.
>
> Add the "memory" clobber to fix this.
>
> Link:https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/135
> Cc:<stable@vger.kernel.org>  # v6.3+
> Signed-off-by: Pavel Kozlov<pavel.kozlov@synopsys.com>


Acked-by: Vineet Gupta <vgupta@kernel.org>

Fixes: b64be6836993c431e ("ARC: atomics: implement relaxed variants")

Before that commit, atomic ops could elide memory clobber because the 
trailing smp_mb() did that anyways.
However after that commit, the smp_mb() was optional for relaxed 
variants and thus needs clobber.

