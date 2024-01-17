Return-Path: <linux-kernel+bounces-29133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35488830951
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C9728337F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC1224DB;
	Wed, 17 Jan 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UXOWctkc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C202232F;
	Wed, 17 Jan 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504337; cv=none; b=uNqihsyyl7XfiAfbrLLl2Qbe44T4qtpOy3vmtiubzfCpaaHHNtZFCOQWZwiYHtsW6Sp4PrrveRk7A1V0gFprmpkuKG24eMAlqkQtmOEXJJr9W0OGWqylLCGoYneVTLq0hQoGEHWaAnxXTPyRMDzm/E4GmnH5C0hCS1JrR9cLNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504337; c=relaxed/simple;
	bh=LlaH55pFjbWivU+dttpe9o8/QD9wyqoX5RfDenXs8uQ=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=eCmkVlrVW/dLxthTjVA44iVDZUASI57gE/kerBkBa/PpkVbt640gJQ4mhDvo8JlS5HbxrO17YtZXLFAU5jSs9PE+BZD0flKhhn9GTlwRwtb/LuSxpOBbQmgWAqRf7Kft6nsTTT/RnZUedCciI8xVI49GkoWTd4UjjMYwSltZX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UXOWctkc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705504334;
	bh=LlaH55pFjbWivU+dttpe9o8/QD9wyqoX5RfDenXs8uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXOWctkcRIkFtTC1POhkkYkF0FzjkM5GarfK93CLKxuTVQlLRJk+dvs56P0Wwq7kr
	 KEF2sUuxybHTZY/n7/VtxB3OYlT1UsXN/MVjJCtBRxB4rVs8MCLDopGrYDS8fw3YYZ
	 PvmUkT52O9gk0afPRLUa4roebVkC6UFmSiXuQ0FPeoP5pEi1LFya38rGTBKho4tUvU
	 XbIR03zKLFVFW2TTnPDIZetDGS5wYdnuOkrZUdjB1ADGcLjNJi/i2jwUnUONNt51xG
	 z4FwTRiDPme09R+JHWJ78u2U2M9U3PbjJYsLgni2ruCD9W0pudaWGH7FU+spRQLVGC
	 fNpAqq83Tt6tg==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1D1A378206F;
	Wed, 17 Jan 2024 15:12:12 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 3/4] doc: visl: Document tpg_verbose parameter
Date: Wed, 17 Jan 2024 10:10:17 -0500
Message-ID: <20240117151202.405426-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117151202.405426-1-detlev.casanova@collabora.com>
References: <20240117151202.405426-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also document stable frames and what it means for testing tools.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/admin-guide/media/visl.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index db1ef29438e1..cd45145cde68 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -49,6 +49,10 @@ Module parameters
   visl_dprintk_frame_start, visl_dprintk_nframes, but controls the dumping of
   buffer data through debugfs instead.
 
+- tpg_verbose: Write extra information on each output frame to ease debugging
+  the API. When set to true, the output frames are not stable for a given input
+  as some information like pointers or queue status will be added to them.
+
 What is the default use case for this driver?
 ---------------------------------------------
 
@@ -57,8 +61,12 @@ This assumes that a working client is run against visl and that the ftrace and
 OUTPUT buffer data is subsequently used to debug a work-in-progress
 implementation.
 
-Information on reference frames, their timestamps, the status of the OUTPUT and
-CAPTURE queues and more can be read directly from the CAPTURE buffers.
+Even though no video decoding is actually done, the output frames can be used
+against a reference for a given input, except if tpg_verbose is set to true.
+
+Depending on the tpg_verbose parameter value, information on reference frames,
+their timestamps, the status of the OUTPUT and CAPTURE queues and more can be
+read directly from the CAPTURE buffers.
 
 Supported codecs
 ----------------
-- 
2.43.0


