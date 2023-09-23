Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C707ABEE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIWI0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIWI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:26:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87169199;
        Sat, 23 Sep 2023 01:26:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2971C433C7;
        Sat, 23 Sep 2023 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457572;
        bh=QfSZi3CcaKcDGUu3aI1sCsbgvUsfgPydkTm/hs5D/r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ddt1VQNlnRJdg8YQ+u3H8AkGQb/Ge7s36yp6VVg4ovf1KPSUm2QxzplMpZEg1W34E
         ZgG9t6eCpLmYzO8E7fO/YVTZra3cFrUWeNTx6GA3MLf/YSXTBhoIJ8XUzmNat2RB20
         4UptXhhTuAFgl3hpaoH+/shMbQ+eQcXn3IcIYOZA=
Date:   Sat, 23 Sep 2023 10:26:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
Message-ID: <2023092300-sturdily-monastery-b1f0@gregkh>
References: <20230920112858.471730572@linuxfoundation.org>
 <166b5b43-adab-7d00-e3f6-c9a1dfd29f52@gmail.com>
 <1885150a-6caa-8d92-f893-02bdb5ee508d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1885150a-6caa-8d92-f893-02bdb5ee508d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:20:17AM -0700, Guenter Roeck wrote:
> On 9/20/23 10:21, Florian Fainelli wrote:
> > On 9/20/23 04:26, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.257 release.
> > > There are 367 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > perf does not build with:
> > 
> > libbpf.c: In function 'bpf_object__close':
> > libbpf.c:4205:15: error: 'struct bpf_object' has no member named 'btf_vmlinux'
> >    btf__free(obj->btf_vmlinux);
> >                 ^~
> > 
> > due to 34d66b750e83d49c7d3d33d59e6a1b49e0d5db15 ("libbpf: Free btf_vmlinux when closing bpf_object")
> > 
> > the btf_vmlinux member was introduced with a6ed02cac690b635dbb938690e795812ce1e14ca ("libbpf: Load btf_vmlinux only once per object.") which is only in >= 5.6.
> > 
> > Suggset we drop that commit.
> 
> 
> This problem affects 5.4, 5.10, and 5.15.

Now dropped from all of those queues, thanks.

greg k-h
