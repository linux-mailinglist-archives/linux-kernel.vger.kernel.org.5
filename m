Return-Path: <linux-kernel+bounces-92662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92148723D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B86289141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBF129A9F;
	Tue,  5 Mar 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1RlGBDg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D71292E1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655046; cv=none; b=EtWePosrZgjessHlSIus8E3OhBfyZG+Km2k347Yva7dqGDVWNoCa0I1fOR/1e5Ftwr1esBkjwRqgauKhVmCmUin7sdo7jCiZwwpARBXFymDMpR3Lbm5kofCt+/GZ4Deo5WO0mVarxbXuQBABT1IoOZkpn649I3R3Cpi4bfzZvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655046; c=relaxed/simple;
	bh=RBsB1pM+37I1FKxyzuRkXY+Jt+SjFQNHWCKoI6kPgdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4/eL21ra242Zx5ZWBqO3Fdfp+TG6kpN+jcoGkmhiNPgb2eL66xaTnPIqmgdvozbDf/vT3qBvEd+V6gWhOU7bgfdaKmCU6zSp2CrwvOKWOUYFs051kRG535ZfmqQTmzW25Smoj4a6sdc7dcIX/JGgVLoSWqL4fCCLmWtAVkFhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1RlGBDg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655044; x=1741191044;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RBsB1pM+37I1FKxyzuRkXY+Jt+SjFQNHWCKoI6kPgdQ=;
  b=a1RlGBDgHWcqtUH2fEc88lq2iei7HPYzEzWFNd8FQ0AsHgnMwFY8tfw2
   VjzCweMujd3eKW5GZkfoPFjyY73gfJWlTbl+rl046WHOi08h2Ff7u32f7
   Mzp3h9GzbjoHQc8pPQkEI6w7/nLHHpCR+Xat8udT8IXLryl4wYDNbUvBD
   yZqC/PPyl0l6ifjadOxtWCFa29qrSh+g5UqIvoD04cZiSKdAELJHsGfNh
   gvrQKuohnaL9XuhwxZ6Lk7Mnq06X+UiaOhHIPakeHlmrWoASt0B/0M4qG
   8aWUAQgLkSBL4D1oiy288pjw4ILGZSC4Xn9zoKkvjoREtBr7EnijMIYJR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4342172"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4342172"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9846621"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:10:39 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Robert Foss <rfoss@kernel.org>, Alvin =?utf-8?Q?=C5=A0ipraga?=
 <alvin@pqrs.dk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alvin =?utf-8?Q?=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>
Subject: Re: [PATCH v3 2/2] drm/bridge: adv7511: get edid in hpd_work to
 update CEC phys address
In-Reply-To: <CAN6tsi4WzRPKRFTFcK=DwdL_Z_gJPugM1BYaZAGEq2GEkAq_TQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
 <20240219-adv7511-cec-edid-v3-2-445aed2f1cd7@bang-olufsen.dk>
 <CAN6tsi4WzRPKRFTFcK=DwdL_Z_gJPugM1BYaZAGEq2GEkAq_TQ@mail.gmail.com>
Date: Tue, 05 Mar 2024 18:10:36 +0200
Message-ID: <87h6hk1wxv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Mar 2024, Robert Foss <rfoss@kernel.org> wrote:
> Sorry to ask for this again, but this series has non-trivial merge
> conflicts with upstream again.
>
> Could you rebase it and send out an updated version?

Not just rebase, but all of bridge has been switched over to struct
drm_edid based interfaces.

BR,
Jani.


-- 
Jani Nikula, Intel

