Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07B7E07B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjKCRno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:43:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8C136;
        Fri,  3 Nov 2023 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699033416; x=1730569416;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aIvZEKHaJxoPCdC0kbJg+1YILsDyr+aIf900fUUKC04=;
  b=ltUOQcOyy/4ylDF0Xrra6yton99Wor6Pf90fpH0B0N561+RyAviTA2HA
   2u/ebxf49Ccd0CbhUD1TFt4pxvwzsCr6jLnW9nwj9VD2QoNbBAouiEIE/
   1KgiixuPsWYHMUSLRc1VTqgUzFmLQYKR2sloJBQCjkp0UrZxRoOuovJq8
   NQ+2NJSVgXMQtBJMx63xHBZhOzb9wZA83KoptFJaF7tF0PlHDTnzTi0FY
   dUkGCosGLOLJCJ2f/qlauD/YHoQ0s17wuiCh1TXlg5ySdEHxj47lLBQuu
   LU4krZ+ucEx8etCTURvO5NN0Pbu74FOs+rKsJ+OZ7B2PbE1kXVq0omfcb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387880936"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="387880936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="738139242"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="738139242"
Received: from tinggan-mobl.amr.corp.intel.com (HELO [10.213.173.96]) ([10.213.173.96])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:43:35 -0700
Message-ID: <1cf3bf9cb37ddcf0022f680c3f7f4442c6218c10.camel@linux.intel.com>
Subject: Re: [PATCH v2] thermal: core: Add trip thresholds for trip crossing
 detection
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Date:   Fri, 03 Nov 2023 13:43:33 -0400
In-Reply-To: <3fe787bc-f85c-4268-833f-86922415c4d3@linaro.org>
References: <12317335.O9o76ZdvQC@kreacher>
         <6b22f4715641bc4ffc76eea8a4e6358bcbea9e1c.camel@linux.intel.com>
         <3fe787bc-f85c-4268-833f-86922415c4d3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 17:30 +0100, Daniel Lezcano wrote:
> On 03/11/2023 16:42, srinivas pandruvada wrote:
> > On Fri, 2023-11-03 at 15:56 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > > The trip crossing detection in handle_thermal_trip() does not
> > > work
> > > correctly in the cases when a trip point is crossed on the way up
> > > and
> > > then the zone temperature stays above its low temperature (that
> > > is,
> > > its
> > > temperature decreased by its hysteresis).=C2=A0 The trip temperature
> > > may
> > > be passed by the zone temperature subsequently in that case, even
> > > multiple times, but that does not count as the trip crossing as
> > > long
> > > as
> > > the zone temperature does not fall below the trip's low
> > > temperature
> > > or,
> > > in other words, until the trip is crossed on the way down.
> >=20
> > In other words you want to avoid multiple trip UP notifications
> > without
> > a corresponding DOWN notification.
> >=20
> > This will reduce unnecessary noise to user space. Is this the
> > intention?
>=20
> Not only reduce noise but give a correct information. Otherwise the=20
> userspace will have to figure out if there are duplicate events after
> the first event happened. The same happen (less often) when crossing
> the=20
> trip point the way down.
Correct.
The patch looks good to me.

Thanks,
Srinivas


>=20
>=20
>=20

