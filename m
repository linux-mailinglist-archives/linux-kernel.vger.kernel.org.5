Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00827B53FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbjJBN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjJBN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:29:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAAC91;
        Mon,  2 Oct 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696253364; x=1727789364;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B7swZqJPsQnx7pSuZcqhUugl9ZqzOIU+1dxcdDC++ko=;
  b=GbY4N6wFjACljWiKz6bte/8OgC8CDNsNj51TAh+Bx4QkCmkuLaBCgMj2
   9Pffnk/n1jytlts9axu4vjk5X9ElJY9p9TKtMx02PreX8Qv0q/oARxyRt
   XXsg0u0zhlLT2BuJYyKElqBEMNEdICz9eQI0DzgHiQn61RhvRFG2T+SIO
   WgSo/usoU67yHjNeg8lx+k2O+ilBrVYi+lFua/4ir2zRoY9Y3SGThGZbj
   gdMKTvkELH6k7gzBjJrmvo6z9GI1dGdBlKVEIX2hXmB9f/tQQhH2aPZnF
   La3gz6dnce1XEIj1EI5fa04+YbBpJpC8It9Gr/r0VTPCL/Hz9b5dCx8Eb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379921949"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379921949"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754046550"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754046550"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:19:46 -0700
Message-ID: <103cf828dee54804f55764a6e91cab6f96d62283.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Conditionally create
 attribute for read frequency
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Oct 2023 06:19:45 -0700
In-Reply-To: <d725871b-12a0-c2c0-6323-1b7e3a705937@linux.intel.com>
References: <20231002115622.1588852-1-srinivas.pandruvada@linux.intel.com>
         <d725871b-12a0-c2c0-6323-1b7e3a705937@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 15:01 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 2 Oct 2023, Srinivas Pandruvada wrote:
>=20
> > When the current uncore frequency can't be read, don't create
> > attribute
> > "current_freq_khz" as any read will fail later. Some user space
> > applications like turbostat fail to continue with the failure. So,
> > check
> > error during attribute creation.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Should there be a Fixes tag?
Although it can happen when some processor not provide. There is one
obvious one, which I can add.

Thanks,
Srinivas

>=20

