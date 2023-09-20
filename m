Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F47A7578
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjITILU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjITILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:11:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6839E;
        Wed, 20 Sep 2023 01:11:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E813C433C7;
        Wed, 20 Sep 2023 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695197469;
        bh=7wf1p0Aec6gggxYmTBq1JQOuPInnKOwidNeGe4yZnm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDoS+NdziuEqkwYc/f+wdv99E/h00icsJLiYbiWm9zSSrZv1gXZqURhp6bbbgSEVm
         ZNgjEpHfIMpKZ3hfWEWOpFzKWhb58OMrbyp5Uw5CEyhfdaohhXbX+OHFy1Jk4CucWR
         bIQwe/9FXrQ0C78yI9fGl88OMfCCU5rtVo+GbQYk=
Date:   Wed, 20 Sep 2023 10:11:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
Message-ID: <2023092009-angriness-sank-ae4f@gregkh>
References: <20230917191101.035638219@linuxfoundation.org>
 <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:57:25PM -0700, Guenter Roeck wrote:
> On 9/17/23 12:07, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.195 release.
> > There are 406 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> > Anything received after that time might be too late.
> > 
> 
> chromeos-5.10 locks up in configfs_lookup() after the merge of v5.10.195.
> 
> I am a bit puzzled because I see
> 
> c709c7ca020a configfs: fix a race in configfs_lookup()
> 
> in v5.10.195 but not in the list of commits below. I guess I must be
> missing something.

It was part of the big patchset, it was posted here:
	https://lore.kernel.org/r/20230917191101.511939651@linuxfoundation.org

Not hidden at all :)

and was submitted here:
	https://lore.kernel.org/r/ZPOZFHHA0abVmGx+@westworld

> Either case, the code now looks as follows.
> 
> configfs_lookup()
> {
>     ...
>     spin_lock(&configfs_dirent_lock);
>     ...
>         err = configfs_attach_attr(sd, dentry);
>     ...
>     spin_unlock(&configfs_dirent_lock);
>     ...
> }
> 
> and
> 
> configfs_attach_attr(...)
> {
>     ...
>     spin_lock(&configfs_dirent_lock);
>     ...
> }
> 
> which unless it is way too late here and I really need to go to sleep
> just won't work.

Kyle, you did the backport, any comments?

thanks,

greg k-h
