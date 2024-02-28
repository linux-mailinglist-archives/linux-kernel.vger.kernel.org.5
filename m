Return-Path: <linux-kernel+bounces-84989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4C86AEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4791F28669
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758DC1F608;
	Wed, 28 Feb 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFvTkSYC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB473513;
	Wed, 28 Feb 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121791; cv=none; b=NYEdKm1RgrFrAFpaqZaKycmRup0m2ZKG9fe5XG0Kt7ta7zLYbKovuMQpPryO3AyObfLUDpTXrDsjv/FOZUt9ls4e+cz2So9irppmEqX/7QL+X6Oy/J8XyGgVN81+w67J0vD4MTnlPyrYh4l5qola60RecsJlpKIrDkwN6FUvI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121791; c=relaxed/simple;
	bh=MpZ+7FpSdhy1jX1Eb1448QYNsWBInrp8KzudyioVXOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l96OjoPCkSM+F1K27gRfXbTz43/Hugc2ZrO5pv+bRo2ZWVh7jFZZsjKu3sJmP42yzIWe7PD4QhTU2g/Qjr2hcuL/ns7822fEfaPPOJB5NX6AKdCK+hw6ZwEUE+aK7oxZ+JjZ2hG3LbxPxi2uTwC01BN/oQHZwuoyC5ZKwnSmElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFvTkSYC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709121790; x=1740657790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MpZ+7FpSdhy1jX1Eb1448QYNsWBInrp8KzudyioVXOg=;
  b=QFvTkSYCwaQm67HcG888SC1czCDCyQW5SVbKfl9LjzvAXIPqXRdQlIwO
   r3I8aRLVQux9u3dcGVyLczCExjf6wbmovhuzQLLC2A2ffbqEW42NMKTLH
   NN68f75I4w07J9Gdl3y8W0E1/a3xBltRQ2tl/lUe2g7pjKdv7HmLKmKAG
   MjhXZ4RDUmU19IwxJBkMs+sX/SMDKXhHEFQbijmiVXQnYODowSrdoe4ER
   u3YfY5qMKxIyB5DaLUXKKZ3z5zjhKRHd/DrOnFnZEebIpu0KNvMS5H/Px
   WivespjbZEMdZIbFALRlFa7OKXqjp5rxAFZuNx/dYyzAIpQkJnJ3AAZXq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7297436"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7297436"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 04:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11988943"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 04:03:02 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F167911F855;
	Wed, 28 Feb 2024 14:02:59 +0200 (EET)
Date: Wed, 28 Feb 2024 12:02:59 +0000
From: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"10572168@qq.com" <10572168@qq.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <Zd8g81wBXyfMvPhB@kekkonen.localdomain>
References: <20240227013221.21512-1-zhi.mao@mediatek.com>
 <20240227013221.21512-3-zhi.mao@mediatek.com>
 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
 <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
 <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com>

Hi Andy, Zhi,

On Wed, Feb 28, 2024 at 11:22:13AM +0200, Andy Shevchenko wrote:
> > Another, I also reviewed some other sensor driver code(such as
> > gc0a08/gc2145 and imx/ov), they are all the same.
> 
> They are also problematic. So what?

The situation is the same in a large number of drivers, also outside the
media tree. It's also not trivial to figure out which header should be
included and it tends to be that if it compiles without warnings,
developers won't bother trying to figure out what should still be changed.

I wonder if this could be automated by using the C pre-processor and a
small Perl script. :-)

> > Can we keep this coding style and follow with most of those
> > image sensor driver?
> 
> Why? We do NOT want to continue developers to avoid decreasing their
> technical debts.

I agree. People tend to copy the code from existing drivers and argue "it's
just a driver, why bother?". That code will be soon found in a dozen other
new driver patchsets and every time must brought up in review and fixed,
leading to extra work for reviewers and developers. We've had quite a lot
of work improving the current (sensor etc.) drivers and fixing up the use
of bad patterns but this area has so far received little attention.

-- 
Regards,

Sakari Ailus

