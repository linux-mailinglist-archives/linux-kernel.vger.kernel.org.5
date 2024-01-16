Return-Path: <linux-kernel+bounces-26960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D2082E89F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97371C22AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DE1119A;
	Tue, 16 Jan 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WCWJvECM"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482EE11181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lClxhiG7kPciwzOgT7N9lpSqHzzXmh68CO/DdbLniM4=; b=WCWJvECMzP18zlfiqAgmLtYK9B
	7FoSNN0Rx8W4NA4lp7OfrC+VCLJ6jNC7axeCVcvVI1qyTym5ARO2W/mYSCyEWBtctnhwpQ5h2lGqe
	9cwx0Tr1wfwEp18q6n97bdVDNcrDdbTTOkyYQK88Fi1QKCMPNixb4lm8rdU6S/GoNhoy3KZcWheZQ
	YgD6jiSygxm2HKWkR+ReauFXYb5d9yPiVSGTo1lsbDRB0Il3LngupnHkt84qozAN31stOezZsjP7V
	oVRJBdKAmb8NySiMftR+adkjM1ZKOu7MDpM7TbsH6nH798+luyXOrn6esqueBgtdPDMmF3Ojh0Ns0
	mW7wAUwQ==;
Received: from [177.45.63.147] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rPbQn-006r0R-Be; Tue, 16 Jan 2024 05:52:09 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane check for async 
Date: Tue, 16 Jan 2024 01:51:57 -0300
Message-ID: <20240116045159.1015510-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
IME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

AMD hardware can do more on the async flip path than just the primary plane, so
to lift up the current restrictions, this patchset allows drivers to write their
own check for planes for async flips.

I'm not sure if adding something new to drm_plane_funcs is the right way to do,
because if we want to expand the other object types (crtc, connector) we would
need to add their own drm_XXX_funcs, so feedbacks are welcome!

	André

André Almeida (2):
  drm/atomic: Allow drivers to write their own plane check for async
    flips
  drm/amdgpu: Implement check_async_props for planes

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
 drivers/gpu/drm/drm_atomic_uapi.c             | 62 ++++++++++++++-----
 include/drm/drm_atomic_uapi.h                 | 12 ++++
 include/drm/drm_plane.h                       |  5 ++
 4 files changed, 92 insertions(+), 17 deletions(-)

-- 
2.43.0


