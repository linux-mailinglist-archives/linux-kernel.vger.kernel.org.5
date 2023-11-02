Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24C7DFB64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjKBUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjKBUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F1D41;
        Thu,  2 Nov 2023 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698956398; x=1730492398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8FvPa+/6GRdbomabAjZ76exDDp8U1uvgYhrgr1oPcEY=;
  b=Volb+oa9yMdihZzj4akQaA6nWId+HhbiBc1Bsdak7Q+XAc4OfheX7hf0
   Q2vbbedbZLJmx9Sw+d+kw6cEa6OXZHi5apnRNUeVx4mclsQ0F6gB/Nzof
   FXGS5iqY/xy6DUN/B/WIEKy0UYWlZkoo5R3a2IJcB37QvVOIuKlPcMUan
   kfZDE4IwPdoasnMzk5pLObQs8zLr9XJg5P233Xx96Jx59P0iEA0csaOSd
   EGUAjNuHjCG8dhRYiihE8LBAgVuD0Pr8K0qRRf9I9rlLXD6/hBEdRIrc7
   j/Bjz7cQEMvai1HzlW5hfKJBDqfevz4Q4CDU700+LQMqmMdIFGiEx1sgK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="385984624"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="385984624"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 13:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878378211"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878378211"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.28.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 13:19:56 -0700
Date:   Thu, 2 Nov 2023 13:19:55 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Message-ID: <ZUQEa1q/R2KBF/3W@aschofie-mobl2>
References: <20231102155232.1421261-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102155232.1421261-1-terry.bowman@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:52:32AM -0500, Terry Bowman wrote:
> Native CXL protocol errors are delivered to the OS through AER
> reporting. The owner of AER owns CXL Protocol error management with
> respect to _OSC negotiation.[1] CXL device errors are handled by a
> separate interrupt with native control gated by _OSC control field
> 'CXL Memory Error Reporting Control'.
> 
> The CXL driver incorrectly checks for 'CXL Memory Error Reporting
> Control' before accessing AER registers and caching RCH downport
> AER registers. Replace the current check in these 2 cases with
> native AER checks.

Hi Terry,  Does this have a user visible impact? 

Alison

>
--snip

