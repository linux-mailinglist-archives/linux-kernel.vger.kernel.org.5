Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC534788366
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbjHYJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbjHYJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:19:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E271FF3;
        Fri, 25 Aug 2023 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692955140; x=1724491140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmrsNWY4+QS5tyCiAogZ574zDVYYOApC/VkIfTywXhQ=;
  b=PzOCMgDr5jAiaB2QSp4e7+0BlT3XVg+y0JyN4MGwtFucGnHbqMtxZfnR
   QN5eB7fvQY04eeNhvOFp06MpjInf1LwjHRyx4mLBAPaSmeM/tKZiHQbaE
   MYDpH0DEKU941ura4DPg6icEVeB++ru28LQV0ddo2qa/3cZhA1x+iALmH
   3pGT6jg08iRLygXFJssBRcw5GTob3hgx27Z5ghdXjW62HrL+T1EIkZYzl
   wz+WKBJLnk35IW0YJHQmkWV9Z2EJLooSuSJnr2SRGwOCjf+vhuUSuQVbW
   Axv4/e8Jv1rxWkdQPBFmbKl/u8G2MwgMWZxL824d1ViPnV+3MYYTrJuPT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364868264"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364868264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802899875"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802899875"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:18:58 -0700
Date:   Fri, 25 Aug 2023 11:18:56 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accel/habanalabs: refactor deprecated strncpy
Message-ID: <20230825091856.GB3748525@linux.intel.com>
References: <20230823-strncpy-drivers-accel-habanalabs-common-habanalabs_drv-v1-1-147656947586@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823-strncpy-drivers-accel-habanalabs-common-habanalabs_drv-v1-1-147656947586@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:23:08AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> There is likely no bug happening in this case since HL_STR_MAX is
> strictly larger than all source strings. Nonetheless, prefer a safer and
> more robust interface.
> 
> It should also be noted that `strscpy` will not pad like `strncpy`. If
> this NUL-padding behavior is _required_ we should use `strscpy_pad`
> instead of `strscpy`.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

