Return-Path: <linux-kernel+bounces-28236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855C82FC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CD3B2671A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042720DE5;
	Tue, 16 Jan 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ximf6L/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECF20DD7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435789; cv=none; b=QE7ITi6peZHE8oRDcRIdTVuJ2bUB2gxAqS6IINHp6/rKpwF7sdtnRYIe5J9SPGFFwV9fy2KhW0DVz1rrgosRdvNGxctzwkNCZ1V5ro+5mNqmRTPRPczJR+QBPV86N0cqkVhCZTammqes5nWdvo7+x8rWtKbYjXeA0IhI0Ggi594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435789; c=relaxed/simple;
	bh=gdAk4kWrtWiAqmSMBrHr5e88tr+iTIpY2yL02fV4bbc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding; b=ebeF2sdTCeQ+775bi7suVh7gZnmo1u1kcOlaDX5q4Pv4X/9lU/AgMRPBv+HIGZ9vxNpast+DiUwJofE/SSeDfegMgrzzl1Asm4pGg3c996NUWWpwQkSroJ5ZVPZfRlj5KsQAIKtvOZrHgn1rLiRKbyLsdP8N/XoTFjyWseLxivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ximf6L/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA47C433F1;
	Tue, 16 Jan 2024 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705435788;
	bh=gdAk4kWrtWiAqmSMBrHr5e88tr+iTIpY2yL02fV4bbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ximf6L/FlFDOaC4lTZoERv3GRCOcXwpMDcTwLfIBdb9Y7QbGHchGwcV6jPEk2RLln
	 Sijv3uG5gjBvBQmdHDch73vEq6QYRibVjWCh4aty4p61vKoEa+9ZGgM1FbU1iiEtnp
	 8Sn75qvrUvjgbGKnvWPhxZNc7B1SWoxQo7vFhyC4=
Date: Tue, 16 Jan 2024 12:09:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Yosry Ahmed <yosryahmed@google.com>, Christoph Hellwig <hch@infradead.org>,
 Nhat Pham <nphamcs@gmail.com>, Domenico Cerasuolo
 <cerasuolodomenico@gmail.com>, konrad.wilk@oracle.com,
 vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-Id: <20240116120944.01f25e65d13f0fc7e2a2df34@linux-foundation.org>
In-Reply-To: <20230717160227.GA867137@cmpxchg.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
	<ZLIVleBYOm4HIGTZ@casper.infradead.org>
	<20230717141250.GA866068@cmpxchg.org>
	<901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
	<20230717160227.GA867137@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 12:02:27 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> The only user of frontswap is zswap, and has been for a long
> time. Have swap call into zswap directly and remove the indirection.

This falls afoul of "mm: zswap: multiple zpools support".  Could we
please have a version against mm-unstable or linux-next?

