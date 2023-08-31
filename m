Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2A78F004
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbjHaPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346443AbjHaPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:13:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED6E6E;
        Thu, 31 Aug 2023 08:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A78B0CE2137;
        Thu, 31 Aug 2023 15:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8880BC433C7;
        Thu, 31 Aug 2023 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693494814;
        bh=8EjyOxDLw+FwPwX3qIdoCkLu6PFqd/mYkxhM3oZ1aI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wd+m8j+vDaMSHQl5oLmg8V0KI97uS3ANStDxTK57HJ+sptRUThFx3FybvoZ9l3HeH
         bRLNrmEjYnBmSLEGBhp0mMOwcf1HKVHjBn3heTTqfSqzn54r+qHAYIy/zMh0Hvz+L7
         w8xtwETqtNcZR5+R9YeaXc0pXe9PbGFK04WXgczk=
Date:   Thu, 31 Aug 2023 17:13:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Message-ID: <2023083107-calcium-slab-89a5@gregkh>
References: <20230828101149.146126827@linuxfoundation.org>
 <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
 <2023083014-barley-upscale-518e@gregkh>
 <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
 <95baa835-9940-a257-cf96-93c543aa389f@gmail.com>
 <CAOLZvyEuj=93tpObwDgyAK01Jyz8NfXQzJfAX5=vVwG1wxo-cA@mail.gmail.com>
 <2023083138-frustrate-race-9264@gregkh>
 <4a69c0c0-5e8a-9a3a-6527-3eb7e51a955e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a69c0c0-5e8a-9a3a-6527-3eb7e51a955e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:54:06AM -0700, Florian Fainelli wrote:
> 
> 
> On 8/31/2023 3:31 AM, Greg Kroah-Hartman wrote:
> > On Wed, Aug 30, 2023 at 07:38:09PM +0200, Manuel Lauss wrote:
> > > Hello all,
> > > 
> > > Florian Fainelli <f.fainelli@gmail.com> schrieb am Mi., 30. Aug. 2023, 19:07:
> > > > 
> > > > + Manuel,
> > > > 
> > > > On 8/30/23 09:01, Guenter Roeck wrote:
> > > > > On 8/30/23 03:52, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Aug 28, 2023 at 09:42:11AM -0700, Guenter Roeck wrote:
> > > > > > > On 8/28/23 03:13, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 5.10.193 release.
> > > > > > > > There are 84 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > > 
> > > > > > > > Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > > 
> > > > > > > 
> > > > > > > FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be
> > > > > > > reverted
> > > > > > > v5.10.y since it doesn't fix anything but breaks the build for
> > > > > > > affected boards
> > > > > > > completely.
> > > > > > > 
> > > > > > > arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
> > > > > > > arch/mips/alchemy/common/dbdma.c:632:14: error:
> > > > > > > 'dma_default_coherent' undeclared
> > > > > > > 
> > > > > > > There is no 'dma_default_coherent' in v5.10.y.
> > > > > > 
> > > > > > But that was added in 5.10.185, from back in June.  What changed to
> > > > > > suddenly cause this to fail now?
> > > > > > 
> > > > > 
> > > > > Nothing. I started to build this configuration and tracked down the
> > > > > problem after the build failure was reported by others. Sorry, I didn't
> > > > > initially realize that this is an old problem.
> > > > 
> > > > We could back port 6d4e9a8efe3d59f31367d79e970c2f328da139a4 ("driver
> > > > core: lift dma_default_coherent into common code") but that won't work
> > > > too well on 4.14 or 4.19. I believe it would be simpler to adjust the
> > > > branches with this patch, Manuel does that work?
> > > 
> > > Please drop this patch from all stable releases. I didn't CC stable
> > > when I submitted it,
> > > and have no idea why it ended up there anyway.
> > > It was intended to fix a problem initially found in 5.18 (I think).
> > 
> > I'm going to revert it now, thanks!
> 
> I prepared reverts yesterday that I can send out if you want?

I think this is all taken care of in the latest -rc releases, right?  If
I missed anything, then yes, reverts would be great to have.

thanks,

greg k-h
