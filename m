Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F967D66B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJYJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJYJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:26:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FC88F;
        Wed, 25 Oct 2023 02:26:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D1C433C8;
        Wed, 25 Oct 2023 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698226005;
        bh=4n0iQGryR3l11ivfAXSZJrCU7Nk2I5Jy+sv+NdwUasQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tULDT4F4BuJuij+PaCntRR4+ii5P140m7lR+dfTCphuE2Q+ux46tUY8wcaQ6uXiMb
         pLYWpIqLoR9/kKBHvCCvRkzTR3OGVnmxBc9TDnZkHYNEJqB0ZZPB9y5VXOCuDtB561
         7PB4243yWqd+wmudvFJX/c16YrRlC+opihHGC5/SMlUkJevQCZpDCqePPdRYcGj31p
         JzIr9+RKEI7INPqB8H1fiChgl5cpBDZ3RL2ct7XoslhxFnwSEJ5jjWbyX676rEQLJA
         n6jYty+uYu4cQ5gYBLp2h18fOBAZnPgC/CmwiXq2VateWeAW0vdbpIT3/c5AFUbanw
         6EwJxQVsC8z3Q==
Date:   Wed, 25 Oct 2023 10:26:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <20231025092639.GL8909@google.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <ZTiJYxAvqfBMMJ1S@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTiJYxAvqfBMMJ1S@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Jeff LaBundy wrote:

> Hi James,
> 
> Just a few trailing comments on top of Lee's feedback.
> 
> On Wed, Oct 18, 2023 at 05:57:24PM +0000, James Ogletree wrote:
> > From: James Ogletree <james.ogletree@cirrus.com>
> > 
> > Introduce support for Cirrus Logic Device CS40L50: a
> > haptic driver with waveform memory, integrated DSP,
> > and closed-loop algorithms.
> > 
> > The MFD component registers and initializes the device.
> > 
> > Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> > ---
> >  MAINTAINERS                 |   2 +
> >  drivers/mfd/Kconfig         |  30 +++
> >  drivers/mfd/Makefile        |   4 +
> >  drivers/mfd/cs40l50-core.c  | 443 ++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/cs40l50-i2c.c   |  69 ++++++
> >  drivers/mfd/cs40l50-spi.c   |  68 ++++++
> >  include/linux/mfd/cs40l50.h | 198 ++++++++++++++++
> >  7 files changed, 814 insertions(+)
> >  create mode 100644 drivers/mfd/cs40l50-core.c
> >  create mode 100644 drivers/mfd/cs40l50-i2c.c
> >  create mode 100644 drivers/mfd/cs40l50-spi.c
> >  create mode 100644 include/linux/mfd/cs40l50.h

Just popping along to say; these are excellent comments Jeff.

Thank you for your review.

-- 
Lee Jones [李琼斯]
