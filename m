Return-Path: <linux-kernel+bounces-16893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21382458A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9901F228D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078A24A06;
	Thu,  4 Jan 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8zralTf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967D2376B;
	Thu,  4 Jan 2024 15:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DC1C433C8;
	Thu,  4 Jan 2024 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704383864;
	bh=PzJa6Sf5vdRNwqMGijItRavDPKV5p00ag32J65NjZSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q8zralTf1wpf3rF5oDuoMpSS42wmGElvZw2fP6KqRQUj1gMHf9kX3K4mwAUDTrG5x
	 N/bdFb5Fk1/tHXVtoItcJeG64R1dbw5SvMZho1uXBR+rY9xc2/gc8m0HZl5ef3Rh55
	 gMHCvVct/63Nii82aVfvi9OtiHgF8Gh/4eX+scRIIHj093eTPQWPFc2JRgsYRBgVEd
	 t7A7jaN/uG3JL6xpEezleWDu74W9aqvBA/Uau0q1DGaCNDTS4iV3Tohmv3XoHxkZac
	 mckf28qvkOjqagF/zEOhcx66ABkUFvWyiTimNu4ZZfBjZkP6nA17nluhabAgR+Mb7Q
	 4okNrGiHlqOkQ==
Date: Thu, 4 Jan 2024 07:57:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Christian Kujau
 <lists@nerdbynature.de>, Salam Noureddine <noureddine@arista.com>, Dmitry
 Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Message-ID: <20240104075742.71e4399f@kernel.org>
In-Reply-To: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jan 2024 13:42:39 +0000 Dmitry Safonov wrote:
> User won't care about inproper hash options in the TCP header if they
> don't use neither TCP-AO nor TCP-MD5. Yet, those logs can add up in
> syslog, while not being a real concern to the host admin:
> > kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]  
> 
> Keep silent and avoid logging when there aren't any keys in the system.
> 
> Side-note: I also defined static_branch_tcp_*() helpers to avoid more
> ifdeffery, going to remove more ifdeffery further with their help.

Wouldn't we be better off converting the prints to trace points. 
The chances for hitting them due to malicious packets feels much
higher than dealing with a buggy implementation in the wild.

