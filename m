Return-Path: <linux-kernel+bounces-131325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26589864F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE07288BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97A84A31;
	Thu,  4 Apr 2024 11:45:18 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B885280
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231118; cv=none; b=P4X2qWKU5RoRQZA4H13eyXWh/FKlGj2NzcxlTsvG8a+RWNmOY5k7oeN/UqvhI8ufxXroteIXG4USB1qPuLBtq5DX4ulDXYC+YdBMdKWDofmu2Nqkqkxp+1cXSV+toHEngqgvn1LPmtT8d0GeWCB3jpGN+qG2OfxUjtKiV54LbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231118; c=relaxed/simple;
	bh=ylbl0xLM20RXeU86JQxIxQGnFc4IkTJwmxXrjH2ttMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QL/L+kpaK6afUps2Y4eTAuOP3adhs+VHPfOTLIjfXlyqRp6ancyXGu0qgOJGmpmpcBXSr4tjpdfBKxgZ6mVtwZIlRCZ33EWKWN6zUB1AV2pnxDWtlNoi/MYCZwWC0uVvE7b654J5dJWxJrrXtKsDeCBkUxvUjxYJzVoY48BwRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.253])
	by sina.com (172.16.235.25) with ESMTP
	id 660E92BB00003139; Thu, 4 Apr 2024 19:45:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 70933534210418
X-SMAIL-UIID: C5660C13CBE64EE8B9A9F29231FF9B65-20240404-194502-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
Date: Thu,  4 Apr 2024 19:44:50 +0800
Message-Id: <20240404114450.4136-1-hdanton@sina.com>
In-Reply-To: <000000000000b92a9d0615433065@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 03:56:24 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    727900b675b7 Add linux-next specific files for 20240403
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13764a3d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  727900b675b7

--- x/mm/madvise.c
+++ y/mm/madvise.c
@@ -482,10 +482,7 @@ restart:
 				err = split_folio(folio);
 				folio_unlock(folio);
 				folio_put(folio);
-				if (err)
-					continue;
-				start_pte = pte =
-					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 				if (!start_pte)
 					break;
 				arch_enter_lazy_mmu_mode();
--

