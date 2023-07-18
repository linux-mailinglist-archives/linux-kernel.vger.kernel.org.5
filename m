Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1938575822F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjGRQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGRQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:33:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A410C;
        Tue, 18 Jul 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689698002; x=1721234002;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=p2StYZ/CJnj2bZSCSEtO3x2enP4NjCt63nrW2M8VDAw=;
  b=AygK5SyAC+TCmhSnMFJipLfpqaTCXgvji1o2SPsalKwFfAU2c9x3IGtt
   qXIgC4mVJ7GoRruPCladvRLxf1oUhxdooFwOfOI2u5F/gUpP9T8uY5Cs/
   8//PREVP9gef+m/vn1rgguc7OvBext0+RV6orLtszFckSHSdtQWugk+0x
   wuAO6+lpb+qfIQsUp8syWfBF+GSP2T2sAEPkmek8jBY2BcSdCtOaQrADT
   9/UolqjxSCBfepRiWYYzxdEYWx5xlvlNUlnAyiWk0uCioG1ygSVGn4Swq
   BuRmF///4sxtvNdVX7fCs0DlLEiGZWT6OM31r71Z8pNBCX+IdWb92Iztx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430015988"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="430015988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:33:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837336227"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="837336227"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.215.197.225]) ([10.215.197.225])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:33:19 -0700
Message-ID: <2dab15ba-efd0-97cb-dfde-fa6f9d05f5fb@linux.intel.com>
Date:   Tue, 18 Jul 2023 22:02:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: ANNOUNCE: thunderbolt-utils-v0.1-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an official announcement that 'thunderbolt-utils', a collection of
user-space utilities for the TBT/USB4 subsystem is now made public for its first
release candidate.

# What is it?

The utilities comprise 'lstbt', similar in lines with 'lspci' and 'lsusb',
which polls the TBT/USB4 subsystem's information including enumerated
retimers.

The secondary component of the utilities is the goal towards providing
a collection of available wrappers to provide the abstraction of configuring
the subsystem in user-space. This is made possible via porting the DMA layer
from kernel-space to user-space for the subsystem in an IOMMU-protected
environment.

# Why?

Thunderbolt/USB4, a relatively newer industry standard with its v2 released
past year is now increasingly being adopted.

'lstbt' serves as the first incorporation of a user-space helper library for the
subsystem that fulfills the following requirements and provides advantages
throughout the Linux community.
1. Better subsystem exposure to the user: The library provides the subsystem's
information in a compact and legible format to the user with detailed
functionalities available using the verbose option. Apart from serving as a handy
library, it exports the information using TBT/USB4 keywords like domains, routers,
ports, etc., most of which are unperceived to the users as of now.
2. Better debugging: Since the library extracts valuable information like the routers'
functionalities (PM, protocol-tunneling, e.g., PCIe, USB, and DP, various states,
negotiated parameters, bandwidth used, NVM, etc.), it will serve as a very vital
tool for Linux debuggers throughout the industry.
3. Automation exposure: Automation being increasingly adopted in various industries
as a way to aid in debugs, detect faults autonomously, or even create dedicated scripts
around the subsystems, the library will be utilized as the primary go-to option for the
TBT/USB4 subsystem.

The secondary component of the utilities is providing wrappers for the user to configure
the subsystem. This is probably the first prefatory incorporation of such utilities
which would help the users who wish to handle the subsystem outside the kernel-space.
This subsequently provides the user better controllability over the subsystem which
obviously would pave the way for the development of independent software around it, which
can provide the users to derive dedicated functionalities over the subsystem.
This is in its rudimentary phase as of now.

Repository: https://github.com/intel/thunderbolt-utils

Thanks
Rajat

