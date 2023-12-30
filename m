Return-Path: <linux-kernel+bounces-13328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC1820399
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B8A1C2129C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709023AE;
	Sat, 30 Dec 2023 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="E8QScfN8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9215B7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911895; x=1704171095;
	bh=Bb2hc/iRnBAHpF2TK4kdPjCrMxFKX5qQZIMIQTkGeCc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=E8QScfN83edDrT6Vr12+bVBQzHTeJz5l9FdscK4pWbEk7slPLj12cXtVuuVtgnrlm
	 tcrLdx/Svz7f/zqzStOCuEAEuvE0J75DVnaT42rEgjQN1Ip/iFWyM0ExSmeEF5nDwy
	 fHgrBRQtnFa5UssysBN3jB32rL4iy9Hd4HFHd22AoPUtaLdsjoJGieEmGe/Gbz/f28
	 DOzlrnGSOTS1Lkyxc3lm/zDXKnwzk4WtyAwL/G5xmUO+Rbe3ACxAe9xIzoQ5iWF6Z+
	 z4+M87rWxOKt3tgOlzGpsXG0DKhrI0DYf8YjJ6rWxioDmPcmkEv52zPzSTZvwBkN9j
	 rMAwc/AUA71JA==
Date: Sat, 30 Dec 2023 04:51:23 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 0/5] wifi: b43: Various QoS-related fixes
Message-ID: <20231230045105.91351-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Recently acquired a MacBookPro8,3, which has a bcm4331 card. Noticed some i=
ssues
with the wireless driver, specifically related to QoS, when using this devi=
ce.

Out of the box, applications like ssh appear to not work with the device wh=
en
QoS is enabled. This series attempts to improve the out-of-box experience w=
hile
cleaning up some fundamental issues in the driver when QoS is disabled, eit=
her
by the related kernel parameter or the newly introduced QoS disablement
function.

Running FW 666.2 during testing.

Log:
    [  +0.169771] b43-phy7: Loading firmware version 666.2 (2011-02-23 01:1=
5:07)
    [  +0.249032] b43-phy7: Loading firmware version 666.2 (2011-02-23 01:1=
5:07)
    [  +1.394130] b43-phy7: Loading firmware version 666.2 (2011-02-23 01:1=
5:07)

Rahul Rameshbabu (5):
  wifi: b43: Correct OpenFW QoS capability warning conditional
  wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
  wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
  wifi: b43: Stop correct queue in DMA worker when QoS is disabled
  wifi: b43: Support advertising lack of QoS capability

 drivers/net/wireless/broadcom/b43/dma.c  | 10 ++++++--
 drivers/net/wireless/broadcom/b43/main.c | 32 +++++++++++++++++++-----
 drivers/net/wireless/broadcom/b43/pio.c  | 17 ++++++++++---
 3 files changed, 48 insertions(+), 11 deletions(-)

--=20
2.42.0



