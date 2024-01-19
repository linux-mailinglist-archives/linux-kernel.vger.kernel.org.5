Return-Path: <linux-kernel+bounces-31463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFB832EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EDE1F24714
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6D56454;
	Fri, 19 Jan 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Rn4mlrLK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937B3C6B9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687981; cv=none; b=p1ePCLgnvuP2Qs4zqHeg9poBadjDJpK9O0eJDaYnNfwpRQ15GE5JYw+JvS4a5GiFGkLDx0+03TeX/klHaUeuWyVmdiHOoJ04BBkOS9ceWBgQ+rpIFq7k3AuOGR4eONrb5IjCfqCirxKfcGQsuGIDgyAlc1/dO0rhnSFxwjD0t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687981; c=relaxed/simple;
	bh=qhvEmmdHG6XJFlP+++1jTmWjYBCnRGIB+7vVpzhQfvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r58nrXz3eSTVHXuykdShp0MVsaioVHFgIr67zbJzHEXGxQXd+Wr63L8s6TNui4Y7gxGOZzDgA7zazquoWOaqV/y9cLocQ5kQ7FVzYEmAm489yoHe+A2ShoF4yJX//jfqs2838eJhDM1vqol6Y35h1x/DKO8BymiUKU4tjBPERXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Rn4mlrLK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=snS3sepdCs4f30m6IiSQJtRwuG+MKNNfpUzB7tS2E6E=; b=Rn4mlrLKo/ZYehkmOop33PLDPN
	UhTix9wtq+KOdPY1ltIEEzTRN2i445FkNqJPbe65lzVHlkVGXy6yw4F0/hvfuJ1ystQ20uGwNJmw3
	iOQDBpmvBIdEpz8zjLdnXEjxY1JbZNJCxvJwBEwDNA5J2iV0WzV9/AB5OrvJb5p5w4zdjxL1GM2ck
	ZTl//TlPnWoKFvaRyU4gVNhK/6Cvvqdb4srxuaJTfU6Ll62vr34UItsdYpXiRwgf5F0UvvCKs+1/4
	oLkLiuQliar5aRo015hSSNukTtY/q+BJAcHe29J2kbzUgGRwar2/dp2uXBLg3WSraSSlcxBEPPyLp
	9OkZLP8A==;
Received: from [177.45.63.147] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rQtMD-00873a-BS; Fri, 19 Jan 2024 19:12:45 +0100
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
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/2] drm/atomic: Allow drivers to write their own plane check for async
Date: Fri, 19 Jan 2024 15:12:33 -0300
Message-ID: <20240119181235.255060-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

AMD hardware can do more on the async flip path than just the primary plane, so
to lift up the current restrictions, this patchset allows drivers to write their
own check for planes for async flips.

For now this patchset only allow for async commits with IN_FENCE_ID and
FB_DAMAGE_CLIPS. Userspace can query if a driver supports this with TEST_ONLY
commits.

I will left overlay planes for a next iteration.

Changes from v1:
 - Drop overlay planes option for now
v1: https://lore.kernel.org/dri-devel/20240116045159.1015510-1-andrealmeid@igalia.com/

	André

André Almeida (2):
  drm/atomic: Allow drivers to write their own plane check for async
    flips
  drm/amdgpu: Implement check_async_props for planes

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++
 drivers/gpu/drm/drm_atomic_uapi.c             | 62 ++++++++++++++-----
 include/drm/drm_atomic_uapi.h                 | 12 ++++
 include/drm/drm_plane.h                       |  5 ++
 4 files changed, 91 insertions(+), 17 deletions(-)

-- 
2.43.0


