Return-Path: <linux-kernel+bounces-101811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBA187ABCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3721C208C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2905D72F;
	Wed, 13 Mar 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcFccfP0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016F5D460;
	Wed, 13 Mar 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347841; cv=none; b=jnV4OHajy6eCbSVMUr9yfzxbqb26jLmk4ymdmWl8gARcYFtKTD0lbno4NwASSvZPQ1cyLk76gOzPdhxdaO1RbI5vOWPAXq05ixJWIy/WzOzOuhrtbJpXs1TuF2pujkXrvBbECCWnMKsBMy4mHrymstqmQgotJq9Ft0UdJ9XmW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347841; c=relaxed/simple;
	bh=KQvW4QLqr7rEMfi/hFQOWFcSE+Lk/YdZwM/sAdZU8Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/8xOwwi9p/siTm31mLL0hG1LdBEN7KccuMveJQNh3nDjvIDMpQvjOYdLf4PFEdrd3Vxn29MNWU4d3KHkcWWQH0vJjQypzDlzuDfMF13TWAUSsTEmfoUN7HmiF+ODi2VX8qpbp0V8PgN+dm0TDnrn00QDq+a7QWNbzIAkTD/vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcFccfP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E82C43394;
	Wed, 13 Mar 2024 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347841;
	bh=KQvW4QLqr7rEMfi/hFQOWFcSE+Lk/YdZwM/sAdZU8Ec=;
	h=From:To:Cc:Subject:Date:From;
	b=QcFccfP0iWyuyg7dmYSxeMED1MJH9zJ5I13qdTMpm9k+gBLWKyBb+9/mOB2KcfRh1
	 dGhjb9W/4N+EdKcUS06eR55r9U0S8mzyfKb8b0WFux1jA6YamOwOIkVSc08H5Y0+ei
	 5zYu2a2uLnMexXRWo1UTiwAn+gXmGL2KIdz73bUcJQ2fX61d8N7a9/by2Y7lSR4pHO
	 QwFUlknS67JXAADwfnpFFhUX50hQhSq2q/rKT/TU++YuNB2FW18cOVde+ClYZbs2kW
	 n40Y9/7SY5DtcSfsTJqg1PwTYbbfI0pqSU9J1AUR/mgG90A5sqpl8eknByDXrK8ooo
	 UP3iMh+Rryv+w==
From: Arnd Bergmann <arnd@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: changen strncpy() to strscpy_pad()
Date: Wed, 13 Mar 2024 17:36:56 +0100
Message-Id: <20240313163712.224585-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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


