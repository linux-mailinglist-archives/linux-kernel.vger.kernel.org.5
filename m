Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47DD7F630A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbjKWPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346183AbjKWPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:31:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C0D50;
        Thu, 23 Nov 2023 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700753509; x=1732289509;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W0fgiAGWwiKqiZeN+g8YmYk5JRXIYdwCl8CV0D/C4Zk=;
  b=PQ86CNRD2yl0ueGKw/mBJjvCAsfiNfe54hsHEZqZ2LhRa7ICGCfPeLfY
   TsjyYPpMZd8CYyn/1IoZmw+pPTEfS98Q2YosbMvFMgpNEJPxfLeugt4Z4
   VpmMy8AZG0cchOewXh60ZtDLktpaVKFTuW2d7wMiPE+fTnYjTIA1NwVsw
   juVOouNw/Y+XV8c+kb23WdLs6Sxy0nEAkJgF6F7skFTo3KvZ4X7ZkARWg
   NrjGZsF4z3HSW2wFcSbIw5HIPwNLOzlFyM8XPNoHngJdNUBH+/udiwynE
   vNHBnUGxA5pHBqroy03CvUnRwe/NbczKH6NHuszFX1zLordylZGk+S6MC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5488698"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="5488698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:31:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767230174"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="767230174"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:31:45 -0800
Date:   Thu, 23 Nov 2023 17:31:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     SungHwan Jung <onenowy@gmail.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/2] platform/x86: acer-wmi: add fan speed monitoring
 for Predator PHN16-71
In-Reply-To: <20231123152229.4920-3-onenowy@gmail.com>
Message-ID: <434bb85a-905b-da27-a541-e6096a7f072@linux.intel.com>
References: <20231123152229.4920-1-onenowy@gmail.com> <20231123152229.4920-3-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023, SungHwan Jung wrote:

> Support CPU and GPU fan speed monitoring through WMI for Predator
> PHN16-71.
> 
> This patch depends on patch "platform/x86: acer-wmi: Add platform
> profile and mode key support for Predator PHN16-71"
> 
> "select ACPI_VIDEO" cause recursive dependency and it is not recommended
> to use "select" for visible symbol, "select" has changed to "depends on".

> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -177,7 +177,8 @@ config ACER_WMI
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
>  	depends on ACPI_WMI
> -	select ACPI_VIDEO
> +	depends on HWMON
> +	depends on ACPI_VIDEO

Also, please make own patch out of the ACPI_VIDEO change.

-- 
 i.

