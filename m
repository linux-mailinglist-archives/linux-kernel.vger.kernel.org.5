Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65D7F8E20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKYTme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjKYTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:42:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC262127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:42:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB3DC433C7;
        Sat, 25 Nov 2023 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700941359;
        bh=79ZNx7QbXwaR+DfeqRTqWoT3nqX+9Dx5NLciWccHvug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NIOTBwZUI2ROKL5BP9uDPFQLAX4dOowNfklRMvs1UGB5Vm+IhldlYSzE8uiy0nJC
         9UNw5LoGbnZgak3ouwW2tdKVlNNqtF/enAeyiAxohivjZXliHVLeUiL3IshAXyO0Ju
         9UdC6Gj63jCBv3rRe/6DvpdMIQnb8SRj3xYcU7SE=
Date:   Sat, 25 Nov 2023 19:42:36 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 000/155] 5.4.262-rc2 review
Message-ID: <2023112529-waking-breeding-bc77@gregkh>
References: <20231125163112.419066112@linuxfoundation.org>
 <261a0a3b-d1a4-4fe8-8fd7-42e9e2786348@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261a0a3b-d1a4-4fe8-8fd7-42e9e2786348@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 10:07:33AM -0800, Florian Fainelli wrote:
> 
> 
> On 11/25/2023 8:32 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.262 release.
> > There are 155 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> perf does not build on ARM and ARM64 with:
> 
> util/evsel.h: In function 'perf_evsel__has_branch_hw_idx':
> util/evsel.h:387:54: error: 'PERF_SAMPLE_BRANCH_HW_INDEX' undeclared (first
> use in this function); did you mean 'PERF_SAMPLE_BRANCH_IN_TX'?
>   387 |         return evsel->core.attr.branch_sample_type &
> PERF_SAMPLE_BRANCH_HW_INDEX;
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       | PERF_SAMPLE_BRANCH_IN_TX
> util/evsel.h:387:54: note: each undeclared identifier is reported only once
> for each function it appears in
> 
> dropping 946b6643e67f552a9966a06ab5a9032120eeeea9 ("perf tools: Add hw_idx
> in struct branch_stack") allows me to build again for ARM and ARM64, howevef
> for MIPS we also have:
> 
> 50a3ffda05679c55929bf2bdebc731dfafe3221b ("perf hist: Add missing puts to
> hist__account_cycles") failing to build with:
> 
> util/hist.c:2600:5: warning: nested extern declaration of 'maps__put'
> [-Wnested-externs]
> util/hist.c:2600:23: error: 'struct addr_map_symbol' has no member named
> 'ms'
>      maps__put(bi[i].to.ms.maps);
>                        ^
> util/hist.c:2601:24: error: 'struct addr_map_symbol' has no member named
> 'ms'
>      map__put(bi[i].from.ms.map);
>                         ^
> util/hist.c:2602:25: error: 'struct addr_map_symbol' has no member named
> 'ms'
>      maps__put(bi[i].from.ms.maps);
>                          ^
> 
> so I would suggest we just revert both commits. Once we do that, all is well
> for ARM, ARM64 and MIPS.

Thanks, both now dropped.

greg k-h
