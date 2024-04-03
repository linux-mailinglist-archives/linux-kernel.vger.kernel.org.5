Return-Path: <linux-kernel+bounces-129297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B32896850
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22388282F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1BC13E40E;
	Wed,  3 Apr 2024 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgWmibZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664D12CDBE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131832; cv=none; b=UhQgzWXpZ4RlNXgwxxaxA8Nw3Y54flO57XDiA+e86qJbpnJgVkaOpsO0Iy4Kyk2NmAb5I+D4nGTmZtTJY2EHvAu5Swu2dEJrfNr3n1K52j+O9D6k+H2onH+opYVNgv+FATf9vpMvvbl4WvP8ueW9EZL2cKdWvpfcHjQpLl2xWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131832; c=relaxed/simple;
	bh=aLO3cxXiffx87dLimQWP9nA/rRLONji1XWCMwWSXdsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSmZRJEq0GHBk6GHD7n+P4vApCyXriD+4Qnr1NkAe5FRIYSB/WjVDwvwgtnMXf/AQ/G/AMrRPsvhgBathSbCFrRXSAw8VeeUv9OJas530iQgfv3DZRrqAaAwVEIyqXzrNQeKhYXZAvR2mXGh7y371MknFRehkyXg4h5Hh8aSgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgWmibZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26808C433C7;
	Wed,  3 Apr 2024 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131832;
	bh=aLO3cxXiffx87dLimQWP9nA/rRLONji1XWCMwWSXdsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgWmibZ6ZAVyuwPXz7ayvE1R1QNNlcfOUDLR7RUCRl0XeoGld8MZrtOsneRgqCvjI
	 Pe0Z/Cbyb3JW9+vRkOe2I3CGsOuqpNWLyRBo6VIcbfNtyJZ0gCDBMp31N7MXysszE1
	 PD95/YvlKZHk2W1dz5qN78Yc2aCfBqIiXavL2wPZWRuVBJSvN3m5R+3RCX3ODTOvUS
	 uWi6PmVLQD40onTbamtFKxQqMVlD5ZnvGZUryfFr4KoKPfq3aaQflBGWHRqp3pqJdM
	 9y7Yek9xIG7sHXiWynUBLYqM3ma77Uhl+0/rqjW9HKZ6m6StdvWIcP9n8Q59RnhGCZ
	 Sw+HBscTqSJJQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 20/34] comedi: ni_atmio: avoid warning for unused device_ids[] table
Date: Wed,  3 Apr 2024 10:06:38 +0200
Message-Id: <20240403080702.3509288-21-arnd@kernel.org>
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

When the driver is built-in, it produces a W=1 warning:

drivers/comedi/drivers/ni_atmio.c:209:35: error: 'device_ids' defined but not used [-Werror=unused-const-variable=]
  209 | static const struct pnp_device_id device_ids[] = {

The actual probe() function has a different way of identifying
the hardware, so just mark this one as __maybe_unused so it
can be dropped when built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/comedi/drivers/ni_atmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 8876a1d24c56..09dece0994c2 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -206,7 +206,7 @@ static const int ni_irqpin[] = {
 
 #include "ni_mio_common.c"
 
-static const struct pnp_device_id device_ids[] = {
+static const struct pnp_device_id __maybe_unused device_ids[] = {
 	{.id = "NIC1900", .driver_data = 0},
 	{.id = "NIC2400", .driver_data = 0},
 	{.id = "NIC2500", .driver_data = 0},
-- 
2.39.2


