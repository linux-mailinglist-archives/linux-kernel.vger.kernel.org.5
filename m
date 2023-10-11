Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C37C48E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 06:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjJKEm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 00:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbjJKEm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 00:42:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81ED94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:42:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02561C433C8;
        Wed, 11 Oct 2023 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696999374;
        bh=NYNisQuom27rBBJUfP7fvKUCts8FyNst+nzRKYiXRgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+YMg1lcNAhugNq0hVyJhWNO15HUnl7sfbqkcuNsA97qPrFaocaBoxH0rt1Ks+vMM
         nRIkvHGSTW7dnZKQWZ69K6R4XKGHIG2Up9Tw6xXwI8JmqC54TuCuv5bFO8GzCaORaT
         yr3LD10abrgUB6pwHEQdltQRQu5gO0yghMH9jZ6dnwnhg/7lvUiIfGw8JVB8KOTnX1
         WeTCmlKwc8g0lAVfb20pk9yINgyd2HRG8OWIA2+XUpdk14zxm0UUz/9y3CXAL5xIAh
         CInUjJkliBc69D3OITHRNkPaqHRMddwEeolPZTEZCjNl9FbQNBisEAk5n5omSjfi7o
         cbB4RxYEfZHFw==
Date:   Tue, 10 Oct 2023 21:42:52 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231011044252.42bplzjsam3qsasz@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010103028.4192223-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:30:27AM -0700, Breno Leitao wrote:
> +config MITIGATE_MDS
> +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
> +	  a hardware vulnerability which allows unprivileged speculative access
> +	  to data which is available in various CPU internal buffer. Deeper
> +	  technical information is available in the MDS specific x86 architecture
> +	  section: Documentation/arch/x86/mds.rst.

MITIGATE_GDS seems to be missing?

For consistency I'm thinking it would be better to call them
MITIGATION_* rather than MITIGATE_* since they're under the
SPECULATION_MITIGATIONS menuentry, and the bugs code almost exclusively
uses the noun "mitigation" rather than the verb "mitigate".

While we're at it should we go ahead and rename the existing options?

e.g.:

  MITIGATION_PAGE_TABLE_ISOLATION
  MITIGATION_RETPOLINE
  MITIGATION_UNRET_ENTRY
  MITIGATION_CALL_DEPTH_TRACKING
  MITIGATION_IBPB_ENTRY
  MITIGATION_IBRS_ENTRY
  MITIGATION_SRSO
  MITIGATION_SLS

-- 
Josh
