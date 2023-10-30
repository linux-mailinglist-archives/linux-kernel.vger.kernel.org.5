Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76757DB332
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJ3GYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3GYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:24:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB094
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:24:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366D2C433C9;
        Mon, 30 Oct 2023 06:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698647080;
        bh=2tB1guhBfYrZu5adq6I0lYKpY3+d8eVRbal6gHyEA0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwiRR/bQ0LdbjutMPX+kumE3h0Jj3Y8Q4xAaoyUVtiMbr8zqWeNHOX4JO/8hAIia6
         fXC/ut8HuCd+NpKNYqfqQREujU9ulkcIhwYRwSQizLHbgDWXdkScOaO3a9WVhaLmrr
         tEBNhurAB0ksSllDicC3fGlWKQoV5ApztyuJQNbM=
Date:   Mon, 30 Oct 2023 07:24:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oliver Crumrine <ozlinux@hotmail.com>, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: octeon: remove typedef in enum
 cvmx_helper_interface_mode_t
Message-ID: <2023103049-daybed-abstain-bad9@gregkh>
References: <cover.1693236450.git.ozlinux@hotmail.com>
 <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <32e9ad3c-191e-4dd1-b1cc-07f7b93c3f28@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e9ad3c-191e-4dd1-b1cc-07f7b93c3f28@roeck-us.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:17:21AM -0700, Guenter Roeck wrote:
> On Mon, Aug 28, 2023 at 11:39:07AM -0400, Oliver Crumrine wrote:
> > Remove typedef in enum cvmx_helper_interface_mode_t, and rename all instances
> > to cvmx_helper_interface_mode
> > 
> > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> 
> In linux-next:
> 
> Building mips:cavium_octeon_defconfig ... failed
> --------------
> Error log:
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
> drivers/staging/octeon/ethernet.c:204:37: error: storage size of 'rx_status' isn't known
>   204 |         struct cvmx_pip_port_status rx_status;
>       |                                     ^~~~~~~~~
> drivers/staging/octeon/ethernet.c:205:37: error: storage size of 'tx_status' isn't known
>   205 |         struct cvmx_pko_port_status tx_status;
>       |                                     ^~~~~~~~~
> drivers/staging/octeon/ethernet.c:205:37: warning: unused variable 'tx_status' [-Wunused-variable]
> drivers/staging/octeon/ethernet.c:204:37: warning: unused variable 'rx_status' [-Wunused-variable]
>   204 |         struct cvmx_pip_port_status rx_status;
>       |                                     ^~~~~~~~~
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_probe':
> drivers/staging/octeon/ethernet.c:801:22: error: variable 'imode' has initializer but incomplete type
>   801 |                 enum cvmx_helper_interface_mode imode =
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/octeon/ethernet.c:801:49: error: storage size of 'imode' isn't known
>   801 |                 enum cvmx_helper_interface_mode imode =
>       |                                                 ^~~~~
> drivers/staging/octeon/ethernet.c:801:49: warning: unused variable 'imode' [-Wunused-variable]
> 
> Bisect points to this patch. Bisect log attached.
> 
> As usual, my apologies for the noise if this has already been reported
> and/or fixed.

It has not been reported, thanks for it, I'll go revert the offending
commits.  And I need to figure out how to build this driver better, I
get no build-failures from anyone for it when stuff like this happens,
odd...

thanks,

greg k-h
