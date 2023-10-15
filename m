Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF17C99A5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJOPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98317DA;
        Sun, 15 Oct 2023 08:06:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E7C433C8;
        Sun, 15 Oct 2023 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697382384;
        bh=VFgG/GeOFjZBpWQhFBCt12gjtE4bL5QgGojqf6ykkEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmPkmpkk8dxofiw/rBxB87ue0PkE1wqtTN/hWDFuBD6+kgyN/F2bsPnDK5VssS0yW
         YczAhfcBOERdXnuB/NGwNdLd6upUPdXPfNdbVve3NwXWxqvwOk8O4yGbiw2sDA3Fnv
         FuBYJNZsSjkTgOG1i8r6dpaEbHjIgl9gh4EMG53XP4fbCotfhaR5wKyPpW9xY+fmD7
         Ya7VX+o7Xi55Q7B89miEkxf9k27VUdfQPm0juny7V7zmWyPNcX1o/mUU0ABKV2KPfm
         faUxYFIBv5vED/iwT9jvC/CmAlSR1k0l2SdVaq2F8jXIhymnA+RHd1q7CFVKlWN3Z9
         7j4SGgGJgAy/g==
Date:   Sun, 15 Oct 2023 17:06:19 +0200
From:   Simon Horman <horms@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
Message-ID: <20231015150619.GC1386676@kernel.org>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both hi.data.modename and hi.data.drivername to be
> NUL-terminated but not necessarily NUL-padded which is evident by its
> usage with sprintf:
> |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> |               bc->cfg.intclk ? "int" : "ext",
> |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> |               bc->cfg.loopback ? ",loopback" : "");
> 
> Note that this data is copied out to userspace with:
> |       if (copy_to_user(data, &hi, sizeof(hi)))
> ... however, the data was also copied FROM the user here:
> |       if (copy_from_user(&hi, data, sizeof(hi)))

Thanks Justin,

I see that too.

Perhaps I am off the mark here, and perhaps it's out of scope for this
patch, but I do think it would be nicer if the kernel only sent
intended data to user-space, even if any unintended payload came
from user-space.

> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

...
