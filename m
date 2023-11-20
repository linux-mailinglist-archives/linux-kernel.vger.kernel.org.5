Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D137F0FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjKTKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:07:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9AB10E;
        Mon, 20 Nov 2023 02:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700474868; x=1732010868;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xR0+UQoJfM6pZ/tg70OOBb2loJbFmI+VNTmfYo2c9eU=;
  b=Yw0pCCNQGCl11r68DBlu13se7+NPskXNO9ClNsUKWXM8TXQ9P11i/8WR
   DBG41m/Ctn34SK1Thz/wMhMjS14X32+V6Z1W0wc1k424qThEO+Rhp+wKe
   XtdosEi0v8kFAYlHKzm9jSoKLRL2lQeEHGAMugdP68an0DU1VzXv89dxQ
   ncnKVwPNN5JYqqb9UckHKy/oXhKM9LwiiM80iISAlMxv5uJwyW6ei7Vfv
   TyANepkn7exfbV5R+MN0u0VGZrizhNSmrFXeAM68vRwowm4WJAlqPZHt/
   e2wy8dXmqRIWCjDYHLhmB9BQyGcEIxHf7s12k5TATGh7VqndKOpMWGCSJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477800373"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477800373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 02:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="14548591"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 02:06:19 -0800
Date:   Mon, 20 Nov 2023 12:06:17 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] rtlwifi: rtl8821ae: Access full PMCS reg and use
 pci_regs.h
In-Reply-To: <20231117224842.GA96270@bhelgaas>
Message-ID: <553cda39-ffe7-e9b3-a38b-d1f3381b485@linux.intel.com>
References: <20231117224842.GA96270@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1384141213-1700474781=:2032"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1384141213-1700474781=:2032
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 17 Nov 2023, Bjorn Helgaas wrote:

> On Fri, Nov 17, 2023 at 11:44:25AM +0200, Ilpo Järvinen wrote:
> > _rtl8821ae_clear_pci_pme_status() accesses the upper byte of the Power
> > Management Control/Status register (PMCS) with literal 5 offset.
> > 
> > Access the entire PMCS register using defines from pci_regs.h to
> > improve code readability.
> > 
> > While at it, remove the obvious comment and tweak debug prints
> > slightly to not sound misleading.
> 
> OK, ignore my previous comments ;)  I should read all the way through
> before responding.

Please don't do that because then you'll just end up forgetting useful 
comments. :-)

I had this all in one patch initially but thought it's better to split it 
a bit.

Thanks a lot for reviewing.

-- 
 i.

--8323329-1384141213-1700474781=:2032--
