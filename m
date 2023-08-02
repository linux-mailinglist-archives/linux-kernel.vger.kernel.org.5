Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD676CB8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjHBLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjHBLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:14:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A32D4E;
        Wed,  2 Aug 2023 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690974871; x=1722510871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/cs+jJte6HO7usFj7kMbMOyqZ6ySurFpnQ9adQ5vBQ=;
  b=dyMhi2UDruns4JEJefzPSUnQUtHPcwFchcdIup3lrTNcNlYOrxXmnwhZ
   o3Ex0oKDs9Fg19r43gvnEDKhZYXJghqDHJro8k0DNuzgpklEFI/WCOT5P
   0Qc2Z1a43xp2zyKe5GpwxI9GdDLLQmLwiLznox08Jzv9ZNwspoHkfEYjW
   Vf0CDRWS5xo//f/zPN5hs0eHsGX+9lVzq/ufdU1HIPHcF4ZGKUzcThEDs
   LEPqMhpP+tOBsUuQJij2L8B6guoUBdAKc09IETKpORI2ETNndgcpkCuVQ
   fnvQR2CbO3SJu9HVC59fJbw3YLAdTFS2kXOzrS8bg5Rn173pd/ET7A9gl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349155844"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349155844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 04:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722825000"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="722825000"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 04:14:12 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 43A0811FBE7;
        Wed,  2 Aug 2023 14:14:10 +0300 (EEST)
Date:   Wed, 2 Aug 2023 11:14:10 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
Subject: Re: [PATCH v8 16/16] media: ti: Add CSI2RX support for J721E
Message-ID: <ZMo6gtN/4sQz44tH@kekkonen.localdomain>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-16-fb7d3661c2c9@ti.com>
 <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moi,

On Wed, Aug 02, 2023 at 02:04:57PM +0300, Tomi Valkeinen wrote:
> > +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
> > +				      struct v4l2_fmtdesc *f)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt = NULL;
> > +
> > +	if (f->mbus_code) {
> > +		if (f->index > 0)
> > +			return -EINVAL;
> 
> This fails to enumerate the formats if mbus_code is set, doesn't it?

This is intentional: if the mbus_code field is set, you're supposed to get
only format(s) corresponding to that mbus code.

> 
> > +
> > +		fmt = find_format_by_code(f->mbus_code);
> > +	} else {
> > +		if (f->index >= num_formats)
> > +			return -EINVAL;
> > +
> > +		fmt = &formats[f->index];
> > +	}
> > +
> > +	if (!fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat = fmt->fourcc;
> > +	memset(f->reserved, 0, sizeof(f->reserved));
> > +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +
> > +	return 0;
> > +}

-- 
Sakari Ailus
