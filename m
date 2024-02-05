Return-Path: <linux-kernel+bounces-53373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B484A3AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F91F21A32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01D82D9F;
	Mon,  5 Feb 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAdtPOm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117A81AB3;
	Mon,  5 Feb 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159805; cv=none; b=skZpw8nhLSauNemfh+L16x1VilqvfsiyEn1IxPHxL85k4AkLld20CrRmqcBOhroMrao/LQ3Mccxwmn0cjNNUlpO208VHf/yiDLdVTTqo0BFy751/C7bXEnXbXOVQdz5zVIV6egW6Ew+21t1KqAkRJx0a4eKp7mSp2BQ4x7DyJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159805; c=relaxed/simple;
	bh=l8E48JqEiLUq+g7VXEPmj7k+iRCuEuoIVhBVcSOCs+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtLy5V3qYlT+rGr+OvIVYvVMms3JQ3BsTV9YtzWdZaBLjQZhgJt13RXAEj6c6Hp7TNwm4RADvzGij0Sgy9Zaa/rlIkA1MwQX4iYvsRe1faajRAGilrV9qLJEHUcMwmSEeXxpmk1EkeuIU9bH3eXcCF6x+PcT5vDiyWXB2OkSxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAdtPOm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4254EC43394;
	Mon,  5 Feb 2024 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159805;
	bh=l8E48JqEiLUq+g7VXEPmj7k+iRCuEuoIVhBVcSOCs+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAdtPOm7Z6gCfcPSGvj2SAwmyPEMR1HthJCYOpI4ubBie8cOSUh+f9zqyHV0DiXlZ
	 C7FCF/zljJC6pv87qiPWKeELiL8Hfs6ESw2GD4IZ91NkdjKcltn3BaHfQ4UOtQ1RFt
	 o/5EdVoaGaX0X4oxdeZShn91Bhjle8WzV068L/Qo=
Date: Mon, 5 Feb 2024 04:48:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvdimm: make nvdimm_bus_type const
Message-ID: <2024020512-bondless-suction-9ad5@gregkh>
References: <20240204-bus_cleanup-nvdimm-v1-1-77ae19fa3e3b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-nvdimm-v1-1-77ae19fa3e3b@marliere.net>

On Sun, Feb 04, 2024 at 05:20:07PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nvdimm_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

