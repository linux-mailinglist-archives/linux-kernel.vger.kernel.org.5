Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7E7DB86B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjJ3KpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJ3Ko7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:44:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F1683
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:44:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 436A421CAD;
        Mon, 30 Oct 2023 10:44:56 +0000 (UTC)
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id CA894A3E05;
        Mon, 30 Oct 2023 10:44:55 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id 07E224A0396; Mon, 30 Oct 2023 11:44:56 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
In-Reply-To: <20210419005539.22729-6-mick@ics.forth.gr> (Nick Kossifidis's
        message of "Mon, 19 Apr 2021 03:55:39 +0300")
References: <20210419005539.22729-1-mick@ics.forth.gr>
        <20210419005539.22729-6-mick@ics.forth.gr>
X-Yow:  Four thousand different MAGNATES, MOGULS & NABOBS are romping in my
 gothic solarium!!
Date:   Mon, 30 Oct 2023 11:44:56 +0100
Message-ID: <mvmjzr475jr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of schwab@suse.de) smtp.mailfrom=schwab@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.49 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[5];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[17.22%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 436A421CAD
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19 2021, Nick Kossifidis wrote:

> @@ -605,6 +606,18 @@ static void __init reserve_crashkernel(void)
>  
>  	int ret = 0;
>  
> +	/*
> +	 * Don't reserve a region for a crash kernel on a crash kernel
> +	 * since it doesn't make much sense and we have limited memory
> +	 * resources.
> +	 */
> +#ifdef CONFIG_CRASH_DUMP
> +	if (is_kdump_kernel()) {
> +		pr_info("crashkernel: ignoring reservation request\n");
> +		return;
> +	}
> +#endif
> +

Why is this necessary?  It breaks
https://github.com/openSUSE/kdump/tree/master/calibrate which wants to
run the kernel with both elfcorehdr and crashkernel.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
