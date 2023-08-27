Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77942789DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjH0NLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjH0NLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD17188
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E1D611EB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC54C433C7;
        Sun, 27 Aug 2023 13:10:52 +0000 (UTC)
Date:   Sun, 27 Aug 2023 16:10:51 +0300
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Message-ID: <ZOtLWxokPxBCg0ao@arm.com>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-5-revest@chromium.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:28PM +0200, Florent Revest wrote:
>  static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
>  				 unsigned long arg4, unsigned long arg5)
>  {
> +	unsigned long current_bits;
> +
>  	if (arg3 || arg4 || arg5)
>  		return -EINVAL;
>  
> -	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> +	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
> +		return -EINVAL;
> +
> +	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> +	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
>  		return -EINVAL;
>  
> +	current_bits = get_current_mdwe();
> +	if (current_bits && current_bits != bits)
> +		return -EPERM; /* Cannot unset the flags */
> +
> +	if (bits & PR_MDWE_NO_INHERIT)
> +		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
>  	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
>  		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> -	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> -		return -EPERM; /* Cannot unset the flag */
>  
>  	return 0;
>  }

This works for me, it's easier to read. I don't expect a use-case where
the app starts with MDWE no-inherit, forks some new processes and wants
to turn inherit on for further forking.

> @@ -2384,9 +2406,7 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
>  {
>  	if (arg2 || arg3 || arg4 || arg5)
>  		return -EINVAL;
> -
> -	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> -		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> +	return (int)get_current_mdwe();

Nitpick: the type conversion should be handled by the compiler as
prctl_get_mdwe() returns an int already.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
