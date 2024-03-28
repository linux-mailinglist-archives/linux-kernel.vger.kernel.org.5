Return-Path: <linux-kernel+bounces-123598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AB890B92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742411C2DED4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC13AA4C;
	Thu, 28 Mar 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgEJipg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7513A3F3;
	Thu, 28 Mar 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658392; cv=none; b=Czb3LQsT5mn4D0WrS45GN4YTKYJ3Ch1a7W1I6fSVvooueqhp9dMnISAcTgOimB1sukrGVpJGcnsRvQ8YzFUp3nF4zTDkDPBLhbt7Ri3y1oll1ls25P7WUQoFDqHr1fgamUVtqN1HiH3WnSXJMR1xTx6XZN3dTO4E050bU1rId1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658392; c=relaxed/simple;
	bh=wNEOt6nhkwgxlBg+GMM4yjneoi9cWEwTzl98ewOO420=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GN5HUGz4Ytuf+CN5RRPEukeIkBPhH1s0ZBQ+zomWXhrLzSIXWhEmO8FG9QmrzM7tLSUjvZF7Rg4Mjj5GxHskRwRYiCTM/lfvpVCJIaHxQYLIgRKdgj2Zd6S5Nazr/4lGltCHSRIMa1KwHYWQkgLP5TfBXOiwZIt4TwePxNQAZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgEJipg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86231C433C7;
	Thu, 28 Mar 2024 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658391;
	bh=wNEOt6nhkwgxlBg+GMM4yjneoi9cWEwTzl98ewOO420=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MgEJipg7BZ/754JMJHKXgeKjLH176NZLsTXmtVLrvKdyP0VMh3TR1/JX3TvNgkoLL
	 N7YKW7C7bG8Eynwl5xFwOXDlApOan5+v+UNR8w4+5A+8Jzj8axLQcaR90CZJO3c4R3
	 R3+qfW+dY5qU1LApyEXXxHFOJxAu3wutofCzxkcoHMz3nvH9lKt+H1CeUuZiu/u/I1
	 5zynv11b7kaO1rvJ/JqfQCLth0GQ8/OV8wIiVChsb4CpdginmFrMSy0O2+5B8dwdXV
	 mkUE3IpIaFm+H6SeYaXCAlBKr3pxHiFOt7fi5mWx1eEb62RCGvxdahszMLaP88UN7j
	 Vg65e8SlqyHXQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7074611A1DC6; Thu, 28 Mar 2024 21:39:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, syzbot
 <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
In-Reply-To: <42106158-ca2b-48f5-9397-87e7cd9d4fc8@kernel.org>
References: <000000000000f6531b061494e696@google.com>
 <00000000000069ee1a06149ff00c@google.com>
 <CAADnVQLpJwEfLoF9ORc7bSsDPG7Y05mWUpWWyfi7qjY+2LhC+Q@mail.gmail.com>
 <42106158-ca2b-48f5-9397-87e7cd9d4fc8@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Mar 2024 21:39:48 +0100
Message-ID: <878r222iqz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 27/03/2024 16.19, Alexei Starovoitov wrote:
>> Toke, Jesper,
>> 
>> please take a look.
>> It's reproducible 100% of the time.
>> dst is NULL in dev_map_enqueue().
>> 
>
> The `dst` (NULL) is basically `ri->tgt_value` being passed through
> (unmodified) via xdp_do_redirect_frame() and __xdp_do_redirect_frame()
> into dev_map_enqueue().
>
> I think something is wrong in xdp_test_run_batch().
> The `ri->tgt_value` is being set in __bpf_xdp_redirect_map(), but I
> cannot see __bpf_xdp_redirect_map() being used in xdp_test_run_batch().
>
> Toke, can you take a look at xdp_test_run_batch() and where
> `ri->tgt_value` is getting set?

Sure! I'm off for Easter, but I'll take a look when I get back next week :)

-Toke

