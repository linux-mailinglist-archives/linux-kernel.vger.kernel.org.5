Return-Path: <linux-kernel+bounces-163611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B678B6DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319C11C20C51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D74128820;
	Tue, 30 Apr 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lnsjK/12"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F34128386
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467436; cv=none; b=WnnHLRfiI9kw51ZWFYU/ldxTxF7lsEoR8PuUCItvN1mEaAX3yn2YHM6fxosBpICUyoyx3Z/nZOq81O8YdeG+qgv1scLluxV0Np+CyefnS0xQ+fp7lqJOTrW4WdQi+6LYicHN7obVUEaTpQelQzsdpevL7tzWMjvjK5AmlIM1RT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467436; c=relaxed/simple;
	bh=/2fEJS6FCERWu5aErMU7Sj/IGaU+g0Dcq0Va2kmaP28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1kzCu6Ac6okRoQ3NCFcibL0VDJpR3rRD/k8/uILvuOLS7oZR4Zb14DmOo/4+PO5LFWVV9r925vsx6znACn+zrdc1EIfM+G2qn/42zL8DwNzAwmD+mcVAktmSc4bN4WpFu32efrY9Vo6FnUd9atDqcjth6g6/h0s+NamCgzHW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lnsjK/12; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714467433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDKTQ7ySnyCQitXHa2W4+LR+te50oYvXk/O8GHcSFcg=;
	b=lnsjK/122vpFUb5Khby+9G1jNeqZLjt9vHtlHmZH73dllClWZnQgOQHq9qzs+DeAR5EBvG
	hy+VYFt42DrVEIV/j+czp6YlBk4r78OmhM2M2R3W6Eqqi0HM7pxU3R4+GTPRUYbo8BlF3j
	U1CDWOq9yugSl6+DfRz7Eu9AsM4VJJ0=
From: George Guo <dongtai.guo@linux.dev>
To: mark.rutland@arm.com
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	dongtai.guo@linux.dev,
	guodongtai@kylinos.cn,
	jbaron@akamai.com,
	jpoimboe@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: [PATCH v3 0/1] cleanup arch_static_branch/_jump
Date: Tue, 30 Apr 2024 16:56:54 +0800
Message-Id: <20240430085655.2798551-1-dongtai.guo@linux.dev>
In-Reply-To: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
References: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Hi Mark, 
I have tried to define macro with key and lable in v3.
What do you think on v3 patch?

George Guo (1):
  arm64: simplify arch_static_branch/_jump function

 arch/arm64/include/asm/jump_label.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

-- 
2.34.1


