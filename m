Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29717812B99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjLNJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjLNJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:27:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2682B7;
        Thu, 14 Dec 2023 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702546045; x=1734082045;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j+OKMNvYP/TsJ2cZYfFOMvsa6Wp1SnLuZ4Neu5W5W1g=;
  b=BJEVUfgF4woExtodGFQ/s8AbGf1L9fJZmKij9Df92g4sLiWqZkT9TIG7
   RNUdIOdv2eGANMqnfo+/tkQ16mWttwu3kU2surBzhwYe5GuTW0+jyJ7f2
   3S9n80W6jZuVF0KlrnY3FD2hoKOhZhazo+Lqa3EsYmgHoymDs9bUcnjY/
   SId2RgTwOpiP3tGDjbno/Ebv/uCBlL8YPTslr/Z+zcUECAlxkyyBCeRis
   EIxaExGhBZILztD6uawqZbG+CvwzHdPnrDbyAH6SJp5QieuNkEK0dzpSu
   MyUhWUCqoARNQ68kavGHEKN3uPSpYJShqFq64B/xO/8M/O2QdXb8dhG0m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394840191"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394840191"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774286358"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="774286358"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:27:10 -0800
Date:   Thu, 14 Dec 2023 11:27:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 5/7] serial: core, imx: do not set RS485 enabled if
 it is not supported
In-Reply-To: <9271d88a-52bf-4f3a-9861-fdc5120cfc31@gmx.de>
Message-ID: <fb579fd-a5ae-2838-d1b-eefc16ad015@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-6-l.sanfilippo@kunbus.com> <ffdaf03b-65af-731f-992-3e90ca6fca@linux.intel.com> <9271d88a-52bf-4f3a-9861-fdc5120cfc31@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2144092122-1702546036=:5690"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2144092122-1702546036=:5690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Lino Sanfilippo wrote:
> On 11.12.23 12:00, Ilpo Järvinen wrote:
> > On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
> 
> > Looking into the code, that setting of rs485_supported from imx_no_rs485
> > is actually superfluous as it should be already cleared to zeros on alloc.
> >
> 
> Yes. BTW: Another "no_rs485" configuration setting can be found in the ar933x driver.
> If we do not want to keep those assignments I can remove the one for the imx
> driver with the next version of this patch...

I think they can just be dropped as it's normal in Linux code to assume 
that things are zeroed by default. Those "no"-variants originate from the 
time when supported_rs485 was not yet embedded but just a pointer to a 
const struct and I didn't realize I could have removed them when I ended 
up embedding the struct so it can be altered per port.

-- 
 i.

--8323329-2144092122-1702546036=:5690--
