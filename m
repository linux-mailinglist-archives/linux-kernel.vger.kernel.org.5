Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8F7E1D70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjKFJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:49:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99597DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:49:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EB2C433C8;
        Mon,  6 Nov 2023 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699264140;
        bh=J+UtUK5jNoTnUce3qF2KYAJHZLqEpd1q/Qp29qYt+yA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkSdq7VkM8dlXDHxaqQYrG0/fvr+C44VpLGTtGRsaAwWT2/Cm4B1LtqBX8b1tJf3d
         GkYTm2UHMwEM8K0Wz9+0gMdDN9lVWF8rFQL0RaGpfh30xLjklg8YJF+IXqguDxC/Ia
         fWkXCvji8Ts3biavFrXnGcGE0RaaQ3KoAl05Gn6g=
Date:   Mon, 6 Nov 2023 10:48:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <2023110639-overbuilt-caliber-28ef@gregkh>
References: <202311060001.aEuf1q9y-lkp@intel.com>
 <2023110641-profusely-factor-b3c5@gregkh>
 <ZUiybtcMJGI5ZCF5@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUiybtcMJGI5ZCF5@yujie-X299>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 05:31:26PM +0800, Yujie Liu wrote:
> Hi Greg,
> 
> On Mon, Nov 06, 2023 at 10:00:14AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 06, 2023 at 04:49:17PM +0800, kernel test robot wrote:
> > > Hi Greg,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
> > > commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
> > > date:   2 years, 7 months ago
> > 
> > Have you tested a newer kernel?  Testing a 2 1/2 year old commit feels
> > odd to me, was this intentional?
> 
> We did test new kernels with W=1, and the issue was captured by the
> bot, then bisected to this 2 years 7 months ago commit that was likely
> to introduce this issue initially.

This commit is a "move files around" commit, so it obviously was not the
original problem commit here :)

> We have no intention of directly
> testing a very old commit, and we're sorry that the date info may
> cause some misunderstanding.
> 
> This can be reproduced by allyesconfig build on v6.6 with W=1:
> 
> $ git checkout v6.6
> HEAD is now at ffc253263a13 Linux 6.6
> 
> $ make ARCH=x86_64 allyesconfig
> 
> $ make W=1 ARCH=x86_64 drivers/comedi/drivers/tests/ni_routes_test.o
> ...
>   CC      drivers/comedi/drivers/tests/ni_routes_test.o
> In file included from drivers/comedi/drivers/tests/ni_routes_test.c:22:
> drivers/comedi/drivers/tests/../ni_stc.h:1140:35: error: ‘range_ni_E_ao_ext’ defined but not used [-Werror=unused-const-variable=]
>  1140 | static const struct comedi_lrange range_ni_E_ao_ext;
>       |                                   ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This is odd in that a static constant is being defined in a .h file, so
anything that happens to include it, like this test, will then need to
use it in order to silence this warning.  I don't think that's going to
happen any time soon, so it's good that we don't really care aobut W=1
just yet :)

thanks,

greg k-h
