Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD779E510
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjIMKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjIMKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:36:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBEC3;
        Wed, 13 Sep 2023 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694601395; x=1726137395;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4WUEy9IajOAQvb6MTevfkqkS+hTFZ1eehulh/xUwM8E=;
  b=nUbsOuHDMP54/3QfY2NPL28s1sNzxY3YFb60cV9zeRJgKBnUuGwbF/fV
   3wltt9S8B/XQbyHWmMfEYodZoz0nE+Xg54CvfwSQovMjNWI5HK9iPUcXF
   qSaTj76AS/SnCFsqfqgT+4py+snDWTtxVv/ZATXu/qEEtbi0Izu9FQ3qF
   UkmgRQBZupfTH/10g5mxKd0IyrBRwiCRbhNug4MHmFOa+A/gNDfdz7iZf
   xzWUwM+KT4imqqoVmc61q5O8hwauXbQVkE7QRkCno/XJv3J/vkr8vMoTR
   ZtvqEQw4dN0DZMOFoYRxzUqyssY4PF9kLZTPSHktGAQ2fE6SvG+UWeBXW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377535210"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377535210"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="834261637"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="834261637"
Received: from pakurapo-mobl3.ger.corp.intel.com ([10.249.45.213])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:36:33 -0700
Date:   Wed, 13 Sep 2023 13:36:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty/serial: Sort drivers in makefile
In-Reply-To: <e74982c0-4942-1c46-1c53-6dd6e7677373@kernel.org>
Message-ID: <e25ef4f-48bb-eeff-f181-794afe716a81@linux.intel.com>
References: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com> <e74982c0-4942-1c46-1c53-6dd6e7677373@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-11916867-1694601394=:1849"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-11916867-1694601394=:1849
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Jiri Slaby wrote:

> On 12. 09. 23, 12:35, Ilpo Järvinen wrote:
> > Sort drivers in alphabetic order in Makefile to make it easier to find
> > the correct line. In case the CONFIG and filenames disagree, sort using
> > the filename (but ignoring "serial" prefixes).
> 
> Overall looks good.
> 
> I just want to make sure you considered the below, as you don't say explicitly
> in the commit log.
> 
> The order in the makefile defines the link order. So built-in drivers are
> loaded in that order. So are you sure your patch doesn't change order of some
> drivers which need to be in a specific order?

Thanks for taking a look.

I limited the ordering to non-library like "leaf" driver files so it 
should be safe. Except for 8250_early that was in middle of drivers so
I moved it before the driver section but that doesn't alter anything 
important AFAICT.

In any case, I double-checked this again and only thing I found out is 
that for some reason SERIAL_8250_EXAR depends on 8250_PCI but nothing uses 
the 4 functions 8250_pci.c EXPORTs (which I'll address shortly).


-- 
 i.

--8323329-11916867-1694601394=:1849--
