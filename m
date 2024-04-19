Return-Path: <linux-kernel+bounces-151116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F08AA951
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C75282765
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DB4596D;
	Fri, 19 Apr 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKMZfcmE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA62AD1A;
	Fri, 19 Apr 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512244; cv=none; b=oNMt2Zyk5tll18s3UrUk6pLI7yR5zkuV2P4/OdOdFOECthpfhTqHWIJ2BGwdDwvdTeETyHesuEvnHApKoGy4fYGvkfJoKVuzmESwy3AgBC4N+0wWQnZ9g7lEz5+uo53RJoqGqGBGElUFfDxgfUKyPeTOtPvg8j6g5RCg9dxqeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512244; c=relaxed/simple;
	bh=WH/TWNwyB1L7t0DkTK1GAarV0p0L0EueWHtAvZAq7rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzOL4uJSMa4rRpyO5T7YTKWTT1eOmesuSuWzmcvQd/LsNGQ6AkWDsnRN1YMWNNE43BrUYPMxuo2aAcmsl8+vwEb7oKESuXyx6jx5vzVRD2USdacrBZZO0ENZa4NEvsazQULppVBItxiqW78NXZYBpEdzSgEBx42uktIOTFmUtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKMZfcmE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713512243; x=1745048243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WH/TWNwyB1L7t0DkTK1GAarV0p0L0EueWHtAvZAq7rg=;
  b=mKMZfcmEiZVzsb+MQXHDxkkOducz+2zyhbWIsncm5iKGKFhd4a8nUHsN
   veln5dTnAVZSLrjEYz9qbTCRqJW3wr860e9FCUrDy5KrvieyWKI4wySIG
   QVJnoDV23cABB70a8QARP0KtwTNhg7Q4aQHox2bPtcA20kVVEHod+p0jZ
   AL2oJg5eyjZ8dXiz7nr12XkERanL+EJgCG3oOy98iY1IGv9KuDxbk60+c
   WvnSkzh6fr0yflLOdqXEQfvp6mSXy5RwN5EdJon3v85czDlzTrVVYMYll
   4EIGRLh7JzLIcmtRA/lAgbK/xRGB7Xi2eMm74W618MA0g3UqKI7QRKmjT
   w==;
X-CSE-ConnectionGUID: /mEfzdxcTjCZGy4zHlGAng==
X-CSE-MsgGUID: SaCLh30YTvGhejiV2LmGnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9217819"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9217819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:37:22 -0700
X-CSE-ConnectionGUID: yDaNp2+dQdWidn2TlCgqcQ==
X-CSE-MsgGUID: 4DX5CsrsS/6l5cwvv9bu0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54179291"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 19 Apr 2024 00:37:19 -0700
Date: Fri, 19 Apr 2024 15:32:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
Message-ID: <ZiId9CnGEjwMcXeX@yilunxu-OptiPlex-7050>
References: <20240411144811.121500-1-marpagan@redhat.com>
 <ZhnviXAgnTdzUyV4@yilunxu-OptiPlex-7050>
 <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
 <e5f15ea4-f8e4-4a97-95f6-63a2099d084c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f15ea4-f8e4-4a97-95f6-63a2099d084c@redhat.com>

