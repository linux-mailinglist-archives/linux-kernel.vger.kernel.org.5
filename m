Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56337F6195
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjKWOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjKWOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:35:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A491A8;
        Thu, 23 Nov 2023 06:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700750156; x=1732286156;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KGlwD8rp+uPqOsIf21qzpA1CqHn9GSr54froc9uEVm0=;
  b=oKWzq32JCXna1ymcJfxiuWWRccG6Ys+hVuWxDaSw7Dtawmh49J68Ro4/
   /iFbO0Gf0shZRklHizc16tooyI6XKmQoHUvuwCt1P59vq8Gq6jkg7d7wf
   KS0iR18PP6MPl/0SujvgvDHN1Syu9rLGlMGgaaYoaIF6Wnqbc1DVPHvPI
   r2FsFhIFEaEDH8obrskwNMudD6XRH45PXpMcwHE7xBlUlnBonyXVaWxae
   6ge+IbGk7/iTza1ldFINo03YR8pCPIWEGWr5NCJyJNyPkDcarBfyl4CKX
   0mTGgbKdZGyGQyZeKhNEs176QZb/oI5snCujCS3fqICigY7tWSgccLWwL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10951440"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="10951440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911187643"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="911187643"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:35:52 -0800
Date:   Thu, 23 Nov 2023 16:35:50 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v4 6/6] tty: serial: amba-pl011: factor QDF2400 SoC
 erratum 44 out of probe
In-Reply-To: <20231123-mbly-uart-v4-6-7f913a74ff89@bootlin.com>
Message-ID: <ae209c94-3749-1787-6299-9381ee3949d2@linux.intel.com>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com> <20231123-mbly-uart-v4-6-7f913a74ff89@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1933260631-1700750154=:1676"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1933260631-1700750154=:1676
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 23 Nov 2023, Théo Lebrun wrote:

> On this platform, different vendor data is used. That requires a
> compile-time check as we access (1) a global boolean & (2) our local
> vendor data. Both symbols are accessible only when
> CONFIG_ACPI_SPCR_TABLE is enabled.
> 
> Factor the vendor data overriding to a separate function that is empty
> when CONFIG_ACPI_SPCR_TABLE is not defined.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1933260631-1700750154=:1676--
