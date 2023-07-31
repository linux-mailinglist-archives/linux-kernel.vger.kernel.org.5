Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4751F769A87
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGaPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGaPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B21702;
        Mon, 31 Jul 2023 08:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A238761197;
        Mon, 31 Jul 2023 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E584C433C7;
        Mon, 31 Jul 2023 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690816398;
        bh=MrF8t4t8uZvmRiF8M4pqprmOZSgb4oSYLczB3T4NgPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYuSN8EF6dbJJwz5kYvjtRQHEirq5FstpPilnFRsZt1Eh6QBnsOyYNSwMbskHFPyC
         hAIEAhlQcHT9Chsxo9VdFI1VgjpH0GrUHKRECmuEBvFz7dZHVlX6RIGUEzcBsbEpS8
         paqhOgiC2Yxfj+uN/q1+ZAGLqfFJf8t2cHm3l07Y=
Date:   Mon, 31 Jul 2023 17:13:15 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by
 writing 1 for lpuart32 platforms
Message-ID: <2023073106-disallow-sketch-c5cf@gregkh>
References: <20230731015053.15150-1-sherry.sun@nxp.com>
 <51a7f260-59f9-2cd4-9d49-484df00fb3b2@kernel.org>
 <AS8PR04MB8404AA5CD478CD6AEEFC42A29205A@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8404AA5CD478CD6AEEFC42A29205A@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:50:46AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Jiri Slaby <jirislaby@kernel.org>
> > Sent: 2023年7月31日 13:24
> > To: Sherry Sun <sherry.sun@nxp.com>; gregkh@linuxfoundation.org;
> > tomonori.sakita@sord.co.jp; atsushi.nemoto@sord.co.jp
> > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by writing 1
> > for lpuart32 platforms
> > 
> > On 31. 07. 23, 3:50, Sherry Sun wrote:
> > > Do not read the data register to clear the error flags for lpuart32
> > > platforms, the additional read may cause the receive FIFO underflow
> > > since the DMA has already read the data register.
> > > Now all lpuart32 platforms support write 1 to clear those error bits,
> > 
> > What does this "Now" mean? Will this change break some older platforms?
> 
> Hi Jiri,
> 
> Sorry for the confusion, maybe the "Now" should be removed here. I can
> send a V2 to improve the commit message if needed.

Please do, thanks!

greg k-h
