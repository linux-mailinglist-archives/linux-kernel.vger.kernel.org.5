Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DED7919A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351106AbjIDO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjIDO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:28:35 -0400
Received: from smtp66.ord1d.emailsrvr.com (smtp66.ord1d.emailsrvr.com [184.106.54.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3DCE5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1693837711;
        bh=XJpws83PAeltUvDGI90D5dKMClclXtIXCy296ciNP6Q=;
        h=Date:From:Subject:To:From;
        b=lCcK27klLgm9Obrnk9gQsfj1fiaqG9UUFhg68/rhTpFA/XUwUoyB70BqA7618SI0o
         iluFnSqJnCAJmzHk8g8oMmib62orTjakmXGuB9pgfhnN2WU9gy4GpRM2cuSyZ7KL2H
         KlyRCSZfuR/W2vkvidE3wE/CfKz9WEhCUjXVApVM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3BFF8C00EE;
        Mon,  4 Sep 2023 10:28:30 -0400 (EDT)
Message-ID: <aaf05569-1564-43de-8706-d604e583bf42@mev.co.uk>
Date:   Mon, 4 Sep 2023 15:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Subject: [REGRESSION] comedi: add HAS_IOPORT dependencies
Organization: MEV Ltd.
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 61c97e35-feac-47a7-8abd-1087e1289693-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") in v6.5-rc1 
onwards makes it impossible to select some comedi configuration options 
that were previously selectable.  In addition to adding 'depends on 
HAS_IOPORT' directives (which is OK for most of the options), it also 
changes 'select COMEDI_8254', 'select COMEDI_DAS08', 'select 
COMEDI_NI_LABPC', and 'select COMEDI_AMPLC_DIO200' directives to 
'depends on' directives.  Since there is no other way to select those 
options it renders the options that depend on them permanently disabled.
It also adds a dependency on HAS_IOPORT to COMEDI_PCI_DRIVERS even 
though several configuration options that depend on COMEDI_PCI_DRIVERS 
are for drivers that neither use I/O ports nor depend on modules that 
call the I/O port functions (inb()/outb() and friends).

Arnd Bergmann recommends[1] reverting the patch and following up with a 
fixed version.  I intend to do that.  Niklas Schnelle confirms[2] that 
it will not break anything.

[1] Link: 
https://lore.kernel.org/all/33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com

[2] Link: 
https://lore.kernel.org/all/65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com

#regzbot introduced: b5c75b68b7de

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
