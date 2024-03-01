Return-Path: <linux-kernel+bounces-88336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1786E02A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7C2876A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E086BFDE;
	Fri,  1 Mar 2024 11:26:31 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC476BB4E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292391; cv=none; b=p8beTNg6byqJzKnkuiQdrPo81XL7m9KtgknwG/rrHnCPZIFZNmz4FU02+eweuDFCe+2RHunj1EbyDu0IUjqMkC88NEXaUwL0DpR1TG99Nst9kOD9Gqh8VDVx5b2etSjx2/8FSpmJE7icscgfbfOCHjk0Co5v9+Mdg1hq9wLW0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292391; c=relaxed/simple;
	bh=nbVwHvjmHH4KDCGPaevXUB6jSz5bGZKRg15ibfjJG0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtZJsN6uNOZxRaqULhbKTryVQQ85UigYrI0gAF57Q2VDOBj4taeoyHtQJIid7Qo1Bwdb9XRgkfRNQ3gd6l4ZzGUUgFfGHPCXH03alo/OGUtsWDnfqFQXcYc0zUXGiiQOYdarVjV1SvofnU+PbvMZn+co2FUCA4XB9yht5MBEFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.15])
	by sina.com (172.16.235.24) with ESMTP
	id 65E1BB37000026BE; Fri, 1 Mar 2024 19:25:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 51075845089115
X-SMAIL-UIID: EBE7EC53C58A480281876D9622824AFE-20240301-192546-1
From: Hillf Danton <hdanton@sina.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: chris@chrisdown.name,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yuzhao@google.com
Subject: Re: MGLRU premature memcg OOM on slow writes
Date: Fri,  1 Mar 2024 19:25:35 +0800
Message-Id: <20240301112535.1609-1-hdanton@sina.com>
In-Reply-To: <20240229235134.2447718-1-axelrasmussen@google.com>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 15:51:33 -0800 Axel Rasmussen <axelrasmussen@google.com>
> 
> Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
> makes sense to me at least that doing writeback every time we age is too
> aggressive, but doing it in evict_folios() makes some sense to me, basically to
> copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> 
> I can send a patch which tries to implement this next week. In the meantime, Yu,

Better after working out why flusher failed to do the job, given background
writeback and balance_dirty_pages_ratelimited().
If pushing kswapd on the back makes any sense, what prevents you from pushing
flusher instead, given they are two different things by define?

> please let me know if what I've said here makes no sense for some reason. :)
> 
> [1]: https://lore.kernel.org/lkml/YzSiWq9UEER5LKup@google.com/

