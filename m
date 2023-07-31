Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EA769D51
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjGaQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGaQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0D1722;
        Mon, 31 Jul 2023 09:57:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A68A68AA6; Mon, 31 Jul 2023 18:57:22 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:57:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/5] mmc: use EXPORT_SYMBOL_GPL for mmc_detect_change
Message-ID: <20230731165722.GA10760@lst.de>
References: <20230731083806.453036-1-hch@lst.de> <20230731083806.453036-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-5-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:38:05AM +0200, Christoph Hellwig wrote:
> mmc_detect_change is used via symbol_get, which was only ever intended
> for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
> for it so that symbol_get can enforce only being used on
> EXPORT_SYMBOL_GPL symbols.

Btw, I really wonder if this should actually be used through symbol_get.
It seems like the MIPS/alchemy boards should simply require MMC to be
built in and not modular, or the IRQ handlers should move into a driver.

That would be a much less mechanical change, but this use really looks
a bit odd.  And makes me wonder if we should only allow symbol_get
on symbols specifically marked to supported it, but that would be
another incremental step.
