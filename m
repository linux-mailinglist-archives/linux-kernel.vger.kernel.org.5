Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDC77DBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbjHPIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbjHPILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83023AB;
        Wed, 16 Aug 2023 01:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177826345F;
        Wed, 16 Aug 2023 08:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552FFC433C7;
        Wed, 16 Aug 2023 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692173491;
        bh=Vaj4jf6XLcsiRxLxN7vFGefZkgbs6uwB9LPt3hNn17k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEzohTfbauIWJLpGGasVcvpqjbQio9vmTLRIqqxc1ESh1HoWRnBgljFF9Ibuu+3Rb
         B9TTxjHL97V6ANBb5SwwTXoQs37cqfAeAN/v2ozcDAKtNLps1bhBY86LVHunYplTNP
         3bregalJtbOUEcDu6nxnZ4Tb8lgDTNv+6/B1cnqRD74xZcNv5Nu6TIZaq6R/xM1nC0
         yKbBNCGAt/p1eCtvoylCpDU9SquxB542zRG3IheqIxaXDsZhZXaBGLgvyso77512fL
         p0QBGwloTX8grMsVga6hMOU3ZwmD01an3QypD/BWiZGL11JhvhLFuBwkJU3jJF8VU3
         hwoJVSYsbMEDA==
Date:   Wed, 16 Aug 2023 10:11:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-s390@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next-2023-0815: s390/block/dasd: build error
Message-ID: <20230816-substantiell-ansporn-5db2e3d0c877@brauner>
References: <95b176a2-3670-1e89-c8f6-86b094eebc4c@infradead.org>
 <20230816170934.71a5e306@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816170934.71a5e306@oak.ozlabs.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:14:39PM +1000, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Tue, 15 Aug 2023 22:34:19 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > I have spent some time on this but I don't see where the problem is.
> > 
> > ERROR: modpost: "bdev_mark_dead" [drivers/s390/block/dasd_mod.ko] undefined!
> > 
> > CONFIG_BLOCK=y, bdev.o is built and contains the missing symbol.
> > 
> > Full randconfig file is attached.
> > 
> > Hopefully I'm just overlooking something.
> 
> In your config, CONFIG_DASD=m which means "#ifdef CONFIG_DASD" will
> fail since CONFIG_DASD_MODULE is defined instead ... so maybe it should
> be "#if IS_ENABLED(CONFIG_DASD)" in block/bdev.c.  This also fails an
> s390 allmodconfig build (obviously).
> 
> So this is caused by commit
> 
>   381f678306ce ("block: consolidate __invalidate_device and fsync_bdev")
> 
> from the vfs-brauner branch in linux-next.

Thanks for reporting this everyone. Fixed in-tree.
