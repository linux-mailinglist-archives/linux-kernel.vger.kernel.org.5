Return-Path: <linux-kernel+bounces-106344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD587ECCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB4D1C211A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39FB52F7F;
	Mon, 18 Mar 2024 15:55:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E652F6D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777344; cv=none; b=osHdL5XXPFHp8V7jKQxpIVu1//gd69WSCOkQYAwp/sI+LnOwPZcJMb2KCMZQrvly1Sy2M1QAY/kbpowS1Zhqs/XA53y/LmlfGhRblAGPIm+Glz+JW0/rIzJt8Vcry/pBdxAfvfFBXPTrK4Dl7FVzgOeFH9nqZkl4J9RgulwRkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777344; c=relaxed/simple;
	bh=J3kVjYNZKCHPoUNJ+tUmXtQFeVyfeNdZ6VNt7xpM6fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/5Plhn5g0uqBudqSRiV/RvAsx9FkbkuWFyqSdFBY5BfV7lySkTEkwDG/HeP5rckLZeN5WSxo8Q7wfWW35gokguPgP8hc2cvkpVJldwfrHUNRv8689T/aCIt0PDsxxN60IIp3FQLcb9Zsbln3O8MuX6UT7tGyU7FMt70W5wma84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A2C43390;
	Mon, 18 Mar 2024 15:55:42 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:58:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Vince
 Weaver <vincent.weaver@maine.edu>, Dave Jones <dsj@fb.com>, Jann Horn
 <jannh@google.com>, Miroslav Benes <mbenes@suse.cz>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to
 static
Message-ID: <20240318115802.39f89b73@gandalf.local.home>
In-Reply-To: <20240229004252.awmammhp63f5udyy@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
	<43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
	<20240228183507.78c5f130@gandalf.local.home>
	<20240229000309.ibtuk7gr27d7cbxz@treble>
	<20240228191406.21e894b0@gandalf.local.home>
	<20240229004252.awmammhp63f5udyy@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:42:52 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > I'm guessing because we don't have the full dwarf info?  
> 
> DWARF isn't needed for that.  Even the symbol table has it (as does
> System.map).  For both globals and statics.

It is in System.map, but I guess the real issue is that the compiler can
optimize it out. That is, the number is never set as it is static and the
compiler doesn't need to do anything to make it valid. To the compiler, the
number is just a local variable. I'm not exactly sure how it does that, as
it sets the value in one function and uses it in another. But clang appears
to not be setting it when it is static.

Either removing static or making it volatile makes it work again.

Thoughts?

-- Steve

