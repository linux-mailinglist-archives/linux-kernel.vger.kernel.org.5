Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA307755DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGQIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGQIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ABD10F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891C260FB4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF2CC433C7;
        Mon, 17 Jul 2023 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689581017;
        bh=fxCzi9cqQ/6Te9Id+fLIHCQJFVg7LEXG2cA0E+qADbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FISKc+7gCFhCRRl0wkH4LKhJ2TtLo1Zcbd5H+B09PDWFKUUyJcBeJg8VL+QClvgea
         y4E77RexFfMjBLyDjcaeMg4lWfeICFn4Oveq5XGMC+aUifC1cYMA3yCcRwnIisZhxr
         Jmpm2nph7AAyTLi77S1ghli1vuBZpaVXqYg9dV3rWYMOUiVBlrmTDD1YOw7pTILx02
         YQloLQwMXxGqmcyRSvTbK3zNyJJMG3uNkc4gP8mT5NWVi7UDBhl1QN06YpwygQOI9l
         o8qBEmIhDKjm3J9+L4ZVo00gG+Egb/vpHbwsCXAsatTAhdqhfCrUtZvhHwUBPryh7h
         4UURKLSAGBsLQ==
Date:   Mon, 17 Jul 2023 10:03:32 +0200
From:   Keith Busch <kbusch@kernel.org>
To:     Sean Wang <wangxiao@hotmail.it>
Cc:     "highenthalpyh@gmail.com" <highenthalpyh@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "xuwd1@hotmail.com" <xuwd1@hotmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
Message-ID: <ZLT11NpGd4hR4yp7@kbusch-mbp.dhcp.thefacebook.com>
References: <MEAP282MB039120C4DEF97CED9B4CE841B33BA@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEAP282MB039120C4DEF97CED9B4CE841B33BA@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:41:26AM +0000, Sean Wang wrote:
> My two SSDs are from different companies, but they all use MaxIO 1602 nvme controllers.
> 
> After applying this patch, they could work.
> 
> Otherwise, here is a workaround to make live cd to recognize these SSDs:
> 
> 
> echo “1” > /sys/bus/pci/devices/0000:02:00.0/remove
> sleep 1
> echo “1” > /sys/bus/pci/rescan
> 
> Where device id (02:00.0) could be found via
> 
> lspci -nn -d ::0108

We have a generic solution for such devices as of 6.5-rc2 so it should
work now; however, it's still recommended to get devices with this
behavior in the quirk list in order to ensure that the we get udev to
generate deterministic symlinks. Since this controller is used by
multiple vendors, though, it's unclear if this quirk applies to all
variations.
