Return-Path: <linux-kernel+bounces-81213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6B86721C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FF51C24E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455814CB4B;
	Mon, 26 Feb 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i8S0YQKG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910A1BC56
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944569; cv=none; b=oIcf5x12DEg792vqVvGEFyZIeKhl4+HscuLV36WkVSKjlbFwMmP49rOGit0TNDK481TQmjsEQ+yRjd5NrcY5w1FuTp/u6x30oXkviaf7OWni88hfjl1FFifW0uHg3JE7URAe70e8hCwVvwBOEX2CzcAUck/ryUD5jNcdZ53vewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944569; c=relaxed/simple;
	bh=eLfyJG12kaItxg13e18RHjrrXXaXp5DlEPZTXUXx6GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3tbMiLMPu0VicWOceHEXVqF29W4j9HMn1LAYZ/35mYJ8dcbFQhhLyZsqdwjB1vBa+kjRgx/HhZGOD4ywCPTRS1drDNYI2XQDEE++wGgZhvSwPUSrkfEIjrktTFg17+RoYesp/3586QeH4iWeO/nenR2+LiDzWfqAX7y4yU76m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i8S0YQKG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4MCPZEvnFdEIt7LHCyEa+ziE6doF9XD3m7PYs+EDEg=; b=i8S0YQKG+fw1xbIKZetnZ2jdsn
	HOE9nqzyIxHTYctCFe1eOZsokSasqyFkIfrYrJOWX/yz+JuTpvZRYuoGE2UjqKV7VtMQJlcJDKsWH
	I1kLsyvi2gATgRRXV/Wyd/Uw74ILdb1kf1OEOP8vJavSFqoUVEihgYceLuXgUef5+t7fGmwOTZOLZ
	FwPTTiWJ79j8hdgmIf4d1RnJKYovN5QotsPoGAtkr/CYwU5KvdCQEIf+d87rTkSXT3f9N7iHIfBAT
	OPRD8WIoN/d70oYmyeLWpW1ndu7g0CnSUQSdzFSbr6Nk5ZuIXrYfOP2xnYwU6lc7D4P0Nh/U6w6pp
	JDKJhCzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYY1-00000000Bci-1osE;
	Mon, 26 Feb 2024 10:49:25 +0000
Date: Mon, 26 Feb 2024 02:49:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] freevxfs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <ZdxstVnClJAFQl6h@infradead.org>
References: <20240224134835.829506-1-chengming.zhou@linux.dev>
 <ZdxiqJZY2qSRVvEU@infradead.org>
 <e5709d61-18cf-4c6e-89b0-9615296c645a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5709d61-18cf-4c6e-89b0-9615296c645a@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 26, 2024 at 06:24:32PM +0800, Chengming Zhou wrote:
> On 2024/2/26 18:06, Christoph Hellwig wrote:
> > Please just do a scripted removal after next -rc1 instead of spamming
> > everyone..
> > 
> Do you mean put all diffs into a single patch, send it to all people?
> That is also a choice if it's preferable. Should it will go through
> the slab tree then?

Yes, send a scripted removal of what is left after6.9 -rc1 either to the
slab maintainers or directly to Linus with the slab maintainers ACK.


