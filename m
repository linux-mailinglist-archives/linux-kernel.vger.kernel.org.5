Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B62788371
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjHYJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbjHYJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:21:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18E2105;
        Fri, 25 Aug 2023 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692955283; x=1724491283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J994JRI+fRnunrBXP4WK+3tE2os0ATDa3+yt0fYJsyg=;
  b=Ro56UcAgD08twhFGDXI1Qgzz9q0gKkKm1kOHRnzGuD9kVFgBbVrMMxxu
   vgs22r1NN5ZOSrH9hN3crWuIlE6T4LDNHG/lBnNaNYanBFHHxWb3q4Hve
   3InW8b1K9UotrIJWGkg42TP9nRas7+vHUy85Zvv4c9Lja4aB1+93ZDG/w
   Suo5NxLoDTcGx4rWZMSyXjDIGoeKng5+VuS6TrsWtkUmxEbBlM0QaCj0o
   W0hDXmoKdedC6M6a+p07qTKb6fR2cRNsoM5JH/RTVC427rI4/9fvzXOpe
   fe5pxMB92MlU5t9u5VkMV/7NuKZxTKfoKgA47VpgumTNUp4VeC7nO1VWM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364868599"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364868599"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802901144"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802901144"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:21:21 -0700
Date:   Fri, 25 Aug 2023 11:21:19 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] habanalabs/goya: refactor deprecated strncpy
Message-ID: <20230825092119.GE3748525@linux.intel.com>
References: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:49:11PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
