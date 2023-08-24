Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC772786EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjHXMUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241350AbjHXMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89D19BD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740A566B25
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C7FC433C7;
        Thu, 24 Aug 2023 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692879571;
        bh=7DoxyHgUOzfItSz0te4kD/RDGv8F9/FkGoy0vBLm1ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fz/1P9NlbRiSaa90TqTo1/ACT9bjaU6i755dtJroFJeJOWKQ8J3ZTcbmoqIFM1vn7
         OdxCwY0A9D7JPQN/yUb73RsNaVG/UXl/+i2hIf/Z4IKmeaG1Jatczt9wlmixZSvIYl
         UANwQE0PIYSylfyu/Q9V69ecXoLukpM9FajvMqcHCg2L3OgJDN+gqdjYzEC3XQHiWv
         geTnRITdZ2OC4AmuPVAv0ESumYkM6I38YcsT0QVDM77vLBcxQeSuVUHp03puPcQGVM
         Qi3aj+afoMqB0mkLPzypUBNbq2CzUZRuAccTM+13Y8SgWffkxkPfihGsSzSCpSivo/
         wxS5U5Dsls5dA==
Date:   Thu, 24 Aug 2023 13:19:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
Message-ID: <20230824121928.GX1380343@google.com>
References: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
 <20230818155815.GY986605@google.com>
 <ZOAIplO6tcFN2H8L@qmqm.qmqm.pl>
 <20230821081340.GD1380343@google.com>
 <ZOUOIT40/qH7VOTS@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOUOIT40/qH7VOTS@qmqm.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Michał Mirosław wrote:

> On Mon, Aug 21, 2023 at 09:13:40AM +0100, Lee Jones wrote:
> > On Sat, 19 Aug 2023, Michał Mirosław wrote:
> > 
> > > On Fri, Aug 18, 2023 at 04:58:15PM +0100, Lee Jones wrote:
> > > > On Wed, 16 Aug 2023, Michał Mirosław wrote:
> > > > 
> > > > > of_reg is the only constant member of struct mfd_cell. It seems to be
> > > > 
> > > > Sorry, what?
> > > > 
> > > > struct mfd_cell {
> > > >         const char              *name;
> > > > [...]
> > > >         const struct mfd_cell_acpi_match        *acpi_match;
> > > > [...]
> > > >         const struct software_node *swnode;
> > > > [...]
> > > >         const char              *of_compatible;
> > > > [...]
> > > >         const u64 of_reg;
> > > > [...]
> > > >         const struct resource   *resources;
> > > > [...]
> > > >         const char * const      *parent_supplies;
> > > > [...]
> > > > };
> > > [...]
> > > 
> > > All those are pointers to const, not const fields themselves. Only
> > > `of_reg` is const regardless of the whole structure.
> > 
> > Please make that clear in the commit message.
> 
> Could you please help with the wording? I'm surprised being asked to explain
> a basic C language feature in a commit message to have a patch accepted.
> Could it be due to me using 'constant' instead of 'const' that made it
> confusing?

I read the commit message to say that there aren't any consts in the
structure, but as you can see, there are plenty.  Just change the
language to be more specific about what you actually mean.  Or just drop
the sentence entirely.

-- 
Lee Jones [李琼斯]
