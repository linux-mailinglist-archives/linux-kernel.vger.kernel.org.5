Return-Path: <linux-kernel+bounces-77354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4F860441
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE81C21F18
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456771749;
	Thu, 22 Feb 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RzVo8jjC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12671752
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635607; cv=none; b=uznKBq3SOO+/NmQ96tzGdkHvm1qlGXvaGV0kaTb6byfebo+N8NhPwjtm1JPTmPXWl8WEcaEoQHyKC8V2GNMj+pxMfe0TVDxVtjTJ1A1xv6abzN9i2YvuJvdB+WIMKjrg8Lg0tgbBnGL4b+Fg4rBDwv1kXKG+tVndbKwmC2Suvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635607; c=relaxed/simple;
	bh=HymouZr2YHKpHb3mvgD1ibkZ/BT1PspGINwhb5XB978=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g61s2NQtQinzhaIeGg/p8z5g08hxk+mFDYXRlabqvdCBVLOzudMO6MAbsQZ+sEvPQ9JziPHOr+dR0cRvzcDEpqJ1NDF6M6Z4E7ZzwYshRu5p/CfgWkOOPOg2JEk0Dv3LpBknfeySxYHRmeBXk0ZAvJ7kXwg77u+qsOyWl3LSKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RzVo8jjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E32C433F1;
	Thu, 22 Feb 2024 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708635606;
	bh=HymouZr2YHKpHb3mvgD1ibkZ/BT1PspGINwhb5XB978=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RzVo8jjCWjxbKTR0lq4p74IvclPrBtHc0dD6boesc39QJaNz4PlZn+6LQH1Mbcst+
	 6Z8ynsaGqqGbItqtA8y89ryPQyb/BTsyh23/5cSpzmc4BvRsvS8/43kmPr0MVMBp2/
	 pnPQSdlh8lZQANoKTmmsTr/QU8xbguAK4lvXf0Uo=
Date: Thu, 22 Feb 2024 13:00:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: aarcange@redhat.com, surenb@google.com, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: userfaultfd: fix unexpected change to src_folio
 when UFFDIO_MOVE fails
Message-Id: <20240222130005.c3f24eed1c1a27c66947e9df@linux-foundation.org>
In-Reply-To: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
References: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:08:15 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> After ptep_clear_flush(), if we find that src_folio is pinned we will fail
> UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
> src_folio->{mapping,index} is not restored in this process. This is not
> what we expected, so fix it.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")

What are the expected worst-case userspace-visible runtime effects of
this flaw?

