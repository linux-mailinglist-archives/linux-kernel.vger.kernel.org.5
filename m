Return-Path: <linux-kernel+bounces-51821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF9848FB3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443741C21A70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E2B24B29;
	Sun,  4 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ePzs/au5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D6249EE;
	Sun,  4 Feb 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067628; cv=none; b=TtafHKgjM/as162A/uJraamIFld80nbLyXBNYk4MXuSVGkZ9Hwsy4fvlxYdacqdVOImWlAaLthrHq7HKnOPMG6mgjNYJ/w25whH1IhiIaAXabJ7RJ09FgYEejBTv7y1vqn8gxNq/JkzxgpNGRlGOwMdH3y6YiCuzNsrCcS2HwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067628; c=relaxed/simple;
	bh=6wpOlSUJjb9Y16FHTSpbQGEf+52/IpYFTBtj/sIlmL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AVJ8NY0l8ghDqjODTS7y4/EKgB8CYdg4iw70bs7DThJ2PG2FraGfd3VWQFqNdNhGWioN/h4BsnFl2KyX0gfCyucPbtsUHzWSKzVUXEG97VGsFVyJf+WG8ahG4PQIa587+40rjYkngLFWSFP0LiwA4Rm3xEc2GdXZR1IK4CZzHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ePzs/au5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067616;
	bh=6wpOlSUJjb9Y16FHTSpbQGEf+52/IpYFTBtj/sIlmL8=;
	h=From:Subject:Date:To:Cc:From;
	b=ePzs/au5TCEzZfOgsIg5Jg675VoOf8rhc6hVAG8kbBsjNLyMTtfv2/noV8yBXwbBh
	 tb6t+saHJ2bl0gi8UrYR3Uv8Lac2tR1s8pGskvXmAe3fgFStM2dvbYYZrprlD3Wwxx
	 /G+K0v9c0X9te2P2JaJdBoFGEYpDko2iPphWGqcA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] power: supply: core: align charge_behaviour format
 with docs
Date: Sun, 04 Feb 2024 18:26:46 +0100
Message-Id: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANbIv2UC/x2N7QqEIBAAXyX29wlmINirHIeYbbVw5LLSF9K7J
 /0cGGYKZBTCDH1TQHCnTGmt0H4aiEtYZ1Q0VgajTaedcYrTgeLzxvy/VFVkRj/gEnZKm3iWxKr
 VMU6js8FaCzXEghOd7+T7u+8HaxeUyXQAAAA=
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067615; l=1305;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6wpOlSUJjb9Y16FHTSpbQGEf+52/IpYFTBtj/sIlmL8=;
 b=qlXa33twbUd1D3UPwT05217J51xiKeF+Tubfs/zdvjIdb5+Qn3f4HBw7oryM3d+iR4amGOwZx
 f5Hru5vv5r9CX4qYMVgR7XbDakPBm2YBiRVT1U4a+3phMkW0m+0iWKd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The original submission of the charge_behaviour property did not
implement proper formatting in the default formatting handler in
power_supply_sysfs.c.

At that time it was not a problem because the only provider of the UAPI,
thinkpad_acpi, did its own formatting.

Now there is an in-tree driver, mm8013, and out-of-tree driver which use
the normal power-supply properties and are affected by the wrong
formatting.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      power: supply: core: fix charge_behaviour formatting
      power: supply: test-power: implement charge_behaviour property
      power: supply: mm8013: implement POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
      power: supply: core: drop workaround for missing POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE

 drivers/power/supply/mm8013.c             |  5 +++++
 drivers/power/supply/power_supply_sysfs.c | 28 ++++++++++++++++++++++++++++
 drivers/power/supply/test_power.c         | 10 ++++++++++
 include/linux/power_supply.h              |  1 +
 4 files changed, 44 insertions(+)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20230929-power_supply-charge_behaviour_prop-10ccfd96a666

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


