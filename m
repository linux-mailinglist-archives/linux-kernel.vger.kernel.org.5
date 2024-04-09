Return-Path: <linux-kernel+bounces-137468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463089E28D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8831FB25327
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95946156F24;
	Tue,  9 Apr 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9ekr+1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA794156C59;
	Tue,  9 Apr 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687279; cv=none; b=IZOFhhfZJAA7cgDygOXvl2PIcc/A9sCIHqhWlR4n3hVrXkCUNanB2KE0Xf0UwXuTKTLkWp+vDJU3MiPsgYNE+josNFFaF6KcHlfL3+bH2ukBR9sQWdAiJ0AbCCD2hbFJgUqdMp5owBuE3GFslzu6L37CqEk3rL/i9C1Lam6EjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687279; c=relaxed/simple;
	bh=e+7ypjG7GJWusPSQ1GkqvA0QW8u/9PQVtayld3hw7W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgRAuPUdyvccmBMlpamMFb+ue2FJF/4xwwNeuzmCkbpcTj6JvVdQtR93iJYccv0CzESzH+yDVAaobA0+tbe69psZkI2Oe/Z6EVDk7rL1lfEpaR2ihn5XHhO28S/IR8NEWHIG6/Db8/TZy6jCFtOGewTh090dmufTzDp0BIe4sAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9ekr+1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAA1C433C7;
	Tue,  9 Apr 2024 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712687279;
	bh=e+7ypjG7GJWusPSQ1GkqvA0QW8u/9PQVtayld3hw7W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9ekr+1jWiyOO5KJgD93e+zuDIQGgg2+259iBLLbwJXpU2KcafBwaFvNQ7OdXdb5m
	 GG9RUeqjmtJwNO8e6UyQisdzUHngKTb7IhUSqK7/81C9MK8tOjhGWEYBeytUstMopF
	 4A6zXK3iTU9qs7ixXJ8VX9lGPw83j35YDsdVyYzMfnM8vLaAdKoJmQX6ZiDLz69psh
	 rPikQgAPjQFRDkL+1DkVcqZuZlwuvGbqY/1KbfZSXVgFImw4RjRpjomnNQWZKF8bcF
	 BmLagDWxHXOnPyfTCxpAHQUEhJUJmnx2+o+Ae8ti4UWpjpvDNuPNpB5foyWmK8eG2L
	 OSjmthgrKCTtA==
Date: Tue, 9 Apr 2024 11:27:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: eric.dumazet@gmail.com, edumazet@google.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
 pmenzel@molgen.mpg.de,
 syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param
 >= sizeof(int)
Message-ID: <20240409112757.51ef8964@kernel.org>
In-Reply-To: <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
	<tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 22:01:45 +0800 Edward Adam Davis wrote:
> > I think I gave my feedback already.
> > 
> > Please do not ignore maintainers feedback.
> > 
> > This patch is absolutely wrong.
> > 
> > Some setsockopt() deal with optlen == 1 just fine, thank you very much.  
>
> It's better to use evidence to support your claim, rather than your "maintainer" title.

Run selftests.

