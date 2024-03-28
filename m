Return-Path: <linux-kernel+bounces-122599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56F88FA42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691E91C23C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60555769;
	Thu, 28 Mar 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGl1UpLj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415350A97
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615717; cv=none; b=pZkPKxXiSDjhyXF+dVG8u5HoMeZCg4aWqFadUjDhB1y6KL0zpFX+nxn9NEasTDP9PLiO0aYz+EbrT6XKXAp7jI/Q0Zl/zqErIiIbajNpZMSia19R7+7Z4g3/7KqXKPtyaojmYFrlT2N+ztwKCX41TaLzd/c4pL5tT0O9YGf19wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615717; c=relaxed/simple;
	bh=VK3K1906pn+VZ1ChQSfs4FviSEXV15gaAIHqx5oSo9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LT9yVT2AicKtG1xlvZCG4BmXUiiwqdxYITRliEdDUsOqUkPsXZCfqe46kNOiPnQGytOV8oSugDJ+WnX7IHCz99gTtEoIR+12Ev+azI7k9F56fmEiKzuq9bWtLBCWyv9aNbrNMbgxUEquHMNZXdmC+HKCdKwpPhxOutFkPZZ2rUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jGl1UpLj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UKVEcTbagBAdMxFicyIyswFc3/9wne69Ef2ZgpUnIgY=; b=jGl1UpLjd0SdQYxaQdg0BkAXvC
	+JiWd8Z5T7oTxTtj2RCctBk7mri3XCqK2B10szU+SA8LzZo9eYpJuAunqCAyPzDVI8E5GvBacxHwN
	RV0koV2UqcB6N4yDD+DpVMvQ164HlYaAK5PN5U2Tk9IbFcuVJi6uwIS8DB8lHKbDSpa/u1qnYpNRw
	WX7yPlQBoKVGt4mb9Y3C6VaR1uNwVsDV1PLJ2E08J9jql3rOSEmJkTD0UNSZWgwrnkGEFtHG7WM9+
	CI/RMdDUd9cYux7+96YucWHG8xAQYXYYj/EF3n6bes2VmXzfYydNdzzQYygd7yZZkpdkN3o5n6k3S
	6ebH2SJQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplR4-0000000D950-1vmb;
	Thu, 28 Mar 2024 08:48:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: remove unused ioremap-related code and export
Date: Thu, 28 Mar 2024 09:48:29 +0100
Message-Id: <20240328084831.2955605-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Russell,

this series removes one unused function and one unused export
from the ARM ioremap code.

Subject:
 include/asm/mach/map.h |    7 -------
 mm/ioremap.c           |    8 --------
 mm/mmu.c               |    1 -
 3 files changed, 16 deletions(-)

