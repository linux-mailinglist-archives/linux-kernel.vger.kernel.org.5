Return-Path: <linux-kernel+bounces-94191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F0A873B18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230201C21099
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3013540F;
	Wed,  6 Mar 2024 15:48:43 +0000 (UTC)
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A873130ADD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.78.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740122; cv=none; b=pBm48lIR9aTIfIi2xHC3hnMPjWEG907SXW7gZf20h3NNKy84TCkNGpIBBgDRcKNM7jTLDQpJjJrbCLahaTeRJyl8+dUhYsUcQRCPUIaYKMemx0ugjAe/yy42hfN0ZpnThmvpvZ9OMFnNUoR4SvCleLlGaP38otQ1MKlv/8O1Zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740122; c=relaxed/simple;
	bh=ddVEZ/hCRRIaQR+Zd4qHp55qWobjMRKrD1xXYor6Njs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tfCsT7mnLfo23l0wJh3xGGr8bxRzoPwOY6OxQXp5NIiiZNj3lazSOJnnYthWUJpvu2XvxrSNrEDYC7Y7qNIMtQXhz22oqf94VqAPlvKajFF1khthHpXSf6wWiMAx07/basFyKdO68+Rm+BupIICgoXApfUCvwlFXEzf3eWzDQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.78.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.148.178])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4TqcCk08Sdz1Prr
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:43:29 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-zgt6x (unknown [10.110.113.115])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 523151FFCE;
	Wed,  6 Mar 2024 15:43:29 +0000 (UTC)
Received: from etezian.org ([37.59.142.109])
	by ghost-submission-6684bf9d7b-zgt6x with ESMTPSA
	id mCmqCiGP6GXMAwEAjxLk1w
	(envelope-from <andi@etezian.org>); Wed, 06 Mar 2024 15:43:29 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S003b68dbd3f-2314-40a5-abca-d04c75d496b3,
                    62DEF991EB217AB86F953B10C2782167B22AFEEB) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240119013326.3405484-1-jisheng.teoh@starfivetech.com>
References: <20240119013326.3405484-1-jisheng.teoh@starfivetech.com>
Subject: Re: [PATCH v2 RESEND] i2c: cadence: Add system suspend and resume
 PM support
Message-Id: <170973980846.1763249.4872045565378143580.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 16:43:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 10313524625080715995
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepffetheduffdvhfdugfffudfgjeejudehheegfeeguefhieeugffhgfeuffdvgfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeelrddvudejrddutdelrdduieelpdefjedrheelrddugedvrddutdelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht

Hi

On Fri, 19 Jan 2024 09:33:26 +0800, Ji Sheng Teoh wrote:
> Enable device system suspend and resume PM support, and mark the device
> state as suspended during system suspend to reject any data transfer.
> 
> 

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: cadence: Add system suspend and resume PM support
      commit: 747bdf912e22732e8de9bd04a2d3e387055604a8


