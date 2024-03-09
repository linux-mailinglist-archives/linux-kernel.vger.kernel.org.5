Return-Path: <linux-kernel+bounces-97740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE3876EA4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97DB1C20D13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7E168B8;
	Sat,  9 Mar 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdAyec9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4872CAB;
	Sat,  9 Mar 2024 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709949194; cv=none; b=ODXR3X7Vzr6EWp6AfVGoi3J+mIJvplZaWnSnReXRffbZ335Gp/XRfeOimED6UpscntHqi/5QRdKRnbSUMqajQNjKiXE9lnlU35hODvQx0fUioeBal0aBpmkDmRaFbXWMvpBOIqxUAHlbpHJMo/wTadBHCQ40l9UYXYDmgrv/Q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709949194; c=relaxed/simple;
	bh=2knyzT26kc/AoacFUv5gxCg0MX3pdvSH3cxpNCbbYtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/cYqauO0d0BOAQiQwAUFo+HgT+7KovEWM9Sd+Y3HWUb5Zrwx8vkjoCa16ns/VhmvgJpqtOruH9CSiHBwGYDJmJ2lXr+Am/MTZRDpDYTIMx44MH0MoqL+WN2vRUnhJCbjifHf/oyJjRnfrq0KHNTu8x+lMEVrFJzOn69C254Qec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdAyec9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E0DC433F1;
	Sat,  9 Mar 2024 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709949193;
	bh=2knyzT26kc/AoacFUv5gxCg0MX3pdvSH3cxpNCbbYtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdAyec9xU/ehyjyfJwe7qad+5r2egSexq8GXPXFLTw/wvmpAHxSLb9RsAXp2iJfHl
	 AXLYRsMDs6Iv7r/wcMsKA1sRKlctdDv2IIEIj9m2XN6gH+qWydxczRmjCSDaOZYCFi
	 WtLIoXdBINcFQOhRbPZvZ+Mk+b21HMlxN/Yp4J1pxNPLMJrSuOkozvhfpEaXph9ZJM
	 qVpnfq/JyxY5OENt2OkgvaZe1SRgD71Ipd4m5Oh0K3imAJY2vU4YKYNpsP9EQFxt5D
	 TIhYCU5jAf/IPZGjCb8J1jEFZM+EYRal1W2oYpiy/Y2wn0jjet/1EZ85l/CJPcVUDF
	 SSIH04uWuZnAg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm/damon/paddr: support DAMOS filter type YOUNG
Date: Fri,  8 Mar 2024 17:53:11 -0800
Message-Id: <20240309015311.45954-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307030013.47041-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  6 Mar 2024 19:00:13 -0800 SeongJae Park <sj@kernel.org> wrote:

> DAMOS filter of type YOUNG is defined, but not yet implemented by any
> DAMON operations set.  Add the implementation to the DAMON operations
> set for the physical address space, paddr.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/paddr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index deee0fdf2e5b..52e4be7351cc 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -209,6 +209,9 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
>  			matched = filter->memcg_id == mem_cgroup_id(memcg);
>  		rcu_read_unlock();
>  		break;
> +	case DAMOS_FILTER_TYPE_YOUNG:
> +		matched = damon_folio_young(folio);
> +		break;

damon_folio_young() doesn't reset the Accessed bit of the folio.  Hence, unless
something is resetting the bit, this damon_folio_young() call will repeatedly
return true even if there was no access to the folio since last check.  We
should implement Accessed bit test-and-reset variant of this function and
replace this, or call damon_pa_mkold() when 'matched' is 'true'.

I will fix this in the next spin.


Thanks,
SJ


>  	default:
>  		break;
>  	}
> -- 
> 2.39.2

