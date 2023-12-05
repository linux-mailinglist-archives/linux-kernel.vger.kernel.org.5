Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF779805DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbjLESPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:15:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED94090
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:15:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD47C433C7;
        Tue,  5 Dec 2023 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701800135;
        bh=bN5M5BOBJOwrIVMsNWK7bjhKGDGQO9YdEWRVdOmIYjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaXHjxPy6hTSuvkcqqcUVrH5WolUmMBjLaSob/gHuzn8gP5b/2LpDQ0CQvXNcL83c
         k1OVG9msLnZ8VmxaiFEGF9onp4EyIx9dGC0ljimI9F39sQBDNEV37U+nkpyyFLdwwv
         rIXk1ucRixyJ47l9WZVvbqIa9782k4QsTW+pRHmY=
Date:   Wed, 6 Dec 2023 03:15:33 +0900
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
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.4 00/93] 5.4.263-rc2 review
Message-ID: <2023120625-pastor-result-4424@gregkh>
References: <20231205043618.860613563@linuxfoundation.org>
 <9b88236c-8616-4a08-9c8e-9a6c09868360@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b88236c-8616-4a08-9c8e-9a6c09868360@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:33:54PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 05/12/23 10:07 am, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.263 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 04:35:52 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > Adrian Hunter <adrian.hunter@intel.com>
> >      perf intel-pt: Fix async branch flags
> > 
> > Adrian Hunter <adrian.hunter@intel.com>
> >      perf intel-pt: Adjust sample flags for VM-Exit
> > 
> ^^^ these both commits causing:
> 
> util/intel-pt.c: In function ‘intel_pt_sample_flags’:
> util/intel-pt.c:1004:38: error: ‘const struct intel_pt_state’ has no member
> named ‘from_nr’; did you mean ‘from_ip’?
>  1004 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
>       |                                      ^~~~~~~
>       |                                      from_ip
> util/intel-pt.c:1004:60: error: ‘const struct intel_pt_state’ has no member
> named ‘to_nr’
>  1004 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
>       |                                                            ^~
> util/intel-pt.c:1007:38: error: ‘PERF_IP_FLAG_VMEXIT’ undeclared (first use
> in this function); did you mean ‘PERF_IP_FLAG_IN_TX’?
>  1007 |                                      PERF_IP_FLAG_VMEXIT;
>       |                                      ^~~~~~~~~~~~~~~~~~~
>       |                                      PERF_IP_FLAG_IN_TX
> 
> 
> I have reverted these locally and then one more build failure
> 
> > Adrian Hunter <adrian.hunter@intel.com>
> >      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> > 
> ^^^ This is causing:
> 
> In file included from util/jitdump.c:28:
> util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
>     5 | #include <linux/math.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> 
> Reverting this as well, fixes the perf build.

Thanks, I'll go drop all of these now.

greg k-h
