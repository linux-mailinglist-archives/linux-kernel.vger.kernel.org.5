Return-Path: <linux-kernel+bounces-1320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366FA814D62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E0C1C23042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BA3EA60;
	Fri, 15 Dec 2023 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XIXpbTO/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762B3DB94;
	Fri, 15 Dec 2023 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702658686;
	bh=f+TCM7pGtaT/lQaRtao0Q8SkJwJVGAdBLHsGY6Pv5qU=;
	h=From:To:Cc:Subject:Date:From;
	b=XIXpbTO/l0VFnvYvsHNl//QYwLMgO5u4W/YAG6YNpFSQXbk4wfYRhPOLG6rSxIhYE
	 rPG6pTfdxkV2clDrf4ByZQzmgBCZrWSjSMxRmmre/oegAbAWC89RuYbBCzN4nKZwgz
	 uLA5++SiK19g91Serzhc4SgIYZMkT15B+K7juItNijlkL8c/nI/QXN8x/GyrjsjA5V
	 q6r8CbN2+7oaQMvBydbijYvrxrpSFCb67JJGibwq9ZrSSe0ndAUWUEKorRGjEVCFlS
	 u20zLmbvMOP0EuGrkyWm3LOCFCCYZFbpisS8Ucfl5zgNfMLBrz7Qa4ZG3GoizHbqxM
	 btqrbS1cBUNYw==
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A662D3781F93;
	Fri, 15 Dec 2023 16:44:45 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 0/4] visl: Add a tpg_verbose parameter for reference comparison
Date: Fri, 15 Dec 2023 11:42:54 -0500
Message-ID: <20231215164447.743787-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using visl in automated tests, we need to have output frames that
can be compared to reference frames or hash of those to validate that
the whole pipeline is working properly.

Make sure that a given input stream always outputs the same frames.
This is done by removing TPG information like queues status and pointer
values.

Introduce the tpg_verbose parameter to allow adding the more verbose
information that this patchset removes

This also adds some stable variation in the frames so that different
input give more different output.

Changes since v3:
 - Fix some more permissions in vidtv
 - Rename stable_output to tpg_verbose
 - Rebase on media_stage/master to include AV1 support
 - Remove code churn in visl_get_ref_frames()
 - Remove code duplication in visl_tpg_fill_sequence()
Changes since v2:
 - Set parameters permissions to 0444 in visl and vidtv
 - Make stable_output true by default
 - Keep showing frames timestamps and remove vb2 buffer indexes only in
   stable output mode
 - Make codec_variablility non optional (remove parameter, keep
   implementation)
 - Add details on used variability fields
Changes since v1:
 - Fix typo in parameter documentation


Detlev Casanova (4):
  media: visl,vidtv: Set parameters permissions to 0444
  media: visl: Add a tpg_verbose parameter
  doc: visl: Document tpg_verbose parameter
  visl: Add codec specific variability on output frames

 Documentation/admin-guide/media/visl.rst      |  12 +-
 .../media/test-drivers/vidtv/vidtv_bridge.c   |  26 +-
 drivers/media/test-drivers/visl/visl-core.c   |  15 +-
 drivers/media/test-drivers/visl/visl-dec.c    | 346 ++++++++++--------
 drivers/media/test-drivers/visl/visl.h        |   1 +
 5 files changed, 237 insertions(+), 163 deletions(-)

-- 
2.41.0


