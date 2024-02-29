Return-Path: <linux-kernel+bounces-86222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3E86C1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2604B1F24B74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0C44C9D;
	Thu, 29 Feb 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heN6FNVU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55644C62;
	Thu, 29 Feb 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191178; cv=none; b=QF/hmIoGCSys1vdZSn3SRs/6nH1CFbi6hzBskw/cY290ICP3q/epfWcVjgRDHQ6eYCBvsD62n7fGJBrgOWda1jjbhpTip5kynTcBiMkINzeLhae0ELjIZol7Wpo0sBY45g4rA5JJLYiqPLmZXuFjzBOhvSZ1ioxx65qy3FeOx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191178; c=relaxed/simple;
	bh=Znyef0w00wFhrFfOangTwrEShTAAZ9j4c+Qy3tm5Pho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzjO9iRvN9hOsqSTnU4y31L9d9JeHmBNPvg5pdJkXka2MntclDMPBRSdZnm+bGjzdkE+arkXfc3VLNMQZzbM/ftXWM6PGZySz2IJe8cti1iAIv+U8UKZgvsFGvGMSBuvwFl5/ZaTKcDq8chVuhOx0IhbZ/zKwcCGVuRCq98w+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=heN6FNVU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ygama+h1D6ZMT3In11w2DYFC+Ygt+wGjnAaK2I0y9rM=; b=heN6FNVUX0cTwhasrYNlknUpTh
	c4Z4JgU8kzTNNYRzsROAkQ3YIHO2WLJMTv6B9pf+i3Ipz8DF60ARNS0/jhutErbZAmVsRcgaJwsuy
	IiXbEjjgE0kCOlhPxLnS0fwjM53z/9bMe73kOSXfAq+Ql5JYwK1EkwAaaVvhpO9urP0U3qDm4T/Rv
	RqPVuVIw1rZZ8obsGLTwWnhs4VG08JF46yww2sccjuAkBZR5eG2dDA+zagryWHB1Bnm4NdFIJBn3M
	+0zF3IvTz4uLMHGX61vnNQrloSDHBSHrirI37w4ijV/pMED/HyBOlILD07FMLcP02Mn92pct1pgBJ
	qtXJPqdg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfahb-0000000CRbT-1bIn;
	Thu, 29 Feb 2024 07:19:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 2/3] leds: leds-mlxcpld: fix struct mlxcpld_led_priv member name
Date: Wed, 28 Feb 2024 23:19:30 -0800
Message-ID: <20240229071931.7870-3-rdunlap@infradead.org>
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

Change "cled" to "cdev" to quieten kernel-doc warnings:

leds-mlxcpld.c:86: warning: Function parameter or struct member 'cdev' not described in 'mlxcpld_led_priv'
leds-mlxcpld.c:86: warning: Excess struct member 'cled' description in 'mlxcpld_led_priv'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
v2: make the 3 leds patches a series as requested by Lee;
    make the Subject better/unique

 drivers/leds/leds-mlxcpld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/leds/leds-mlxcpld.c b/drivers/leds/leds-mlxcpld.c
--- a/drivers/leds/leds-mlxcpld.c
+++ b/drivers/leds/leds-mlxcpld.c
@@ -77,7 +77,7 @@ struct mlxcpld_param {
 
 /**
  * struct mlxcpld_led_priv - LED private data:
- * @cled: LED class device instance
+ * @cdev: LED class device instance
  * @param: LED CPLD access parameters
 **/
 struct mlxcpld_led_priv {

