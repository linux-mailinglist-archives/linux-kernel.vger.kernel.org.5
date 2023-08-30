Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FD78DFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbjH3T30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbjH3Ou7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:50:59 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9CEFF;
        Wed, 30 Aug 2023 07:50:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C7225CC;
        Wed, 30 Aug 2023 14:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C7225CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693407053; bh=CGC2+sJRlyPyvstCgdyHNPMRf4Fom6L1Najc3yZL/cQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pUBpw14Os43A5nRvyphht8lcH5JYldqKY2+QlC8x9OgyWk/m9y8qPuvQiN3CNS9zO
         tnL1vMTv/NLI1p4kwN4e62GkxBB9x3D8G8uRv/l4rVJ1p0qh3Okwi45IK7+KjQrq+q
         ubrVjgYOA25TAkP8hxQR1nbrkKyDNz0q6ylST/ofFZtMpl8e8+OL23FjUmvZak3LFf
         9FmaN+5OzdvKJyXMVd87Kn+oSPiPZ3xWuRctt719RR3bv9nKF+7JyHlYBG2hEJwOtq
         Kbv4f+JtPI8iOxh7t0NJ9d1wJM2Kbni2p88g8vF+W7rOJbaF2nT1IyqOk48pjAVBCE
         9RhjNxfns2rtQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Takahiro Itazuri <itazur@amazon.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: Re: [PATCH] docs: Add desc for best effort mode of mmio_stale_data
In-Reply-To: <20230830144426.80258-1-itazur@amazon.com>
References: <20230830144426.80258-1-itazur@amazon.com>
Date:   Wed, 30 Aug 2023 08:50:52 -0600
Message-ID: <87msy8r3cj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro Itazuri <itazur@amazon.com> writes:

> Similar to the sysfs files for mds and tsx_async_abort, that for
> mmio_stale_data also provides the best effort mitigation mode which
> invokes the mitigation instructions without a guarantee they clear the
> CPU buffers to address virtualized scenarios. Adds description for the
> mode in the mmio_stale_data's page to make it self-contained.
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  .../hw-vuln/processor_mmio_stale_data.rst     | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> index c98fd1190..c1c96eeb8 100644
> --- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> +++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> @@ -226,7 +226,7 @@ The possible values in this file are:
>         - The processor is vulnerable, but no mitigation enabled
>       * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
>         - The processor is vulnerable, but microcode is not updated. The
> -         mitigation is enabled on a best effort basis.
> +         mitigation is enabled on a best effort basis. See :ref:`best_effort`.
>       * - 'Mitigation: Clear CPU buffers'
>         - The processor is vulnerable and the CPU buffer clearing mitigation is
>           enabled.
> @@ -254,6 +254,23 @@ the above information:
>    'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
>    ========================  ===========================================
>  
> +.. _best_effort:
> +
> +Best effort mitigation mode
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the processor is vulnerable, but the availability of the microcode-based
> +mitigation mechanism is not advertised via CPUID the kernel selects a best
> +effort mitigation mode.  This mode invokes the mitigation instructions
> +without a guarantee that they clear the CPU buffers.
> +
> +This is done to address virtualization scenarios where the host has the
> +microcode update applied, but the hypervisor is not yet updated to expose the
> +CPUID to the guest. If the host has updated microcode the protection takes
> +effect; otherwise a few CPU cycles are wasted pointlessly.
> +
> +The state in the mmio_stale_data sysfs file reflects this situation accordingly.
> +

So the change seems OK, but why not just describe the "best effort" mode
in the place where you refer to it, rather than creating a forward
reference?

Thanks,

jon
