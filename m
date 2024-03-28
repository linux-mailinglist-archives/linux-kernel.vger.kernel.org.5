Return-Path: <linux-kernel+bounces-123015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB1890115
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81C62994E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB55823A3;
	Thu, 28 Mar 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS5rxxdm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7318120F;
	Thu, 28 Mar 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634740; cv=none; b=JkAPNt7yoZ68jUJXSV+6YcItnIecuQSbG1IfghltNXQwoslFsNall28iUXHLIfM9/mVBNv3GiQkrogjBaVBI62AxHO4SupyhU5E+ACIVI9vfS4QdiXBdPpz+h0aX9oxfHFBmOulsIvR+TvY3Dihkasvde7VkB0pXcQm6xBKxVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634740; c=relaxed/simple;
	bh=KQvW4QLqr7rEMfi/hFQOWFcSE+Lk/YdZwM/sAdZU8Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEASRvB40k7cGGe4rXIlhI8LSjeH1i/fpzMuY/cuJr3nRMtY4MZe6aiDLTLPQdXVL4LOzPlFIZlnHFL1q3CrM9hfvdMICPD/SPaVRWaTsDMyzqNpLW8bWdoRpByOnF42KyLbB1r49L5Jc8B3fg9siSwubIgsT9YpQD/k4EA6JvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS5rxxdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD5C43394;
	Thu, 28 Mar 2024 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634739;
	bh=KQvW4QLqr7rEMfi/hFQOWFcSE+Lk/YdZwM/sAdZU8Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS5rxxdmgygAFwMhA8Fqr1RY9HLrIBrzNT+eF5P1RzqAVY16HCcGTOFiOFllAb59v
	 S9nizxhkPHCJYGBUcaZRpH+G4RDp9ALws5aboUqudsDYMPwLgQWp3TWxokC6vfnSBU
	 uj5/np5TsbsyZQsQDSHFwZWOxEXxyG5Tus5znIq3DYIzxP3kRBJ21xyZaZPHoGP9x0
	 x/Vq23EqqFMhVLzX9xaYQo0nO6EVC6A2ZdRI54IRrEBK70XXOOGsIAGSKqy4wszunR
	 cGBLYiJMaEGr3FK2J/Y4iHw/ynBlZKwr8bSo46fWlWT6UiG9qovFBkGKTOYDTHFr2T
	 e7w3Z9MmUZSHw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 01/11] staging: vc04_services: changen strncpy() to strscpy_pad()
Date: Thu, 28 Mar 2024 15:04:45 +0100
Message-Id: <20240328140512.4148825-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-14 warns about this strncpy() that results in a non-terminated
string for an overflow:

In file included from include/linux/string.h:369,
                 from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:20:
In function 'strncpy',
    inlined from 'create_component' at drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:940:2:
include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' specified bound 128 equals destination size [-Werror=stringop-truncation]

Change it to strscpy_pad(), which produces a properly terminated and
zero-padded string.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 258aa0e37f55..6ca5797aeae5 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -937,8 +937,8 @@ static int create_component(struct vchiq_mmal_instance *instance,
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
 	m.u.component_create.client_component = component->client_component;
-	strncpy(m.u.component_create.name, name,
-		sizeof(m.u.component_create.name));
+	strscpy_pad(m.u.component_create.name, name,
+		    sizeof(m.u.component_create.name));
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),
-- 
2.39.2


