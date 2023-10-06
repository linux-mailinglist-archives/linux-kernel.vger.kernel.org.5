Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1087BB511
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjJFKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJFKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:25:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A585DAD;
        Fri,  6 Oct 2023 03:25:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC9CC433C8;
        Fri,  6 Oct 2023 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696587915;
        bh=MVH7x9N25lGNzI2/k2QWeN3rLCO8cwbceLAdRNEQdsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7OSk9c2xIAjt3sZYoUkzPPa9xoaiyL7NgFtm6ulkxKZAVmi1jE5g9gSn18XKQl1i
         NETlGNbKhmu0yQuq+QcuCFtzO84QkMiRKegC9uEPqWFiScdoa3f8Mt7bBjCOrXMMrs
         jKpc+r+GfFTBZlAjJVcTSy8Vn/ly/n7lzk10bOXE=
Date:   Fri, 6 Oct 2023 12:25:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <2023100601-ending-prevalent-c8d4@gregkh>
References: <20231004175203.943277832@linuxfoundation.org>
 <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:43:46AM -0700, Florian Fainelli wrote:
> On 10/4/23 10:53, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.134 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> perf fails to build with:
> 
>   CC /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o
> util/metricgroup.c: In function 'metricgroup__parse_groups':
> util/metricgroup.c:1261:7: error: 'table' undeclared (first use in this
> function)
>   if (!table)
>        ^~~~~
> util/metricgroup.c:1261:7: note: each undeclared identifier is reported only
> once for each function it appears in
> make[6]: *** [/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o]
> Error 1
> 
> caused by c1ef510a0f2a879bf29ddebae766ec9f0790eb8f ("perf metric: Return
> early if no CPU PMU table exists"). Dropping this commit allows the build to
> continue.
> 
> I had reported in the previous cycle that 00facc760903be66 ("perf jevents:
> Switch build to use jevents.py") was causing build failures:
> 
> https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
> 
> do we still want these commits to be included?

No, I'll go drop them now, thanks for the report.

greg k-h
