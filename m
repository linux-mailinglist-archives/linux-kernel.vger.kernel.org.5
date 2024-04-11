Return-Path: <linux-kernel+bounces-140390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4F8A13C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977C31F2165D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FA14A627;
	Thu, 11 Apr 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M28gMKaR"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDC13FD9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836692; cv=none; b=ix68sF+kV80hH/SNcvTNHgVgeM5ABAmugRFXlf2l9TDp7lEqbFxb0cORfpvoCbqnj7TyOgXQAFV3TlQu5adWGUfFlLRM22HO+ueIrN++jqHLPJe5vV66WUCYluvJw1nhvCNQm2ebojRiSOgzSlddtn1jS5DpQnqAcmss+5UxO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836692; c=relaxed/simple;
	bh=IUDw7H4hboh4qzKlyLqHQAVJxJPRvKYfydLuR3Ts37I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRb88Wo6ePy+rdfwqIGkR4PqY06XCDe6AiBQ+TTjgJDN/mfO3044uwYhYsMpOWNULFCjRJn58YE1zpe/xhV2PJCk3zHvc/NE3c6rDf3qIPvMwF6qwm4PqoS1xpfngQW/Y10xiiH/13FrxWst8iGUTO6S+IfvhnPH6UUZ8jebpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M28gMKaR; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712836687; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IUDw7H4hboh4qzKlyLqHQAVJxJPRvKYfydLuR3Ts37I=;
	b=M28gMKaRQjRB+j+hcKQ52uH7QIUGHBFAEH+wesyLnSSVE2QLw+FgZSQUwL9NubWDcYxuBj/XHsksKHDN5OB9cvPh/KRDUoKWX0JDfeBArqh17PZbcqXupkAjALlpoMN1ql1wUgTE5KT1BrnP3UCiw7a0mG+YmEb9hsowrpQ8hjI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4L5Jp0_1712836685;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4L5Jp0_1712836685)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 19:58:06 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: guanrui.huang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	yuzenghui@huawei.com
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Fix double free on error
Date: Thu, 11 Apr 2024 19:58:05 +0800
Message-Id: <20240411115805.115673-1-guanrui.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <86r0fcrvsz.wl-maz@kernel.org>
References: <86r0fcrvsz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if (vm != domain->host_data)

This is just a safety check. It looks unlikely happened.
After all, vm is obtained from the args. If the caller has a bug, can we check here to avoid possible problems that may arise in later code?

Thanks,
Guanrui

