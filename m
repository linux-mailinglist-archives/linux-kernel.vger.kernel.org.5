Return-Path: <linux-kernel+bounces-45275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D070842DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0876285DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C069E14;
	Tue, 30 Jan 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="FCdLf2bF"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D79DDB;
	Tue, 30 Jan 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647063; cv=none; b=B5VjpBf0dW5tEexYPXSxFM+MNqIDFsB5rrClLep/CCHZa4bi5aZn38RXEjAZZqasFOdqbZZq9Ny2FwJgXEkXzf0lqqFmuKRD9OJGPlU3vkRRs1izQ6Bi/EaFwV1tEenBpvUxL+j6eeDFbp6SW5xapo1REugMmmWYNVxxrD99Uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647063; c=relaxed/simple;
	bh=42VdHmLmZuT5O6V8Q0K2GarSQjq3zsRvTNhsMQjm5BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DRUvygh1qP6mycdWKFluM6ewOzUkhhDOUfJpMh2BaDK1By7xHO0aExO5nFLfaLPzEfUpt3KPtmSzNUTbrLsn2HA/2N6kHvoRXj/lytOm/R0GIcNoEVX7IPNH6bdOsUyhnmXe3jc4OVJFBsAH1RGzfQPdtdSr9evcWVdpM6nuem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=FCdLf2bF; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 6F80046B74;
	Tue, 30 Jan 2024 20:37:32 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Quentin Schulz <quentin.schulz@bootlin.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 0/5] power: supply: axp20x_usb_power: cleanup input current limit handling
Date: Tue, 30 Jan 2024 15:27:56 -0500
Message-ID: <20240130203714.3020464-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706647053;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding;
	bh=CnBNCViJHvy4cEKLBSR8JFJniQcbGnFyzpaAFuYyqxw=;
	b=FCdLf2bFSk3L24ys482teOv4NVoVkgp4hXsRIVyC5BUHZ8cG2nFh55b0ScOuKuZFTJvYvl
	xx6gGB7eSX+NQ5R92XAVdibbCIxBAoA0yk8f07JvMTRtTxxohiNwkeW3E7ZqJ7zYOYUDvX
	uXb6y4TWC3K6SHhtEurSClxGvtrPkZo=

Proper handling of the input current limit will be necessary to
implement usb power delivery on the Pine64 PinePhone. The PinePhone has
a separate chip (anx7688) that handles usb power delivery (among other
things), so we will need a way to apply the current limit which that
negotiates.

The new logic to get/set the input current limit, and get the usb type
is originally based on code Ondřej Jirman wrote[1], but I have
significantly refactored it.

While working on this, I also discovered that the axp803 pmic sets a
current limit of 3A on the usb port without any negotiation if it
doesn't detect a battery.

v1 of this patch can be found at:
https://lore.kernel.org/lkml/20240121014057.1042466-1-aren@peacevolution.org/

1: https://xff.cz/git/linux/commit/?h=axp-6.7&id=3dcd33dfd1ae58db159427365dcb6d0d2b12f06d

Changes in v2:
 - Values less than the lowest supported limit are rounded up instead
   of returning -EINVAL when setting the input current limit.
 - Rename existing current_max logic to input_current_limit. This also
   makes it possible to reuse some of that logic.
 - Split current limit register and bc race condition fixes into
   different commits.

Aren Moynihan (5):
  power: supply: axp20x_usb_power: replace current_max with
    input_current_limit
  power: supply: axp20x_usb_power: use correct register for input
    current limit
  power: supply: axp20x_usb_power: fix race condition with usb bc
  power: supply: axp20x_usb_power: enable usb_type reporting
  power: supply: axp20x_usb_power: set input current limit in probe

 drivers/power/supply/axp20x_usb_power.c | 160 +++++++++++++++++++++---
 1 file changed, 144 insertions(+), 16 deletions(-)

-- 
2.43.0


