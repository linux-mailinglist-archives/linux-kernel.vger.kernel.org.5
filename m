Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F117EA354
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjKMTLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:11:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371B10D0;
        Mon, 13 Nov 2023 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699902670; x=1731438670;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FvnxEpuq/W9dHqKhcK5kdN3paQbY4rspDuNs7x8zG/k=;
  b=Dsa5LZ8g0con66Cb90ADVmuZTdcUeYwMGhVSwyzw6pfHLq1OTWFqV/ed
   cosdavXymanXdrgPQhqjVlcrtGUgiQFKDvQIKUN81Ca5KNxVqi8LOowuQ
   ZQD9VEZK4jlDcUYiwNUodm49CIhJeeA5kVafUWqoc8qLGa5ua+a4GpJkU
   51A6AstUmpHXW588yxcdGm17fDpjZmREk6JCtlypLQ8wDqbB8Mo8IoMIH
   HDPvszY3QzxR0bPfZEYyILE2QLy9jD4Ytgg9xvNWGlc5V6Hsd43SSqstg
   iIU2ibHtzbfljrUAt4JmaZrfGXWRnf3YpyH1Yc/Bm/MOXhlvwL8UfmPRQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="369833678"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369833678"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 11:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="799274307"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="799274307"
Received: from alexdsou-mobl3.gar.corp.intel.com ([10.249.44.83])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 11:11:05 -0800
Date:   Mon, 13 Nov 2023 21:11:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, vegard.nossum@oracle.com,
        darren.kenny@oracle.com
Subject: Re: [PATCH v3 2/4] platform/x86: hp-bioscfg: move mutex_lock() down
 in hp_add_other_attributes()
In-Reply-To: <20231113185852.3579970-2-harshit.m.mogalapalli@oracle.com>
Message-ID: <682889a3-2f6e-5141-1f5d-1150119ad1fb@linux.intel.com>
References: <20231113185852.3579970-1-harshit.m.mogalapalli@oracle.com> <20231113185852.3579970-2-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1437471784-1699902669=:1867"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1437471784-1699902669=:1867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Nov 2023, Harshit Mogalapalli wrote:

> attr_name_kobj's memory allocation is done with mutex_lock() held, this
> is not needed.
> 
> Move allocation outside of mutex_lock() so unlock is not needed when
> allocation fails.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1437471784-1699902669=:1867--
