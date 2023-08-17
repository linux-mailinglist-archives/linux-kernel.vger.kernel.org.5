Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B877FD02
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354005AbjHQR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353989AbjHQR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDE10C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759826686F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D26BC433C8;
        Thu, 17 Aug 2023 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692293290;
        bh=LnZjsJz7EZXeWbPKrmBF1pX9XMVjg1pxfryeZzTteec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RozV1TsWvToEi3lx/ro/Xe9DZER9Qw9kzYusKskWHrURFvw7TdfrMVCw2IDvZPl25
         wshQrwsWuIxdz+vKdRlhBQHhbaEjL6xh9AnirlGII7tVFOLk+xfwlvscnHlM+hWfUe
         80EM2BwjZ4ynBVGWA4ogzRHujEf1EeOGGunLLXfi95CzHLtli6KU8+a8nvmqnzlNqv
         2quhoPb9n7Bc4rfZHaJjOjr+Td0kacwvq0qku6D0/Bs9ncmlfkBSCIts0e2pSqxjpC
         IeWO/KbuT5Zes/2qYer9IJ5g5uAz04QZZvmLqSuJt/xInTkCDAtbgQ31pK/Z5E9yJJ
         nHEvSGhQngNlw==
Date:   Thu, 17 Aug 2023 11:28:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Genes Lists <lists@sapience.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de, arnd@arndb.de,
        ricky_wu@realtek.com, gregkh@linuxfoundation.org
Subject: Re: Possible nvme regression in 6.4.11
Message-ID: <ZN5YqPuT0+j8kP3l@kbusch-mbp.dhcp.thefacebook.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:16:01AM -0400, Genes Lists wrote:
> On 8/16/23 21:30, Genes Lists wrote:
> > On 8/16/23 17:04, Keith Busch wrote:
> > ...
> > > It sounds like you can recreate this. Since .10 worked and .11 doesn't,
> > > could you bisect the git commits? It looks like it will take 7 steps
> > > between those two versions.
> > > 
> > > I don't think there are any nvme specific patches that could contribute
> > > to what you're seeing, it's more likely some lower level platform patch
> > > if a kernel change really did cause the regression. None of the recent
> > > commits really stood out to me, so bisect is what I'd recommend.
> > 
> > Thank you
> > 
> > Bisect done - This is result:

Sounds like the driver's ASPM suspicion was justified, however the
recommended work-around doesn't appear to apply to this hardware.
Thanks for running the bisect!

> > ----------------------------------------------------------------
> > 69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
> > commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
> > Author: Ricky WU <ricky_wu@realtek.com>
> > Date:   Tue Jul 25 09:10:54 2023 +0000
> > 
> >      misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> > 
> >      commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.
> > 
> >      ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
> >      to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
> >      always set to HIGH during the initialization.
> > 
> >      Cc: stable@vger.kernel.org
> >      Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> >      Link:
> > https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> >   drivers/misc/cardreader/rts5227.c  |  2 +-
> >   drivers/misc/cardreader/rts5228.c  | 18 ------------------
> >   drivers/misc/cardreader/rts5249.c  |  3 +--
> >   drivers/misc/cardreader/rts5260.c  | 18 ------------------
> >   drivers/misc/cardreader/rts5261.c  | 18 ------------------
> >   drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
> >   6 files changed, 6 insertions(+), 58 deletions(-)
> > 
> > ------------------------------------------------------
> > 
> > And the machine does have this hardware:
> > 
> > 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A
> > PCI Express Card Reader (rev 01)
> >          Subsystem: Dell RTS525A PCI Express Card Reader
> >          Physical Slot: 1
> >          Flags: bus master, fast devsel, latency 0, IRQ 141
> >          Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
> >          Capabilities: [80] Power Management version 3
> >          Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >          Capabilities: [b0] Express Endpoint, MSI 00
> >          Kernel driver in use: rtsx_pci
> >          Kernel modules: rtsx_pci
