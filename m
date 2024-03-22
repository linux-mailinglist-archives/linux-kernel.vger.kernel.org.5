Return-Path: <linux-kernel+bounces-110901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41F88656D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D93A1C235BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D48C1F;
	Fri, 22 Mar 2024 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UVJ+CcqO"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290D8BE0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077899; cv=none; b=iBack1afHNiWOveuxgpqNll6Dufxuld7VwCX8u9BxQ6+e35WqS/Q9eQRZL6xkEyiu3RouNyWiu/wI0Z0KsgRxQRgvRSTF+yaoBOZsKb8SY+vEq/x0evJYLphbF5SJM/XSuyVpCqEU+HgVrR+TkNjhZDnewQkgn6CEDwvV3v/rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077899; c=relaxed/simple;
	bh=9XPjD+HP21f4zddlLmex6fWKZNAEjxzYlyxyr/LxtsQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cM6YJsM4Vr/oSj1m6URO/RQJ/8p7saflBG469tRf68oBin0Q2H7p5OOk1TiGoK86Ttmbk3Ei16U/ImGLBCvy+LiADqWuCEfwUc4Umag65iR97xIOJUtiJh6+0zYGhrrazqzCzV12m+yThsCGqZMvTZDUpp2u/vAZ6O1p6zoy1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UVJ+CcqO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711077894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XPjD+HP21f4zddlLmex6fWKZNAEjxzYlyxyr/LxtsQ=;
	b=UVJ+CcqORFfUVHdqZRyiE8nwhY51TtQGbRVq27cC7AtHLcN2BtsZkcd8Wj15Eni/xVSpn/
	Ptaw19McrVffmH9YvE67dyFLMe4B8su+FODJYCUsqLYyT4UB0jyY5mfLMJP/E53NL1UbsW
	jOn93oXrVO8Vw5KqTRsQG2GX8StVyiA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZfwJ0JOgcMCTcSgZ@localhost.localdomain>
Date: Fri, 22 Mar 2024 11:24:10 +0800
Cc: syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1349A15A-341F-4EE4-AD40-805A97A9FFD1@linux.dev>
References: <0000000000006cfe98061423cde7@google.com>
 <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
 <ZfwJ0JOgcMCTcSgZ@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Mar 21, 2024, at 18:20, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Thu, Mar 21, 2024 at 05:49:49PM +0800, Muchun Song wrote:
>> There are some more page dumping information from console:
>>=20
>> [ 61.367144][ T42] page: refcount:0 mapcount:0 =
mapping:0000000000000000 index:0xffff888028132880 pfn:0x28130
>> [ 61.371430][ T42] flags: =
0xfff80000000000(node=3D0|zone=3D1|lastcpupid=3D0xfff)
>> [ 61.374455][ T42] page_type: 0xffffffff()
>> [ 61.376096][ T42] raw: 00fff80000000000 ffff888015ecd540 =
dead000000000100 0000000000000000
>> [ 61.379994][ T42] raw: ffff888028132880 0000000000190000 =
00000000ffffffff 0000000000000000
>>=20
>> Alright, the page is freed (with a refcount of 0).
>=20
> Yes, basically the page changed betwen folio_test_large() (returned =
true
> for PG_Head) and the call to const_folio_flags() (which now returned
> false for PG_Head).
>=20
> As David pointed out, Willy is working on making PageHutelb more
> robust [1].
>=20
>=20
> [1] =
https://lore.kernel.org/linux-mm/20240314012506.1600378-1-willy@infradead.=
org/

Sorry, I am not on the CC list, so I didn't know this. But thank
you and David for this information, I think it could fix this problem.

Muchun,
Thanks.


