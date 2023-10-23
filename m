Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE07D38CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjJWODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJWODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:03:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56BD7E;
        Mon, 23 Oct 2023 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698069779; x=1729605779;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=mco6F5pM3N+y18qY9xYdMZMN9NeQCPYRSl/IX3kb2Ao=;
  b=Bk+3Po7Di5GinIZIPQwzeomEVwpa/EFY00TJCZ6izpQuObOfmitdndhe
   Bq/KZR6yzt2wfCJe2OZUq3CMfqHe5Nu0WsFOTBPRbEVqXklY9Z+JyAtUU
   HS6WydezU8sqBA9k48wCInGPzhYy1YtSWAk9zRJzrAPas5TBW9Oe1bLgY
   IoENuRja0qjWf/ur4sgySMpWtv5W+6fZtQ2VqeRyUfgE9h5p2atm0SjHz
   1eq6TUwquyWRDmAF17P6knB1/Tru3oFRGiIqIudOCdizgFmOaywOGGShI
   1msTKm5ZRQUAkd4ncTyWlRHPJJI0KUJY68JgZ2GOgentQj2IUrR5ufraw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384042936"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="384042936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793143088"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="793143088"
Received: from spididi-mobl3.gar.corp.intel.com (HELO localhost) ([10.249.40.91])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:02:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-platform-x86-thinkpad_acpi-c-v1-1-312f2e33034f@google.com>
References: <20231020-strncpy-drivers-platform-x86-thinkpad_acpi-c-v1-1-312f2e33034f@google.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: replace deprecated
 strncpy with memcpy
Message-Id: <169806974784.2853.7847788147335527279.b4-ty@linux.intel.com>
Date:   Mon, 23 Oct 2023 17:02:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:52:43 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
> 
> We expect ec_fw_string to be NUL-terminated based on its use with format
> strings in thinkpad_acpi.c:
> 11241 | pr_notice("ThinkPad firmware release %s doesn't match the known patterns\n",
> 11242 |     ec_fw_string);
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: replace deprecated strncpy with memcpy
      commit: 942a4a61b64e182d756a1a5776aa500d3b3d862f

--
 i.

