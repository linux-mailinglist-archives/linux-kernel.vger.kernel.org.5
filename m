Return-Path: <linux-kernel+bounces-110177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD8885B23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505881F21489
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058928593F;
	Thu, 21 Mar 2024 14:47:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A72CCA3;
	Thu, 21 Mar 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032435; cv=none; b=qvyq+uytuUuiD8rjRLjfVS3v9kUwIqQe2FcKSi4oWW7ebFwMeVHTohyxpCXBAonc/ut+hnkBvOfmliOmlN7BDGNCZ0KoyIvbJItn82NbkI6LcJjnY0O8C8omfP79ozaiwVgqnLfVf4S6a/aSpf5uep/ATF2xP2OXDLhBXBDGYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032435; c=relaxed/simple;
	bh=ewOumbTsMKH3CFdRvCcy8rBQytRnuQkAjPV7reMCuUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFdTj70FAnN/0Bjpr5Lf/X0F+0qhWsnFyxA22BUE/Tx0MvVJzulOqTA3G442L3N5X+ctp9r5QQkRTDHWE3M9MhX04HkzRM0taxWb+TRA77fhYnuaw5CH+qBg4iMp6WDL8M87/k4XwlUtRpPY7yhMvCkwmNNwwjZ7/eD4FKA1+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E16C43394;
	Thu, 21 Mar 2024 14:47:12 +0000 (UTC)
Date: Thu, 21 Mar 2024 10:49:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Bj\"orn T\"opel" <bjorn@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Masami
 Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, "Bj\"orn T\"opel" <bjorn@rivosinc.com>,
 Song Shuai <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20240321104939.60c54560@gandalf.local.home>
In-Reply-To: <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
References: <20240306165904.108141-1-puranjay12@gmail.com>
	<87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
	<ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 13:42:28 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > It would be interesting to see how the per-call performance would
> > improve on x86 with CALL_OPS! ;-)  
> 
> Heh. ;)

But this would require adding -fpatchable-function-entry on x86, which
would increase the size of text, which could possibly have a performance
regression when tracing is disabled.

I'd have no problem if someone were to implement it, but there's a strict
requirement that it does not slow down the system when tracing is disabled.
As tracing is a second class citizen compared to the rest of the kernel.

-- Steve

