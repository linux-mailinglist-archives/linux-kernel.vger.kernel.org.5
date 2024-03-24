Return-Path: <linux-kernel+bounces-116336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AB889E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325671F37735
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6113280B;
	Mon, 25 Mar 2024 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptXdiobx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E516185236;
	Sun, 24 Mar 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324337; cv=none; b=t6dm/yNjQu41eZCitDOtV4RSNbTrhURAe+76WWBfRu2nzfsK++SbbNvsdRh7SFk0qy84L3ug7sC+h9NEErQUG3LIUNJaDGdHqLP83zeiHu1+b6g1A1XfYqfvprMrNM1F0BSX9j5q4xsuxWCNJvhcxkhxZ9zxIQnTJucorlUWtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324337; c=relaxed/simple;
	bh=HjJ/dTR++zAMfVXYPFsG/0p7h3CxF6pmnwiIwdiU8Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN6vO8HOQCGkK8P+YjqFiB8EZD/1QVkvFGsB/UUAjUB2A6ngor7hapeypGGH4mBCBJVEiXBnGGmy6hmqesRHEi0BA+ox+GNj00e5D5FfnRCIygDqKOjldfj4nL2UtwVocvhI0Ow4KqzzzdLiUQsiwYfIVVwWQ6dw67ZIUCyhJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptXdiobx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3BEC433A6;
	Sun, 24 Mar 2024 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324336;
	bh=HjJ/dTR++zAMfVXYPFsG/0p7h3CxF6pmnwiIwdiU8Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptXdiobxMI2okkptNbeTZP3AFnGJsAUiZJyDRyMYdVLz2dkfTMIINNb7YbcrLX593
	 qlHnsAhTJoCGNC1pQCajeO1L64uOUWcJVCM56AxbpF7piEQ+hx1DCjJ8yXhXtbuNo1
	 QZToqx5x+4IdrzAYfomLFSvd9iZf/fNYnsQofus1dYYddF/XpHVPc0ZpDa021Ruk2e
	 kAXwDDbwdJmQmFA+NJdRImxd3Jll1sWz0CvToRl5XcPjswgiE2ud7YzA9PylIn7MUj
	 A9M5dE27J03ghS5yo+b4MXcmcA6CM4FYCgM9ZyIQNcmiPORtsLu9676WOstWZ4jL0F
	 8oBRB3OUrpDaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/148] PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Sun, 24 Mar 2024 19:49:30 -0400
Message-ID: <20240324235012.1356413-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jörg Wedekind <joerg@wedekind.de>

[ Upstream commit baf67aefbe7d7deafa59ca49612d163f8889934c ]

Per PCIe r6.1, sec 2.2.6.2 and 7.5.3.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The 3ware 9650SE seems to have issues with handling 8-bit tags. Mark it as
broken.

This fixes PCI Parity Errors like :

  3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.

Link: https://lore.kernel.org/r/20240219132811.8351-1-joerg@wedekind.de
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Signed-off-by: Jörg Wedekind <joerg@wedekind.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 99a8a24ea79dc..bb51820890965 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5189,6 +5189,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
-- 
2.43.0


