Return-Path: <linux-kernel+bounces-1322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A41814D65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D1F1C232DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C33FB0A;
	Fri, 15 Dec 2023 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mWcd45+X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC593DBA7;
	Fri, 15 Dec 2023 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702658694;
	bh=Nv+IV+YSuDhGHdPzPSPBxi9UyOR7ZCJuKFQHHIDTm84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWcd45+X2WTCtklfpOHASYBdIDtKwHevwVqabCmBtrtOOHZC3BoDH44B/HyuLf4Kz
	 nIP/li997kYb9lIrU0Cm8+2SpE/mQIHRIgHWVmuhOkX5pJV8MkjxuIwZHCewd19jkq
	 7quH82RtplF6qubTjCJVfThcGHqanTEcj3ajVM7ieFG4zCqVBBLe1VHFzCGVhJuFoV
	 /7Jm4q4YgUG6wK8IhUlaxSGIcOs9vTn76s/sJMqSXCvQ1tm4rWlWe0D3WX7NG+w+Sf
	 CSydr8wcNiHYK1quojrtjQjqkXiYQDmUB65I3zQcaMpxNj3Uz8+fcKqTIzMD9jx2SH
	 CYgphNuJ8WiAw==
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A5A53781FE7;
	Fri, 15 Dec 2023 16:44:53 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 3/4] doc: visl: Document tpg_verbose parameter
Date: Fri, 15 Dec 2023 11:42:57 -0500
Message-ID: <20231215164447.743787-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215164447.743787-1-detlev.casanova@collabora.com>
References: <20231215164447.743787-1-detlev.casanova@collabora.com>
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
2.41.0


