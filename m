Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE47C5ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJKSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJKSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:03:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CFDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697047388; x=1728583388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lURMbn5dRbkd2o52I5y99bEbTUmrRbrcbtygejYOJrA=;
  b=i6fnfctpVFCCCZfdzk11lelZ6CHnaJnaKTlMxvfkL3hqEnmjWLQZ2mER
   9tJFai8VyedHeQd/yacEHz963vKj5X/bbBOgOu+dB+nWQ+jZGOWrldLB9
   aXvqxSP/DWll4P7oDNzgDRVojZot8vCHgwbV+JiaxvGJmwhNJT3gpXY0A
   l5ZUL59EZCvsQZ55yvjnq+VZRZZ5vVYkrpN35iDBk+dwUdpkeXmDYuGId
   l+dp341RHWCFG+EJ1X3pjNnIepnfGPzhPcWQsfWSZvZlikOefpfq5MQV7
   vjQGP9f9JgEFDlY6tPJFCP+J3Gvdb2DogQby9yxKLrmp1ZH7B78MijO6e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="6290833"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="6290833"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 11:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="927661637"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="927661637"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 11:02:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqdXj-00000004nnD-07AG;
        Wed, 11 Oct 2023 21:02:47 +0300
Date:   Wed, 11 Oct 2023 21:02:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v7 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZSbjRjUriEUebKs2@smile.fi.intel.com>
References: <20231011172836.2579017-1-glider@google.com>
 <20231011172836.2579017-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011172836.2579017-3-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:28:32PM +0200, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.

Would be nice to have an additional test like

	bitmap_write(..., 33 /* or anything > 32 */);

This will require ifdeffery. So at least this code may warn users about corner
cases in the agnostic code.

-- 
With Best Regards,
Andy Shevchenko


