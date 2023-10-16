Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAA7CA7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjJPMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:20:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F88E;
        Mon, 16 Oct 2023 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697458850; x=1728994850;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ju6GSa3Te5xfMivOhV89l8PydA1byI2D3QT5q1MaBTk=;
  b=jQLFpGoHrgvv22l5pYgV3OOGvaQ2DRHsZyoMQ5zJ8PSGPX/AZofYHRLg
   g5mtShEOtSdzx8gwfUMAHobKMhVl6w2o88oDZfyLTYTWPPpAMJ+IB0h04
   FFvfJtx47+Go2LR85ldxwgtzAHREEtLzxtnSuSPs4qeNNslu8oHWwd1RH
   4wbxrlgUk3HlFvvnoUq2+FeoDBJec1GRNDHzMZWi0lOfdA0lmfhlskqlO
   kAk6ZlyUw0LmMwuJddGd7MlGaaGaDMPSG6dt7rnn7mRiKje+hzfF1lCOD
   PcocEJ5dapJR+auw4wQjENsuybskJj9mJ2GjzsXHwkuppA4Zlij+osRty
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416582456"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="416582456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="879410152"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="879410152"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:20:47 -0700
Date:   Mon, 16 Oct 2023 15:20:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Laing <richard.laing@alliedtelesis.co.nz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Allow TX FIFO to drain before writing
 to UART_LCR An issue has been observed on the Broadcom BCM56160 serial port
 which appears closely related to a similar issue on the Marvell Armada 38x
 serial port.
In-Reply-To: <fb92ed83-478-4d71-2bd-ab3a37b1352@linux.intel.com>
Message-ID: <a7e2f6ee-ea44-5fed-1a-274863a5613@linux.intel.com>
References: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz> <20231016013207.2249946-2-richard.laing@alliedtelesis.co.nz> <fb92ed83-478-4d71-2bd-ab3a37b1352@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-344325805-1697458849=:1986"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-344325805-1697458849=:1986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 16 Oct 2023, Ilpo Järvinen wrote:

> On Mon, 16 Oct 2023, Richard Laing wrote:
> 
> Your subject line is way too long. If you refer to some other issue, 
> please link to it properly with commit id and/or with Link: tags.
> 
> > Writes to UART_LCR can result in characters that are currently held in the
> > TX FIFO being lost rather than sent, even if the userspace process has
> > attempted to flush them.
> > 
> > This is most visible when using the "resize" command (tested on Busybox),
> > where we have observed the escape code for restoring cursor position
> > becoming mangled.
> > 
> > Since this appears to be a more common problem add a new driver option
> > to flush the TX FIFO before writing to the UART_LCR.
> 
> This looks like a problem we already have solution for, the userspace can 
> use TCSADRAIN/FLUSH to indicate what kind of flushing it wants for Tx 
> when it makes the tcsetattr() call. Thus, userspace can avoid the Tx side 
> corruption as long as its behavior is sane and doesn't e.g. try to race 
> writes with tcsetattr() call as mentioned in commit 094fb49a2d0d ("tty: 
> Prevent writing chars during tcsetattr TCSADRAIN/FLUSH").

I'm sorry, it was actually mentioned in commit 146a37e05d62 ("serial: 
8250: Fix serial8250_tx_empty() race with DMA Tx") although that 
094fb49a2d0d is also related to the draining.

> Have you tried to use the userspace solution? Isn't it working for some 
> reason?

-- 
 i.

--8323329-344325805-1697458849=:1986--