On Mon, Apr 15, 2024 at 07:11:03PM +0200, Marco Pagani wrote:
> On 2024-04-15 14:19, Marco Pagani wrote:
> > 
> > 
> > On 2024-04-13 04:35, Xu Yilun wrote:
> >>>  /**
> >>> - * fpga_region_register_full - create and register an FPGA Region device
> >>> + * __fpga_region_register_full - create and register an FPGA Region device
> >>>   * @parent: device parent
> >>>   * @info: parameters for FPGA Region
> >>> + * @owner: owner module containing the get_bridges function
> >>
> >> This is too specific and easily get unaligned if we add another
> >> callback. How about "module containing the region ops"?
> > 
> > I had some concerns about using the name "region ops" in the kernel-doc
> > comment since it was not supported by a struct definition nor referenced
> > in the documentation. However, since the name is now referred to in the
> > ops_owner pointer, making the change makes sense to me.
> > 
> 
> On second thought, I think it would be better to leave the @owner
> description to "module containing the get_bridges function" for the
> moment. Otherwise, it could confuse the user by blurring the connection
> between the @owner and @get_bridges parameters.
> 
> * __fpga_region_register - create and register an FPGA Region device
> * [...]
> * @get_bridges: optional function to get bridges to a list
> * @owner: owner module containing get_bridges function
> 
> We can always modify the @owner description later, together with all the
> necessary changes to add a new op, like grouping all ops in a structure
> and changing the registration function signature.

OK, it's good to me. I'll apply this patch to for-next.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> Thanks,
> Marco
> 
> > 
> >>
> >>>   *
> >>>   * Return: struct fpga_region or ERR_PTR()
> >>>   */
> >>>  struct fpga_region *
> >>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
> >>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
> >>> +			    struct module *owner)
> >>>  {
> >>>  	struct fpga_region *region;
> >>>  	int id, ret = 0;
> >>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
> >>>  	region->compat_id = info->compat_id;
> >>>  	region->priv = info->priv;
> >>>  	region->get_bridges = info->get_bridges;
> >>> +	region->ops_owner = owner;
> >>>  
> >>>  	mutex_init(&region->mutex);
> >>>  	INIT_LIST_HEAD(&region->bridge_list);
> >>> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
> >>>  
> >>>  	return ERR_PTR(ret);
> >>>  }
> >>> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
> >>> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
> >>>  
> >>>  /**
> >>> - * fpga_region_register - create and register an FPGA Region device
> >>> + * __fpga_region_register - create and register an FPGA Region device
> >>>   * @parent: device parent
> >>>   * @mgr: manager that programs this region
> >>>   * @get_bridges: optional function to get bridges to a list
> >>> + * @owner: owner module containing get_bridges function
> >>
> >> ditto
> >>
> >>>   *
> >>>   * This simple version of the register function should be sufficient for most users.
> >>>   * The fpga_region_register_full() function is available for users that need to
> >>> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
> >>>   * Return: struct fpga_region or ERR_PTR()
> >>>   */
> >>>  struct fpga_region *
> >>> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> >>> -		     int (*get_bridges)(struct fpga_region *))
> >>> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> >>> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
> >>>  {
> >>>  	struct fpga_region_info info = { 0 };
> >>>  
> >>>  	info.mgr = mgr;
> >>>  	info.get_bridges = get_bridges;
> >>>  
> >>> -	return fpga_region_register_full(parent, &info);
> >>> +	return __fpga_region_register_full(parent, &info, owner);
> >>>  }
> >>> -EXPORT_SYMBOL_GPL(fpga_region_register);
> >>> +EXPORT_SYMBOL_GPL(__fpga_region_register);
> >>>  
> >>>  /**
> >>>   * fpga_region_unregister - unregister an FPGA region
> >>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> >>> index 9d4d32909340..5fbc05fe70a6 100644
> >>> --- a/include/linux/fpga/fpga-region.h
> >>> +++ b/include/linux/fpga/fpga-region.h
> >>> @@ -36,6 +36,7 @@ struct fpga_region_info {
> >>>   * @mgr: FPGA manager
> >>>   * @info: FPGA image info
> >>>   * @compat_id: FPGA region id for compatibility check.
> >>> + * @ops_owner: module containing the get_bridges function
> >>
> >> ditto
> >>
> >> Thanks,
> >> Yilun
> >>
> >>>   * @priv: private data
> >>>   * @get_bridges: optional function to get bridges to a list
> >>>   */
> >>> @@ -46,6 +47,7 @@ struct fpga_region {
> >>>  	struct fpga_manager *mgr;
> >>>  	struct fpga_image_info *info;
> >>>  	struct fpga_compat_id *compat_id;
> >>> +	struct module *ops_owner;
> >>>  	void *priv;
> >>>  	int (*get_bridges)(struct fpga_region *region);
> >>>  };
> >>
> 

