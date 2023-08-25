Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E9788329
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjHYJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHYJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:12:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF519BF;
        Fri, 25 Aug 2023 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692954744; x=1724490744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGxkO6pWElUh9VCtq/z4PhgMeq1KmRq1BNRNSeDk+a8=;
  b=Gq1BVmOpQUiKYGlSLMcqICWYTaYvYEANXeGN9Y4zxqKBkmb7KcA3gWqU
   ZqJZ/glNTXg2ipZhNxTzB7VNCgApnKbezVvvKftmSEx5Bapd2JajXeynX
   I8HIzdIaeucZHjRbutHRtwYo+GXwk/1619+1ExsSyXIiu4+udXJgkVokE
   fo7LGOR5mLqz5G9mT01YVpYZYoe7P9PaYvA6Q6SDUK2Jri+7uchScTAXH
   0fKIZQzIY8MzWasBgRSOIsOxGGPILQZiaRHEp0uw7u1bLsXigb9UKbfJS
   SG2ZDGCaJR7Zv1yjoZjajznY2yctouGZEFdDilHL9mUtqbc2JFe675XxG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="441018155"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="441018155"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827517344"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827517344"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:12:22 -0700
Date:   Fri, 25 Aug 2023 11:12:20 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: refactor deprecated strncpy
Message-ID: <20230825091220.GA3748525@linux.intel.com>
References: <20230824-strncpy-drivers-accel-ivpu-ivpu_jsm_msg-c-v1-1-12d9b52d2dff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accel-ivpu-ivpu_jsm_msg-c-v1-1-12d9b52d2dff@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:20:25PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> Also remove extraneous if-statement as it can never be entered. The
> return value from `strncpy` is it's first argument. In this case,
> `...dyndbg_cmd` is an array:
> | 	char dyndbg_cmd[VPU_DYNDBG_CMD_MAX_LEN];
>              ^^^^^^^^^^
> This can never be NULL which means `strncpy`'s return value cannot be
> NULL here. Just use `strscpy` which is more robust and results in
> simpler and less ambiguous code.
> 
> Moreover, remove needless `... - 1` as `strscpy`'s implementation
> ensures NUL-termination and we do not need to carefully dance around
> ending boundaries with a "- 1" anymore.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
Applied to drm-misc-next-fixes

Thanks
Stanislaw

