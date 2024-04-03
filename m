Return-Path: <linux-kernel+bounces-129293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E959789684A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9555528D86E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96912A14F;
	Wed,  3 Apr 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPo1hZbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF91272C0;
	Wed,  3 Apr 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131800; cv=none; b=CBltegfnWOjPxbtGN/ycuT93XE81F8XBRu7aaGoQmMT3wDFXV9cNrVAH2H8Du95Lsp5UvPs5ZytG9AKcMPgMnLUynql+6o62t/RwtlW8q3xv4syNX7MqP/nxtS1Jl1GR3ei/czGrI5n0oZPRiMvs1u3zr4RB01IKUzVF0NQ3DrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131800; c=relaxed/simple;
	bh=pX6dYyDPlq8hzzGWYPenFWRCC5RcIISkFIbgpQbdAic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUJYNYuiFsQhY9ER+aZ/AYNUV5cPB0puJ4a6VKowCqrJB9nIRDNKfB21ESMCMYx0CPB6ATSKrTBrEpurnZaioSws7RPJk6RmxmI4ibrL9s7P3hTArKBkDZGlgjtuKj+Ja7jCtysio4w8Z9iUbUetJTrFQ4ZQp1HlixqKkFI0bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPo1hZbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDC3C433F1;
	Wed,  3 Apr 2024 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131799;
	bh=pX6dYyDPlq8hzzGWYPenFWRCC5RcIISkFIbgpQbdAic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPo1hZbHq1OpuLsc+XNRFuEVSBFO6Rg1j5p54Ljrc1DIZRdU00w+JzXqBAN5oR7sv
	 2r8JjHioIIiG7s34QrVMlnAOW4YJ3h5WjcpBFMW6Xy0tEycOcCgsCm0EUgTer2XPuI
	 UzAgPhvABQpHeDKIoDqQRXUoaf60SJZB3OVs3eXhwTDbFKYQK/vcn+r9C5pO58DKj0
	 nF+IMOoUiVvhaKQfhlUj00v9j1ZIyd3Uu8RKFFrC//bgjOuRjf3nphvEBKyFYnjThK
	 JJjI42L6HpHSHGNKZQdRsSi1Ny5jcIF32hE8AmREWRfmM/SPffGCiJEMfvRxDJpxay
	 3f16whpPww5qA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to platform driver
Date: Wed,  3 Apr 2024 10:06:34 +0200
Message-Id: <20240403080702.3509288-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When the driver is built-in, 'make W=1' warns about an unused
ID table:

drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
  866 | static const struct of_device_id ad5755_of_match[] = {

While the data is duplicated in the spi_device_id, it's common
to use the actual OF compatible strings in the driver.

Since there are no in-tree users of plain platform devices, the
spi_device_id table could actually be dropped entirely with this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/dac/ad5755.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 404865e35460..5c1e7f428c25 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
+		.of_match_table = ad5755_of_match,
 	},
 	.probe = ad5755_probe,
 	.id_table = ad5755_id,
-- 
2.39.2


