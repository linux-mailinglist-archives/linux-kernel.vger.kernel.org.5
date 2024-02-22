Return-Path: <linux-kernel+bounces-77349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01086042F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B687928CE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479273F3A;
	Thu, 22 Feb 2024 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfpSA7iM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9AA73F0C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635486; cv=none; b=KEa/FKsdN6yoVxJpZrlY8Hgvp0fMWK7dtFpuzF2LSorxz+cg1OGFvZ56uJsUSIDOBtT5PZeX8u/aL5SEcUODZpQkfO9zzbF3PKwJr8b9UV4TrxfhPjzfU16cy4KP1wPFrafLIFAVnVMPeQ+pN+XpGig3NTr2DTOOkT8wdyM/4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635486; c=relaxed/simple;
	bh=KO17FxZqGQUTkWpzYZMY3Yy4KQM5Bz9Xy9i+eEsb9uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrjamSw3tibInCgiLoZJ77sINaqp2PK7yVVn56a/5M70v+jJ3bY2VPkZeEeZHfSyPrYDFrJlu2e+H6hogw2d9Zij5aRvo1er2FTecspHKuU99xA2ZSCgbUfN8GMPC+C4VKuEyB8Nc1giGl6jNojI5jjAEA/fYFIic+dG7JjKcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfpSA7iM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708635484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uQNCPPxOXSIi1YvPzBU8stcQQepKpFfnl3c3A7lEn1w=;
	b=GfpSA7iMstK3TApu2JFY6mmuYZs9vWfU793d/EA5McPw0zmMJcW2Fs2feneAxPZK76u73N
	Mvlp66MDTdweIfJnd6XDVQMjPYFDFcESoTruIgMXA4N2BJ26dRKmlSEj4Uvc6k65yKQSOV
	fLAQti2wJR7750gzy1gfUPRvSimWizc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-iPvArl2jNXObXjSmQJpj3Q-1; Thu, 22 Feb 2024 15:57:58 -0500
X-MC-Unique: iPvArl2jNXObXjSmQJpj3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43454890F64;
	Thu, 22 Feb 2024 20:57:58 +0000 (UTC)
Received: from ibm-p8-16-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC3EB10802;
	Thu, 22 Feb 2024 20:57:56 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: ilpo.jarvinen@linux.intel.com,
	shravankr@nvidia.com
Cc: davthompson@nvidia.com,
	ndalvi@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
Date: Thu, 22 Feb 2024 15:57:28 -0500
Message-ID: <cover.1708635408.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi,

The mlxbf-pmc driver fails to load when the firmware reports a new but not
yet implemented performance block. I can reproduce this today with a
Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
reports the new clock_measure performance block.

This[1] patch from Shravan implements the clock_measure support and will
solve the issue. But this series avoids the situation by ignoring and
logging unsupported performance blocks.

NOTE: This series is based on latest linux-next which contains new changes
to mlxbf-pmc.

[1] https://lore.kernel.org/lkml/1c2f1b6da51523fe0f338f9ddce9e3903148f604.1707808180.git.shravankr@nvidia.com/

Luiz Capitulino (2):
  platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list(): make size ptr
    optional
  platform/mellanox: mlxbf-pmc: Ignore unsupported performance blocks

 drivers/platform/mellanox/mlxbf-pmc.c | 56 +++++++++++++++++----------
 1 file changed, 36 insertions(+), 20 deletions(-)

-- 
2.43.1


