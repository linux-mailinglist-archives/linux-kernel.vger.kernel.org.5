Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9657C5141
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjJKLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjJKLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:12:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF0A7;
        Wed, 11 Oct 2023 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022742; x=1728558742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6X17CQk262SF6/jtSrC9+lvmvN3o4Ya/8mawpifctfY=;
  b=Uz0f/eNlcyqTalTISzq3YeTdlPf7GgcjiitXhbHsV2uP4/hEZAvzGLY9
   O6Jomj50TyQUyeiTFI9Kq/1nhelw2qrCsEtECHK1LO7E8UvwDw4AFm3Px
   lebvcKMut+C/yZVt22FkwC6xTPvD+JuR6pDbnZayM/dKKdO2nHMpQ/T/5
   Iu76zTZfEun+2DskjZnH51wbnJMmluW/SkCI8n/DI+YAi4B2Khfp+J38h
   2EZyywyjLs6V8SWvFtPBpUHNYmIZr3BW2dEPhHnBARVDCNpup/K2Ur4Db
   AJeoGWswd3RnxCo2PhIOIN0bsIgg+DA9IYPzMyZs94Iyv+rmKYOCGycE2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3224774"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3224774"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730459248"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730459248"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:12:18 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 07C9011F835;
        Wed, 11 Oct 2023 14:12:15 +0300 (EEST)
Date:   Wed, 11 Oct 2023 11:12:14 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl
Subject: Re: [PATCH 3/5] media: i2c: imx335: Implement get selection API
Message-ID: <ZSaDDqrpX4LeoLqX@kekkonen.localdomain>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
 <ZSTrse7OeKIA+k2t@valkosipuli.retiisi.eu>
 <169701831889.277971.6656559808677876108@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169701831889.277971.6656559808677876108@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wed, Oct 11, 2023 at 10:58:38AM +0100, Kieran Bingham wrote:
> Quoting Sakari Ailus (2023-10-10 07:14:09)
> > Hi Kieran,
> > 
> > On Tue, Oct 10, 2023 at 01:51:24AM +0100, Kieran Bingham wrote:
> > > Support reporting of the Sensor Native and Active pixel array areas
> > > through the Selection API.
> > > 
> > > The implementation reports a single target crop only for the mode that
> > > is presently exposed by the driver.
> > > 
> > > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > 
> > Shouldn't you use the same callback for .set_selection? I guess this is
> > somewhat grey area but doing so would be in line with how V4L2 API works in
> > general.
> 
> Hrm ... I didn't think it was needed as it's not possible to /set/
> anything.

Similarly, VIDIOC_SUBDEV_S_FMT is available even if you can't change the
format.

> 
> I expect to change this once I add support for setting crops later
> though. It was going to be something I'd add when it is used.
> 
> Only the 'get_selection' call is necessary to make this camera operate
> on both i.MX8MP and RPi5 platforms with libcamera, so that's what I've
> done so far. My goal of this series was to bring the existing driver up
> to a point that it can be used, before I start making new feature
> additions.

I don't have concerns with that, just that we implement the IOCTLs
consitently. This has been discussed before but AFAIR without any firm
conclusions.

Additionally, some targets are settable while some won't be, and it may
well depend on the driver.

v4l2-compliance appears to be happy with G_SELECTION without S_SELECTION
though.

Also cc Hans.

-- 
Regards,

Sakari Ailus
