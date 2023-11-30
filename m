Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C27FEE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbjK3LfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbjK3LfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:35:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB410CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:35:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB79C433C8;
        Thu, 30 Nov 2023 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701344121;
        bh=aXMCvRbkbAavtJM/apaYExo/mAL/W5+YtPx7xBZtPGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZWEHStWGFkUOVCoEGkX84XImKjl1P+rgEdzoDX8HIICyn1sEoHm3cmuEsjw/cpzP
         qV4LyjM3aSC+fe9S3lqQZ5i8CAoS2grjDwhKd5kxqEGmfCODhCjNlRu+K/L6bY7Kaa
         5pvhgEleJ/nCcMEBnvO/12CxNwQq8i7Px1PyjYbFIDNsseZ7/nk66yxUez5R4uPHkl
         +8lItc8llCIH4kcHox3D3BS8olQVVsBQejD3IAVjUqXzyEAQt7wC1Jm63uFTAFgnbg
         xU8aKWzAxbWSv9rjaXAlr2SfsCsmAaiIbTc1nW4qHeFZqlggD3NMkD249Q83mh0l/h
         3aOhAU/Fd4reQ==
Date:   Thu, 30 Nov 2023 11:35:17 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <20231130113517.GJ1470173@google.com>
References: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
 <ZWDhpZLCZ5xz1RKR@smile.fi.intel.com>
 <20231127085356.GD1470173@google.com>
 <ZWSQnZfGKQ_0DaYJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWSQnZfGKQ_0DaYJ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Andy Shevchenko wrote:

> On Mon, Nov 27, 2023 at 08:53:56AM +0000, Lee Jones wrote:
> > On Fri, 24 Nov 2023, Andy Shevchenko wrote:
> > > On Fri, Jun 09, 2023 at 09:48:18AM +0800, Jiasheng Jiang wrote:
> 
> ...
> 
> > > > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > > 
> > > This does not fix anything and just introduces a duplication code.
> > > I would like this to be reverted. Should I send one?
> > 
> > Checking this value at the source of obtention and providing and earlier
> > return with arguably a better return value, all at the cost of an
> > inexpensive pointer comparison to NULL doesn't sound like a terrible
> > idea.
> 
> In general, I agree with you, but the cases similar to this. Why?
> Because memory resource retrieval and remapping has a lot of helpers,
> some of which are enriched with own error handling and messaging.
> 
> Yes, we use devm_ioremap_uc(), which doesn't give that (yet?).
> However, it will be more work if we, theoretically, switch to
> something like devm_ioremap_resource() in the future.
> 
> Hence, I would like to have a common code to be in common place
> and behave in the same way independently on the glue druver (PCI,
> ACPI, etc).
> 
> > If you were committed to the idea of removing it, which I suggest you
> > reconsider, I would insist that you replace it with at least a comment.
> 
> Isn't what I have done in the series I sent last week?

You have to send links when you say things like this.

Last week I had 1000 unread upstream mails in this inbox.

-- 
Lee Jones [李琼斯]
