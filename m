Return-Path: <linux-kernel+bounces-103274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90787BD53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14BC1F228A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C575B03A;
	Thu, 14 Mar 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mnqlVAWL"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4C5A7AE;
	Thu, 14 Mar 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421781; cv=none; b=QvxRrcJZ/SgQNHxakITvAUGnGpdQDaliOrU6yvxg0HAKOKQpF4gvbyWWoAxbq+ZP+JfcJgs6hcjo0uaKTek7GlxIl757dc15dnfUnEjR2UiS+3fMY/rx1mK1Q3sa3/MgcxLU6U4ryih4VVll0N85b5nMLzHzcfukS8EZDVPZ77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421781; c=relaxed/simple;
	bh=X+C4Lb37uB9McXdaw6/uGad+ij/t1LeB2+QKiBogxVY=;
	h=From:To:Subject:Date:Message-Id; b=p2XeQ7+jw6DuNybROGmMbKipy/UIrohotLtTxP4tegjCSmlGR5LjZNZZQeM9//zc6J43qe5lP/xuKGMbEiT6GWnyjvNtx4e95XMk/hAdRo4KJg8QqY4HmCyZM8+yt0HrPYiFrdg88zaEqToPzNoCBuF8FlKsqmP93nhhEB3DVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mnqlVAWL; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710421776; h=From:To:Subject:Date:Message-Id;
	bh=WxLutTnRoPbq6saJpMDkQW7pepYVttH65771Wfq4fM4=;
	b=mnqlVAWLDZUq15xD+cThmjVa8ct/lrY+3d/59w1U1DHSy7JhZYVKvkur4X2BioF3DVNb+PXOBB3ItqHbU47sRzYjZL8QZxpVrNnszx7QYApm+t8SczVXaDfQu8iw0aZM3o6Zrxyn4sve82nMDnc8sllrQqpGwebzkioCzwmLZI4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2Swf5l_1710421773;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2Swf5l_1710421773)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 21:09:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Tal Gilboa <talgi@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RFC PATCH 0/2] net: provides dim profile fine-tuning channels
Date: Thu, 14 Mar 2024 21:09:31 +0800
Message-Id: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a channel through which
the NIC can be custom configured is necessary.

Please review, thank you very much!

Heng Qi (2):
  net: add sysfs attributes for customized dim profile management
  virtio-net: support net sysfs to fine-tune dim profile

 Documentation/ABI/testing/sysfs-class-net |  17 +++
 drivers/net/virtio_net.c                  |  64 ++++++++++-
 include/linux/dim.h                       |   7 ++
 include/linux/netdevice.h                 |  35 ++++++
 lib/dim/net_dim.c                         |   6 --
 net/core/net-sysfs.c                      | 172 ++++++++++++++++++++++++++++++
 6 files changed, 294 insertions(+), 7 deletions(-)

-- 
1.8.3.1


