Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD15F78569D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjHWLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjHWLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:16:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711BD184;
        Wed, 23 Aug 2023 04:16:10 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qYlqH-0006gR-QF; Wed, 23 Aug 2023 13:16:05 +0200
Date:   Wed, 23 Aug 2023 13:16:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: imx-rngc - use polling to wait for end of
 seeding
Message-ID: <20230823111605.sxtf3kriavv6hzxy@viti.kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx>
 <20230822152553.190858-4-martin@kaiser.cx>
 <5662754.31r3eYUQgx@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5662754.31r3eYUQgx@steina-w>
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

Alexander Stein (alexander.stein@ew.tq-group.com) wrote:

> Am Dienstag, 22. August 2023, 17:25:53 CEST schrieb Martin Kaiser:
> > Use polling to wait until the imx-rngc is properly seeded.

> What is the benefit of burning CPU cycles while waiting for hardware?

it seems to me that

readl_poll_timeout
   readx_poll_timeout
      usleep_range
         usleep_range_state
            schedule_hrtimeout_range

will not wait in the foreground and burn CPU cycles.

The comment for schedule_hrtimeout_range says

 * Make the current task sleep until the given expiry time has
 * elapsed.

> > We do this only in the init function when the imx-rngc becomes active.
> > Polling is ok at this time, there's nothing else we could do while
> > we're waiting.

> > We can now remove the code for the interrupt and the completion.

> Please split the change to polling and IRQ removal into two patches.

Good point. Will do this in v2.

> RNGC_STATUS_SEED_DONE, 1000, RNGC_TIMEOUT * 1000);
> So you want to poll for up to 3s?

According to the manual, "The initial seed takes approximately 2,000,000
clock cycles." With a 66.5MHz clock, this is approx 30ms. So that should
be

RNGC_STATUS_SEED_DONE, 20000, 100000);

The comment for readx_poll_timeout suggests <= 20ms for the poll
interval.

Best regards,
Martin
