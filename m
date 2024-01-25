Return-Path: <linux-kernel+bounces-39074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF583CA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3FE1C24DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54613398C;
	Thu, 25 Jan 2024 18:08:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E412FF99
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206103; cv=none; b=YqK3zB+5VEYMTiRV/ibc6kmoHO5Ysm/mwEc5XSWERZGmpibicK8t3D5NclhRFQa7ClTjyDCfmXK7Xg4DkjJznXcM0ZX2HKguwJNjKjilNzxHijL+96f5XVBxhGhATgilUkrz2/nNro9g/0ZviGBjgu5/QlXQBqbApBsmseGbTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206103; c=relaxed/simple;
	bh=yhJX56xWgM8By3Ugqx7spaQnHv52Kk2oJeWEf0AZZls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzON0nPVLk902SLTz4YwziEAcsJMhHfObaY1N8qpoNqvr+/f2Iar5FRo80jqyb+zAoQQmxFFfYsI0Zoi5rJyLqgY1eeF5Mb/suIe9QLomI9lSqEAqTwR2/z543X9N+4CEOz7+VmXQDwscQ6B4T93QTvNphl8g//dO5IVafqEHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA8DC433C7;
	Thu, 25 Jan 2024 18:08:21 +0000 (UTC)
Date: Thu, 25 Jan 2024 13:08:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240125130821.0a1cd3a7@gandalf.local.home>
In-Reply-To: <20240125130731.3b0e2a42@gandalf.local.home>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<20240122144443.0f9cf5b9@gandalf.local.home>
	<20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
	<20240125130731.3b0e2a42@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 13:07:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Actually, inodes isn't the biggest issue of tar, as tar *is* a common
> operation on tracefs.

Correction. tar would be a common operation if it worked ;-)

-- Steve

