Return-Path: <linux-kernel+bounces-124446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77878917F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4664A1F22D99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2246A8A3;
	Fri, 29 Mar 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b7knOlp2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA848CC6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712432; cv=none; b=nnxV5LK4+Nc7H0mNS1DgO6+qQ77Uq1vEnNDF2/MWm2GAidIqk8CntRTeAGyHWbUzzq63UutB+jUwM5Qh5AFDXItQbU97bpfn4VMToa10WhX92Jlv7LUfLwBN/LV+n4Qy0RnagQAF32a515ibAVSSroUtNnzScpxWsRccy3KktPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712432; c=relaxed/simple;
	bh=2q9bon1N7z/YcMTzpMZQcL/2FStifz9bwDhhUDmX6Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOP1icH683yV3woEFQwvaPTFnNCgS3hOzsRl72haE6xVDc7L/hkEZqGm4tjGrUR+9tmo8XIVcXRBTn6nGgMVSnOI1Z9UZqhKKCtf9E2FQJj/osWWegHAIeenJDJe/qFXINkpVNonwBV1QHW7NmypZpw++IFsbM5ht1xCVWVGY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b7knOlp2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B50CE40E0247;
	Fri, 29 Mar 2024 11:40:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kf6oI_slP4Vq; Fri, 29 Mar 2024 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711712417; bh=qheMQpL7pKOjznFuXvmy0Ba+G6vxwN2lpdMdpi2wNKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7knOlp2beVUrI/zPH5WYYycV3Tk88DjTJedtwI/59jIsRDcLFmVNREf0uXxUdK7Q
	 MR8lWDCWjzt+ZD2oCYZPbczSQZLybGsJPKMmrYJWKVZQ7ODOgnbfcHYeMSWYCuVWRN
	 cGCLFobW+WJqm3rkaECt/8XTfic9J1q8nIQtonctLKK4aBP5CAihc9V4QQdOR+4aiy
	 1XBbYvseWw1bgeQIdlghMNEcGJaj+aHfe31ROEAVVKZhBqpfQAlxiyjG3DTmxOm/MX
	 IXKUrXmUUNM0hSk51b/4FZ1cQiGeCs3W2LZ4yuqZL4qsVs9zova7NpoNsrNNEqhCgv
	 Ggaju8wKpUissF9vg3Tn+EPtpBCYAfuT9dKWnqY7l3p5UiaHgi+O9jredJS8l+vicP
	 bHMNXRansdQihxgvXvh2OqKcTfppkELZmt97TAV5V78a+nwgOM+96p9WzrQ0/ZgZZE
	 vcNyYAkPLxVg5lBnCdNIi1MQRsGERI2QTCu7bUkLTcUopTYZnCvTCh1wvS/e6ISmgr
	 NGDeLQyF0XagKXzjdpPecnUKvtRwiua2z7OM7rwYeF3wXPnpAOiyUYYm4de1U94Zx5
	 03fxryJfrfJ70YSIYtw5Upv6j5ZHxZMIi8x2Hcet6Y9mxOpwsTKt6ntFKjIl4mzjGe
	 aaBlesBajaswMWrW3HXgaoU0=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE60040E024C;
	Fri, 29 Mar 2024 11:40:13 +0000 (UTC)
Date: Fri, 29 Mar 2024 12:40:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Mar 28, 2024 at 06:32:35PM +0000, Luck, Tony wrote:
> I don't think the format is really that big an issue. Including stepping in the
> format adds complexity to a thousand places these checks are made while
> only being useful in a few dozen.

I've figured out what the problem is with steppings - ranges. If you
have a range of steppings which all belong to the same model, then you
have to complicate the checks by either masking out the stepping or use
the X86_STEPPING_ANY thing which forces you to use x86_match_cpu()
instead of a simple integer comparison.

And you should talk to your folks what their plan is for the new
families because if they do a range of model numbers which all belong to
the same CPU model like AMD does, then your simple comparison scheme
goes out the window because it can't really deal with ranges.

Because from looking at your set, I don't see a slick way to check
whether a concrete f/m/s tuple belongs to a range without involved
checking.

For example, models:

                case 0x30 ... 0x4f:
                case 0x60 ... 0x7f:
                case 0x90 ... 0x91:
                case 0xa0 ... 0xaf:

are all Zen2. I could do a X86_MATCH_VF_MODEL_RANGE and we even had
a patch like that at some point but it didn't go in. But even if I did
that, I'd still need to do x86_match_cpu() instead of the current
X86_FEATURE_ZEN* checks we're doing.

So I don't think I can switch AMD to use that. It looks like the 'V' in
"VFM" could just as well turn into "I".

:-)

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

