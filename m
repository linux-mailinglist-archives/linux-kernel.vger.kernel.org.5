Return-Path: <linux-kernel+bounces-96055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD7E87569B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C68A1C2141D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65B137C33;
	Thu,  7 Mar 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOrcAxHh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AB136663
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838359; cv=none; b=oyMc09w7sqC9jCoXdzTzMf4qV2UjdR4L60qcOqzTL7Mw0bLMNYcBW4qxhLfPv2emeZ2SH9QpNxORFJ42IK14cDZ1S+Do9rE2ToZc5qB73Ux6yCZEthn3T+h4n9/9a4/rnj8Iv1UbcDdOG1aFnoZL5dUhgZkEn2YESqa5cZ+KsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838359; c=relaxed/simple;
	bh=Ih4ktTzIyaeVkaakCPU+cWTcUAGjxp+w40KS9sTMnEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFhH9IOs2RHzHvZD3M9klxQLhFfeWR5meqX9skPCtQd8vQqB/JaxXReGxY+jClXHZeuw4D0nWXagFrEV4M/3aU/+sjdznYUKaCKLsEQ15XxjhtOpjVUXiQhjWhyqZ6CLxKHFXAyJy9PdGav68VnW4FU1OOGfe8VtLObiMBOHAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOrcAxHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709838357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c6iPnAD0cw9qJdQfLtL9m8kcE1/+mcntTfIjJ/1xUPY=;
	b=ZOrcAxHhk2Tge/H5sSrgsp+9t7bVb2gVz0doI3hGrErHMeq8KIkcGcM169/1yuPl1o4Ra4
	XX4Dqq9e0KCNX/0wl4zoU6+lTjghc42tF4DW4jgrUH2fUvIpg4zmZbg1vveAAtGAP2gynL
	mYgTwcxb3+Vm0O211T/a8cGJ2rq3Mcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-DOPq5pkLNH2vgVoWPXYZww-1; Thu, 07 Mar 2024 14:05:55 -0500
X-MC-Unique: DOPq5pkLNH2vgVoWPXYZww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DEA4185A783;
	Thu,  7 Mar 2024 19:05:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC6522166B33;
	Thu,  7 Mar 2024 19:05:53 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] mm/kmemleak: Minor cleanup & performance tuning
Date: Thu,  7 Mar 2024 14:05:46 -0500
Message-Id: <20240307190548.963626-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

This series contains 2 simple cleanup patches to slightly reduce memory
and performance overhead.

Waiman Long (2):
  mm/kmemleak: Compact kmemleak_object further
  mm/kmemleak: Disable KASAN instrumentation in kmemleak

 mm/Makefile   | 1 +
 mm/kmemleak.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.39.3


