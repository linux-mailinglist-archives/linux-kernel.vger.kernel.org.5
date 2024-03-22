Return-Path: <linux-kernel+bounces-111403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43E886BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C247D1F24B42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01040876;
	Fri, 22 Mar 2024 12:07:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949D405E5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109229; cv=none; b=nkKg+AYmtoPd8z46aotzzY59xz5Y9IigCJKTaTg+7Edu/sYHQjQRlmCRFE6EOHASTWJ+Mqbl/eIecGmEnBXl2AQUxsJDEMGVBYMglaR4NS4KiVI9FjypxEFeCmK6NR4PkXF2VLapduGoCa5DXag/N+A58mjX0wTuXr3jgsRlnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109229; c=relaxed/simple;
	bh=kufeTNTTFGWRuFYb0FBECu4GuGhaE+m00A8aK6r/Qio=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u52j3UWqcwNpd7QNLSl8XcGLKzRl/rErOcWaMdS4xS9oPKciUKs9By0HumVY0/8zbE1bDII0fO7qgdfFPjFG5ceiHtM4Zo7xQ8TYHnGVHRBmrHatD+rXjaXZyxEFdF1RqzDKjGsEO31LoepR8fMZQI7GhQU3UGxGRGVbukyQ5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1LcP36Jyz1xsN1;
	Fri, 22 Mar 2024 20:05:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 821E71A0172;
	Fri, 22 Mar 2024 20:07:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 20:07:03 +0800
Subject: Re: [RFC PATCH 2/5] ubifs: Initialize or update ACLs for inode
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-3-lizetao1@huawei.com>
 <2991c168-723d-48ef-8420-61e22a897239@huawei.com>
 <661736fb-bb3c-3519-1f4b-44dff285ea0b@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <10859a10-5c31-a5ec-02f5-47216132cf01@huawei.com>
Date: Fri, 22 Mar 2024 20:07:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <661736fb-bb3c-3519-1f4b-44dff285ea0b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/22 19:57, Li Zetao 写道:
> Hi,
> 
> On 2024/3/21 11:47, Zhihao Cheng wrote:
>> 在 2024/3/20 0:16, Li Zetao 写道:
>>> There are two scenarios where ACL needs to be updated, the first one
>>> is when creating the inode, and the second one is in the chmod process.
>>> When creating directories/files/device node/tmpfile, ACLs needs to be
>>> initialized, but symlink do not.Why not support symlink? It looks 
>>> like many filesystems(eg. ext4, f2fs, 
>> btrfs) support it, except xfs.
> Thanks for the reviews, but this is inconsistent with my understanding.
> I think most file systems in Linux do not support it, because most file 
> systems do not register the get/set functions of ACLs for symlink 
> operations. And the posix_acl_create() will determine that it is a 
> symlink type inode, and then skip the creation process. But except for 
> bcachefs, it may be to solve the problem of certain scenarios, so it 
> would be nice if anyone could explain it to us.

You are right, only bcachefs support acl for symlink.

