Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B876942A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGaLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGaLFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305A98;
        Mon, 31 Jul 2023 04:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A196100C;
        Mon, 31 Jul 2023 11:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24852C433C7;
        Mon, 31 Jul 2023 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690801529;
        bh=aDQytpIehxdC9Y92aOCsKJiiWVzUj/QKa0p5med/PCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6NCuUd2dWAFRltw2+pGmuDVTotQpjH0ekKpzZTX6xFqUgNw1T9VfYT3y9t9W5+Zi
         a90PJEXjCJlyzYqhxvr/DW6eMaqAi8zS6wVgLCL/aR8FuEgbQLT1Uwoy4WRgpwA9Qx
         +/vFsSMs5e4xpn7tonapNyoZMS+bpeH9TBXzd6Xo=
Date:   Mon, 31 Jul 2023 13:05:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] modules: only allow symbol_get of EXPORT_SYMBOL_GPL
 modules
Message-ID: <2023073135-destiny-washbowl-2689@gregkh>
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:38:06AM +0200, Christoph Hellwig wrote:
> It has recently come to my attention that nvidia is circumventing the
> protection added in 262e6ae7081d ("modules: inherit
> TAINT_PROPRIETARY_MODULE") by importing exports from their propriertary
> modules into an allegedly GPL licensed module and then rexporting them.
> 
> Given that symbol_get was only ever inteded for tightly cooperating
> modules using very internal symbols it is logical to restrict it to
> being used on EXPORY_SYMBOL_GPL and prevent nvidia from costly DMCA

"EXPORT"  :)

> circumvention of access controls law suites.
> 
> All symbols except for four used through symbol_get were already exported
> as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> the preparation patches.
> 
> Fixes: 262e6ae7081d ("modules: inherit TAINT_PROPRIETARY_MODULE")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for fixing this hole up, it's much needed.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
