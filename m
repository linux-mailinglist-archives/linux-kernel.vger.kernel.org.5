Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216480A1CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573727AbjLHLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573702AbjLHLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:06:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9471732;
        Fri,  8 Dec 2023 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702033583; x=1733569583;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lut/IjYzOv9srBYiYEXBVWgNLBYWSH+5N7YUlD28cxc=;
  b=mFAmQkqKPLCTFHur5PtlFRwBLZlUcDWL1v3pkIDkR0EgbP2ZQWeo0vTp
   TAPPQ7YxJEWHmmNYb4ZkIs+4e7Xv2F3IbIJQlsbtoWiLYEt7W013aERfH
   K9IeD+X6NkYUEH4IQQfFKum2dyZFiE5OMga2BB+gI9x31MxwVNI0lt3XE
   tS4iufHJtmBn55CZ4+sgSS5BlJnCBUHkfHXTSI/qyerLJI+/pmZl4OxjD
   mmOcQvS4zG8jzm2Kb1o2+rIJKF3v05QlWZJSJ/8c72DG3uk1ddt1hoOP+
   WkXgSybHxWxTtBJd4O4opXOXRBUzB+RWGVOW4H5eWXdEUZCQ9D68Jpy9S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1456041"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1456041"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1103534402"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1103534402"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:06:19 -0800
Date:   Fri, 8 Dec 2023 13:06:17 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vishnu Sankar <vishnuocv@gmail.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, markgross@kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
In-Reply-To: <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
Message-ID: <25f86da-2484-3cf9-ae1e-73cac2e6541a@linux.intel.com>
References: <20231206162003.92010-1-vishnuocv@gmail.com> <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-4976533-1702033581=:1875"
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

--8323329-4976533-1702033581=:1875
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 8 Dec 2023, Ilpo Järvinen wrote:

> On Thu, 7 Dec 2023, Vishnu Sankar wrote:
> 
> Hi Vishnu,
> 
> Thanks for the patch.
> 
> > Some ThinkPad systems ECFW use non-standard addresses for fan control
> > and reporting. This patch adds support for such ECFW so that it can report
> > the correct fan values.
> > Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
> > 
> > Co-developed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>

> > +		/* Default mode is AUTO which means controlled by EC */
> > +		if (unlikely(!acpi_ec_read(fan_status_offset_ns, &s)))
> 
> I'm skeptical that all these unlikely/likely() are useful. Some might even 
> be harmful if e.g. is some error condition keeps repeating itself and 
> the particular if handling that is marked with unlikely().
> 
> I know the code in that file is littered with them already but it would 
> be better to add into that, IMO.

So I'm missing the negative here, I meant: ... not add into that ...

-- 
 i.

--8323329-4976533-1702033581=:1875--
