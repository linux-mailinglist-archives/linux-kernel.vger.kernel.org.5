Return-Path: <linux-kernel+bounces-91284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFF870C47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C0C1F2640C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672C200A9;
	Mon,  4 Mar 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="g/ArLPpg"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B359EED3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587192; cv=none; b=bNeCqo4cG+gwxdgv5RujeHvj3ibYwMlm/KOZl788J8QxbJ1EFVdCtlMDOQQkORTIr6HlACPe+NYmh1VHoqhB5FQT/q6Zd2r7We/zYT3GLwoN7RCoP+y/mJLtwWlVNG+dDqf5gH1X7IgR/vFMQ1EI4twhAr9ZWdxtobfVPEnkA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587192; c=relaxed/simple;
	bh=EyCnhyZx8y61GIK+e1cgky+PPZbRfpMMnKuKuP3ADVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+6D/l1mW+4ObN6rzoUyG3YJx5/kWtc8FLP8n200gtRjg+2OfnN1ypcrrkz3KDCCFNCK2f3AXU36CKafxYCyFU2eWR5tBRXbwrqlzTMgDmLMst1m/VoF2qeMBZ576zbD0pP2Q3/ipWIOXtXd4A+ApyCIBBxXq1mblryDYjejNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=g/ArLPpg; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7864E40F1DDF;
	Mon,  4 Mar 2024 21:19:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7864E40F1DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1709587186;
	bh=nvSvmkdYAiWxaqGPMtppRIO/kU85atmGqBYFjnB7fj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/ArLPpgS24z1ofyCdO3tL69gg5RqObbiWy0rskesljj7t7SNN/fjJR6j25jYaZUm
	 od9ktWV0aE1olE7EFv6RH/qYZnwNZqvW824QFeP5ieO51nvO9wiO9Aiap7FBGyqykQ
	 NAHs3jdXyZk4tXt0qOLxSLEAH6DmM5mEmOmdNofg=
Date: Tue, 5 Mar 2024 00:19:45 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, 
	syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com, syzbot+a83dc51a78f0f4cf20da@syzkaller.appspotmail.com, 
	Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: Re: [PATCH] fs: 9p: avoid warning during xattr allocation
Message-ID: <7096c0ab-e2ee-4aa9-bb05-0667efa85fd1-pchelkin@ispras.ru>
References: <20240202121319.21743-1-pchelkin@ispras.ru>
 <ZeXIAmbZmENoKr2f@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXIAmbZmENoKr2f@codewreck.org>

On 24/03/04 10:09PM, Dominique Martinet wrote:
> Fedor Pchelkin wrote on Fri, Feb 02, 2024 at 03:13:17PM +0300:
> > An invalid server may reply with an xattr size which still fits into
> > ssize_t but is large enough to cause splat during kzalloc().
> 
> 
> Ah, sorry for not replying to this earlier.. and I had forgotten about
> it when something similar came up just now.
> 
> I've submitted a patch to limit such allocations to 64k:
> https://lkml.kernel.org/r/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org
> 
> Would you agree this makes this patch obsolete?

Yes, thanks! Checking against the VFS limits is more appropriate.

> 
> I'll go ahead and add the reported-by/closes you cited in this mail to
> my commit.

Okay.

--
Fedor

