Return-Path: <linux-kernel+bounces-110271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D5885C63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01808B21691
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD286AD8;
	Thu, 21 Mar 2024 15:44:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2B3A1DD;
	Thu, 21 Mar 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035850; cv=none; b=RtYxt64Q/yHSV9F9x4ZGU8vXiIeSPJzBuDY2Ae/AlIqfE52t86tITAsqcHmnydcBl2HoOSZ87b2zntAj9GB+C8uRQjucRp5uhYTrnFx9D+S0tGfgueyiIkn2xueFZ9tkcfEW9MN2qfY6PcfrX3KPj8f9JwjNe+GWbs88/9uq4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035850; c=relaxed/simple;
	bh=cTCVXG3LA1UgfV++ZX8LGO7BlD43EmFcKlyQPgaKLPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M05UYmYGiE6jc6ZXQT3z0cqsG6cN6swEz8UGaScju/k3H69cX4gSh4H9ntZm9WdZzaO6Gih2lHukb0/o+yeIbLU6FvAFluI2ULzzHcxqcOMXpq+YHJxd0cd5nLXn7A5LsHu0KysF9bf2xHiqGsQr360skupiJ63ue4926t7MOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3273C433F1;
	Thu, 21 Mar 2024 15:44:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 11:46:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ye Bin <yebin10@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-ID: <20240321114636.5ed19630@gandalf.local.home>
In-Reply-To: <20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
References: <20240320132924.2802187-1-yebin10@huawei.com>
	<20240320132924.2802187-2-yebin10@huawei.com>
	<20240321101547.1f4e68ab@gandalf.local.home>
	<20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 00:07:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > What would be really useful is if we had a way to expose BTF here. Something like:
> > 
> >  "%pB:<struct>:<field>"
> > 
> > The "%pB" would mean to look up the struct/field offsets and types via BTF,
> > and create the appropriate command to find and print it.  
> 
> Would you mean casing the pointer to "<struct>"?

I mean, instead of having:

 ":%pd"

We could have:

 "+0(*:%pB:dentry:name):string"

Where the parsing could use BTF to see that this is a pointer to "struct dentry"
and the member field is "name".

This would also allow pretty much any other structure dereference.
That is if BTF gives structure member offsets?

-- Steve

