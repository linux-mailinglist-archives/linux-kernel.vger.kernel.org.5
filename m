Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386727929A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbjIEQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354542AbjIEM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:28:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595F1A8;
        Tue,  5 Sep 2023 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693916911; x=1725452911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIvwvVLX2QgqgZ6NIpuMrd+CJE12wHgoLPkmBc9kTgM=;
  b=CYASRsL8e8a3oLKwz5mE5kMg0LV/sV484j52k61uesQ7Zpjjp3RMXcZp
   F7Qm5J5ugUGEzeGW9yDokC13KVGlSsx5Pchjoro3NJRX1FlkvYmd6OL3e
   mnIrodc3m+pwHtSIum0eScmq1Soyc7LAK88LK1oHOw2U+/kY8dm4bAfzv
   p86we1SP/1f9E//fRE9BuRxuKRKfNDVoYtjUlDMs4znu0yoSGsB0OAvo+
   SqHge78sMH7IUkVJiVMBnsL21s8d5pafVZcdqQjBocYmQc8aUAv1YfvtE
   5oKRmSOLVKDgjZ8sIbbN9wvqW74h7GxQSxTBAsW1Dqqb68TtERsj7uDsd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379501517"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379501517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="776187146"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="776187146"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:28:29 -0700
Date:   Tue, 5 Sep 2023 14:28:27 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Dani Liberman <dliberman@habana.ai>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/habanalabs/gaudi2: Fix incorrect string length
 computation in gaudi2_psoc_razwi_get_engines()
Message-ID: <20230905122827.GD184247@linux.intel.com>
References: <d38582083ece76155dabdfd9a29d5a9dd0d6bce7.1693855091.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38582083ece76155dabdfd9a29d5a9dd0d6bce7.1693855091.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:18:36PM +0200, Christophe JAILLET wrote:
> snprintf() returns the "number of characters which *would* be generated for
> the given input", not the size *really* generated.
> 
> In order to avoid too large values for 'str_size' (and potential negative
> values for "PSOC_RAZWI_ENG_STR_SIZE - str_size") use scnprintf()
> instead of snprintf().
> 
> Fixes: c0e6df916050 ("accel/habanalabs: fix address decode RAZWI handling")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
