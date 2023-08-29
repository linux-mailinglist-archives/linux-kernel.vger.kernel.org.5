Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53078CC91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjH2S6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjH2S6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:58:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BAFFC;
        Tue, 29 Aug 2023 11:58:20 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qb3un-0008OZ-I9; Tue, 29 Aug 2023 20:58:13 +0200
Date:   Tue, 29 Aug 2023 20:58:13 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hwrng: imx-rngc - use polling to detect end of
 self test
Message-ID: <20230829185813.odjl3zqwshbgki4m@viti.kaiser.cx>
References: <20230824192059.1569591-1-martin@kaiser.cx>
 <20230824192059.1569591-4-martin@kaiser.cx>
 <8370215.EvYhyI6sBW@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8370215.EvYhyI6sBW@steina-w>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Alexander Stein (alexander.stein@ew.tq-group.com) wrote:

> I'm still not convinced that using polling is simpler. By using 
> readl_poll_timeout() you will also get an interrupt, the timer one. Why 
> exactly is using polling much (!) simpler?

it requires much less code in the driver.

> > The selftest should take approx. 450us. Keep the overhead to a minimum
> > by polling every 500us. (We've already lowered the timeout to 1.5ms.)

> I suppose these times only hold true for a specific peripheral clock 
> frequency. Is it guaranteed that this frequency is fixed?

Good point. The lowest possible peripheral clock frequency is half of
what I used for the calculations, i.e. 33.25MHz. That would double the
durations. Should be ok for the selftest. But for the initial seed, we'd
get into a region where readl_poll_timeout (usleep_range) does no longer
make sense.

> For using IRQ it's simpler, there is no guessing: you return once the self 
> test finished. The timeout is identical anyway.

I've looked at other callers of readl_poll_timeout. It seems that none
of them is called in a driver's probe function or uses an overall
timeout of 200ms.

I'll keep the interrupt + completion and resubmit the patches for
adjusting the timeouts.

Thanks,
Martin
