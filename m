Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8CF805C53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442504AbjLEPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbjLEPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:52:53 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61EB122;
        Tue,  5 Dec 2023 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=LhMdVz+ZNJasrk+ZfyCQUSB1AUQOhaqb2Xcla+hSRhc=; b=pu3Jea13HRpIWeJ6Cic8c+4FrH
        1Tr2G27tYtcc2kll2v+Eczt9JU8c2jGHQoreDN9D6d7dmk0gfSdk4JWt009ctq+jNBAsZHhMVsa4H
        6q1BmCwYJPIexxdU4n2wyoNofqwfjGjWB494p3G1Xninkt8lw0aDExbHJ7vjBpHvKLGU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54368 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rAXj4-0000St-CJ; Tue, 05 Dec 2023 10:52:46 -0500
Date:   Tue, 5 Dec 2023 10:52:46 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231205105246.a0864cd10ff0252dec9ffabc@hugovil.com>
In-Reply-To: <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
        <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
        <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 18:34:38 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 01, 2023 at 01:27:36PM -0500, Hugo Villeneuve wrote:
> 
> > it is funny, as I am preparing to send a patch for the sc16is7xx driver
> > to convert FIFO R/W to use the _noinc_ versions of regmap functions,
> > inspired by your patch 3f42b142ea11 ("serial: max310x: fix IO data
> > corruption in batched operations").
> 
> If you're working on that driver it'd also be good to update the current
> use of cache bypass for the enhanced features/interrupt identification
> register (and anything else in there, that did seem to be the only one)
> to use regmap ranges instead - that'd remove the need for the efr_lock
> and be a much more sensible/idiomatic use of the regmap APIs.

Hi Mark,
after our discussion about regmap range, it seems that the
efr_lock will need to stay.

In fact, all of this helped me to uncover another case where an
additional lock would be needed.

Hugo Villeneuve
