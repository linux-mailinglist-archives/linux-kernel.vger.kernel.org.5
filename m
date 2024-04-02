Return-Path: <linux-kernel+bounces-128369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECC895A04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD79281AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81A15AABC;
	Tue,  2 Apr 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEzfPU6S"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18915A4AC;
	Tue,  2 Apr 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076376; cv=none; b=hpKinvnuYM4fARZ1psv+vDQy9eV/qnXRQKH71ZeOjoYPWXt+c7nisXR5RbeAmIPtoNvQN3SITddMUDA1S6PU73Z6a/CG5btBL7iA7tnZ2UxoEzG0DOBHag+I/QJYFIdPZPDByW14WVsBAxCq2+fzXwMXSqnFCo/vw5igExBbA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076376; c=relaxed/simple;
	bh=yE0FsoUymeXjfLMsyNScjrVGMjxDxsYpVdsOrcTmCh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6NoejLQVGL56Eh915VhJ5/YzYReTTz96H7I7rUhUZYOpL35AbP0Mo0GdqNSo1cHg62YMkhTQuQ457djJ3um7Jqay6F2VearaiRx09FhFohhgEM1NVNxpZygRDDm8YEOflVrJNVZLOOGsam68IdShCl2O1m/JEl7qqmOWLFQmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEzfPU6S; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d247e3c4so49868e87.0;
        Tue, 02 Apr 2024 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076372; x=1712681172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NYgY1znrae2KCyhiaf38CHKStR6C+BE55+RHyD8rWk=;
        b=KEzfPU6S7l0lVM8/PZPSaFutv/a6DImfRBrBPFxJFgyTBU/Scf/N3xTpZGgtczgJRc
         B6pUQkGjgq6HIGOKsT33AzMn1PhOv9DCOU1/FZdv92WCbR3yK2Vb6Rt7YVVG2X+idzSB
         Q+x6d8sSzrGeLfAS3CL2qdiYMDhAjTGv0Dtdi5Fp5Xc1EiDKqAYMrZAgtkbdoRscTZtm
         M6AWz6JT78RyGdryYeQwCOjbKwPU05Sdoj2xd4fJMymHoHk48v2O1oSmYubl6hshuDoW
         r+hLVCzbh3Wo8CTfV/G6eX62ykSVjqXJZbVJVhbLbOKI0TPDahnwGKW4igqxAkaSO6Le
         IAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076372; x=1712681172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NYgY1znrae2KCyhiaf38CHKStR6C+BE55+RHyD8rWk=;
        b=EAWhmPEXrs1u5te2lNhTDMdsrn3XWFpQm5RbAQYA0HFAJIvc1TH4sm6ZT8Tb5rcynM
         fM51A/TcqiPfKET9h4OWVlIOA97GkwvSMDl4WmkDWufOckKtyiYXvviTh4fhCvLaK7W7
         JbwiLp7BqeXbyXWEaw7rpjfE/nwyijvSshNU5UlnCqxnZKFRcpRkvm5WsSN7uyGj6Hza
         R5wQ650yRYf+up5hpavhbHm35O132+YGo0EQj9OQFEytqxqii3yKyTmcXhJ8uysdIIDZ
         S/d9N8x/xlp2o3oJT/jk5sbGgjnMbd5POlskuQF1fJGUIJ30ikQDqzQh1rTtrAm+S3KU
         wHCw==
X-Forwarded-Encrypted: i=1; AJvYcCUXnOaSnDl6SUY+RcgK9NDPmoPCAUfaxX390WdradgH2uoc4OGe+3JHBF998rpz1fBm2MGNS4aeFZGiYj7wxbr+G/OeTDf7jiNpFEKc
X-Gm-Message-State: AOJu0YzreH+G4tuGUYSJygd23azWoaLi84p2Rc533ref46qeocfHyPfy
	lgtE60LK2ymfHJ5m1ly7jajQoKEcjl2oaEMRpKliEYQcVkh7l9wlT3KTTxzQo45jiQ==
X-Google-Smtp-Source: AGHT+IEbqT1qtDrPXym+06/GaUki8nFJlVHxGAeNzFOWXRypLpTW30p4QiC/2evEZByVTFlJz7en9Q==
X-Received: by 2002:a19:5e13:0:b0:513:d125:43b8 with SMTP id s19-20020a195e13000000b00513d12543b8mr11018lfb.25.1712076371753;
        Tue, 02 Apr 2024 09:46:11 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id z10-20020ac25dea000000b00515d4457ff9sm1190395lfq.89.2024.04.02.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:11 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 03/20] media: i2c: ov4689: Fix typo in a comment
Date: Tue,  2 Apr 2024 19:45:34 +0300
Message-ID: <20240402164552.19171-4-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling error in a comment.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index a6c101044eb3..f2614a0b1340 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -692,7 +692,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
-		/* 4 least significant bits of expsoure are fractional part */
+		/* 4 least significant bits of exposure are fractional part */
 		ret = ov4689_write_reg(ov4689->client, OV4689_REG_EXPOSURE,
 				       OV4689_REG_VALUE_24BIT, ctrl->val << 4);
 		break;
-- 
2.44.0


