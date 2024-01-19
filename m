Return-Path: <linux-kernel+bounces-31561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC2833017
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6738C1C20AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF4E57873;
	Fri, 19 Jan 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r87M/8Nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF057333;
	Fri, 19 Jan 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698619; cv=none; b=tyevIF2MLFJP0hDillqvvCchHn4NJpzADahO8GXlnc1nEOCsOpXIAnsDKhBrWV5VyxJ+nXaXlQFXo+cp6G2Noxpx7sxpWLepCqPYZO44K2RuKbrqSPUNf7wWfJkOVj3Q3uUkFiC60yGd0fsc1jo4UXxh5xVDpCvRmhs7fnKYM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698619; c=relaxed/simple;
	bh=GHGt3a1M2b6DqQEJSUpiqra2/Wnu01aLNg7ndzk/SHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L1wq+MY76QIJsGsXhljE9021o7hCflvoyIzHCwyrL1LuWqEzAq1dGUU5vJ9mCzdvG5BS/g4Gif27t62bKNS5+I+Rz4hQz24JepoNP19b4D6/ugzQCJm8lKi48zMaUOU/UwLfwGRHjsfGSSV5QsABPk5/fm579oG2n28sROND2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r87M/8Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB156C433F1;
	Fri, 19 Jan 2024 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705698619;
	bh=GHGt3a1M2b6DqQEJSUpiqra2/Wnu01aLNg7ndzk/SHY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r87M/8NvP/n4DrqkokSrI+vHc16xCd/loSxDnNuP92yGsLsPdtZb4pS4EM/mAVHGj
	 8kole/BH2+NS3HaZYR1QLdVkgGJwhfsL49bAwr2WWVXrNscN3icFVlRS2zbYm0k65C
	 B3kqNnOlIs30iiGhc6/ZSFAB7dmCYsxQ+b2Fg986PSPaxNSYrjk1mAgolX3zYC40hP
	 dFNmSTGMrWWLr95pIRgTC/moyRChgJpJKahip/BdelPLGx6bBWISlUHl6pdEN4C+1q
	 tx5sMz3cx+scSzNfAbV6Mo9RL0mwYrSOWJiVyc1L8v1l2yiS50D9V3ruqBkFB4IXGr
	 8EKImtxPjNVNA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:10:15 +0000
Message-Id: <CYIZP2D9FS0N.1XY2F5VX9STEY@seitikki>
Cc: <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Luis Henriques" <lhenriques@suse.de>, "David Howells"
 <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.15.2
References: <2744563.1702303367@warthog.procyon.org.uk>
 <20240115120300.27606-1-lhenriques@suse.de>
In-Reply-To: <20240115120300.27606-1-lhenriques@suse.de>

On Mon Jan 15, 2024 at 12:03 PM UTC, Luis Henriques wrote:
> Delaying key quotas update when key's refcount reaches 0 in key_put() has
> been causing some issues in fscrypt testing.  This patches fixes this tes=
t
                                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
						This commit fixes the test

> flakiness by dealing with the quotas immediately, but leaving all the oth=
er
> clean-ups to the key garbage collector.  Unfortunately, this means that w=
e
> also need to switch to the irq-version of the spinlock that protects quot=
a.

The commit message fails to describe the implementation changes.

You have a motivation paragraph but you also need to add implementation
paragraph, which describes how the code changes reflect the motivation.

BR, Jarkko

