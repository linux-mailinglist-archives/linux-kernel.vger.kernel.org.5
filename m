Return-Path: <linux-kernel+bounces-112215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA78876FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D841C2122F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E284A1B;
	Sat, 23 Mar 2024 04:07:25 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B83212;
	Sat, 23 Mar 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711166845; cv=none; b=X4osUGSl3KnmD+3wsBtKx0xXdo+gIuW66R8yzWS0ysKCtb7QaV8pfIVCQhumvSbweUSDQQ8BbpV4gtn4whJfErWP4agVyKoSjhU2fIDPWcklz9REOxrjvcNns6/OyInjOSwaZj4OlLp4RcCtosyRDjedWMTi0PZ/moy4McRtczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711166845; c=relaxed/simple;
	bh=53+HDN4Gu4DKIzm6NKYD884OFkgcG1uX5jRvgTqedSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFajyNPyOPKff9WmPpq1nNZRgez2v3qxmkhwmaxyBmbjn3uZZfRnNs6Oa6KXOD5FLtBpptftH5WO6hQr7OMeyWNuTyVgLzPTcww+fwyZbo/rIDXgoiG5u087p5j3nMZ+w9eY+UIN33ECgPKmd7nhb6Yw2/YEnVHQAmtdSUIucOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1lyT3SP3z4f3jdt;
	Sat, 23 Mar 2024 12:07:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8D0161A06DD;
	Sat, 23 Mar 2024 12:07:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g51Vf5lhTs2Hw--.40826S4;
	Sat, 23 Mar 2024 12:07:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	hch@lst.de,
	bvanassche@acm.org,
	axboe@kernel.dk,
	mpatocka@redhat.com,
	snitzer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/2] block: support to account io_ticks precisely
Date: Sat, 23 Mar 2024 11:59:54 +0800
Message-Id: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g51Vf5lhTs2Hw--.40826S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (2):
  block: support to account io_ticks precisely
  block: remove blk_mq_in_flight() and blk_mq_in_flight_rw()

 block/blk-core.c  |  9 +++++----
 block/blk-merge.c |  2 ++
 block/blk-mq.c    | 36 ++++--------------------------------
 block/blk-mq.h    |  5 -----
 block/blk.h       |  1 +
 block/genhd.c     | 20 ++++----------------
 6 files changed, 16 insertions(+), 57 deletions(-)

-- 
2.39.2


