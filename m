Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311EC7A0CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbjINShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjINShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:37:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED3C1FD7;
        Thu, 14 Sep 2023 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694716631; x=1726252631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lE/AQEBUOLaO32yy15qBqA273NUv+ScDqbpAk7foBXU=;
  b=c/ua3s3H63jKI6FollYNeNfTat1li97ClLbMLgPah+m7hWLnlStgR5mL
   0x9nZr2MVz3OMLoXvhHtySkNrLzM5SBUHaodJcDgBVpvFJLidckIOgA+w
   HEL1jo+S6VzaO6JDwiIdCp3zVWfcXiKHpNoR1JalTiXCIAhu3+xQXB8lA
   ismPmXTjE5witLPDMuV2I6sdAXD0UPaFpTeuZ5spvgulLNSyDpD+I04u8
   1FeU/HTb+mpSYI1gSWuAsSQv7hC0RK9fc3cWeLLiMWc69wqJ9Fdb5hFaA
   6D23NFaNUDMueMqBrYrV8wFgxxokBP6BGlVvt44FGUuE7jQBxSvE+U6GN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359299906"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359299906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 11:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834841504"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834841504"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 11:37:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgrD9-000000080uK-1QDB;
        Thu, 14 Sep 2023 21:37:07 +0300
Date:   Thu, 14 Sep 2023 21:37:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Don't copy a tail in
 kstrdup_and_replace() if 'new' is \0
Message-ID: <ZQNS0qzJVrRRgNLO@smile.fi.intel.com>
References: <20230913094557.451463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913094557.451463-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:45:57PM +0300, Andy Shevchenko wrote:
> The kstrdup_and_replace() takes two characters, old and new, to replace
> former with latter after the copying of the original string. But in case
> when new is a NUL, there is no point to copy the rest of the string,
> the contract with the callers is that that the function returns a
> NUL-terminated string and not a buffer of the size filled with a given
> data. With this we can optimize the memory consumption by copying only
> meaningful part of the original string and drop the rest.

Thinking about this more, I self NAK this.
If the caller knows the size of the original message it can be handy to make
a copy and replace all occurrences of old by NUL. This will be an optimized
implementation of strsep(str, "$OLD").

-- 
With Best Regards,
Andy Shevchenko


