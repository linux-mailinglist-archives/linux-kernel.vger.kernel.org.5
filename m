Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF527992AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbjIHXJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjIHXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:09:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5B1FE5;
        Fri,  8 Sep 2023 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7DXMMG8lphyN1UYT/bdqivjwbJYfjhTJFNgrVjQWJQ=; b=MIVUvcTZhlZQmiAIATHfNHIKVO
        CJhnk788m6vic6dye+YMPr2UEzzGxKosZEX2+BqKuM1BdlPQHPzRQGrzmxqKTMBxHDr+ZJXS97qeQ
        xHOnlbO/94akhRCatQ2Zc4pKvw0UH3SbzYruUX/iHZ7JvTS3CIk6ibVxkAuEIAR6rNwgGBBkFnaTp
        l0l/Zx28gD/dgjZ3owAYXUGk99MlNFCC8/XAV4IhQ1vo9bIAiyU33YEAtMy+Y/zEMzzRoqQa5SRuW
        zI5XMt1bdzbGutzevigArC3YwxvoAtfLqduxeK7zoWa7mx/vtfv4+scIKgHUDxSEcpP8ujhTnAV+K
        IMz7pbQw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qekbf-00Efj4-2D;
        Fri, 08 Sep 2023 23:09:43 +0000
Date:   Fri, 8 Sep 2023 16:09:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] media: dvb: symbol fixup for dvb_attach()
Message-ID: <ZPupt66Ue9PutjTK@bombadil.infradead.org>
References: <20230908092035.3815268-2-gregkh@linuxfoundation.org>
 <ZPtKCc2PLi0wdR2+@bombadil.infradead.org>
 <2023090852-stoppable-jackpot-549f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023090852-stoppable-jackpot-549f@gregkh>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:35:07PM +0100, Greg Kroah-Hartman wrote:
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

Sorry for the delay:

Acked-by Luis Chamberlain <mcgrof@kernel.org>

  Luis
