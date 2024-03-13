Return-Path: <linux-kernel+bounces-100954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6787A006
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A001C2214A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F27818;
	Wed, 13 Mar 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/vHl9zb"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB2383;
	Wed, 13 Mar 2024 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288791; cv=none; b=uw1KR/Qh5i8iofMfP3/n0J34eBLsOmT1Hc1mLRQx95RowfHl387LQOTa/MQe2J+lRFYdP11cCb74zUyiO7O3fqW8u0V7EaZ0zjBZQyCarprQhekryaH6mk7oSHpn/GEkXQRGjbSqmPGAevwfOEvqXy+zHmK3iVDHEjOIF/ypSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288791; c=relaxed/simple;
	bh=A9kOC1slsnVJaeITuIzwuSjDlo6jbDc0WYt2FwZ/9AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XafQodnQvPSZ4Qy+5IekdbfdAyKaumXmAk0pHdJVILQRpB35RgNmIk9eF3MIgZfVZf+W3+hSBrEhwciXT589NOSOGsGqOAVRod1wTwVSxGzf34OPIiNSMOaqTZtIOnrXcxtXgGg3op53zYIk2XRco8cBMQKySkng3mPPW3FXFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f/vHl9zb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Aq/qe/UqYnh0Tz/4wphtq/tI1WEKyfaTtB+iYz/Zxi8=; b=f/vHl9zb4QoIpv1AomINljXGuR
	b46V6c2lZIF7KFofUVOzFleZWKssFMm2nTIJEukfoMmQVG7KZ9OSCfgjHAunOiIjkNUXjcUlziqJh
	G/LvI7CL1B6Nbzhqv9Y5J1yqsAdaymvfJVMh8Zu7Mj3U1l+Q51TTExUkN7RNATJRDJLfz84sti9Ui
	dFsx1IGGj6LbdwoPS+Lfa3TwQDQ+m0COHysc01BOkCEgcGzu0kxhBBISv/zIYQxcBYZbD20xdEp8t
	n/Y3wx51EWCrTv9G4khi6qRmi85BgB7HdvbskBKlVVkRoTmtMSHTM25q0qvAGj17jIv/4YlDX1E1X
	8sW5KSRA==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkCF0-000000085a7-0oG3;
	Wed, 13 Mar 2024 00:13:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	llvm@lists.linux.dev
Subject: [PATCH] ssb: use "break" on default case to prevent warning
Date: Tue, 12 Mar 2024 17:13:03 -0700
Message-ID: <20240313001305.18820-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Having an empty default: case in a switch statement causes a warning
(when using Clang; I don't see the warning when using gcc),
so add a "break;" to the default case to prevent the warning:

drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]

Fixes: e27b02e23a70 ("ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403130717.TWm17FiD-lkp@intel.com/
Cc: Michael Büsch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: llvm@lists.linux.dev
---
 drivers/ssb/main.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/ssb/main.c b/drivers/ssb/main.c
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -1144,6 +1144,7 @@ u32 ssb_dma_translation(struct ssb_devic
 				return SSB_PCI_DMA;
 		}
 	default:
+		break;
 	}
 	return 0;
 }

