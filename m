Return-Path: <linux-kernel+bounces-87702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E986D7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC91C21B47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D387C094;
	Thu, 29 Feb 2024 23:38:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1B17545
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249902; cv=none; b=L/yJQvyjaIKBvzbGc822HMZaoTnS63ewu+z/tKVtVeZWYsEpLmoYdJ9dvkPNF0NsgxvFKiH7+66/SBaZKaaUofr85aXXERWt5S7udhODhuJ0zWRuCmxNQpZVPhCiolAmF0/mti3pWa/A6sVXZAaRLzy6FO72UbXv60sCaHiMN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249902; c=relaxed/simple;
	bh=JxabirRy9sp8zBzir1sOeWwkxxHBQdkLBmgQvc4b6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbss4kwDC7MEMZn9yHXWp43WED5wvk3yZn6wspk0i82H+6ODV/uihYFUiZB4OXB1BUxi/Q2RMg6lgtfGiJFBjVG7Em+6lE8/kENfShRn9wXnFHHOUJuWXHxdDSHEvIOlVaf6cb0yEtL4orepqcckRfoCxxfKrd8W20kBpkbVDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD4C433F1;
	Thu, 29 Feb 2024 23:38:20 +0000 (UTC)
Date: Thu, 29 Feb 2024 18:40:27 -0500
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
Message-ID: <20240229184027.45609c0f@gandalf.local.home>
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

> DWARF isn't needed for that.  Even the symbol table has it (as does
> System.map).  For both globals and statics.

Interesting enough, it is reported that if lookup_num_blocks is global,
crash returns the proper value. If it is static, it just returns "1", which
is incorrect (the correct value is around 60K).

-- Steve

