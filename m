Return-Path: <linux-kernel+bounces-52665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE819849B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B821F273AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E7D2C190;
	Mon,  5 Feb 2024 12:55:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1424B5B;
	Mon,  5 Feb 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137709; cv=none; b=ejV48AcKa0aKpesB/OI1ZkrPaL/JaO0pFyqwESj+qI+7Tev7qcEIATHPw6I6jYeau0lVI1c6IwsX/e6a8OWKwl2blnuAGHhDtlnVpsKZccBAkd4TVbtFhelIDXyUoIjxgWDHGXu7nAxwEKK/On4O/pGWjR+hCOls1sZmUjEmkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137709; c=relaxed/simple;
	bh=RydxO7dOlNRVK8/BCFH6wMENEOVZlKouAZ/pEt+4pK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CB5a6qnHCVN/ifpa5tNBRgn4OoQSFDtr0BKaEAoktc37rmef+vvvS+hiKZTCNODoG1KZNp5T0ztXeBDpxOcplz4jwAurKWvwlX8sTND2X4YJHc9ws+F9NpLb6i86V4iVyTBTWhK7XeOSXufyQfcdCJ2VqvRofpiHS02yXw1uJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD7AC433F1;
	Mon,  5 Feb 2024 12:55:08 +0000 (UTC)
Date: Mon, 5 Feb 2024 07:55:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240205075504.1b55f29c@rorschach.local.home>
In-Reply-To: <20240205065340.2848065-1-svens@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 07:53:40 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> tracer_tracing_is_on() checks whether record_disabled is not zero. This
> checks both the record_disabled counter and the RB_BUFFER_OFF flag.
> Reading the source it looks like this function should only check for
> the RB_BUFFER_OFF flag. Therefore use ring_buffer_record_is_set_on().
> This fixes spurious fails in the 'test for function traceon/off triggers'
> test from the ftrace testsuite when the system is under load.
> 

I've seen these spurious failures too, but haven't looked deeper into
it. Thanks,

-- Steve

