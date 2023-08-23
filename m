Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2F78566A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjHWLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjHWLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:07:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A6CEF;
        Wed, 23 Aug 2023 04:07:46 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qYli7-0006dD-2j; Wed, 23 Aug 2023 13:07:39 +0200
Date:   Wed, 23 Aug 2023 13:07:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwrng: imx-rngc - use polling to detect end of self
 test
Message-ID: <20230823110739.4oqyhjca7ratf5sx@viti.kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx>
 <20230822152553.190858-2-martin@kaiser.cx>
 <3503619.mvXUDI8C0e@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3503619.mvXUDI8C0e@steina-w>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

thanks for reviewing the patches.

Alexander Stein (alexander.stein@ew.tq-group.com) wrote:

> Am Dienstag, 22. August 2023, 17:25:51 CEST schrieb Martin Kaiser:
> > Use polling to detect the end of the rngc self test. This is much simpler
> > than using an interrupt and a completion.

> > Active waiting is no disadvantage here. The self test is run during
> > probe, there's nothing we could do in parallel at this time.

> If this driver is built-in you are stalling the boot process while
> polling, no?

According to the manual, "The self test takes approximately 29,000
cycles to complete." On my system, the rngb peripheral clock runs at
66.5MHz, i.e. the self test takes 436us.

A poll interval of 480us and a timeout of 1.5ms are more appropriate
than the current values (1ms poll interval, 3sec timeout). I'll fix this
in v2.

If it is unacceptable for a probe function to run for 1.5ms, we could
probably move the self test to the init function. It's called when the
rng is selected as the active rng.

> Unless probe_type = PROBE_PREFER_ASYNCHRONOUS is set of
> course.

This does not work for drivers that use module_platform_driver_probe.

We could switch to module_platform_driver. I'd prefer fixing the timing
or moving the self test to init, though.

Best regards,
Martin
