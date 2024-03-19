Return-Path: <linux-kernel+bounces-107735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC58800FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1116B22C80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E081AB4;
	Tue, 19 Mar 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYoEadP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD892E400;
	Tue, 19 Mar 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863173; cv=none; b=AjcWNPjBxK+bsVpUTtPqtnx9I/6KAzfeXUfnA3Wup47L7GL2yuhWmL5DhvwU34EqECiPLbHFa4GO7Y0yJrXS+LcWSocItqBkRqLCWEvm5XrTS4b9kn8jMCbceDSiMH+/SFwKzm5iXYzB+doySCrkYsWaq5hfhdI79O+Qfsey624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863173; c=relaxed/simple;
	bh=pd6u63f7QKmzAlsvJyOlOlrn80eFLOYslxGeKqxNvYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naNoGSkTYbOuWZmH2V+u4XYfv9sPRYuvicyOuAatoGKNF9ZjS8y9WtA0UHvKYPjT8q5LklHV/rJxpet0HDYg+28UVfS0BPOIF/ks10GpfUwzWlYnn5hWbYw4O+zyl11ar62KgAzBKdm97pM8zgidF25VRIC27ycDNtei2qqiBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYoEadP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBB1C43394;
	Tue, 19 Mar 2024 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863173;
	bh=pd6u63f7QKmzAlsvJyOlOlrn80eFLOYslxGeKqxNvYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYoEadP+Vi9xy8UPK80v19Sx5CBhULXg7DUaeWSBD1YcjvT9Gc7s8lE05390dPPRM
	 VId9psPr15oh2Q9E+DHnmLlM5eEmcKrPJc9FX3RGu/RRzedznIy6/9K47EbQ9Mbjys
	 VaeTzpjwN9/ULvyB4Ks+F6XxabSw3iA/6WXwzrumo31df1AZszM7ATOTb7HEv3xWnc
	 ZzfrwjOAzZJeGog6wAfdIL9oMw7m1Je1IHhBkn663t2W04sVeF/CoQ8f+Z9qKpLDx9
	 XTPq9DbIRWy1eWFT+gAIpffbkkah+Uu9/Nag5OaLzIB1RJaXC+wvjpQWHEBu68RLxq
	 xOQRRRalxZR0g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbfQ-000000000eV-1bvU;
	Tue, 19 Mar 2024 16:46:20 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: qca: fix NULL-deref on non-serdev suspend
Date: Tue, 19 Mar 2024 16:46:10 +0100
Message-ID: <20240319154611.2492-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319154611.2492-1-johan+linaro@kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm ROME controllers can be registered from the Bluetooth line
discipline and in this case the HCI UART serdev pointer is NULL.

Add the missing sanity check to prevent a NULL-pointer dereference when
wakeup() is called for a non-serdev controller during suspend.

Just return true for now to restore the original behaviour and address
the crash with pre-6.2 kernels, which do not have commit e9b3e5b8c657
("Bluetooth: hci_qca: only assign wakeup with serial port support") that
causes the crash to happen already at setup() time.

Fixes: c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
Cc: stable@vger.kernel.org      # 5.13
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c73481c57741..84f728943962 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1672,6 +1672,9 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
+	if (!hu->serdev)
+		return true;
+
 	/* BT SoC attached through the serial bus is handled by the serdev driver.
 	 * So we need to use the device handle of the serdev driver to get the
 	 * status of device may wakeup.
-- 
2.43.2


