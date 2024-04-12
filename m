Return-Path: <linux-kernel+bounces-142991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93B8A32FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611761C2130F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074A148FF2;
	Fri, 12 Apr 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMZahp1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E3148FE5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937520; cv=none; b=JnWKXtbpmsGzFPN5uMnhBp/eDLZ6qgD/NsMFnscRw+Nvo/iOmJkqJqekt8lPqmpmHffjM2uY8jXHEyFnrzizYj8WymZ4bd83ofCs/vgDPdsZiZOCygcZA/VJ23pAOPBXDE4N7VRZ+vflW79YzqNq2BCpBmFnc33zLJu3bgzo1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937520; c=relaxed/simple;
	bh=WvDq6Hny3Xw6gF3pW8g/vUx26jooVVQ0n8bwSIymP9g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QhfD7YxHDDtKoL2IEweQruDUCfLMlb4OAn4I7QYitDZc0/yYzi91I91I3G0Tc1yxLEXLcyprhN0UKzsBbMyUOiY5N7oqFf81pbuX5umbdViN+Xz96XYcnEvZ0PPVtupAo+3QsVWJXmTdnfHgWjmkD/O6eV+mAkjTNmOunHzvSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMZahp1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC674C2BBFC;
	Fri, 12 Apr 2024 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712937520;
	bh=WvDq6Hny3Xw6gF3pW8g/vUx26jooVVQ0n8bwSIymP9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uMZahp1pB+OxUWGE2a5lOzqj8hWj3+rpoz9QK/R5/vASI/94hRR37vgs2sPqOaI7S
	 6y4MkfRxs8wQ+1knRJrfXLKP7S4CX/YHrEHLYFRKso9gR6aSTeTPd4PNng/1A1vTI0
	 WgVcmV9rcJkKIMaCVbFJ/W9LTrtpEkm3KJsXyy9hRVxZDa8WyBShG6dbs82XMrKilU
	 BPiUrYTs+q80kr+Bu9a9ZI5Lmw+sY912D00BNJYGhUwsWxSss9tmzFQe4YBLI5R6uX
	 GE30gXd6i51C0qOTVeu+2LMiP4gVY94XOCUAzOfM2YKOje5qtcKAMlYqRjB38bXKY7
	 6OtkvjCZ5ybDw==
Date: Sat, 13 Apr 2024 00:58:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
 geert@linux-m68k.org, jpoimboe@kernel.org, kjlx@templeofstupid.com,
 linux-kernel@vger.kernel.org, ndesaulniers@google.com,
 peterz@infradead.org, rppt@kernel.org, tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH v2 0/2] Fix potential static_command_line memory
 overflow
Message-Id: <20240413005835.d2f6f7d24d2cec438cf7459f@kernel.org>
In-Reply-To: <20240412081733.35925-1-ytcoode@gmail.com>
References: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
	<20240412081733.35925-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 16:17:31 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> v1 -> v2: Split the v1 version patch into a bugfix patch and a cleanup patch
> 
> Yuntao Wang (2):
>   init/main.c: Fix potential static_command_line memory overflow
>   init/main.c: Minor cleanup for the setup_command_line() function
> 
>  init/main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

OK, both looks good to me. Let me pick it.

Thanks, 

> 
> -- 
> 2.44.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

