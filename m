Return-Path: <linux-kernel+bounces-131952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A6898DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4306A1C233EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC31130A56;
	Thu,  4 Apr 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eu/GxhyK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9D1304A9;
	Thu,  4 Apr 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255119; cv=none; b=LMd+wq69nqIEsAYkIKtWNS9pE3FQBAHYbht2aj/IyxqqnW48fDLB7csR6oG3enUViutKN5pPNEYSoFgmEBwEc+tVJ8rNzgV0kj5GniGukrMgj3qdNdYERUibKJ1cA+Q3Ud0blOqhWjE6BrPIkqcGXpccgiJOP/7U5tpAeREHeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255119; c=relaxed/simple;
	bh=e/bLGRSHGTFwElW+K1iLJxL/megYxkWcxCZjL1nF0Rc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LQYq+6HCSYkMSgBzn4OZ7kfCLvBu5ovsBiMArLl0Bb3LTN7LGgSelMDKiWA41M3inOYl6j1LJSQ5mi8XOp5D9oxe7+01H9PqKtCSp0/tzy5bs55bVtV7fJJrkNE38IUoRegJkBBgr256CxZQQMgBv0FeFfUNiC0EKRuHPakD+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eu/GxhyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF83C433F1;
	Thu,  4 Apr 2024 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712255119;
	bh=e/bLGRSHGTFwElW+K1iLJxL/megYxkWcxCZjL1nF0Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eu/GxhyK6rSliu26tWMN2lD7qjjN9caVpmyl8Rs2B07arfXPlSkDzMEfbPjLbBICF
	 2rKA7vefw5tUUdiItpyyecMVzgEPJKSTKzh8axyExo6DWo4k0Z8SGsgjk28DJHjM5V
	 IlJgQ1XSXx2LsOuZg7VP1nYVgKkc1uZ20xaLWWvw=
Date: Thu, 4 Apr 2024 11:25:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 linux-mm@kvack.org, Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren
 <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 1/3] mm: Move lowmem_page_address() a little later
Message-Id: <20240404112518.51204544a4e73c2639ce53b1@linux-foundation.org>
In-Reply-To: <20240404133642.971583-2-chenhuacai@loongson.cn>
References: <20240404133642.971583-1-chenhuacai@loongson.cn>
	<20240404133642.971583-2-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 21:36:34 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> LoongArch will override page_to_virt() which use page_address() in the
> KFENCE case (by defining WANT_PAGE_VIRTUAL/HASHED_PAGE_VIRTUAL). So move
> lowmem_page_address() a little later to avoid such build errors:
> 
> error: implicit declaration of function 'page_address'.
> 

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please ensure that it spends adequate time in linux-next for the
compilation testing.

