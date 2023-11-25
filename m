Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35FE7F8C30
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjKYPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjKYPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:53:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958A10B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:53:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872B6C433C7;
        Sat, 25 Nov 2023 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700927598;
        bh=al+G0rriiHu1mo6bmsIUbIhr6a/3qzbcnyBNXYRyZC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8U/vD7VrZxIR+HnhzkI56te2jE8QiD3+9kFourtDRrbOYMt3tfmI8cAASWmC8PhY
         eN+Kg9NYTNeToCoW3i7/S/gmJhlDU0FozTS0GwlTABfgz0UvA58x98HIxPhAMsWnjy
         R7oSlqzppmywGFGMSgCIufjIfbVXW6R+rANBxhAE=
Date:   Sat, 25 Nov 2023 15:53:15 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, jack@suse.cz, chrubis@suse.cz
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Message-ID: <2023112502-supernova-copier-7615@gregkh>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:45:09PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.140 release.
> > There are 297 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We are noticing a regression with ltp-syscalls' preadv03:
> 
> -----8<-----
>   preadv03 preadv03
>   preadv03_64 preadv03_64
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> ----->8-----
> 
> This is seen in the following environments:
> * dragonboard-845c
> * juno-64k_page_size
> * qemu-arm64
> * qemu-armv7
> * qemu-i386
> * qemu-x86_64
> * x86_64-clang
> 
> and on the following RC's:
> * v5.10.202-rc1
> * v5.15.140-rc1
> * v6.1.64-rc1
> 
> (Note that the list might not be complete, because some branches failed to execute completely due to build issues reported elsewhere.)
> 
> Bisection in linux-5.15.y pointed to:
> 
>   commit db85c7fff122c14bc5755e47b51fbfafae660235
>   Author: Jan Kara <jack@suse.cz>
>   Date:   Fri Oct 13 14:13:50 2023 +0200
> 
>       ext4: properly sync file size update after O_SYNC direct IO
>       commit 91562895f8030cb9a0470b1db49de79346a69f91 upstream.
> 
> 
> Reverting that commit made the test pass.

Odd.  I'll go drop that from 5.10.y and 5.15.y now, thanks.

greg k-h
