Return-Path: <linux-kernel+bounces-52053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29350849379
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0BC1F21146
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E2BE47;
	Mon,  5 Feb 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="saBm3e9u"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE04BA28
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111666; cv=none; b=BOPd4m/dCp97F8n2zyo2NBNVUzOh2MLGh3szWg6kbDFBLs8U3kJGPPlZEdOybgEPdduFaQoPEh6bEZvEozNyUhrfatryXTCnonUeAgZooz3cl/X5zeVOnjtAZXDVvEJhr/PidtrbgJjMxjUFmr65vNbR+dBD6r1gVRZOkcIfS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111666; c=relaxed/simple;
	bh=GtIQt3HoLx2kqnhCVHhJstG+Wvwf1XNCGTYHKYPnQO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXa+uAjj1y3NPdluYRnCnVFZDQ9ul904Ehpm7QJruzOkimBTSPSswVG4HiMOqW4nBy6ekUbvUSE30pFQnPt19hO9RdiB6ahnm3LLI6/pjYa406Nu3hQFUMfzsyoJ5CLRzTGLxK9lfNYq2mLP45vqzOyTzBXgbnm0BexlDYA36Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=saBm3e9u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rtk1/1Oqfan3c3AyvrsnNRZo+2UCl3bzkD+9KBjYrMc=; b=saBm3e9u4HqxkJQ7SSjNaKcPn1
	bqQmT3CM2JwC7i/jn13A2Vn3tp+e42Em/Q2Q3k3idLpMXDyliuBPDg7sXHrChu7vtJgORRuWAN5jC
	RgiTy5WNjA62ZRCx4qyLTLCCZuSaCqfN015r5wMxnDbDBqgyIPxUWy0E3HWW5ADv2kyOpGxtJMphD
	GceDoNbACxn11c8W1CUH2rMhTbGl3/W958nLQdcElp8INVfTY1dGYSjWxy9qUKSwHEikRGdEd3yId
	tpP0YfuIU3vnCxvve24e5j3wL6EjM36c3G3tc2MOjtL9MG3ujNLV8zdNUUx4I4tFtVnzSqAu7ZqCV
	Nm8L0TQw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWrj3-000000025xu-2ggJ;
	Mon, 05 Feb 2024 05:41:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simon Ser <contact@emersion.fr>
Subject: [PATCH v2] drm/rect: fix kernel-doc typos
Date: Sun,  4 Feb 2024 21:41:01 -0800
Message-ID: <20240205054101.27929-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct typos of "translated".

Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: add Reviewed-by, rebase

 include/drm/drm_rect.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/drm/drm_rect.h b/include/drm/drm_rect.h
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -129,7 +129,7 @@ static inline void drm_rect_adjust_size(
 
 /**
  * drm_rect_translate - translate the rectangle
- * @r: rectangle to be tranlated
+ * @r: rectangle to be translated
  * @dx: horizontal translation
  * @dy: vertical translation
  *
@@ -146,7 +146,7 @@ static inline void drm_rect_translate(st
 
 /**
  * drm_rect_translate_to - translate the rectangle to an absolute position
- * @r: rectangle to be tranlated
+ * @r: rectangle to be translated
  * @x: horizontal position
  * @y: vertical position
  *

