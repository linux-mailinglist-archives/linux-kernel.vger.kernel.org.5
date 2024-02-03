Return-Path: <linux-kernel+bounces-50825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1952847E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F5F1F275F1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0ED524C;
	Sat,  3 Feb 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNbrVhlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBC63B1;
	Sat,  3 Feb 2024 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927580; cv=none; b=rExRYlT+vRwwOMdqv6x2vBHfvNgKXL7aP2H/c0i6Pgo2zBUpWbxoENvZXUvIUEbbT3V1E8shHaLn0JJEtZPeRwGn7eUnS+6RrixBxfw4Jrnliwr3FNHPKhCbJrXWROJ6/0JSZ3fB6VtbT/O+wygTjeCWK6x9uLtFiIllwhy9DEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927580; c=relaxed/simple;
	bh=oPKPWVZc3lK5bY74y4kgZ4jboVGXI984yXwFNj9D9fA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyttMPVhenAP+/RfN06l03NgRUTJHtGOXG99D+E/i0eWRn3zUjG2auukqFcYcyh/w98Poi448d0J767357ZZoN+zOhyx5ks0/RkMNExf8luNu2gXoX+zalO4oT1Y6KNB0pJpKuxafglYKjvj3AFWh0+DkaJ6G0nHBI4NtGD9KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNbrVhlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EDFC433F1;
	Sat,  3 Feb 2024 02:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706927580;
	bh=oPKPWVZc3lK5bY74y4kgZ4jboVGXI984yXwFNj9D9fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UNbrVhlJAyx42S6ix5Yw0LW7LkQBg3nvR4ug7XwYHMCzJfAp36GXShKnVWpGJHQlu
	 uwprJewL16ZZJIT4Q5wgqtNiFl2tLtGOckQlkiFDadP6lgfWKv90zOVZVZj9XJX30J
	 KdI+zXwe6dnRfYJYoSD0hwCumLLXoVjY+MBQgkpeCQVHMbmcw3ibEI/Fr86vfyet2s
	 +zT7oG7ZKPT3CUzJzCVG7todKfxnC9A6D3u6Pwpgivq8Ctqlxzj9KhLIHycOk73zok
	 aRenfpxFW11z8RSVSL4m9u078TzOAq9UVxCWQ7xafs2SseReFogcARU51cpi2C0aQN
	 3l5IoVwlWdBsA==
Date: Fri, 2 Feb 2024 18:32:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Network Development <netdev@vger.kernel.org>
Subject: Re: This is the fourth time =?UTF-8?B?SeKAmXZl?= tried to find what
 led to the regression of outgoing network speed and each time I find the
 merge commit 8c94ccc7cd691472461448f98e2372c75849406c
Message-ID: <20240202183259.33859154@kernel.org>
In-Reply-To: <881d47bf-5f5d-49d6-9502-3b22899eb253@infradead.org>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
	<43a769dd-aa09-4da3-a226-ecef98f32e0f@infradead.org>
	<881d47bf-5f5d-49d6-9502-3b22899eb253@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for the forward!

On Fri, 2 Feb 2024 17:16:41 -0800 Randy Dunlap wrote:
> >> When I copy files from one computer to another and kernel snapshot
> >> builded from commit 296455ade1fd I have 97-110MB/sec which is almost
> >> max speed of 1Gbps link.
> >> When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
> >> significantly slower.

There isn't that much networking in between the two.
Is any of the CPU cores at 100% when you are transferring the data on
the bad commit?
Do you have any iptables / nftables rules?
Are you using TLS in the transfer?
Did you try reverting f1172f3ee3a98754?

