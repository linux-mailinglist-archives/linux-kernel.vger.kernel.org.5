Return-Path: <linux-kernel+bounces-36758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57183A616
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D5B1F22447
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0BD182C5;
	Wed, 24 Jan 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cu3eigpU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1417C6E;
	Wed, 24 Jan 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090252; cv=none; b=QdMMkpTVrjQoWu6R+FJYyqyuQXGjcZw/1IAkMsqK347GoaMXjv9vpButoWtSqNEVG8GtgpUpwaNMwUXx//xSp/64PQFsFJ8s+fdw1tj5VehuFMVd7kKnk+vtiukjuEl67RMxArXVzx3GYLNn7mTqa9B1DhHkulkR1Gt2rN52oeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090252; c=relaxed/simple;
	bh=9+hKMgNhK0f6pEf/gbfH0HV3V5FHbRS671inekWpQlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewTW9mS+JbPtStVh/86gFwfmyc1vifRSf6o+gnU3BIhkevB+QBNaAsmXJBqlicWdr+NexSgzQrQl2O01gLnepJHTXbLHpnaaQVjC8ClfWRD+blYleGMXa366RpF4SetKFCqTNIHn2aDdZLWicC1nqzoape1KQC6fSg7Y4ejSaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cu3eigpU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 347E540E01A9;
	Wed, 24 Jan 2024 09:57:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y0rsV01bne4u; Wed, 24 Jan 2024 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706090244; bh=Wto19mwz6qJ8ocgEL/gMtNXJgnaeFsjJB6kj/OkwYo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cu3eigpUjChBJTCD/hAw5mjfgJEHHw6B4s6u4ZmNj0d+5LEzcvUIdv09VBtPD9UqD
	 SSzMty3hlSB7Tmki1utFQ0sK/eF1Bfwd3KpLdWmG6gWTA9M9K1+10XXdJYJy+8CSSJ
	 DwrRnBtBCb1+6uy7Y5LZkr8DhoUoqIi/EBTBPpf5B/PY7mt9tjT6QDfHegQC8UgMwg
	 2Pj7syZ1T2cmLebELuNFJ17U/OMK/UcfDL4uCMNsG3Ybh978r31+Uq0IzJgSF+xMtf
	 unIU5bN54CgTcfSZGwOSlCKE9jx5kP+ZamDhZJzjuUZqA8Vx6nAIxYXWz4oe7OSe++
	 V1VqHw1i1qoXykDWSZ2DJY/ADblFdD+vbfXQK68JQ2H2uAQZHQtYOljsECw4oSnXwe
	 6vKCNDIpBKIkQ6L9njqxzG5K6StncKR9PVXVSu3O2fHtJp9C2lXZS5Im6oeNsvnjMv
	 2RbsGexzBLDMyT1mmTY87yP4qkIlxuFFp3rEj6z5SnOIkoFcAp9cpauRBML3MvBKkN
	 MFdgaiNySpC198OdSCjRrlh+l6jRllabsrsF33f/esFOYyYB0I/b1VpQq+K/ZAtNNF
	 UPaqPD585GJaHC3hzj/5I1+D3rKhsD0DhuWcjRUGtUsjpCw4zpnctxbFGHd0s41NmP
	 4Jjr1z/00jR+fwpBzdXlXBEg=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFBA140E0177;
	Wed, 24 Jan 2024 09:57:14 +0000 (UTC)
Date: Wed, 24 Jan 2024 10:57:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Naik, Avadhut" <avadnaik@amd.com>, Tony Luck <tony.luck@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, yazen.ghannam@amd.com
Subject: Re: [PATCH] tracing: Include PPIN in mce_record tracepoint
Message-ID: <20240124095708.GAZbDe9Hks0tL2Aj94@fat_crate.local>
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
 <ZbBV4EGrZw6hJ5IE@agluck-desk3>
 <be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
 <20240123203853.66655e95@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123203853.66655e95@rorschach.local.home>

On Tue, Jan 23, 2024 at 08:38:53PM -0500, Steven Rostedt wrote:
> Yes, rasdaemon uses libtraceevent (or a copy of it internally) that
> reads the format file to find fields. You can safely add fields to the
> middle of the event structure and the parsing will be just fine.

Should we worry about tools who consume the event "blindly", without the
lib?

I guess no until we break some use case and then we will have to revert.
At least this is what we've done in the past...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

