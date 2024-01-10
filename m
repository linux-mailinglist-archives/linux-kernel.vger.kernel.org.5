Return-Path: <linux-kernel+bounces-22801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2182A30F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBC0281772
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178334F61B;
	Wed, 10 Jan 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T0yCjpjE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E14F5EF;
	Wed, 10 Jan 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704920893;
	bh=5xzC9o7ZwfdiClX7d+ONP8pEhD1E9GYUmkmkVAcMUhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0yCjpjEZbcEntuGdOJbnpHvA818RIEsBiZ2olN3DGSVUuYTCw8Dnc0T9zjaezfKc
	 WCIRfTk83m5YU/TtUeXtYh3qoy/auhkBqWg/cPDNINKwmkxVKfF1e84Ku7hacwFhjT
	 4bIyZw4mWedSLR6fHuGT/GIPXt1begbF3vanEMB2sCOHT0Vn/SVKJE9xdNP+Zbx9TK
	 Wi/skF+NcFLBZ1FkMi/vmE2mt2lKDUe3cufGBB99GdJ45KQE6vGoiz4lsUOsg9q89s
	 uoNUABJ3O9AdhLekv5ezO1b2MiMjsfdkWJp10OEZg+luSBl6lCxmT8b3A/0TyiirWD
	 zObEe1TNwBCrQ==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A5077378147E;
	Wed, 10 Jan 2024 21:08:10 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pstore/ram: Register to module device table
Date: Wed, 10 Jan 2024 18:05:02 -0300
Message-ID: <20240110210600.787703-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110210600.787703-1-nfraprado@collabora.com>
References: <20240110210600.787703-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Register the compatible for this module on the module device table so
it can be automatically loaded when a matching DT node is present,
allowing logging of panics and oopses without any intervention.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 fs/pstore/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 88b34fdbf759..b1a455f42e93 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -893,6 +893,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "ramoops" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, dt_match);
 
 static struct platform_driver ramoops_driver = {
 	.probe		= ramoops_probe,
-- 
2.43.0


