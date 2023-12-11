Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5580CED1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjLKO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:56:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946BC5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:56:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B8FC433C8;
        Mon, 11 Dec 2023 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702306596;
        bh=yeGJvoAhrRUdjjLyjIJiQRRidjJWgvKa+3GL2nDVUtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lr0A/IQzptm9L/e+o5KMT9FMS3j80GX6sEJbS6KS607y4WTzHTs6rXMSTMV+TjcFK
         46Nr8O+JVoKoj9tJ88rsIM6K6+jL+E7IUF6VFHYLuqvpT2SuSLCb/C4wzJ2PfKSFwL
         HbgUe7TcvMQgCp+JN5/Xm2LcjIeh7TkbvyEwWxFw=
Date:   Mon, 11 Dec 2023 15:56:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
Message-ID: <2023121118-snagged-ninja-7efb@gregkh>
References: <20231205183241.636315882@linuxfoundation.org>
 <5b0eb360-3765-40e1-854a-9da6d97eb405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0eb360-3765-40e1-854a-9da6d97eb405@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:09:17AM -0800, Guenter Roeck wrote:
> On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.263 release.
> > There are 90 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> > Qu Wenruo <wqu@suse.com>
> >      btrfs: add dmesg output for first mount and last unmount of a filesystem
> > 
> 
> This patch results in the following code in fs/btrfs/disk-io.c:open_ctree():
> 
> 	struct btrfs_super_block *disk_super;
> 	... (no access to disk_super)
> 	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
> 
> which I would assume _should_ result in btrfs crashes. No idea why that isn't
> actually happening or why gcc doesn't complain. Building allmodconfig with
> clang does complain, but doesn't bail out.
> 
> s/btrfs/disk-io.c:2832:55: warning: variable 'disk_super' is uninitialized when used here [-Wuninitialized]
>         btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
>                                                              ^~~~~~~~~~
> 
> The actual log output is:
> 
> [    7.302427] BTRFS info (device nvme0n1): first mount of filesystem (efault)
> 
> It might be a good idea to either revert this patch or fix it up
> (though I don't know how to fix it up).

yeah, that doesn't look good, now reverted, thanks!

greg k-h
