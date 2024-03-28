Return-Path: <linux-kernel+bounces-123238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE51890503
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2ED1C2F7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D131353E1;
	Thu, 28 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgmsvwWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463C13118C;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=WARF9FuMGuiAibB0y5nVZfmzmloZVBsw+LRu3N3DuN4cl4MXhwhBn15GinxOM6dMyOSdpMTbI4q+RQrTg00akeN3bDjy+LvpTXsfA16Ztpu6F/hoqBRvBzB+K11hM2E0X5f2Ud4jy6WPy9hQmInE7JOJ5qLwBHWWx+oDcSB93UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=zBhogSNxNauQDqG7V2YIRjTJ7pHNH4Qj7ezF+eXpGV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q8YeqUBfWnmaOw5hiBvd2CRwZdkfCb9WWSaKCInVRCh105c7Iyhw0nzqos6uIWNAifQNpZa7WUVp3BoGD+0ssJHHHpqaBds//cyGuLx451fF7FdMWDSXUkFpAzrCuCYlPS+J7wWXGzunyDjeE9seYOIwtF0ZEVTnCptGdApvo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgmsvwWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1808C433A6;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642926;
	bh=zBhogSNxNauQDqG7V2YIRjTJ7pHNH4Qj7ezF+eXpGV0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fgmsvwWrV1E1iopjBIDtM6GXoD/bXq6DjZcgg4tJIKe5jVKtKkqd8zIryOLmjlPPg
	 Tz8qIAzrADFTWTQERC8km7SoLV4d94tNWHMjPldiZ7H1LwDqYSE2lnR38swF8m59gE
	 NVi5p6UbeByDgHEEdKpIFlYuKGi0K0t8Xks9dPmWGnNI44yoUGXhIhv64X7KzQi5y8
	 ZzeAhppoNzvCqaqpCp9/UVuYV9auXNjKYiylbyNJFLYoioRIk7Vaq4vbwCDBg/gzMS
	 R7Qx0zn1AD1vCGMkMsWEK2vvk1dfKPqly3ZQKAIcr69iRCQR00eQ12piuTWbjCFAu4
	 Nnq4BoVaTZ3mQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0762CD1284;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v4 0/6] iio: temperature: ltc2983: small improvements
Date: Thu, 28 Mar 2024 17:22:00 +0100
Message-Id: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACiZBWYC/22Nyw6CMBBFf4XM2jF9oFJW/odhUYcCkwAlLWk0h
 H+34tblOck9d4PoArsIdbFBcIkj+zlDeSqABjv3DrnNDEqoUih1w3ElZSqNE0dCnpbgE7aGSqs
 raZ6yg7xcguv4dVQfTeaB4+rD+zhJ+mt/PS3k317SKJCEucirJeE6utvZjr4/k5+g2ff9Ax5YN
 Du3AAAA
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=1447;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zBhogSNxNauQDqG7V2YIRjTJ7pHNH4Qj7ezF+eXpGV0=;
 b=/wppr/f3yBPWBOrF9QxOnuWQh+UT4MUEz7k/gAKAKugqeXNaT5a/rg5waRpDGfNPv5Wo39m6h
 TQrgwlv1OSrC3RjIrcwWtqMdCtOj678YLeGrOs7R5E5A3eCH+bxU3A6
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

The v4 introduces an new dev_errp_probe() helper to deal with cases
where we want to return error pointers. The refactor in the IIO ltc2983
is an heavy user of the pattern and was the main motivation for this.

Also added two new patches so we have three users of the new
dev_errp_probe() helper. 

---
Changes in v4:
- Link to v3: https://lore.kernel.org/r/20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com
- Patch 1
 * New patch
- Patch 2
 * Use dev_errp_probe() instead of local variant
- Patch 5
 * New patch
- Patch 6
 * New patch

---
Nuno Sa (6):
      printk: add new dev_errp_probe() helper
      iio: temperature: ltc2983: convert to dev_err_probe()
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator
      iio: backend: make use dev_errp_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

 .../bindings/iio/temperature/adi,ltc2983.yaml      |   4 +
 drivers/iio/common/scmi_sensors/scmi_iio.c         |  45 ++--
 drivers/iio/industrialio-backend.c                 |   8 +-
 drivers/iio/temperature/ltc2983.c                  | 260 ++++++++++-----------
 include/linux/dev_printk.h                         |   5 +
 5 files changed, 151 insertions(+), 171 deletions(-)
---
base-commit: 27eea4778db8268cd6dc80a5b853c599bd3099f1
change-id: 20240227-ltc2983-misc-improv-d9c4a3819b1f
--

Thanks!
- Nuno Sá



