Return-Path: <linux-kernel+bounces-157115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60B8B0D07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC670287B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531415F3F3;
	Wed, 24 Apr 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POu6RgCC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589D15ECDE;
	Wed, 24 Apr 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969939; cv=none; b=Xwg5mKboxBbEmZZtp7hce8PznA0bVLQUnCwugz4iY9eXk8PwYXRtEjO223fZf9PDXAzgikNwiYSQup6CMct5tUUtIcdjCWPBbbk6SZ+kBPVLi1/bEhbT2bDz6lT8y+A+1hlCNvsuw+SdPDyttQJj4xaTRf9hdJ8TCREUTGh1HbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969939; c=relaxed/simple;
	bh=qHuzbsJMf3S460RwiwXSHw6yE5orNpAw50ZGRvWXY2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5ziRagr7LZdYhmjph35UHtoBCYZv03F6pKopdDXYIpfco48yU7f6WUSx7Z/LpImaF+2Bk2Fbh5LGQi5AaN3kYoMOiCOyO8XrQQUydsSeoQU9WzgUkL9zUamxAliW9NVbgfK1WC0C1+gdIyYnJLS1lKNZYq2dtRql00yj/+jvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POu6RgCC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so6878672b3a.2;
        Wed, 24 Apr 2024 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969938; x=1714574738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gidUAIU6zNq3nqwNVk0FnSKhJXDhb87LidO9RgqJHX8=;
        b=POu6RgCCZN0PQFgxPio3t/cpQftii/Hb2Asw/gqV+slegFPuwtaLwMD01jnm8Sd+ia
         Vg2WBlRvmlMPttyTB/UMgIZ9Wm+HmNB/5cgPY2u+IKdvaERQ5tpZ0xkk1v3FXUPnKX3E
         ATsk08R07Y+ZHmS9qyFncPPBjXGotf4VBfkl/OqHBMLgUCRQM7gFB+sfdBvzsIpyDsXb
         yZeuHUvZRm+7vWiOkI0EdB23rJqdc2wM04A5QVTRo0m51xwl5CrwbmSD3GDp8JK0Y0do
         FUnhaf93sqeuHFDsB6N6c63wgD+JE1Osav+ZBDl9hTi+sCw17CFtrdHvJZc9dAU82gYV
         enQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969938; x=1714574738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gidUAIU6zNq3nqwNVk0FnSKhJXDhb87LidO9RgqJHX8=;
        b=mnGfHWh7az5smVJO3+7wy6SvsBr0GlHPjty+Xj8swObwp8PMDfJqyRD+x0jxNpJego
         LwYxm+B77/MNImngVRSB2+hVMnk5OEFZKr7ZTSxlF+L+kKBTjRQCBigHepbdybGvS+qX
         KO7Gy9nDAKF+RO8KcWlPTuA//w5h6y0uEXxNT66jp2zHzvo30qAJeiOW7nNhQSOoluie
         g/1S7kHihTzLJJc9ygLF7MJ/syhAkkrcsigE50BFTkKQ7gdSwy/deb5EYm1Hp2sAaNNT
         wC93KXde+v+5AgYsA2BBYiWZMkcDdnjVaYB/e/M1I9m0WsfB6UwZLiuZ50VZeJX7/g0P
         6e4A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6E7hrPR16FlVlvhmUfUResmo4RfANUVBCIKQ5JtqtI8MwTlH7VqdkjvqbrRWXSm921XgwnKnYlybK2+BeKrIlrjW9TOA5oMMBbRz92jGZnkPoUxAyn07zTJ8LjrklbOduhuqs8yqKUXlhE158PNCFlL4HUraKy8S6YRwYcdHsFQhj7KBI16FJQBaDpWRpHQ8loYTd2EGy8Z/gog=
X-Gm-Message-State: AOJu0Yw2g4uWQ0D1mmjqJu2nNwAudSwvzPEYBbtZBuyNKXTDiHtfIvk5
	yor1xmDfo4037924Y1ypHriXOkPwpRHyw4g9dHjx953ZOfBf4tgB
X-Google-Smtp-Source: AGHT+IGeNjB3NpMCWzCQbPhAaZQV6llgvyRG5b7gCOW/NIIlVaFwAk61/hP/yLztj3BEfPsY05pjOw==
X-Received: by 2002:a05:6a20:3d87:b0:1a7:892b:5f89 with SMTP id s7-20020a056a203d8700b001a7892b5f89mr3307558pzi.11.1713969937682;
        Wed, 24 Apr 2024 07:45:37 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:45:37 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:23 +0700
Subject: [PATCH v2 6/6] octeontx2-af: avoid off-by-one read from userspace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-6-f1f1b53a10f4@gmail.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
In-Reply-To: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>
X-Mailer: b4 0.13.0

We try to access count + 1 byte from userspace with memdup_user(buffer,
count + 1). However, the userspace only provides buffer of count bytes and
only these count bytes are verified to be okay to access. To ensure the
copied buffer is NUL terminated, we use memdup_user_nul instead.

Fixes: 3a2eb515d136 ("octeontx2-af: Fix an off by one in rvu_dbg_qsize_write()")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 2500f5ba4f5a..881d704644fb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -999,12 +999,10 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
 	u16 pcifunc;
 	int ret, lf;
 
-	cmd_buf = memdup_user(buffer, count + 1);
+	cmd_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(cmd_buf))
 		return -ENOMEM;
 
-	cmd_buf[count] = '\0';
-
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
 	if (cmd_buf_tmp) {
 		*cmd_buf_tmp = '\0';

-- 
2.34.1


