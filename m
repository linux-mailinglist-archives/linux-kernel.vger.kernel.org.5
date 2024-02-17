Return-Path: <linux-kernel+bounces-70030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C48591FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14D0B23096
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12AA7E575;
	Sat, 17 Feb 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.com header.i=@posteo.com header.b="c7T9tjPa"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4A7E107
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708197310; cv=none; b=LEVRs/w2S8OgNui7M7tsXg7NPfwZRZh7zQi3HxZEeZbiUyvsql3JrafoYf5eI4cAwn6GqOZBxA9hcdQRMiWLzpS10cf2D87c4DjyUK26WpDaLjFZ4FhcKoujbIg+WCaPMLCXPNTeJJal5fiP6WizNULx0PjyNdT9ySM0qmZYp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708197310; c=relaxed/simple;
	bh=97GzY2MpYnhzs/TpdBzuVKn6grrjLW2AuK2phabz9FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AEA+FezgmI56Q8cukls5UofDacL3PJmAYyhkIUa0Eentqe881xFeMRd5GNQRKx0ka1yKGZeVpQM/uDjthMAE4mRPKTrjmVBJlT7TG/2OaxCZ8Cdo2jutY7ZQVDplWftY8R857Sw8FsiCAOdQCucwbZ5BUcagx9NhqpBWd7AcwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.com; spf=pass smtp.mailfrom=posteo.com; dkim=pass (2048-bit key) header.d=posteo.com header.i=@posteo.com header.b=c7T9tjPa; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.com
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 609FC240103
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 20:14:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1708197298; bh=97GzY2MpYnhzs/TpdBzuVKn6grrjLW2AuK2phabz9FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=c7T9tjPav+Yq6smuvZvFbwjFn7QuhRtVH/0fTbR/y7hVpC2Y+KYs0A6tI7ZsfDSXi
	 pxXUfFdGCH87uKLdIubEx/z8ZWfDD6sD3R6KuQ3KUQH0/zTwuGCVA5zO4j7slV84SY
	 iT+KEH00hpckNOtaNIS6GV8mc3ZPrHO4yiVcELeembVJaD1NVNIXcxgeTV7Gf9Dzuo
	 pASg3gFGzwcRu+yBiofVIgQ03o3TmiYkci8WBxLineS5AMZcyOI2YoiUIj2w/0yZ+g
	 kvw5ZBMm4ORSBbj8VqeygcdjoR04IcThBu+9ntI857aY1rjg/uf36/pQbofALknpMY
	 +AgsPBDm5cZ1A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tcdm11vyyz9rxD;
	Sat, 17 Feb 2024 20:14:57 +0100 (CET)
From: simone.p.weiss@posteo.com
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Simone=20Wei=C3=9F?= <simone.p.weiss@posteo.com>
Subject: [PATCH] scsi: bfa: Remove further unnecessary struct declaration
Date: Sat, 17 Feb 2024 19:14:09 +0000
Message-Id: <20240217191409.6260-1-simone.p.weiss@posteo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Simone Weiß <simone.p.weiss@posteo.com>

With Commit c3b0d087763f9833
("scsi: bfa: Remove unnecessary struct declarations") duplicated struct
declarions for struct bfa_fcs_s and struct bfa_fcs_fabric_s where already
removed.

There are further duplications:

- struct bfad_vf_s is declared in line 165 remove the duplication in line
  834.
- struct bfad_rport_s is declared in line 394 remove the duplication in
  line 836.

Signed-off-by: Simone Weiß <simone.p.weiss@posteo.com>
---
 drivers/scsi/bfa/bfa_fcs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs.h b/drivers/scsi/bfa/bfa_fcs.h
index c1baf5cd0d3e..4d8bd9f932f6 100644
--- a/drivers/scsi/bfa/bfa_fcs.h
+++ b/drivers/scsi/bfa/bfa_fcs.h
@@ -831,9 +831,7 @@ void bfa_fcs_fabric_sm_auth_failed(struct bfa_fcs_fabric_s *fabric,
  */
 
 struct bfad_port_s;
-struct bfad_vf_s;
 struct bfad_vport_s;
-struct bfad_rport_s;
 
 /*
  * lport callbacks
-- 
2.39.2


