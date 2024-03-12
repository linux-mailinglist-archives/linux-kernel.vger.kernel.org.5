Return-Path: <linux-kernel+bounces-100137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51039879260
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D01A28392A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07D7867A;
	Tue, 12 Mar 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az0eA8sp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F355E73;
	Tue, 12 Mar 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240330; cv=none; b=F5emAqDKdJz5hsCFnAz9no7nYOTsfMNk8kVC7DAlqHofCUhfSoI/Znjh0p3ntNDCP30qbncF3BR8XzDmoQ+D4ipP42BBlwpHgzQ/2ey52xzetu+BqOMmAQtnN4w7c068GUyjHYd2M36hILqXrmGXOcqDec1ybuA+bgVoq3rO6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240330; c=relaxed/simple;
	bh=DD4v8R9W7lbY3AFQ+hQ0Jpk/wrmyWokjjIS0dZTNBsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHjMHuGUbzUR4+CVEcXIk+frVsHrq3oQhaeWRYBEe6N6+FgmNZagCa3OVYwOyo/rcVPlfinOGtAvX1PS33Qbhq5IHKLT2PbcEg4F/m+tPH6WZENsFTmf0eeYiv0PT2FubcKVQneoqXkfESx61ipTi3T6FRrUS0kD2K2HpqKO8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az0eA8sp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710240328; x=1741776328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DD4v8R9W7lbY3AFQ+hQ0Jpk/wrmyWokjjIS0dZTNBsY=;
  b=az0eA8spK5G1VRUYFzjrs5EhuC9Bfvjhb1XsTGAbHP2Hm7OFstV8vnAE
   KxGqVJ9IqRVvLC1hCR2e0CmRGeHoiNsct5Cf9Vljg+J9BIGqxO5njSEA/
   umpPMoxPKuk5ixw7UfJFF8MITzXu01T4yzaYrLOl0IbXdC5MOpVxzmpPz
   ibjvVWC8mJ3SvVzX4u//FYlrS66goORcWASkXrOBlD04Vhh1Wql+Wvczb
   UE4+66FWhxDxSEDAahoPEvDmLHTYSUxjeRvrDGflWqXXpJwCoGG42/Utz
   AAJT1VVGtCaGSMknxNypzeo9Slzn93aA/m0Hr+cPlIue55t0GeQ7Zi/pN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4793214"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4793214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11959019"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:45:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 079E011F819;
	Tue, 12 Mar 2024 12:44:59 +0200 (EET)
Date: Tue, 12 Mar 2024 10:44:59 +0000
From: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH v7 0/2] media: i2c: Add support for GC08A3 sensor
Message-ID: <ZfAyK42Iow-VAOam@kekkonen.localdomain>
References: <20240303022609.26263-1-zhi.mao@mediatek.com>
 <983197a9531748d7a34a77ce0a74dd7f086e827a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <983197a9531748d7a34a77ce0a74dd7f086e827a.camel@mediatek.com>

Hi Zhi,

On Tue, Mar 12, 2024 at 01:31:20AM +0000, Zhi Mao (毛智) wrote:
> ping...

The set (v6) has been in my tree for some time now:
<URL:https://git.linuxtv.org/sailus/media_tree.git/log/>.

If you have further changes, please post them on top. Thanks.

-- 
Regards,

Sakari Ailus

