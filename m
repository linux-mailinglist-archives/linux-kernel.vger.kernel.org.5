Return-Path: <linux-kernel+bounces-153508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567CD8ACEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020731F21CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609A150993;
	Mon, 22 Apr 2024 13:58:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836514F128
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794319; cv=none; b=dUdf0VvIMoaoecmC1Eeqtb4wDd+kl1ilSTO+WSft+yQGXzAk2iu1qn7WQu1/4v+7KUv/ET7k8S0Nayi6cTAH5SqKizz0Hl8s1Ad1No0czafWUtGIiwEXhD8fGXy0CyKQuBh/wH0U069GEUhM7aGO5xYEpz/sl1Fks/HjOU1N3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794319; c=relaxed/simple;
	bh=AhIzPpS4/x0BXMalxZulG6AWY5tEbwV7bUsloM23qZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kMnbETI7Y7S4V1V2JOfo16gD2fieRkEWRkv+sDB6DhjnZrWcQ5HUiCvR2ahN7Yi3Ph0pG7urCX1R1gt+96Ya77fgflPHgBx7sxanQ2ZnKwULYqkqPBy76D+0fW7Wzj27py8YRI+3034mU4/eZx+TLA8imj11FTMHqmJCerGUqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mol@pengutronix.de>)
	id 1ryuBV-0004mi-PP; Mon, 22 Apr 2024 15:58:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mol@pengutronix.de>)
	id 1ryuBU-00Dhch-1z; Mon, 22 Apr 2024 15:58:16 +0200
Received: from mol by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mol@pengutronix.de>)
	id 1ryuBT-0089hS-37;
	Mon, 22 Apr 2024 15:58:15 +0200
Date: Mon, 22 Apr 2024 15:58:15 +0200
From: Michael Olbrich <m.olbrich@pengutronix.de>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: graphics@pengutronix.de
Subject: Reliably selecting non-CEA modes on Intel graphics (and maybe others)
Message-ID: <ZiZs94-ZP1n98RZu@pengutronix.de>
Mail-Followup-To: dri-devel@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, graphics@pengutronix.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

In short: I have a HDMI monitor attached to Intel graphics. I'm trying to
set a non-CEA mode but the driver always maps it to the corresponding CEA
mode.

More specifically, the monitor has two 1920x1080@60 modes in the EDID:
1. The CEA mode with VIC 16
2. A custom DTD mode with exactly the same timings (this is the preferred
   mode).

From a userspace perspective, the two modes are mostly identical, except
for the 16:9 aspect ratio flag in the CEA mode and the preferred type in
the other.

I want to select the second (preferred) mode, but that does not seem
possible:
intel_hdmi_compute_avi_infoframe() tries to determine which VIC should be
added to the avi infoframe and if limited or full range is used.
It uses various DRM helpers here but in the end drm_match_cea_mode() is
called. And here lies the problem:
The mode provided by the userspace has explicitly no aspect ratio. But
here, it is interpreted as "the aspect ration is undefined". So matching
ignored the aspect ratio and the CEA mode with VIC 16 is found and limited
range is used.

The commit that introduces this fuzzy matching
357768cc9e3fdacf6551da0ae1483bc87dbcb4e8 ("drm/edid: Fix cea mode aspect
ratio handling") made sense at the time. The capability
DRM_CLIENT_CAP_ASPECT_RATIO that exposes aspect ratios to userspace was
introduced later in the same merge request, from what I can tell
7595bda2fb4378ccbb8db1d0e8de56d15ea7f7fa ("drm: Add DRM client cap for
aspect-ratio").

Am I missing something here, or is it just not possible to select the
non-CEA mode right now? In my specific example, the selected CEA mode is
actually supported by the monitor, but as far as I can tell, the CEA mode
is used even if the monitor does not support it at all.

I've only tested this on Intel, but I assume that other drivers that use
the same helpers have the same problem.

So how can this be fixed? I've considered matching the aspect ratio based
on the DRM_CLIENT_CAP_ASPECT_RATIO capability, but I'm not sure if that is
valid. The documentation is limited and I found nothing that describes what
the userspace should do here.
Or would a new capability make sense here? Or something entirely different?
I'm not sure how I should proceed here. Any help would be appreciated.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

