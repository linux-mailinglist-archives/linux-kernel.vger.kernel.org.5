Return-Path: <linux-kernel+bounces-15581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1E822E69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83DFB2355C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41019BB1;
	Wed,  3 Jan 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L0+xittV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DAD18C1B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDCCF975;
	Wed,  3 Jan 2024 14:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704288656;
	bh=/a3FQfU+ot843llE5YtaY8TVMQkIl+uXFLMym5WrLkc=;
	h=From:Subject:Date:To:Cc:From;
	b=L0+xittV+g1SMEGY6VCqPfxbAmv8Yjh8SVBo3bIuwtlCtQq3mFpFlsKBrzbxKgRlZ
	 qTlBuN7Df7DEMZ16HKe3mOTI+44Onn5z/X6G3KSYPXontCkm7zQVOgtwu1rJ8Z4FTP
	 uj9bM6eJU7VACGsNdz20VfjZa4fPnhqsdgvizpDY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm/bridge: sii902x: Crash fixes
Date: Wed, 03 Jan 2024 15:31:06 +0200
Message-Id: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJthlWUC/x3LTQqAIBBA4avErBP8q6yrRIvKqWZj4UAI4t2Tl
 h+Pl4ExEjJMTYaILzHdoUK1DezXGk4U5KtBS22lkkYwjVIncVBCFrZ3flCd2Rwi1OWJ+Id6zEs
 pH1RZNU5eAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Boris Brezillon <bbrezillon@kernel.org>, Peter Rosin <peda@axentia.se>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>, 
 Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nishanth Menon <nm@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=558;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/a3FQfU+ot843llE5YtaY8TVMQkIl+uXFLMym5WrLkc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBllWHGuUT5WXW87Ha/0sIaEz8Jxs1wwJLLTOz6X
 Qm42BYATz+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZZVhxgAKCRD6PaqMvJYe
 9fyoD/wIgLOvxYeFfGb9xeWdoQKzvcIVHemlkNk39Iyfxwp+2cF0zcg1LTImtXusDiTq4K9gSpR
 R8nGJHevGseUJVxeOKZDdIfJdW88oJqF8c1e1+oaAJRK8TvqoIheyo153EgdBEVuDH2buE3O5A3
 QxNlP4Btw4ItnfAeSD3pFgumzhy1ZTsu/yONALYjOPNrctAoVN23lKC7DN34WlG8cJEwLH//9iV
 PRjGPtG407TkwUJ3lCBkGQ4dM70WaPhDsuQYt9W4MUamedz/nVx/9zG8C4JJ9qJZGRvpw/2Hk6P
 tc9oULoYIeooWNqtw5VxOt7C2cNvUpZBCtmdzZVe123W+QZOCB1EVwei5zVx5X4mquYQUFrrV/e
 P0N8qAxsWrwaNZbuvW8NfhCByLU3Q4LOB92uDyOcN4RbQZDeHs3dAxmUGXq2J1qEpirIqfhXt/j
 NYtRXWc8ZauevXpeLaD39eA4kP6hJEPH11QVsQtbS260YPY+1NAofaf2UMl78JGfJ7fVH7mgpxJ
 GDAvjPzZjkAydJWnkc5vkZAkfn77LfIJhEQ199r6rL73KxtI7z8BNbOTrCTYw2crKaJ1gUEZ6vs
 SiTh1iCMtH73BGhZjHSt5sM4UrCtk9yWJuDaDZVYN31/A6esj6xqE+pbQ0050mz0MscQGR9V+jf
 LVKIGXXVmeFMD0w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Two small fixes to sii902x for crashes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      drm/bridge: sii902x: Fix probing race issue
      drm/bridge: sii902x: Fix audio codec unregistration

 drivers/gpu/drm/bridge/sii902x.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)
---
base-commit: 0c75d52190b8bfa22cdb66e07148aea599c4535d
change-id: 20240103-si902x-fixes-468d7153b8ee

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


