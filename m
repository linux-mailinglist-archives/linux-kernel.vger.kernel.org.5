Return-Path: <linux-kernel+bounces-129668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D237896E46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B77E28F2FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82031386A8;
	Wed,  3 Apr 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2vn7QmH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AB142E75;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144093; cv=none; b=CJOevTUBWGvdcwGEmvg9ZWyUNgyO0Ir5O8DsraUA5K2J+qCj7I1JrdUMYTz5Yo5cTS7tOnpp7RmntUcqIPGngM+rWQhNg5TQaV5iCe9DrEAwnt8B7cbcopAD8hoNwJgKZy7n5IDN+K0+E0Xus0RemSSnqUvvNe+YjdDcATdn17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144093; c=relaxed/simple;
	bh=9758iPN/JC97kvoDw1mamVXOKflxBHmJlpHg9S7rrE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5b/BT26Jg4v+QVSot2zXezXUM1nAVTdpeUF0GV5s91JmioPiEZ7ddZgRPGJLoG9reSt3pBrvvkJbDFcUWywvhL0otl33TBObNbDVp5wRV4JwiLnJmJ/50XMjir9ZQKuQiQU6ouhqt3U6Ea7s3Gnvt8ZpsHV8kJ6jVDa+H033Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2vn7QmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2BF3C433A6;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144092;
	bh=9758iPN/JC97kvoDw1mamVXOKflxBHmJlpHg9S7rrE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f2vn7QmHwXQ8S+xD1N0fPX0NzPWSSvRNLF5lINARbs8A11BBpw0JH5Z/OUm2tJeRm
	 gj3sdslr/9HBzxOPQfGTSJuRBfDRJek83Bh9a5DMjDbcisARDNrCYGubU5ushMnTKN
	 7YtBu13wzUeN5s5bnYtInW/9FgrlhxF2mwyDPMqnt7gDBw4FkMAbTlxxaYzQY4c9VY
	 fRTlctlooO1tLICiEc1XAEjQc5qqhBBqxtt32gNd+89mdC5j7VjcP2Cc0ycDnSWYY0
	 q6Iz5LkrkkJ9ieAIw8/eA6MYepbpp9DI2keIQtfrCh8AuZOBSh1Sh2FlhOOBd5Rhq+
	 v/GSRVWr0r2Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B586DCD1299;
	Wed,  3 Apr 2024 11:34:52 +0000 (UTC)
From: Nikita Travkin via B4 Relay <devnull+nikita.trvn.ru@kernel.org>
Date: Wed, 03 Apr 2024 16:31:42 +0500
Subject: [PATCH v2 3/3] thermal: gov_power_allocator: Suppress
 sustainable_power warning without trip_points
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-gpa-no-cooling-devs-v2-3-79bdd8439449@trvn.ru>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Travkin <nikitos.tr@gmail.com>, Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=nikita@trvn.ru;
 h=from:subject:message-id;
 bh=gQ/lCJyqNkEYXe64V1azuLWqhZDrPtWfWIzY6a+krrM=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmDT7a1s4sHI60htO7JPYtLc7eKRvDv6ApO1t84
 n+JQrinvFmJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZg0+2gAKCRBDHOzuKBm/
 damjD/9nikGP8u0SyJYkb8/hRI+pmOTDJA6BZr9vFr3xFe9n8VUXi/uAQCG6N6g0/DMZZe1wHwD
 n7SObRXMQBQ8p6G7XxIbkEKqVyQgczzrt2q878TJ9utGt9JTGSlSKKVnslumOQ5brXm9Ykywd9D
 S+O4JveQ5TS1yFPEb4y9G/Y9BmP/URNMt2Y1smsu4E7PwbfFylfM/UUv30MhfXMK62wgQ9lecmf
 lj4KPmxY0DkmV5LTOZDB0WLz75bHQ/7z2ubYtv8FCZJHyZjIVeWCjr7XxDz7fmb2tZc1nmuEZAG
 zdSWk2wr3i/4kc2CY9FTNzqJ9Go6cLlWvMB7xNp7rx8oCSo4YBE/ifUVGncff3gVgTx96HmdyBR
 r3StSRE0Ss8Iz6Clwsi0bexqXEMJWDBryOIuu4h38WVUshRaYP/XAam/9bfWaPiad8CeIVGx+Eg
 RrgzNMB4AyKLeWqUjNwWQwoz7NQQXr1rcB/bIx2JY8T7MGlCdgTKNwjIfRGXna44VmTDwmFClpo
 77Nx6AAFdDkHjdpTCSEpzgvT+9i1p9kgfFEPK+tSDZn5bGu68pMmzJjlVmRb0TUWjxBpqn9cYmb
 gmbdl/egKr5zgMwp2p32obMQq9/w2kMubA2wXhBBHKPWu3iJy8m8A10uMbm9AAJJj6fxinf7NX8
 pL7h1RbIlz0xjtw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Endpoint-Received: by B4 Relay for nikita@trvn.ru/default with
 auth_id=151
X-Original-From: Nikita Travkin <nikita@trvn.ru>
Reply-To: nikita@trvn.ru

From: Nikita Travkin <nikita@trvn.ru>

IPA warns if the thermal zone it was attached to doesn't define
sustainable_power value. In some cases though IPA may be bound to an
"empty" TZ, in which case the lack of sustainable_power doesn't matter.

Suppress the warning in case when IPA is bound to an empty TZ to make it
easier to see the warnings that actually matter.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---

I've decided to add this along to supress those warnings for some TZ on
sc7180. Feel free to drop this patch if you think the warning should
always appear.
---
 drivers/thermal/gov_power_allocator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index e25e48d76aa7..05a40f6b5928 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -704,7 +704,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		params->allocated_tzp = true;
 	}
 
-	if (!tz->tzp->sustainable_power)
+	if (!tz->tzp->sustainable_power && params->trip_max)
 		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
 	else
 		params->sustainable_power = tz->tzp->sustainable_power;

-- 
2.44.0



