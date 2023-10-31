Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED37DCC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjJaLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJaLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:46:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B4391
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698752760; x=1730288760;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/yq1RVlNm6tZQvfQXhB0bbLvhcRCOBHe93SCZE+4CC0=;
  b=QR9HHBaN6naeAFFsLOQemRmI3tgUkw1O7NAJ7LIZAusFlJDVhv3OaChj
   ZDFRVuNFNWyy5EnHhObE3mtnmAHn1jrY8zw8U7ynw4mKZkSxlGxZKTqpu
   z+8gMcIIzFuszRPo4GGr57bwFqyQOUJBZJS0Q7DAHMqIZPAk4mPrYNKqf
   VMh70GHzi3yB4ytJAMLLFlkQKgVZe7HR8ZFQIT20kGQ4xH9v2tHl/6EFv
   OnlIE0Z+vsAnjCGqbaViyF21ykIktz4gYNcfgKrp7yENkmXW5jO0bAQxQ
   LkNNoTU/ek6tEhEMPM7/S9n1/II8bBT6acI547yt7BhAdlXb5LbBmtKJ9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388093001"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388093001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 04:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="904318456"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="904318456"
Received: from moelschl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 04:45:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for
 a VM / BO combination
In-Reply-To: <f00a4975cf32c3ae28124343a2c994acda083829.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231023201659.25332-1-dakr@redhat.com>
 <20231023201659.25332-5-dakr@redhat.com>
 <f00a4975cf32c3ae28124343a2c994acda083829.camel@linux.intel.com>
Date:   Tue, 31 Oct 2023 13:45:54 +0200
Message-ID: <87zfzz3thp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m> wrote:
> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>> + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on
>
> Still needs s/Returns:/Return:/g

FWIW, both work to accommodate the variance across the kernel, although
I think only the latter is documented and recommended. It's also the
most popular:

  10577 Return
   3596 Returns
   1104 RETURN
    568 return
    367 returns
    352 RETURNS
      1 RETURNs

BR,
Jani.


--=20
Jani Nikula, Intel
