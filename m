Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7E799746
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjIIKTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjIIKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:19:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A859D;
        Sat,  9 Sep 2023 03:19:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77328C433C8;
        Sat,  9 Sep 2023 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694254788;
        bh=6M1owz/Gj9mAJIsLcRR/m5NWPD/hw6rxxJhrE/TdRZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WkqUonq1rjkzDIyl8Q006qWDlAYU7gNw6r3Uh9rcIpnIMKQJPgz/6e6qMYrZySiU6
         0CRfcidlspiCdLh910udacTZO61dNe63yn2OXuWE3r5qdtwTgaU5etPpL+RRbSXNTV
         NhH93N8hw51FPlcprfuxUadnhl1u1jRBHtvQcSIGCDM211TApJuyif3qfqyv61zrAp
         NeQvQMj1MIDhFoivreiF3QXCa4GYLvHnXyadEyoOhDEfSai0B2zaf//wOoy7PgI3fK
         ZaIpRjOTJO/dt7v+TjgtzreLcGI8da5493+HrPaPYMCMJ4lMRYZ6M4V9eruJhCEKug
         p0jUqyooOVVTg==
Date:   Sat, 9 Sep 2023 12:19:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] media: dvb: symbol fixup for dvb_attach()
Message-ID: <20230909121941.30a1b1f0@sal.lan>
In-Reply-To: <2023090852-stoppable-jackpot-549f@gregkh>
References: <20230908092035.3815268-2-gregkh@linuxfoundation.org>
        <ZPtKCc2PLi0wdR2+@bombadil.infradead.org>
        <2023090852-stoppable-jackpot-549f@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 8 Sep 2023 17:35:07 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Fri, Sep 08, 2023 at 09:21:29AM -0700, Luis Chamberlain wrote:
> > On Fri, Sep 08, 2023 at 10:20:36AM +0100, Greg Kroah-Hartman wrote:  
> > > In commit 9011e49d54dc ("modules: only allow symbol_get of
> > > EXPORT_SYMBOL_GPL modules") the use of symbol_get is properly restricted
> > > to GPL-only marked symbols.  This interacts oddly with the DVB logic
> > > which only uses dvb_attach() to load the dvb driver which then uses
> > > symbol_get().
> > > 
> > > Fix this up by properly marking all of the dvb_attach attach symbols as
> > > EXPORT_SYMBOL_GPL().
> > > 
> > > Fixes: 9011e49d54dc ("modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules")
> > > Cc: stable <stable@kernel.org>
> > > Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-modules@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > Luis, do you want to take this through your tree?  Or Mauro's?  Or I can
> > > take it through mine, it should get to Linus soon as this is causing
> > > regressions in his tree.  
> > 
> > You've done the work so it is up to you, whatever helps you expedite it
> > as it already hit stable. Feel free to take it through your tree.  
> 
> If you ack it, I can take it now through my tree and send it to Linus
> tomorrow.

You can send it via your trees. So:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
> thanks,
> 
> greg k-h
