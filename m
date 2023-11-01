Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFBF7DDF74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjKAKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjKAKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:31:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB480111;
        Wed,  1 Nov 2023 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698834711; x=1730370711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3j2TIuMUcWxvSGNgASlqGiGLP4y/XnmDJSYpIO7fL8=;
  b=ahWdsNsFAkWMHrhvz84hpvrAXq9u4e0LxhYFNtnaBBgBpEyXbxtyOIhw
   8zfv6A9xL51LrCyxkqDEDz4nsJixh17gYjI7LNv7ziAFkps+g8LIjASll
   2xeOjqYM91hQodwbLIKiQQKx3nr4xFYiH6MTz7r7oYzd1i7BpTeMaFgjc
   KjulSXN1/dU3pxGahcitV/1YTP32ccHHL5UiF/Dpz5mJf/Fj5vFlpqktN
   JmaWMmDDr1pQE9yYOG0sKkyQLRERj2i4/XHTqydSJllLyZK7YNNzE9BGA
   14WSiIcRcsiIJQ2XInetb03OsJMJhY9B74aQ7BEDIPPeIIlfQLpYOenMe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="367817795"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="367817795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934390710"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="934390710"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:31:47 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B898E1207A3;
        Wed,  1 Nov 2023 12:31:44 +0200 (EET)
Date:   Wed, 1 Nov 2023 10:31:44 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "media: imx290: Convert to new CCI register
 access helpers"
Message-ID: <ZUIpEJmmdGTFdx09@kekkonen.localdomain>
References: <20231101100900.224567-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101100900.224567-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Wed, Nov 01, 2023 at 11:09:00AM +0100, Alexander Stein wrote:
> cci_write() unconditionally writes multi-byte data in big-endian format.
> But IMX290 and IMX327 use little-endian format for multi-byte registers.
> Revert the CCI usage until little-endian is supported by CCI register
> access helpers.
> This reverts commit af73323b97702e53b0a336972aaf23e7dd92c850.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> The difference is subtile, but imx290_write() uses put_unaligned_le24(),
> while cci_write() uses put_unaligned_be24().
> 
> I assume this should go into stable as well. How to deal with that?
> Shall a revert get the fixes tag as well?

I'd very much prefer addressing this in v4l2-cci instead. It should also be
a much smaller patch (or patches).

-- 
Regards,

Sakari Ailus
