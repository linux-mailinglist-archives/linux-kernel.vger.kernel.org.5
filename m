Return-Path: <linux-kernel+bounces-45331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CF842E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885E9286A86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFAF76C87;
	Tue, 30 Jan 2024 21:25:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E890762EB;
	Tue, 30 Jan 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649901; cv=none; b=ZsWjYCYdrmPRgkieo8zrosNsdmk/CVdyLWVVNbsA2YpbO4HIXD3ZCt4Xi7NJhHrR6Cx5acRXdSlgXN2iUBh2tev6cDYUyipVZpMOaxWldhDmDisEf7a5VyyPu/2ZsgJi0M49WHeR9B1O7FAU/kRRDgWTchtvCciWORbg6EE9WZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649901; c=relaxed/simple;
	bh=UErUAiK+wbqdYNWFOxyFj3A61/TSdw+2QMruaQnSiYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgRWlwqYJML3xBIhG4J5q8zvIBren1ryqE4EXHPmQYUTBBJAXG7X8i9b5DBmNRS4ARVPZX4Vngj2BoXFv6pH0n1QH7FPgIerTtXALmzK/jABhqrFbJi1dEinaEn4Po5mkR6FAnC6bP643SmVb7hOBqWbcaii2JZ8rkGEzwFW2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C55CC433F1;
	Tue, 30 Jan 2024 21:25:00 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:25:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240130162512.312eb446@gandalf.local.home>
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

> Another thing that might be worth doing is to make all eventfs lookups
> mark their dentries as not worth caching.  We could do that with
> d_delete(), but the DCACHE_DONTCACHE flag would likely be even better.
> 
> As it is, the dentries are all freeable, but they only tend to get freed
> at memory pressure rather than more proactively.  But that's a separate
> issue.

I actually find the dentry's sticking around when their ref counts go to
zero a feature. Tracing applications will open and close the eventfs files
many times. If the dentry were to be deleted on every close, it would need
to be create over again in short spurts.

There's some operations that will traverse the tree many times. One
operation is on reset, as there's some dependencies in the order of
disabling triggers. If there's a dependency, and a trigger is to be
disabled out of order, the disabling will fail with -EBUSY. Thus the tools
will iterate the trigger files several times until it there's no more
changes. It's not a critical path, but I rather not add more overhead to it.

-- Steve

