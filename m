Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A77791918
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbjIDNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbjIDNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:48:14 -0400
Received: from smtp98.ord1d.emailsrvr.com (smtp98.ord1d.emailsrvr.com [184.106.54.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A829E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1693835290;
        bh=oj6kE0tR3mBmhS7q1JhgPp8ImT14KeAUqtqTIcT5iMc=;
        h=Date:Subject:To:From:From;
        b=gxh39NaEelNZYNiyFu9jmxDvR48+PaU6jjy9Vy4dXtKoHfSM2w8nlvm6POXZ2Xax+
         1eRKrauZs22Sz2wTgewh9AriQ1BKgkTlzsSufR4rsBgwABcC8I0c+3KEqGKn3PrRF7
         ZYpOjA6sMgy+ilX4qnZwl7QDeeq594Ugq3TEKwOk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp21.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3A82160086;
        Mon,  4 Sep 2023 09:48:09 -0400 (EDT)
Message-ID: <87f9a142-1ae5-4fe2-b127-fc5e9566ccbc@mev.co.uk>
Date:   Mon, 4 Sep 2023 14:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT
 changes
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org
References: <20230901192615.89591-1-abbotti@mev.co.uk>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230901192615.89591-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 2259e75c-e07b-4d2f-842f-105711fcd2d4-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 20:26, Ian Abbott wrote:
> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed the
> "select" directives to "depend on" directives for several config
> stanzas, but the options they depended on could not be selected,
> breaking previously selected options.  Change them back to "select"
> directives and add "depends on HAS_IOPORT" to config entries for modules
> that either use inb()/outb() and friends directly, or (recursively)
> depend on modules that do so.
> 
> Fixes: b5c75b68b7de ("comedi: add HAS_IOPORT dependencies")
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: <stable@vger.kernel.org> # v6.5+
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>   drivers/comedi/Kconfig | 119 +++++++++++++++++++++++++----------------
>   1 file changed, 72 insertions(+), 47 deletions(-)

Please ignore this patch.

I'll send another patch to revert b5c75b68b7de as recommended in the 
other replies on this thread by Arnd and Niklas.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

