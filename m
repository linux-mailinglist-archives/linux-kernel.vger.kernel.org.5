Return-Path: <linux-kernel+bounces-126023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D389310D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EE82828CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC476F1D;
	Sun, 31 Mar 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0jbTc0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF157603F;
	Sun, 31 Mar 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876669; cv=none; b=HNHfJ04sFe1VZxBK7x42KbxDz7L7YFbKW0/RQY/n6EF7R02Dv0yWJnQv/W8S5yTlQNXYLD26gP9SX0r6mHtv0cKBO28EIxyU5zZHjllpzFHVM6SmNkBh/U17jNXqYt5OZ/z4DT5E1785S7Q0CbS/C3Zh7r9UdZoq7A6JWXvf/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876669; c=relaxed/simple;
	bh=b5bp6YpDxDNAhHm2eA09MHiyRDWjIhYQ/8XegN7bvrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Krgi7KnHp3PRxSsstLx8wzUDwwVsSZ95p1900DqQoOJXvIa3uPndrbwLm/mX8mizlCWxXdIPYD7Lx/oYyACUO7gL0u6OcCwxTYuJGfR/L14iXgZSFcAWgmk9Qfg8cGjlBSMbJMoHG83qaL2CqC6bVTi2OO5ovRl6TrKeNnlHOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0jbTc0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E48C43394;
	Sun, 31 Mar 2024 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711876669;
	bh=b5bp6YpDxDNAhHm2eA09MHiyRDWjIhYQ/8XegN7bvrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0jbTc0mAulFmBNoTtt//EDp/0g+p4YpKduEYSB4vomzDvZQbvdeBeJViLQZS+E4P
	 tuv2na/t+5gpAGnMUfgkpnyU8jW1slfli7lSIVFIHZvfNRUo/ejGaLAw3tZQeC7UJ8
	 j/C6WdlKYNf2NntBp1VrB0akoqpsn3h7Sx4IQZzqAp6S+j5ow5fulOs90Wx7pa5ZQv
	 E8IadavguuF70IR6otgk4V5nEHI/5DHiM9ztMaJwNp8Ug7DIm5DotQjZzNWhnKUimb
	 2idSeatseygg1Kw4Q4JTKSF3d/xe3D3WJv6fwB8okT3Py5RRLl3T9zEt38O1zCSOmz
	 VnsAIR0ZlbX8g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/3] usb: typec: nvidia: drop driver owner assignment
Date: Sun, 31 Mar 2024 11:17:36 +0200
Message-Id: <20240331091737.19836-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331091737.19836-1-krzk@kernel.org>
References: <20240331091737.19836-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in typec_altmode_register_driver() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 drivers/usb/typec/altmodes/nvidia.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/nvidia.c b/drivers/usb/typec/altmodes/nvidia.c
index c36769736405..fe70b36f078f 100644
--- a/drivers/usb/typec/altmodes/nvidia.c
+++ b/drivers/usb/typec/altmodes/nvidia.c
@@ -35,7 +35,6 @@ static struct typec_altmode_driver nvidia_altmode_driver = {
 	.remove = nvidia_altmode_remove,
 	.driver = {
 		.name = "typec_nvidia",
-		.owner = THIS_MODULE,
 	},
 };
 module_typec_altmode_driver(nvidia_altmode_driver);
-- 
2.34.1


