Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBE7D4CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjJXJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjJXJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:40:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E9198A;
        Tue, 24 Oct 2023 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139818; x=1729675818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSD40iH+sPX+DrU5ENcXUhxksvpVp9Sfw5JZjf5AJFA=;
  b=cEbSB0HhGd5FKGuA2NJOQxdMb7ZKRypszTrQ9THJLwAhbH1P7sgg4yt4
   gv6VpdWWCPXumRaDbvVoDxjmyk3xvAuMK1VzLxasqGj+98j5cevmB+5rO
   JX2JwenP5GkvtXJVxfAC44NIvX2p1JHJDHY+v+Aj65it/y9S9drPQGhdN
   pZM66Taw25/7qvZN25TT+TAycNza9gC6ExE2aafOQhsIYk4hhcl8wrPib
   xysPfCNrZ5X5K0bK5jF4Ze7jbq1L354gkHjFDl7D0UU9chnL5xxiXUYm1
   L28qh2O11r4u6JQFRhtNqOuigdbObCrLKMBOysJe1SYwGROThN+XL644g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8570434"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8570434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708224038"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708224038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2023 02:30:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6358894; Tue, 24 Oct 2023 12:30:10 +0300 (EEST)
Date:   Tue, 24 Oct 2023 12:30:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        andriy.shevchenko@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
Message-ID: <20231024093010.GF3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> This series refines _UID references across kernel by:
> 
> - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
>   helper and introducing it as a separate acpi_dev_uid_match() helper.
> 
> - Converting manual _UID references to use the standard ACPI helpers.
> 
> Changes since v2:
> - Drop review tags as suggested by Andy.
> 
> Changes since v1:
> - Change acpi_dev_uid_match() to return false in case of NULL argument.
> - Drop accepted patches.
> 
> Raag Jadav (6):
>   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
>   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
>   ACPI: utils: use acpi_dev_uid_match() for matching _UID
>   ACPI: x86: use acpi_dev_uid_match() for matching _UID
>   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID
>   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
>  drivers/acpi/x86/utils.c              |  3 +--
>  drivers/hwmon/nct6775-platform.c      |  4 +---
>  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
>  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-

This pinctrl one is also fine by me so if Andy does not have objections,
feel free to add my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  include/acpi/acpi_bus.h               |  1 +
>  include/linux/acpi.h                  |  5 ++++
>  7 files changed, 40 insertions(+), 17 deletions(-)
> 
> 
> base-commit: a4ed5bffbeb19cfb7e21ac3b3f09d7bfe39a849b
> -- 
> 2.17.1
