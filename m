Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907DA7BCC37
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 07:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbjJHFEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 01:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjJHFEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 01:04:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC78F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 22:04:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90216C433C7;
        Sun,  8 Oct 2023 05:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696741481;
        bh=EWfEySMIHcEZpgZcolTZHLTL0n7Z1fa2Lb39mIDJ4D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1H0jrg9m3TkWpRkDm1nTyZaxroCotWXSuwEx5MvI3c1hOJoa6UCIRN1HQBBDoy4a
         +XnTGmEBX+tUqTBNT58HakOasGrin9fDR76BhvHLS1tb6oJrW3ugUz9iRZiM1qiQSD
         rpqVbuqtlSHCWT6L6T0iAaKaaAZ0huaNv8mntaFw=
Date:   Sun, 8 Oct 2023 07:04:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Message-ID: <2023100811-shakable-derby-0b91@gregkh>
References: <20231007213820.376360-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007213820.376360-1-jmkrzyszt@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:38:18PM +0200, Janusz Krzysztofik wrote:
> Since types of arguments accepted by tty_ldis_ops::receive_buf() have
> changed, the driver no longer builds.
> 
> .../linux/sound/soc/ti/ams-delta.c:403:24: error: initialization of 'void (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const unsigned char *, unsigned int)'} from incompatible pointer type 'void (*)(struct tty_struct *, const u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const char *, int)'} [-Werror=incompatible-pointer-types]
>   403 |         .receive_buf = cx81801_receive,
> 
> Fix it.
> 
> Fixes: e8161447bb0c ("tty: make tty_ldisc_ops::*buf*() hooks operate on size_t")
> Fixes: 892bc209f250 ("tty: use u8 for flags")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  sound/soc/ti/ams-delta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Odd no built-bots caught this, maybe no one normally builds this file?
Anyway, I'll pick this up in my tty tree now, thanks!

greg k-h
