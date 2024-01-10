Return-Path: <linux-kernel+bounces-21989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7196C82978F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A10D28F411
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078C3FB2D;
	Wed, 10 Jan 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hE1oeo/f"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D534439E;
	Wed, 10 Jan 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BEnR5
	9z9wMRhjDNJz3gaSHgwKAmRI67JW9/IsxhcCkU=; b=hE1oeo/fCWD8ZhmSzGd+H
	uMyQ5FYCVhxT8JhFKlWkdj4d0HfgS2G+oKdQN+Zw6j/sd+sGZFdeUHQ6mBN1yw57
	1hEfdEonfswh92Y0c+5DeRKbffExPpiriclOizP0AKjirSF7Qm9LwFKJ2Raw8DHw
	EIqc/1PrGUg9HCieG6RmhE=
Received: from localhost.localdomain (unknown [111.35.187.31])
	by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wD3H44ucJ5lJdMfAw--.1486S4;
	Wed, 10 Jan 2024 18:23:50 +0800 (CST)
From: David Wang <00107082@163.com>
To: ale.crismani@automattic.com,
	kadlec@netfilter.org,
	xiaolinkui@kylinos.cn,
	pablo@netfilter.org
Cc: linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: Re: Performance regression in ip_set_swap on 6.1.69
Date: Wed, 10 Jan 2024 18:23:42 +0800
Message-Id: <20240110102342.4978-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H44ucJ5lJdMfAw--.1486S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYHUqUUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEhJhqmVOBjJAZgAAsy

I confirmed this on 6.7 that this was introduced by commit 28628fa952fefc7f2072ce6e8016968cc452b1ba with following changes:

	 static inline void
	@@ -1397,6 +1394,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
		ip_set(inst, to_id) = from;
		write_unlock_bh(&ip_set_ref_lock);
	 
	+       /* Make sure all readers of the old set pointers are completed. */
	+       synchronize_rcu();
	+
		return 0;
	 }

synchronize_rcu causes the delay, and its usage here is very confusing, there is no reclaimer code after it.


FYI
David



 



