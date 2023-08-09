Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83799776203
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHIOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHIOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5C1FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD1A62FDC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4AEC433C8;
        Wed,  9 Aug 2023 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691589934;
        bh=C4vGr9VtQ1uJZ1AEXz3WxHMpY3hLIOJDo+mTGMKQeJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRS+cZPwvkKV+8bca4C1LLK2tmCojpzDB4Ip4t7A+qZ7wDMplRv3TwyfY5WwIvaj+
         lAwpzLlufCQJnGT4z46peHy1lfbCICNv+XikWaeYHxPD37O+DS272hxGqDwvJU/PnE
         L7XpmjAqvHO+RBMfq85PFJTzRw1iYmm5TjYYdoGO33bb4PhUunjvdCoWsCggEueplE
         cP7M0i7blFe4I3hrYEJWLnpambzQSxZikkGu+HWs16wmaG3TpBmeQ5+E2DhaT4LQoQ
         SZTjqE4IlXmp55z13/PxqId91Rfyoz53Av+T66B2yCylXcXlnM4WtuqcPGdwQm8m6i
         H6FJNgDwovy8Q==
Date:   Wed, 9 Aug 2023 10:05:30 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Message-ID: <20230809140530.bijq3asl26d2pu7u@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072201.192502969@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:29AM +0200, Peter Zijlstra wrote:
> @@ -2607,26 +2447,26 @@ static ssize_t srbds_show_state(char *bu
>  static ssize_t retbleed_show_state(char *buf)
>  {
>  	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> +	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO ||
> +	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO_ALIAS ||
>  	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {

These retbleed_show_state() changes probably belong in that other patch
which adds the retbleed= cmdline options.

> +
>  		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>  			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
>  
> -		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
> +		return sysfs_emit(buf, "%s; SMT %s%s\n", retbleed_strings[retbleed_mitigation],
>  				  !sched_smt_active() ? "disabled" :
>  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
>  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
> -				  "enabled with STIBP protection" : "vulnerable");
> -	}
> +				  "enabled with STIBP protection" : "vulnerable",
> +				  cpu_has_ibpb_brtype_microcode() ? "" : ", no SRSO microcode");

Hm?  What does missing microcode have to do with SMT?

-- 
Josh
