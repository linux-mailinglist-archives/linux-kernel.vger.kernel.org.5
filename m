Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15D7F8E15
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKYTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKYTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:38:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992FBC5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:38:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C4C433C8;
        Sat, 25 Nov 2023 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700941129;
        bh=lf99ci7DD03rlold82yN4otp41YlY217X1clnyvcLOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncBVHR/DK7BrdztiVIVKwcyJXrOAC3iuu2SufbBPEP10hJObouSnlaeU/ltF95H2P
         alOOCZCjbTzeGbhl9fOXpygzwAHCScmrOp8QTCZmdJfO4IpRyolECKhqkC6pB++nUt
         zGhwA6JZXUfzOUFYwQJcWPW+LI+7Vom40pzVCQCY=
Date:   Sat, 25 Nov 2023 19:38:46 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, hca@linux.ibm.com
Subject: Re: [PATCH 6.6 000/528] 6.6.3-rc2 review
Message-ID: <2023112520-blandness-jokingly-bbd8@gregkh>
References: <20231125163158.249616313@linuxfoundation.org>
 <e819d653-8a1e-4088-a4dd-a093356da8e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e819d653-8a1e-4088-a4dd-a093356da8e8@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:04:02PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 25/11/23 10:33 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.3 release.
> > There are 528 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We see this build regression with System/390:
> 
> -----8<-----
>   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
>   /builds/linux/arch/s390/mm/page-states.c:165:45: error: request for member 'val' in something not a structure or union
>     165 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
>         |                                             ^
>   make[5]: *** [/builds/linux/scripts/Makefile.build:243: arch/s390/mm/page-states.o] Error 1
> ----->8-----
> 
> That's with Clang 17, Clang nightly, GCC 8 and GCC 13, with allnoconfig, defconfig, and tinyconfig.
> 
> Bisection points to:
> 
>   commit b676da1c17c9d0c5b05c7b6ecb9ecf2d8b5e00de
>   Author: Heiko Carstens <hca@linux.ibm.com>
>   Date:   Tue Oct 17 21:07:03 2023 +0200
> 
>       s390/cmma: fix initial kernel address space page table walk
>       commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.
> 
> 
> Reverting makes the build pass.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Ugh, I thought I just had to drop it from the 5.15.y and older trees.
I'll drop it from everywhere now and push out some -rc3 releases...

thanks,

greg k-h
