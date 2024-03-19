Return-Path: <linux-kernel+bounces-108228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1799088081A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E5E1F22D35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294015F87F;
	Tue, 19 Mar 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CtbjiIZZ"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C61E532;
	Tue, 19 Mar 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890227; cv=none; b=mBBNba6+di33sYHjuct6MHYIg/SpckJR9ENBBVDsgyUtnmcZLm1h8AzZmAQPjJLNoGF8/c5OPv5Zla8hv2MFRnBN340d16rTXaBDkF3DJt+RwXu/i44k5WwPY+y9w5GqXsWUykBev1kcTgaghjSbe6JUfvqSLUzUSO6du4hSGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890227; c=relaxed/simple;
	bh=BFzKvRGNRoiy2oC6xsZEBAKqCMoBrZ+wlOEg9IuwYbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx1SJu2pGTPJrVTFyY0372PwklqFeFXQHCMfRe8zSd91hqBpEqc3ys6rRL6DfmlJwqG4WJeehNOIpDXANVbzPbUk+56asVowSW/F2v5fWf2AAFKgJLG9vLqOJCwss3OUkZ6MTpMIuXiCvOkZpjofTZpOM/jIDWyyc5I0F03jdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CtbjiIZZ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [85.89.126.105])
	by mail.ispras.ru (Postfix) with ESMTPSA id 87CB640ADFF1;
	Tue, 19 Mar 2024 23:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 87CB640ADFF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1710890213;
	bh=bK361IhiE+XMAZTsxOEj0ZXg25Ch4uk2S2o4xZFwevs=;
	h=From:To:Cc:Subject:Date:From;
	b=CtbjiIZZOBd/GIX9iUGfUhyJyEejdhVoS+R3KZqQ1kwulOhDw75ifvkprBVahyjo9
	 ySOicKeGkCeYiVlww9iC1LWARppBVUfG6iKNM33C4Y2Pgm40ivwWZP3RpQ6duQe6zp
	 Tnqk22FtM4gyFlLElMgNzkvPkl0ckh4j4niFs0ps=
From: Pavel Sakharov <p.sakharov@ispras.ru>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pavel Sakharov <p.sakharov@ispras.ru>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Arvind Yadav <Arvind.Yadav@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] dma-buf: Fix NULL pointer dereference in sanitycheck()
Date: Wed, 20 Mar 2024 04:15:23 +0500
Message-ID: <20240319231527.1821372-1-p.sakharov@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If due to a memory allocation failure mock_chain() returns NULL, it is
passed to dma_fence_enable_sw_signaling() resulting in NULL pointer
dereference there.

Call dma_fence_enable_sw_signaling() only if mock_chain() succeeds.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>

---
 drivers/dma-buf/st-dma-fence-chain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index 9c2a0c082a76..ed4b323886e4 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -84,11 +84,11 @@ static int sanitycheck(void *arg)
 		return -ENOMEM;

 	chain = mock_chain(NULL, f, 1);
-	if (!chain)
+	if (chain)
+		dma_fence_enable_sw_signaling(chain);
+	else
 		err = -ENOMEM;

-	dma_fence_enable_sw_signaling(chain);
-
 	dma_fence_signal(f);
 	dma_fence_put(f);

--
2.44.0


