Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BF777596
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjHJKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC90C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C659665769
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8AC433C8;
        Thu, 10 Aug 2023 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691662611;
        bh=rxQXVJ0yXjMi3ynyps+JjJfJqtoB7d6KO/4+z5Vs7Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpGE4KO9/C1welyewX/UY4RrCys51AOpewra3tjc/goBaZ96i9jbT1YuB6Mos42rx
         HDr6GRkzc1KBEF9vs8aA5dNfCGm75zmkaYBS6DRzs/cIrOSKVcnDfqNyyansA23MZ4
         wYi6FmobUCWxju8HXbV9+tJya0wEM8vVQgZw7YCVD8vZK0+6fhhYivMDX6fXVFj93U
         cDqIBu/9hQebyOYSWzB0kT1Q1HJTEXVIlAK8NWNWDQsOUbUjfHqWhI6e+fmjjrcUX7
         Ad6bMEYInlaW27uWzEjs1e68gzf4LixxnS7UK6nIOFjvTaGyyaKtr6zDRmYVXYaK+i
         uGwN4Y/77R2/A==
Date:   Thu, 10 Aug 2023 03:16:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810101649.GA1795474@dev-arch.thelio-3990X>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:08:35AM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 10:10:38AM +0200, Borislav Petkov wrote:
> > I can repro this here with Debian clang version 14.0.6-2 even with -smp
> > 2.
> > 
> > Lemme poke at this a bit.
> 
> Err, this stops booting even on plain -rc5 which doesn't have the SRSO
> patches.

Just to clarify, this is the guest kernel at -rc5 and the host kernel
with the SRSO mitigations applied? If so, that's the problem. The guest
kernel does not have to have the SRSO mitigations applied to see this
problem. Sorry I should have made that more clear! If not though, that's
interesting because I was running -rc5 on the host without issues.

Cheers,
Nathan
