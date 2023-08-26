Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6407895C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHZKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjHZKI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A91A6;
        Sat, 26 Aug 2023 03:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F3960BEF;
        Sat, 26 Aug 2023 10:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F294C433CD;
        Sat, 26 Aug 2023 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693044504;
        bh=RAP6Rco8JU6PRoLAXEOoresrmVbcyWQ1Lcgi6z3WzwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFVEdLWrE3kXyQzpsQlwP3283l+vpTp0+FPIQ07CI8YKyjSngSJNO6E4gmcOVy0F0
         UAWFDFFLNy7KZSP3rVYlKeG1T6KWJ2qUmlg0ypxRPemHUgMc3b2u0x7OCSdpGdz+KE
         qdkekGAk9cCwFhrs2i2WhTyQDNTA0E7XXEpCBQj4=
Date:   Sat, 26 Aug 2023 12:08:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <2023082636-postnasal-cobalt-5ab5@gregkh>
References: <20230824170617.074557800@linuxfoundation.org>
 <fb1c3952-1d72-4f9d-bc93-2988bcde462e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1c3952-1d72-4f9d-bc93-2988bcde462e@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:24:29AM -0700, Guenter Roeck wrote:
> On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.192 release.
> > There are 135 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Testing is not complete, but early feedback: All riscv32 boot tests
> crash badly with errors such as
> 
> Starting syslogd: OK
> Starting klogd: OK
> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
> /etc/init.d/S20seedrng: line 33: syntax error: unexpected end of file (expecting ";;")
> Starting network: /bin/sh: syntax error: unterminated quoted string
> sed: unmatched '/'
> /bin/sh: syntax error: unterminated quoted string
> FAIL
> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
> 
> This is no longer seen after reverting the following patches.
> 
> 92609bb3a1f8 riscv: uaccess: Return the number of bytes effectively not copied
> e06648704417 riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
> 20704d763646 riscv: lib: uaccess: fold fixups into body
> 4f503bad920e riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall

Thanks for the review, I'll go drop all of the riscv patches here.
Really, we shouldn't be adding any of them to any kernels older than
5.15 these days as I do not think anyone using that cpu is using those
older kernels (or at least I sure hope not...)

thanks,

greg k-h
