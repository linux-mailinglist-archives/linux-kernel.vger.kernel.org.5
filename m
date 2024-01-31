Return-Path: <linux-kernel+bounces-46943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF658446AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D93A1C228A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BD12FF73;
	Wed, 31 Jan 2024 18:00:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB6131750;
	Wed, 31 Jan 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724026; cv=none; b=cxoaWS7ohqrJTOA31tnggqeNwq+2WaTeaRW55LZOAqj9Mt5IFjxiCFWVsgcR3x6SmHKtJYBTnM9ossCNMM9hnLpSx7HBbhyw019x7Nqjr9bNdYrkYxi1phBdB7xXRrYKcN0Mvv5orya1S0hYQ48grdqlKs6GyQ0woWYLy7hkZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724026; c=relaxed/simple;
	bh=pfjCuFmbF5hKvhNYdwreXy+v0oqzoT+zBRRD6SOcCiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvcL0TL8erMi900LpWmqWQ9e9P73DLl3MY5c15fqIqx8Xkc9Sr6SjxpRMPWrZ0fuGxMrzi5VeZy0n4ucJ76XYPzz/AQ8MS610/SqhWCePgxp17c1ljRPCw4RVFnz6eYx6hkln4SdE58KSENkcEo5cySfCYF3mD74vrKw/I+1884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C5C433F1;
	Wed, 31 Jan 2024 18:00:25 +0000 (UTC)
Date: Wed, 31 Jan 2024 13:00:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240131130039.241c8978@gandalf.local.home>
In-Reply-To: <20240130190355.11486-6-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-6-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:03:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> It would probably be cleaner to make eventfs its own filesystem, or at
> least set its own dentry ops when looking up eventfs files.  But as it
> is, only eventfs dentries use d_fsdata, so we don't really need to split
> these things up by use.

BTW, I have been thinking about making eventfs a completely separate file
system that could be mounted outside of tracefs. One that is readonly that
only contains the "id" and "format" files and nothing more.

Why? Because perf and powertop both use those files to know how to parse
the raw event formats. I don't think there's anything in there that
requires root privileges to read. They should not be exposing any internal
kernel information besides the event format layouts, and it would be nice
to have a /sys/kernel/events directory that only had that.

Making eventfs a separate file system where, when added to tracefs, has the
control files for the specific trace_array, but for the /sys/kernel
directory, only cares about the trace format files.

Then tracefs could be nicely converted over to kernfs, and eventfs would be
its own entity.

-- Steve

