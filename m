Return-Path: <linux-kernel+bounces-167221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828B8BA5DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08AE1F2321F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250822339;
	Fri,  3 May 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gJ3BFFwT"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC41F959
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708927; cv=none; b=WHw+l3gfQxxyLQ7SgGsz5dkBm1bGM3JmwIdrnAthCmvrvA6cqgG5sxxkNx3Km6bvbv7fY/kJTBG4H7qZBGcBBrNQffxJsO54KVBpZ8xk1LDBMlBuE2bMC4WYb/z8O29hQCK/B4MidKNuX2nGXbEugqmev3Ohsiq2xxUyjLdi3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708927; c=relaxed/simple;
	bh=EIKqL4Fe6zTfIiGFvhplX1rkhlisWCXGK/ugG3gF7sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsYRzv6XEiu96j5B8arfQg2LJmrCcODV/hc/iaYDotpaG8zQpXBY4tDVFowU/aky2Ofhoccaxaek51X9jk6DL6Hb9SW8kCvhud07D6TyQvyBVNPniLLNip28O7iBY+gFXL4iDaimOvcYTVGeHXCVn4LZK3gJwyt9Qxw76PZ13aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gJ3BFFwT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44341p7r020175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714708914; bh=/Wbln/AFVQgPbrMO1nTELVEZKZ80m+nkQTpGDkZe9XI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gJ3BFFwTyEwqRz9xM1YQTQROf7/IE+GR83zLkFt22axFIJDUBsSEKMFxvzBdSBrRo
	 8TpeuKaLYO+l8Y5meD8KjNMIjwLYT3CQ3lY5QSNljddgsZVZUzQa+LURkooGyEGs0d
	 uLBY9LB1hGp/SNoDc+YmwvWSzu5nCqyaD8DzUe+G/C4PIOstwLUHYB5HlY77z87+M+
	 42KszM9/mw2S7LRhqWh3DO/wY50nkDvWdu8LeB4/VMZl/4V5TQ4wikqRChzuFaK6B7
	 oGCNsFbyTMro38xzFbwqta7+RiOhd8lcY4h/84JjcIZYV3QM3qq2CpEL45577TN+qr
	 Jyuvpz5hHU6Mg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 828E015C02BB; Fri,  3 May 2024 00:01:51 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Justin Stitt <justinstitt@google.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: replace deprecated strncpy with alternatives
Date: Fri,  3 May 2024 00:01:47 -0400
Message-ID: <171470889035.3010818.5490902997038029222.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
References: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 01:03:10 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> in file.c:
> s_last_mounted is marked as __nonstring meaning it does not need to be
> NUL-terminated. Let's instead use strtomem_pad() to copy bytes from the
> string source to the byte array destination -- while also ensuring to
> pad with zeroes.
> 
> [...]

Applied, thanks!

[1/1] ext4: replace deprecated strncpy with alternatives
      commit: 744a56389f7398f286231e062c2e63f0de01bcc6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

