Return-Path: <linux-kernel+bounces-6115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E448194CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE491C2527B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1D3FB04;
	Tue, 19 Dec 2023 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HiAhe10Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF940BE4;
	Tue, 19 Dec 2023 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EF12D2AE;
	Tue, 19 Dec 2023 23:53:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF12D2AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703030027; bh=4bxsCb3d4Rri3k4ZP1joC3ve9NadD0wIAlYgvDY2Je0=;
	h=From:To:Cc:Subject:Date:From;
	b=HiAhe10QsiNMZLZJVA12+4ieEF5GUsBkHF1JGXD+GKZtyczR7R7ml4WzsqnmzEhcu
	 3dZi+eKXzUXYjxsmFSNxUbnaPvsmOglnAmMmdGMEs6mz9aTzi7dEjDvAK3hS8C0ucR
	 tfV/Y7mi7I+Gh93dCGEEg7cqt6MolzwKTOWrGzShqH/JTeEw3aTtCYfb5eUETc5M1k
	 QafxaRgaoBfma7HUOcNNcv46P/WkyD60if+zV8VCdnrbQzOZecAtWJzWUa7vM8ckNd
	 HDisbqlLW6qkfjfiaZ9QsauiE0IcAqrA/lV9GEU1Bam9WOYV9Q7o88TBRvgzY8nbyp
	 IfX0Q52P44Y3Q==
From: Jonathan Corbet <corbet@lwn.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH net] ethtool: reformat kerneldoc for struct
 ethtool_link_settings
Date: Tue, 19 Dec 2023 16:53:46 -0700
Message-ID: <87zfy5g35h.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The kernel doc comments for struct ethtool_link_settings includes
documentation for three fields that were never present there, leading to
these docs-build warnings:

  ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'supported' description in 'ethtool_link_settings'
  ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'advertising' description in 'ethtool_link_settings'
  ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'lp_advertising' description in 'ethtool_link_settings'

Remove the entries to make the warnings go away.  There was some
information there on how data in >link_mode_masks is formatted; move that
to the body of the comment to preserve it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/uapi/linux/ethtool.h | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..50253287c321 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2128,18 +2128,6 @@ enum ethtool_reset_flags {
  *	refused. For drivers: ignore this field (use kernel's
  *	__ETHTOOL_LINK_MODE_MASK_NBITS instead), any change to it will
  *	be overwritten by kernel.
- * @supported: Bitmap with each bit meaning given by
- *	%ethtool_link_mode_bit_indices for the link modes, physical
- *	connectors and other link features for which the interface
- *	supports autonegotiation or auto-detection.  Read-only.
- * @advertising: Bitmap with each bit meaning given by
- *	%ethtool_link_mode_bit_indices for the link modes, physical
- *	connectors and other link features that are advertised through
- *	autonegotiation or enabled for auto-detection.
- * @lp_advertising: Bitmap with each bit meaning given by
- *	%ethtool_link_mode_bit_indices for the link modes, and other
- *	link features that the link partner advertised through
- *	autonegotiation; 0 if unknown or not applicable.  Read-only.
  * @transceiver: Used to distinguish different possible PHY types,
  *	reported consistently by PHYLIB.  Read-only.
  * @master_slave_cfg: Master/slave port mode.
@@ -2181,6 +2169,21 @@ enum ethtool_reset_flags {
  * %set_link_ksettings() should validate all fields other than @cmd
  * and @link_mode_masks_nwords that are not described as read-only or
  * deprecated, and must ignore all fields described as read-only.
+ *
+ * @link_mode_masks is divided into three bitfields, each of length
+ * @link_mode_masks_nwords:
+ * - supported: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, physical
+ *	connectors and other link features for which the interface
+ *	supports autonegotiation or auto-detection.  Read-only.
+ * - advertising: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, physical
+ *	connectors and other link features that are advertised through
+ *	autonegotiation or enabled for auto-detection.
+ * - lp_advertising: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, and other
+ *	link features that the link partner advertised through
+ *	autonegotiation; 0 if unknown or not applicable.  Read-only.
  */
 struct ethtool_link_settings {
 	__u32	cmd;
-- 
2.43.0


