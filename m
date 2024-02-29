Return-Path: <linux-kernel+bounces-86224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1986C1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C3D1F24B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FF46452;
	Thu, 29 Feb 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccKiWFZL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BB44C67;
	Thu, 29 Feb 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191179; cv=none; b=THhVetIzBMc4uKblsaWrojMT5qfs5VHec/P5lXwiyiiAlwiCBiHgUTmWKyktyjvE78huR+K2f3Eow0bupWL5kjoXyd51l9MtT+LS8kVLyaoJY6+OgVQDmCiYa35dG3TWxlEn8myO3VHvdczhF15IS4M27Ax5vw1dGrVNFQqChaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191179; c=relaxed/simple;
	bh=YBbHi68ekL9P5oNGd7KlhsIkC3X05NvW3icD0z4OX/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0pC00HZCTZ+N/aYYtB9Zr35VfGd4NPLhaSIUTdELzSOwSucTYaWn6CNqwSoIu0DUgcTUt8qV0V1Z8Nt80XPBg/hILA2JB0DtoMKbVl+PcryuNzPHEApC22xnlE0zgem4q0Lvot7kjYFPGXBOuYHp3HxeEZ1tyNAXPOiKNPHu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ccKiWFZL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sVeHjOF3s61YXQA8x4PJM0G1Fv6dbkXZ8N0N3CupNdk=; b=ccKiWFZLf0seg40mSGs42Mh+a2
	XbBeShXiiJ9qTyRl5N6i6PDeK5Q817KxoyiQqGsKTHiGp8HaDrkXbVzv4v7PuQbJQhtsupHdDh8jW
	6KmTSp7keQzqMe9VEhQrniOKOojN7xDprYfDSsB7OtQik7B4LUU9S7Q8njgkwbWOQ8r/Xgn61opVQ
	hWWNgywCGxYyqHthemsvfwcpCb4gyNOXkZ27aJh5iiuk474oGyN9kTY/O7gitcqJf0KEhZKdSP+u3
	OAi5Sg/13bUgAh2aj8tLVoCEvfbCZQywH9srL/6QWWu/GyHAfRNJmo+9dmvZQQ+3PnscLpRUfUEue
	8BvqOdUw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfahb-0000000CRbT-2j11;
	Thu, 29 Feb 2024 07:19:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 3/3] leds: mlxreg: drop an excess struct mlxreg_led_data member
Date: Wed, 28 Feb 2024 23:19:31 -0800
Message-ID: <20240229071931.7870-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229071931.7870-1-rdunlap@infradead.org>
References: <20240229071931.7870-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop one struct member description to fix a kernel-doc warning:

drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
v2: make the 3 leds patches a series as requested by Lee;
    make the Subject better/unique

 drivers/leds/leds-mlxreg.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -29,7 +29,6 @@
  * @data: led configuration data;
  * @led_cdev: led class data;
  * @base_color: base led color (other colors have constant offset from base);
- * @led_data: led data;
  * @data_parent: pointer to private device control data of parent;
  * @led_cdev_name: class device name
  */

