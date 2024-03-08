Return-Path: <linux-kernel+bounces-96979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A6087640A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8336D1C21533
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79E5676E;
	Fri,  8 Mar 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvwdXM/I"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572A535CA;
	Fri,  8 Mar 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899826; cv=none; b=S98WSt33X0QTeHI4TNHV6rK3F0P20Z4lEVQTGYvwjF0fYyk6A2Kgjm/BUbnMCd1F1o54glbttfY4HY7ECVvxusSEHH3KmvYwmRwy7otE3jQSGA8KLap/inPwsT/M0xVz6tn+WcT7mXsOEGgt89Fv9gEX3HaU1b9tpWYwajjM6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899826; c=relaxed/simple;
	bh=Umw52OeAdsCrNTCL2UqZxJ1nYRjrDFqkST66g4dDbGc=;
	h=From:To:Subject:Date:Message-Id; b=iMxMHEQ8G8WFYy+G+Ml3YGfztOIZd1TkR/S0DCD0hNhhVCoMKTfHt4/Ub/MgKSrUFaHvji6avaDv1Xse91DJqlggYcaS9YtlRqmxAINvl7gqdk1Q6H53RlBaKPy70qb0FgmeN33RkxkCf+v/Qv0sOll8/9Q+YJc6gzvg4NOxsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvwdXM/I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc29f1956cso5088275ad.0;
        Fri, 08 Mar 2024 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709899825; x=1710504625; darn=vger.kernel.org;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT4YKhx1arQKM4uZFE6CXUn3u3YsdPfEE6W1XkpDDy0=;
        b=FvwdXM/IPjZt+7o3kBFuAll5FU/BVwPWDbIfpmdEZ8FOh3TTwDh7XjxpQfdRPhzvt7
         2Bwr5d7W14h+Elt24k4g46BXGnQrlhg1JNWbrN6XL2+2wdQu70nYKvtvkB3co2W9eqLt
         /8lYwD5EttxlNuE+YLcW9AFjK4NZKMen/nQuKBr2UOsUVKXtviz15gWxvhZYfg8EfnTH
         xxMCiUQtlMKnO2fOM8JZJ+mh99kiXNkech8jyWp2kH9zq1PAHpSMYoRmsjBujRhUDAZK
         4Nf00Inpy1+XRuKdfKWrMixMDRj024q79SfsurbNqr9I6k37DPaRD/7vn6yZeA/y5o6Z
         bL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899825; x=1710504625;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT4YKhx1arQKM4uZFE6CXUn3u3YsdPfEE6W1XkpDDy0=;
        b=j0CSGjjmegYcvsdI1A2BV/URH07eANl7t4j4N9TxN02iUUSWUK1SMFgLL0JTESI6XG
         cASrKfUAtgrvPu/iDOtv1gFN9Hm+RdS/Kz3FojZ6Xg7ZjwmtJr/qNMLlgJRTwBIsN3js
         JVYQHF1v5ISSelaw+FyTl4/R+z/bR/7/I6cXCJ5g6WN2jymUzUoXzOP66BpaSfUZiCYf
         pPmVAAWjuBLaazionwOeINRH34Q2SEDoD3w/4Hu0pNd8ozGPOKpTrtIiXJxfLTwnVVqO
         ZMrfawhsGq8gEAT1ONKaF/Jj3n55wI5vKFoox+Wgm9FLd8hXwCIYQJ1F0ei4vHsNdB4s
         FcsA==
X-Forwarded-Encrypted: i=1; AJvYcCWbS6/gG8+VXl9lqNpZ3dj9WDn32y3fUCa7GGx51fNaFaFT3ROZbxJeQEH/+PoeRn/UC5dSfKKQoEsxvAqy4ass5LGZZUvVtkZvjaC/7DrtKRLkSBS5KBrt2gsJLKL7Pf1iF2HQUVWoXJo=
X-Gm-Message-State: AOJu0YzkSCI+fsv6/MzgBN+RvrjAQp82dTBkfanzcWBMVAiZvjAxgdhE
	85r4ZLNwSoyEyDR+glc8Rayu1uHBUtdCdsF4cf+AeSpQhSTn4+EBVdzpvjawRwA=
X-Google-Smtp-Source: AGHT+IHsH8NDwM4TODYOCRN5NcxpEfZ5S2tEIVEttMzmnICm6qCNbDEBiYPhQlBVvEUzv2dZkNIrTA==
X-Received: by 2002:a17:902:ec92:b0:1dc:42da:bad with SMTP id x18-20020a170902ec9200b001dc42da0badmr12957207plg.62.1709899824581;
        Fri, 08 Mar 2024 04:10:24 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-52-78-100-77.ap-northeast-2.compute.amazonaws.com. [52.78.100.77])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b001db37fd26bcsm2491016plb.116.2024.03.08.04.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:10:24 -0800 (PST)
From: yongsuyoo0215@gmail.com
To: mchehab@kernel.org,
	yongsuyoo0215@gmail.com,
	v4bel@theori.io,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
Date: Fri,  8 Mar 2024 12:10:21 +0000
Message-Id: <20240308121021.1732-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Yongsu yoo <yongsuyoo0215@gmail.com>

Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>

In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET
ioctl is called, the dvb_ca_en50221_slot_shutdown will also be called.
Inside of the dvb_ca_en50221_slot_shutdown,
the ca->slot_info[slot].slot_state will become DVB_CA_SLOTSTATE_NONE.
In the most of cases, the ca->slot_info[slot].slot_state will quickly
becomes restored to other states by the subsequent operations of the
thread dvb_ca_en50221_thread_state_machine.
But in some rare cases, when the CA_GET_SLOT_INFO ioctl is immediately
called after the CA_RESET ioctl is called, the
the ca->slot_info[slot].slot_state can still remains at
DVB_CA_SLOTSTATE_NONE, and this causes CA_GET_SLOT_INFO ioctl not to
return CA_CI_MODULE_PRESENT as info->flags even if CA_CI_MODULE is
really connected on TV. This means that the CA_GET_SLOT_INFO ioctl
does not return right informtion. This is a Bug. We fix this bug.
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..8d37c3c13227 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1403,6 +1403,10 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 		    (sl->slot_state != DVB_CA_SLOTSTATE_INVALID)) {
 			info->flags = CA_CI_MODULE_PRESENT;
 		}
+		if ((sl->slot_state == DVB_CA_SLOTSTATE_NONE) &&
+		    (sl->camchange_type == DVB_CA_EN50221_CAMCHANGE_INSERTED)) {
+			info->flags = CA_CI_MODULE_PRESENT;
+	     	}
 		if (sl->slot_state == DVB_CA_SLOTSTATE_RUNNING)
 			info->flags |= CA_CI_MODULE_READY;
 		break;
-- 
2.17.1


