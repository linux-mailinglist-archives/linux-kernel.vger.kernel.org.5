Return-Path: <linux-kernel+bounces-57291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5184D67B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6823C1C2402B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F93620313;
	Wed,  7 Feb 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jFhQWVq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD61EB23;
	Wed,  7 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347105; cv=none; b=PlFhpsvnCw8RNRUCSdDMFQaEhEvAuIb4Auqb7fEdghCBCaxYhaP1dP3l48kxO673OzfOrpj7DZ5Da1DBaKu3OQpPclPnzPjOoem9pSXTjn6PrTMQ1IF/ybvtNvkGKusWlLf5rHlsHZBb/50/DE3RtG7asJNb3uQLQKUnwXFkxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347105; c=relaxed/simple;
	bh=4BjASI5o6tvggVKonNgqERKXvBBiAS/dqPsYkoe6JOY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=idtqsOQhGPk3AlvLljIAwP3NUWG4j1qBkX57nkK9deljv65n+hOqLAK/BgRgjC7PTkFYCr8+hvmieNzmw5LwJBSoxXY09+hHQJz61YLxhRS7ZZmXDvVyIUhhcT+AFn2Sj9hYr6amfV1bwQGbLpFvMTjD+BRMZALZOnlPQWvtciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jFhQWVq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3BAC433C7;
	Wed,  7 Feb 2024 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707347104;
	bh=4BjASI5o6tvggVKonNgqERKXvBBiAS/dqPsYkoe6JOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jFhQWVq8EzKzmIwAYefphQlZM82G1QoacYIaQqrzJjEkJ8smUiTB7x2X8H4PF4CqV
	 EmIcBSo6fVVTyMyoVWUnCWptsPR7si2Eeuy1YL8glOP/ec7ZgX/g/pU07BZBDxrgjZ
	 rH1GtqasLYCAeJmiNFD5lKiAMfTUF5t9LFSj8bvs=
Date: Wed, 7 Feb 2024 15:05:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
 mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
 david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, pasha.tatashin@soleen.com, yosryahmed@google.com,
 hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v7 0/1] mm: report per-page metadata information
Message-Id: <20240207150503.ca18b372f899091af5e6c40b@linux-foundation.org>
In-Reply-To: <20240129224204.1812062-1-souravpanda@google.com>
References: <20240129224204.1812062-1-souravpanda@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:42:03 -0800 Sourav Panda <souravpanda@google.com> wrote:

> This patch adds two new per-node fields, namely nr_page_metadata and
> nr_page_metadata_boot to /sys/devices/system/node/nodeN/vmstat and a
> global PageMetadata field to /proc/meminfo. This information can be
> used by users to see how much memory is being used by per-page
> metadata, which can vary depending on build configuration, machine
> architecture, and system use.

I'm not seeing why this is very useful.  OK, you look at it and it
tells you a number, but what action can a user take based upon that
number?

Please tell us more about the value of this, the use cases, what
prompted you to expend effort on this.

