Return-Path: <linux-kernel+bounces-96757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED537876110
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95176B21F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD30535B7;
	Fri,  8 Mar 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqCsbdPo"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50452F89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890833; cv=none; b=RCUTI0iXeki/jbe699wFzyOsqgKKJKufqItnlBKEQDUC5wftck7oaOx4Xp3wDHgmNdgEsN4em48KY+I2vKXX1k1qCgjYfROVx+0WHZL6T9xPT2ORNyJTo2i95qzbzqZs1vBxbFIz8aUaMfmCCg7p9g/sdgzVi9koEBzp60AkNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890833; c=relaxed/simple;
	bh=DElne2Gkjn4z8oemrarE/fUztT15L2tk3hBrUdMeoIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EiZ24e5NLCMlLiZ9saBPr1QA5HaMaqpSuV4Ys72Y8qTpjirbWISsSPHUtVqbFt4usxHarpEKWFoxGFZO0mA0k+E2SWv1l7uwPrkr22/xkxIqzNpvLZIkEg0Pb0Y9d2RUO54vjIdAdw0W+kyyLIwVE/iuvOZNgFSmnBx3aHt2Blg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqCsbdPo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1536619a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890831; x=1710495631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33mEcmSEfEQlJqpXQuHN8Aso2S/mym0SCRxX2k8PMY0=;
        b=bqCsbdPo4nr0UmUwWphUQ1cjpjJeZA/KK0lU9HUEHavZK5f/YA+2uZOgkaeNetWddh
         EZ+K/IGeKtLwV1gxBOqt5YDdHbcELHUnapHeqWdatOT8xCPW/oDUdgDldp0N6SA1ByYF
         mD9oRvDbeQKftLe+FJioTHMy5hkYK9rybAY+LUZiW23UnlQu9aN9R51z2/2tZzGQ7DbC
         7yEdO3rh2xbxbrgUaruVnESrd1/74CYXspxVhqUpYHBCvqtqf/blkU/R4kHiJYE9Q16Z
         juZM7jk2fftKtP+G9yWla9w3qwMPdEGg47quS2b2gzXsrnlQyL0o42iHMYsP0Fn1ai8u
         ri+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890831; x=1710495631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33mEcmSEfEQlJqpXQuHN8Aso2S/mym0SCRxX2k8PMY0=;
        b=NI7ciHqzBUq4WvD2S0q+9kwBcnqLdM9scugDFblt7aMJDf9OAIPFZ4fXDyEuW4HUx5
         HzWGmOvlk9ZE+PyVRDqO9Ud+f338bdgyVaD2N675579lDNMM3rxVKqzOwa8YHTfk69yU
         Bi1yGxdytxLN78aaKZUXzgkfrPDBr3MSBsgfDdX6WaNv0BN1/nGblYOgyK0ZAbRktW4o
         GPAJzLx8zB9e5FcfTEOQIM+3UxPUl45ZZ75i2C3q9YrfW5hb/+9bkkZc+SDgImgf3890
         B3D0uNZSUoFLSDU4H0CqJ+tPYQKzeVuhbzm65RyN0esEwUDoai2Mdn7zGt3KcfCWtNCq
         snLA==
X-Gm-Message-State: AOJu0Yzk7KYU/G+ylyCNPK92OPzVe7nWia13ttWLb/gSwsMGiXIuSRY4
	GMwKXng6FalYRcHZJona+bLRKIUq2Ui2kX44iNrgLdkHCauVhqT1LEB3SGg1
X-Google-Smtp-Source: AGHT+IGMkipKwtUtZJr++8vhFG/1NrSW628yS6QQxQjAl6Xl9hzvRWyzDH9wXdGMuRtPhu2mnKa29Q==
X-Received: by 2002:a05:6a20:9c90:b0:1a1:667c:eece with SMTP id mj16-20020a056a209c9000b001a1667ceecemr9196680pzb.2.1709890831027;
        Fri, 08 Mar 2024 01:40:31 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id gx1-20020a056a001e0100b006e59a311e2dsm13956231pfb.92.2024.03.08.01.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:40:30 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/4] workqueue: Some cleanups
Date: Fri,  8 Mar 2024 17:42:49 +0800
Message-Id: <20240308094253.2104-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Some simple cleanups.

Lai Jiangshan (4):
  workqueue: Use INIT_WORK_ONSTACK in workqueue_softirq_dead()
  workqueue: Reorder the fields in struct workqueue_attrs
  workqueue: Move attrs->cpumask out of worker_pool's properties when
    attrs->affn_strict
  workqueue: Use list_last_entry() to get the last idle worker

 include/linux/workqueue.h | 27 +++++++++++++++------------
 kernel/workqueue.c        | 19 +++++++++++--------
 2 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.19.1.6.gb485710b


