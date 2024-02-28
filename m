Return-Path: <linux-kernel+bounces-84807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C936686ABD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AD1286268
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2E37169;
	Wed, 28 Feb 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="N7XJfSGv"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF5364C0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114648; cv=none; b=fuEk5RJf0sujxtbDCd8QGCZrobIBo0yK5fswBtTzbzSN0hdadBSdUPJ4aImIT5bjDQmS2mUxqJyB5hSvocJoHOMlxM/cscrGXgoV5Dht4GM1NNRStnjJW4sH2NSCrLSqYQ01XopvApbQX2cix1EE+8lkSl8Zv/C8zRAG01Ls2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114648; c=relaxed/simple;
	bh=KQzzUhLT/q9KbVtq8OAn3e60tMLMhyaDIKLmaNMeNN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwqVF+Vp7wHyIahQgsKKi/P8VrAYd6JHNXM9vJLvqdnkNYRKP1KwnMk3ojl/uXKfCcpC+FLgvl8SFd2pywyo/BrgBQfAzQqEQXHIViHB7ZoWipYCP3dO7x4yzg9WCCD8r3nZKTEUY5O3VHhQRVReUkQoeniZHyaZUmjLmNVNgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=N7XJfSGv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=rDq91xwkdeBq+p
	oVwEnDTvivychr45vA3bZxWuSbk7g=; b=N7XJfSGvkmJmWbKxaWscPZOpHc4+QO
	6D3dbNNONjAyvRDPFam8H2yUdSC4/afPOW0KWMmYfX9wEc+E7wnIvyNRlrWzWxZb
	wytxOaen9+3EeuLvKwkhGfgzivPanwwU0IKmZVbwkvWrBo/+tmPTuQ6671MxFn8S
	mbC3nPZqN+HBy/vW+9EfSmn1+y2sgoDwSSnfJ8WPTQ2CotaHbbWuO14LWRGRk5cQ
	Pdd3y5Qpqlvk5LgJYrVsl5tvApAkhjDYyJrysnDn+GowpscN+Y6Ts2VpY/jgwqKl
	M5xdYJw747B/9HN/Vx3M8l97pUBPfslRtdgCitq/CWI8olUTGqHKQ9zQ==
Received: (qmail 1906275 invoked from network); 28 Feb 2024 11:04:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Feb 2024 11:04:02 +0100
X-UD-Smtp-Session: l3s3148p1@nlEfQ24SbIMgAwDPXyvUACsbJ+4rxOVH
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFT] mmc: tmio: avoid concurrent runs of mmc_request_done()
Date: Wed, 28 Feb 2024 11:03:45 +0100
Message-ID: <20240228100354.3285-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
outside of the spinlock protected critical section. That leaves a small
race window during execution of 'tmio_mmc_reset()' where the done_work
handler could grab a pointer to the now invalid 'host->mrq'. Both would
use it to call mmc_request_done() causing problems (see Link).

However, 'host->mrq' cannot simply be cleared earlier inside the
critical section. That would allow new mrqs to come in asynchronously
while the actual reset of the controller still needs to be done. So,
like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
coming in but still avoiding concurrency between work handlers.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")
---

Dirk: could you get this tested on your affected setups? I am somewhat
optimistic that this is already enough. For sure, it is a needed first
step.

 drivers/mmc/host/tmio_mmc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index be7f18fd4836..c253d176db69 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	else
 		mrq->cmd->error = -ETIMEDOUT;
 
+	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
+	host->mrq = ERR_PTR(-EBUSY);
 	host->cmd = NULL;
 	host->data = NULL;
 
-- 
2.43.0


