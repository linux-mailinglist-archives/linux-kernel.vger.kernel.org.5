Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4375269B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjGMPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGMPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30549134
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE351616A6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E068AC433C7;
        Thu, 13 Jul 2023 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689261594;
        bh=VsVd6c6fcDYfKRrByNwWM9qnQW5+5Y5fBRbciDWv40I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5mdgSePHnomeUDlfS+pkzxKFrwwHpKsTuWkBqUg0484adSopLIhookQKA9b9+J7z
         WYum0Nt1IzXiXiTYLXuJYE08RGoyhlqtANzpZdb8GwRbiikqy6vZ9lPzwpRJlVVGWu
         LrQBNXSwL8x8zvgzAwA02tIAbpVCl6ILYu1xoaJslNOWRBh7hyqw1+bpuL73c81MyW
         xDs/Fzh6+vMBPhjxx2U/Brmcjiy5fXO8rUzDvazvIkLv6G2AfAzb4Gccj0rzhrjcBl
         YwjBnBZeaUPvY+7q8qht2BqYB/1m6thCFspv2U/58EJR9yA88OYfbxRImfY+eVHIKg
         DKCbJvpV9aDFw==
Date:   Thu, 13 Jul 2023 16:19:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     Min Li <lnimi@hotmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
Message-ID: <20230713151950.GA968624@google.com>
References: <MW5PR03MB693295AF31ABCAF6AE52EE74A08B9@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20230330132600.GR434339@google.com>
 <OS3PR01MB6593BFFA683814654C957589BA37A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB6593BFFA683814654C957589BA37A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Lee

> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: March 30, 2023 9:26 AM
> > To: Min Li <lnimi@hotmail.com>
> > Cc: richardcochran@gmail.com; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; Min Li <min.li.xe@renesas.com>
> > Subject: Re: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
> > 
> > On Mon, 27 Mar 2023, Min Li wrote:
> > 
> > > From: Min Li <min.li.xe@renesas.com>
> > >
> > > We used to assume 0x2010xxxx address. Now that we need to access
> > > 0x2011xxxx address, we need to support read/write the whole 32-bit
> > > address space.
> > >
> > > Also defined RSMU_MAX_WRITE_COUNT and
> > > RSMU_MAX_READ_COUNT for readability
> > >
> > > Signed-off-by: Min Li <min.li.xe@renesas.com>
> > > ---
> > > changelog
> > > -change commit message to include defining
> > RSMU_MAX_WRITE/WRITE_COUNT
> > >
> > >  drivers/mfd/rsmu.h       |   2 +
> > >  drivers/mfd/rsmu_i2c.c   | 172 +++++++++++++++++++++++++++++++--
> > ------
> > >  drivers/mfd/rsmu_spi.c   |  52 +++++++-----
> > >  include/linux/mfd/rsmu.h |   5 +-
> > >  4 files changed, 175 insertions(+), 56 deletions(-)
> > 
> > I changed the commit message a little and reworded/moved a comment and:
> > 
> > Applied, thanks
> 
> I am writing to follow up with the following change. But I can't track it being merged with any branch, can anyone tell me where it is now? Thanks

67d6c76fc815c ("mfd: rsmu: Support 32-bit address space")

-- 
Lee Jones [李琼斯]
