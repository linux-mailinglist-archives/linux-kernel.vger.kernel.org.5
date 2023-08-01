Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC976BB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjHARaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHARaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:30:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D6E0;
        Tue,  1 Aug 2023 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZvTRdKUSUCAlBq6z3PWYIniKn+jbmGKNY+UDBwFRuzM=; b=ey1Wayli86L3djfdin+4kg0By7
        gwK/elO18xN215cRvoeGvEGlsbZiuwTOJuBPPFPVmIgE0bgCn74jhYQ43AQGwsoy5qAI5Ok3PKHY1
        8DK+zombrHVYE7qV/JzrIeplCgOXFw8dfQFSLNVO7yY9eXHTJyikXL/hJ47+Qy/EchxY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53184 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQtC3-00015J-Vy; Tue, 01 Aug 2023 13:30:00 -0400
Date:   Tue, 1 Aug 2023 13:29:59 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20230801132959.7c02e86f4c863f997226965a@hugovil.com>
In-Reply-To: <2023073135-puppy-reflected-700d@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-4-hugo@hugovil.com>
        <2023073135-puppy-reflected-700d@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 03/10] serial: sc16is7xx: remove obsolete out_thread
 label
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:53:10 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:35AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
> > in probe") moved GPIO setup code later in probe function. Doing so
> > also required to move ports cleanup code (out_ports label) after the
> > GPIO cleanup code.
> > 
> > After these moves, the out_thread label becomes misplaced and makes
> > part of the cleanup code illogical.
> > 
> > This patch remove the now obsolete out_thread label and make GPIO
> > setup code jump to out_ports label if it fails.
> > 
> > Fixes: c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Why is this not ok for stable kernels yet it has a Fixes: tag?
> 
> Please fix.
> 
> thanks,
> 
> greg k-h

Hi,
this is a somewhat particular case. It is a change that "fixes" some
previously unseen consequence in original commit, but that does not
result in any binary change in the end. That is why I decided not to
put in a "stable" tag.

If you want, maybe it would be simpler to remove the "Fixes" tag? I
originally put this tag to have a reference to the original commit, but
since it is already mentioned in the commit log message body, it can be
removed.

Hugo.
