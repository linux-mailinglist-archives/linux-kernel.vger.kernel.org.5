Return-Path: <linux-kernel+bounces-71800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC15A85AAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE8B212DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E699482CB;
	Mon, 19 Feb 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DriiqdOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD346B9F;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366465; cv=none; b=ErBjg2Z7/tFEAhIr4nYr0ffwC3K2U8oaddqOfyuAz27BljIgtWDW6X1X9LhYIWLRAsqncYDOiAxBdTzvpjU5RTDLD2j6OAg+l/MPECkwkCFr13T7DSZjcYp77T4r5tHY9FZIeVCU6L8X9BfXFoSlgno10e4jkitZbd2xfIL1Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366465; c=relaxed/simple;
	bh=3p90HdXjRYqaF/dwaJSI6JIUSflQuajrLtO/CzXAHow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sljBUYF5qN6PSATM+DbamtzuvcWgdhibzoCC4nz0CYtSJTV/3mba8vHNJGvZfW/UHZO/t7g5W6OvggryNxonkD8IlP473PFsFydWLqXZ+ak3fqCigzGE5T2Qi9hZbrJO650nd3iREyE63jo/dTQsNNXAG5ygSFxwSiyMyWCv05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DriiqdOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6928FC433C7;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366465;
	bh=3p90HdXjRYqaF/dwaJSI6JIUSflQuajrLtO/CzXAHow=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DriiqdOZJx7EDXvA7xtliPDhs/8oKgC8Y+MNqeSGCzkh2lUq/k2EvQ0bCuNf8nwgB
	 QvcI2WksBTZS0PQObt9S/jIwf9+zcLPD58p5T2ZLJnaiYA/W32O8bSHmAvSIxrCrwq
	 Z/aijtMrG5fPtae0GDiiPtN37AiZVshFzsdViqfTqwHwGWMdOa/2/Sg83vWwqKHKir
	 qq2oCyHVLmyUBHhoStIHmXlfx+cD1pLeyykEv3zkE6YB+RZn1yuDvx8tDdBawvkLK5
	 iKKHMCPEXuhgVnNFt63vWCqEzwCOHlK0u/FY+GNp+VnhvuwjLVhARh7Udpjkgh+iM7
	 12tw1qGjLM9Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A7C48BF8;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] watchdog: sp805: add reset control support
Date: Tue, 20 Feb 2024 02:14:24 +0800
Message-Id: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICa02UC/22MSw7CIBQAr9K8tRhA20pX3sN0wU9L1D4DiJqGu
 /vs2uVMJrNA8jH4BEOzQPQlpIAzgdw0YCc9XzwLjhgkl3suRc8mStjLZbYzrVS90F2rBFD+iP4
 c3uvqNBJTmDF+1nMRP/tnUgTjzDqjnLPaqO5wxGe+IV63Fu8w1lq/k5lSPqIAAAA=
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708366465; l=825;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=3p90HdXjRYqaF/dwaJSI6JIUSflQuajrLtO/CzXAHow=;
 b=NY9tsSJ4I1KQNgp+4GHYAc0+8hARqMhSN/cqcCnZLV6CXiW8r+zNewLjP58YJ0cUqEk40u7cD
 Con8Y6VpnijAo3L23KyUzMSeGccNOoyrvkinvy/mlYNpfGz63CNGWh9
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Deassert the reset if it's available.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- commit log: dt-binding->dt-bindings (Krzysztof Kozlowski)
- binding: remove "|", join two lines. (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com

---
Yang Xiwen (2):
      watchdog: sp805_wdt: deassert the reset if available
      dt-bindings: watchdog: arm,sp805: document the reset signal

 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 5 +++++
 drivers/watchdog/sp805_wdt.c                              | 9 +++++++++
 2 files changed, 14 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-hisi-wdt-3b52971a6591

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


