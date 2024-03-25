Return-Path: <linux-kernel+bounces-116478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8C889EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9931F3757E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CB172635;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+C4Hn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11518133F;
	Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350672; cv=none; b=nhXZ3jjRFay9b5WUZulJsZy00nap6y8w1MsGpXiHcMUdP6bzsqZF1x2dThVWlfwcHTLtJkVLI6annY3CPHVI8dDijkxJKlX8Xv6mDbhRAKxWiuRNET/vPx7KH0UbyTzQXGuZ8PXlpU4SjhH6uNyoiXetIBCk20Ild+jodiO4ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350672; c=relaxed/simple;
	bh=Na+D4oMLZVbeAYKzO6JgJaOnxkPP6UKJ/rpViZ9Dd7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIP3dZsQudUk4KZNqjRMDBNdhGHixepKQSnB6MtVKlQDf4FELD/ywivTezSNc1FyCr+ohR/jKWJbpQJFjS3pYoZGkEFKzDIXw7A1RDgkXo3Oxp36AVMJX6+kIE2/poVNkAaBZjt8RsiXRnqyshhnqDvP9eLpDCnZTTatufn+tJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+C4Hn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE30C433F1;
	Mon, 25 Mar 2024 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350672;
	bh=Na+D4oMLZVbeAYKzO6JgJaOnxkPP6UKJ/rpViZ9Dd7M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ry+C4Hn2LzihQS6aYeJ2us7Evgo4Rcnoav8aCG4rO5oqgbYGqkMQGQOqvQ76zyHxY
	 R18tc3jQCXE+LxzXXE5wVGg6G/Yz7afT7zHmbGvLab/rp03sQMtPZvNsiIqupEz4Ng
	 wsnnhELGkBqpxX99HZvrwxTu18C68MYp64XQk7/8OSrhSdTQ00/ZccRJix7EKbzX7A
	 KYz/SpO6SkqDUJjeh3MUmXhDEq0muyvCg5h9hjhksm69DGS+ZcIAfHIKgwn/J88zIW
	 CinynW/pKAGvs4PekUCV0PxoLlvFl/rJEtlhHSKj9krwRn+nCIaroYHtEkCGT7NAfi
	 wZTWoG27mOeJQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/28] scsi: hpsa: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:33 +0900
Message-ID: <20240325070944.3600338-23-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..23b19fa30661 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7509,7 +7509,7 @@ static void hpsa_setup_reply_map(struct ctlr_info *h)
  */
 static int hpsa_interrupt_mode(struct ctlr_info *h)
 {
-	unsigned int flags = PCI_IRQ_LEGACY;
+	unsigned int flags = PCI_IRQ_INTX;
 	int ret;
 
 	/* Some boards advertise MSI but don't really support it */
-- 
2.44.0


