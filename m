Return-Path: <linux-kernel+bounces-155042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32E8AE4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE861F204E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55813DDA3;
	Tue, 23 Apr 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kckn1+TF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09313D8B1;
	Tue, 23 Apr 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872453; cv=none; b=ZpUL09OffylU7V65wQ8zDDCm+Jjz0A7zMCk4xkKHQ98pmYudm6WqSRN3O/rXfuJeukUhX/rN9j4T+lUZXlHpMudHIR9EGoQamtqCe0Q0Y9Kerm2/dBCHg2kxkNWJMFfi+p2wNLx0lf60WH4dhtdbdF1mJP+lmgfXNm7SpHUP/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872453; c=relaxed/simple;
	bh=F5YyWvdNkv8DKw0T3YI20djvYl+RtxbGRqQQS14nsNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/E+puHQvaJUfKY/izN2qo22oP/zDDQ2TXOvSt0iDFIIocC0ZDY30hi4gVpGOwvbP6CQXF10tOlayPpiJVOFIKjw3yLAEv0JGVxmzTpc8JFFUDE4DrKmcD1Q0xzcXHnClsXSH2z0louZgo5k+Co45F3AhMzlQxNO0oHcJPIh/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kckn1+TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEA9C2BD11;
	Tue, 23 Apr 2024 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872453;
	bh=F5YyWvdNkv8DKw0T3YI20djvYl+RtxbGRqQQS14nsNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kckn1+TFznkwbzHSn9b8SEuqXxSUHLdCFJ9DIckD1Nm1ln/ymm9jEuKPhZVPqXG+8
	 XeDgiFxUnCqZiFAPle8jA05j9u5CMTcCj4V6u87+T6kMSCqoTA5nNgP0u0EDjXi/VG
	 dJWmRaLM5Rai0oUjrWD3ZGLQlPcUAdkv/+g/rA6rvokQsRCexIaW8kxBYZVMvf1Bt4
	 50zuvGxXgGixmhHfqcN6yq3TAN5kRk1cD+uVmoPDMwv4dKsuXz43sunD8YQ/mnvQg6
	 c7He5CodDZ7cQFQl9YInAJII1+DlPKNsVx974nK/PjfooQvc0vMTemPtvEFcsgmG9t
	 te02n4pBHNomw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Kees Cook <keescook@chromium.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/16] drm/radeon: silence UBSAN warning (v3)
Date: Tue, 23 Apr 2024 07:01:47 -0400
Message-ID: <20240423110151.1658546-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 781d41fed19caf900c8405064676813dc9921d32 ]

Convert a variable sized array from [1] to [].

v2: fix up a few more.
v3: integrate comments from Kees.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com> (v2)
Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: keescook@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/pptable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 4c2eec49dadc9..844f0490bf31f 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -424,7 +424,7 @@ typedef struct _ATOM_PPLIB_SUMO_CLOCK_INFO{
 typedef struct _ATOM_PPLIB_STATE_V2
 {
       //number of valid dpm levels in this state; Driver uses it to calculate the whole 
-      //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels - 1) * sizeof(UCHAR)
+      //size of the state: struct_size(ATOM_PPLIB_STATE_V2, clockInfoIndex, ucNumDPMLevels)
       UCHAR ucNumDPMLevels;
       
       //a index to the array of nonClockInfos
@@ -432,14 +432,14 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[] __counted_by(ucNumDPMLevels);
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
     //how many states we have 
     UCHAR ucNumEntries;
     
-    ATOM_PPLIB_STATE_V2 states[1];
+    ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
 }StateArray;
 
 
@@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[1];
+    UCHAR clockInfo[] __counted_by(ucNumEntries);
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
@@ -460,7 +460,7 @@ typedef struct _NonClockInfoArray{
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
+    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
-- 
2.43.0


