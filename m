Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F176E26B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjHCIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjHCIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4586B72B2;
        Thu,  3 Aug 2023 00:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F24617F2;
        Thu,  3 Aug 2023 07:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AB9C433C7;
        Thu,  3 Aug 2023 07:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691049316;
        bh=V3nQ0ClrF8ZRv/u5/+oTYzQyPMaeCT1q8c3GUFTzhfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUy44YJacb/d0TgmEeKdOLh/xFz1EK+Hd+JI2OdGTS4hPw2kOVcKgq+pPDkJJyEgp
         zSjS/D05ECycP2AGy7kfwz70yexaRfGzY+/lftdWez1UG160a4eYZXDUol5iwCv4WO
         R4ElLYz/nU+wKW5IbfQ4p2F1Me8wSbjt86ObuAfM=
Date:   Thu, 3 Aug 2023 09:55:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 03/10] serial: sc16is7xx: remove obsolete out_thread
 label
Message-ID: <2023080343-contest-gab-5b7d@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-4-hugo@hugovil.com>
 <2023073135-puppy-reflected-700d@gregkh>
 <20230801132959.7c02e86f4c863f997226965a@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801132959.7c02e86f4c863f997226965a@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:29:59PM -0400, Hugo Villeneuve wrote:
> On Mon, 31 Jul 2023 17:53:10 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 25, 2023 at 10:23:35AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
> > > in probe") moved GPIO setup code later in probe function. Doing so
> > > also required to move ports cleanup code (out_ports label) after the
> > > GPIO cleanup code.
> > > 
> > > After these moves, the out_thread label becomes misplaced and makes
> > > part of the cleanup code illogical.
> > > 
> > > This patch remove the now obsolete out_thread label and make GPIO
> > > setup code jump to out_ports label if it fails.
> > > 
> > > Fixes: c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > 
> > Why is this not ok for stable kernels yet it has a Fixes: tag?
> > 
> > Please fix.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi,
> this is a somewhat particular case. It is a change that "fixes" some
> previously unseen consequence in original commit, but that does not
> result in any binary change in the end. That is why I decided not to
> put in a "stable" tag.
> 
> If you want, maybe it would be simpler to remove the "Fixes" tag? I
> originally put this tag to have a reference to the original commit, but
> since it is already mentioned in the commit log message body, it can be
> removed.

Yes, please just remove it, otherwise it will just confuse us.

thanks,

greg k-h
