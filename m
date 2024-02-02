Return-Path: <linux-kernel+bounces-49320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8098468A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5979B1F21435
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1F182D8;
	Fri,  2 Feb 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtuHRPU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C2182BD;
	Fri,  2 Feb 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856980; cv=none; b=qP1gvv5kbJDOyW1RBRFOYsHfPtxHw8mtVBB9RQxgxlSnKZI3DvhIpa9CPDqgTwuxO9J5rwTjJ1J1BGdYLF4s6GS7q0VKZjaI1EHkiey+Z+ECkDQ0nS2/7bXFPl6Or6ZtZv7UeK0+kheRM960cWun74vNP4Tz7AF9zCwR3RHEflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856980; c=relaxed/simple;
	bh=W9KFsqQrZI8Sz/TN7frGjMUlXkKEz2nE7bsFVKL5CyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+QLbkstyzDoORqmuZXG5JDS0cI8BPaxM4m/cGnrqhK5pnWGCQ4+u6qP1LiQoMNLtRgMr+QL7EKb80Oi/1IWYG7N6znulWXlXzGog5n1AiJ4Nn2+LnjL3QaPFEK4O52srViWCIGpDm/sOpVnb/J6iupUAkZbzzaNySbk1vOIeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtuHRPU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756F3C43399;
	Fri,  2 Feb 2024 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856979;
	bh=W9KFsqQrZI8Sz/TN7frGjMUlXkKEz2nE7bsFVKL5CyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtuHRPU9FpzT5yDF2vq8XfXgP/0y1diDcLNimncLlu61PbNXz12OwQkqqyGuYZqxN
	 O/JB61ox5ESoiHepTaoOFlYFhnlbcw1OrSn8stQ+cHPVM8P3c7XEzQIVtIbTU9Z7gZ
	 YgEdY6P63TyIcrBjjgkg94/Iesy033j0dFXERwc0dZYLcD5H0H5F0dFNthvCPP5f3l
	 KAarWoO7igBV/Css7i5QxQvTwaC/6cS3aev+yzbWQofvviEEKNDarQvxUA31EoJuUu
	 HeTnnUXvFVrZ7Def5IuChkVqmJYvIk4bW/yKyS/W1N4oJbJ00o6RaQanX1ewpmY9lP
	 rKp9+IvTbhF1A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/22] tty: vt: remove unneeded assignment of EPecma to vc_priv
Date: Fri,  2 Feb 2024 07:55:51 +0100
Message-ID: <20240202065608.14019-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vc_data::vc_priv is _always_ assigned before the ESgetpars case is
entered (in ESsquare). Therefore, there is no need to reset it when
leaving the ESgetpars case. Note the state is set to ESnormal few lines
above, so ESgetpars is entered only by the next CSI.

Therefore, this obfuscation can be removed.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d04dbafc0517..69ebce0878f2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2421,10 +2421,9 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			}
 			return;
 		}
-		if (vc->vc_priv != EPecma) {
-			vc->vc_priv = EPecma;
+		if (vc->vc_priv != EPecma)
 			return;
-		}
+
 		switch(c) {
 		case 'G': case '`':
 			if (vc->vc_par[0])
-- 
2.43.0


