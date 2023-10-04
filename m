Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E87B77B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJDGTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4417A6;
        Tue,  3 Oct 2023 23:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ACAC433C7;
        Wed,  4 Oct 2023 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696400375;
        bh=CmI8BoWddO62EOPgmJUjKO2JAaho87P2B5wkjnr6E9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjItGs2brBGEUSMVlCA4ApDeGNDKiVtfnwMyjE53ZsZEFr8M+dNRnX/I9BDb+Movq
         32BOUCvZqwoagIY7wj85crNWV7WpQOygMowOYZC+AmIZd9ULix0WkurMAdDvbOngbc
         0oxcZ30ccBm3jFLwxGbH8jBVXWA+YgRYRbCf+jPQ=
Date:   Wed, 4 Oct 2023 08:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        regressions@lists.linux.dev, benjamin.tissoires@redhat.com,
        linux@leemhuis.info, Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - fix fast_reconnect callback in ps2 mode
Message-ID: <2023100418-clapping-driven-bc09@gregkh>
References: <20231004005729.3943515-1-jefferymiller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004005729.3943515-1-jefferymiller@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 07:57:24PM -0500, Jeffery Miller wrote:
> Make `elantech_setup_ps2` set a compatible fast_reconnect pointer
> when its ps2 mode is used.
> 
> When an SMBus connection is attempted and fails `psmouse_smbus_init`
> sets fast_reconnect to `psmouse_smbus_reconnect`.
> `psmouse_smbus_reconnect` expects `psmouse->private` to be
> `struct psmouse_smbus_dev` but `elantech_setup_ps2` replaces
> it with its private data. This was causing an issue on resume
> since psmouse_smbus_reconnect was being called while in ps2, not SMBus
> mode.
> 
> This was uncovered by commit 92e24e0e57f7 ("Input: psmouse - add delay when
> deactivating for SMBus mode")
> 
> Closes:
> Link:https://lore.kernel.org/all/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> 
> Signed-off-by: Jeffery Miller <jefferymiller@google.com>
> ---
> 
> The other callbacks set in psmouse_smbus_init are already replaced.
> Should fast_reconnect be set to `elantech_reconnect` instead?

What commit id does this fix?  Should it also have a cc: stable tag?

thanks,

greg k-h
