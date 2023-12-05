Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C470805DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjLESRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjLESRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:17:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EA1A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:17:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21742C433C8;
        Tue,  5 Dec 2023 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701800249;
        bh=9+ZWs5EHaDXM+kXbnYb4FMhkFDrqEduTIdllgO0DxZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNYuHoIMrEtuBRdgl0VnUNHZvPO0vmND/WmjivuFLUdYLsvJGVKzR2bPz+CNv2nWj
         da2YSmQ6IMdCmW7P19jnCpiERseCns2RfUf4CbadTabskql5464He+2StHC4cGl7Y7
         +HE9m3Jru87/Q2yRlz2Zh4qQxsKqz2ZiHVHSybVk=
Date:   Wed, 6 Dec 2023 03:17:27 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, namhyung@kernel.org
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Message-ID: <2023120618-around-duplicity-8f8f@gregkh>
References: <20231205031519.853779502@linuxfoundation.org>
 <c8ebf598-4d9a-4ce0-bccf-2109150919dc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ebf598-4d9a-4ce0-bccf-2109150919dc@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:46:43PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 05/12/23 8:46 am, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.142 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > Adrian Hunter <adrian.hunter@intel.com>
> >      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> > 
> > 
> 
> ^^ This commit is causing the perf/ build failure:
> 
> In file included from util/jitdump.c:29:
> util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
>     5 | #include <linux/math.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> 
> This was previously reported on 5.15.136-rc:
> 
> Vegard shared his analysis on ways to fix here:
> 
> https://lore.kernel.org/stable/fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com/

Now dropped from here and 4.19.y

thanks,

greg k-h
