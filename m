Return-Path: <linux-kernel+bounces-52687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CB849B69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1234A283454
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5731CA9B;
	Mon,  5 Feb 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IaQsS8wn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7A1CA85
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138556; cv=none; b=i1rNtfA8Yf2jqEXM9f0fJNxuoi4iasNnUfdxd6NiLkFx02F4m+JxfDcUm3WL1rwXW4XWhRced6oSykmw5n619BsEv8c3PO9JjbQfHRieMCvzwnMELHvi6wfNZxHmQ3L5qvRnxJpGavuyVAFM4OuyQSGlMgdOVn4dxTRBn3M2duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138556; c=relaxed/simple;
	bh=cwiMHH/Uxus1b/Lb+fqTiij0yN3Gf84ALCpr8Ufl/HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiZcAgFWh/+ggZo4cI2z6r5/ueUCBP3f4C6k38EJPAuP/kZgd31G+WdVo40w1NFNyg2KRDPAG5HAWTEXCrAPf1iCN8kfKwIjIGzTLz+1zSADXcrNicJ5dNYk8SJPolFS/JsUdktQL+LCb2PfHjM4oQQe+CFkGjCvVDKOqfzGEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IaQsS8wn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 269B340E016D;
	Mon,  5 Feb 2024 13:09:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eBfDbeBbddLz; Mon,  5 Feb 2024 13:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707138550; bh=/6+iWnw0WyzCRyhPWeQ9RCXHp/IIDveLJqKA7zSqZdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaQsS8wnxiT594fXP7DGGqPKnQPRoswfj+vmXfoIqEzFoTLD0a15RHqZMH6ctlClt
	 Iqi/BJgGL9w7ysV/968TsezxCaZwUYnc19uBC37VR4yxgFiUkk7aBaaCjGvmbL9Wrc
	 mnroGC7LI5V9onyggCIU+/tJh5EW0NNzWrEIp2B0eFunaOyayv7pgAS1X4LGCCp9Uo
	 xEB25PYLzbvhL7UFrqhpLpb7M7wXeiH8SKYhHjPvY6j/ld85NCbqlYqo/P/DzSa/B8
	 gS+rtKokXXOBUbUCruohJYP7SXgGSeKcU6L9vrB/lij8Q84V0PAq03TIiiBnMWyJ6w
	 Kc+bZoO1lgthVpb3pY6qpABjYdTzBxcCPyhZcXiehUBwhjqW1VgvzvUZXrPMoqWjt0
	 lbsEW7nqgV4xUbOyBA2tCmAVZaLvX+4ZbZ8ba8+l6IySzW02jzRpg82BwmiRhDN1v4
	 +W3P4v2x4ycgBlvOC4ZvNC6Wraz1S1j8v8vOfb8JMj/QXYL/VuAt0oSQSKI5Cn/TWi
	 mePddY719DklT3Y4u8kIm6f6VzGPlzKRE4TK42GTVXXZ3hMVlia+HEXWhFpnVA9J+T
	 TQeSWYof63BJCRGrVs8hF6/QvRm0GhLVBUdpz4c/vIYYwDMpWR7gLFk9amxFRqIfOa
	 Lyub2uk1TnmyzCzka4e1iNDo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 142A340E023B;
	Mon,  5 Feb 2024 13:09:02 +0000 (UTC)
Date: Mon, 5 Feb 2024 14:09:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <20240205130901.GEZcDd7YsmIpBPuXaj@fat_crate.local>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
 <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
 <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>

On Thu, Feb 01, 2024 at 12:17:32AM +0200, Kirill A. Shutemov wrote:
> It is better to get confirmation from HW folks.

Yah, lemme see what I can do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

