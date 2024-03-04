Return-Path: <linux-kernel+bounces-91249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C58870BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C91A1C220A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFDFDF67;
	Mon,  4 Mar 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isixOAQd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BA8F6E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585063; cv=none; b=K9tRp49kWFPrgdXswK+1z8jei4yZ34me/i7Slz3lxptbZQs9je4efPs94YHVhnJ285+KrUTDA738BKn7aEeaN1JhcOGu1uXnBVgcLZgwqDmuutnfEsj8vtPsWkgvePkcYiSTrr7Me8XzzeSDwghbwhBh2ZHL354txrvTMbs+I/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585063; c=relaxed/simple;
	bh=+LDt+7BROXBNv2O1HJAcO8FeyqvfobiscAmbl8mDiQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2q0/B4dWphvGQ1VAIBgu1l1WSPGigEfx50h5Rh0FgxsKSYalr7vcSNFq0HcT4g+THkgneOQapN/BUSA9bmA82yIO3eKMSEoNhi+3NIS0LDZizODMg9sn8qhnQw5zjEGKd9roFnbcapgejKQGdNFA3ch0vRCmxbP9PRmlaPZUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isixOAQd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709585062; x=1741121062;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=+LDt+7BROXBNv2O1HJAcO8FeyqvfobiscAmbl8mDiQk=;
  b=isixOAQdCUb0vHHFbrVUQxDN6Dq/AExS5y6Q9RnDRlJodjOJpjsrNR6V
   0YEzZXbGM6dAC68lfjMt78Q4xgCpDHxvsf8UmL5/UweCTnDnBoI5iLUAQ
   XbDZ1WCDexmvtRzLBXLZKb8+xib2BM4QktJXCA6dA0QSbMDkhlCmSBSea
   sKnN+O2CgXBK59OB2d4vnxzHuTHcJ24Sp/3t+uFQNz4Iz+/XXlR94qre3
   z1b8rXH7aDe+pzgSYHrTG3Lie0l1qYNi3UoO3HickpdZDRSjNIXgG8UP4
   1FJv4Mhr4pLeFIMLPkRL0674C5GdNU7OYznwe7sbb2Vqwx552zxzJ/PkM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4027933"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4027933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="40118905"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:44:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Doug Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
In-Reply-To: <CAJMQK-gKF+ZeAe4Hp8di83Zx8gp-BJ0vuj6uzi0hsaxeju8GyQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240223223958.3887423-1-hsinyi@chromium.org>
 <20240223223958.3887423-2-hsinyi@chromium.org> <87wmqqjmt9.fsf@intel.com>
 <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
 <87bk7z6x1w.fsf@intel.com>
 <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
 <CAA8EJpqHJTbc+TCpkccjx_eQH36zaNgcQ9QssecNeQUQgfYApQ@mail.gmail.com>
 <CAD=FV=XyV=V-USfq8kp058=FzRQq=bPA5A4GDb1p0zO-KPbtwQ@mail.gmail.com>
 <CAJMQK-gKF+ZeAe4Hp8di83Zx8gp-BJ0vuj6uzi0hsaxeju8GyQ@mail.gmail.com>
Date: Mon, 04 Mar 2024 22:44:04 +0200
Message-ID: <877cih4tij.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Mon, Mar 4, 2024 at 8:17=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>>
>> Hi,
>>
>> On Sun, Mar 3, 2024 at 1:30=E2=80=AFPM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>> >
>> > > The problem is that Dmitry didn't like the idea of using a hash and =
in
>> > > v2 Hsin-Yi has moved to using the name of the display. ...except of
>> > > course that eDP panels don't always properly specify
>> > > "EDID_DETAIL_MONITOR_NAME". See the discussion [1]. If you want to s=
ee
>> > > some of the EDIDs involved, you can see Hsin-Yi's post [2]. The pane=
ls
>> > > included stuff like this:
>> > >
>> > >     Alphanumeric Data String: 'AUO'
>> > >     Alphanumeric Data String: 'B116XAN04.0 '
>> > >
>> > > The fact that there is more than one string in there makes it hard to
>> > > just "return" the display name in a generic way. The way Hsin-Yi's
>> > > code was doing it was that it would consider it a match if the panel
>> > > name was in any of the strings...
>> > >
>> > > How about this as a solution: we change drm_edid_get_panel_id() to
>> > > return an opaque type (struct drm_edid_panel_id_blob) that's really
>> > > just the first block of the EDID but we can all pretend that it isn'=
t.
>> > > Then we can add a function in drm_edid.c that takes this opaque blob,
>> > > a 32-bit integer (as per drm_edid_encode_panel_id()), and a string
>> > > name and it can tell us if the blob matches?
>> >
>> > Would it be easier to push drm_edid_match to drm_edid.c? It looks way
>> > more simpler than the opaque blob.
>>
>> Yeah, that sounds reasonable / cleaner to me. Good idea! Maybe Hsin-Yi
>> will be able to try this out and see if there's a reason it wouldn't
>> work.
>
> Thanks for all the suggestions. I sent out v3, which still has a blob
> type since we need
> 1. get panel id
> 2. do the string matching.
>
> And I felt that packing these 2 steps into one function may make that
> function do multiple tasks?
>
> But let me know if it's preferred in this way.
>
> v3: https://lore.kernel.org/lkml/20240304195214.14563-1-hsinyi@chromium.o=
rg/

I still don't like it, but incorporating all the ideas here, and in the
previous patches, I think I have a suggestion that covers all cases in a
reasonable manner [1].

Sorry about being so inflexible about this. I've just put 140+ commits
worth of effort in drm_edid.c in the past couple of years, and I'm keen
on keeping it nice and tidy. :)


BR,
Jani.


[1] https://lore.kernel.org/r/87a5nd4tsg.fsf@intel.com


>
>>
>> -Doug

--=20
Jani Nikula, Intel

