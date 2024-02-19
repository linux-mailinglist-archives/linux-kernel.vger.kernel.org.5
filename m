Return-Path: <linux-kernel+bounces-71666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80985A8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0811C22CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6341773;
	Mon, 19 Feb 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo5yyCr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D140BE4;
	Mon, 19 Feb 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359584; cv=none; b=h4Pl7sVUNH6harYUSdGXUDYU9VRUt/mzVrOrNWPXpqnX7jxK0It/4YpwfiHcj7eMJPG54/dPGbSwKKoNcTLs/DjH7uY+KDaCHcw1EWkLmnkk6yJm7W0vOWjU/yOf4lkEcZyPTmKK5pzR8v5UjV8HMtTGg5Z7jrN+eDfPPZRNM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359584; c=relaxed/simple;
	bh=geMTJ9lOTTXbNkYKZFBhsIQdmz8LDBCNbCre8M8nqR0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OnisBO6ozDisvQX3znNgeJsLqLm47XXixPrKrEsq9TOTqQAOnYsnOEptiPgm47o90KH1XOiPp0lrX6YZyGo4K7Mm6WDBa6rKPhHeMQO42jofe7apZf09uC4cXapUIe1s5B5zQbiLxb7K4tbNfdTlczr+N3bezepj+9qjTGHcMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo5yyCr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F60C43399;
	Mon, 19 Feb 2024 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359583;
	bh=geMTJ9lOTTXbNkYKZFBhsIQdmz8LDBCNbCre8M8nqR0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Xo5yyCr17Zoe09ZxqrdyCQU2C6g1HE9oPU0CRmvyA8NN9MqCk+sP6YsTrqD1nbheD
	 ZGbriuY5QIQt7FJmgODmak9gdO89i6WdJuNuzt3kQS+GT5wyRNVMNWBcfHM6WuZkhR
	 CHd6SYp3jxQa9G3TZsPxRBuOLfrRjKvdZrIcEojizE2trJ7IiUa4J1fbHERsmRcdCZ
	 gKVmYrLRZ70GMdsr3IolfJuSY6alj3rdMbIBOn1p+WBUn2rxp0kHf2+7CQA9Hj9kg5
	 MbGnhP3Utq9Ok/JWLZBeqrY9Med7mcC//cLqVzvK6AkHoifC6oqHaHvL9D1lEJeiYK
	 80AmKKiI7eN3Q==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  Claudiu Beznea <claudiu.beznea@tuxon.dev>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] wifi: wilc1000: fix RCU usage
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
Date: Mon, 19 Feb 2024 18:19:40 +0200
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
	("Alexis =?utf-8?Q?Lothor=C3=A9=22's?= message of "Thu, 15 Feb 2024
 16:36:17 +0100")
Message-ID: <87h6i4mnoj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> This small series aims to fix multiple warnings observed when enabling
> CONFIG_PROVE_RCU_LIST:
> - add missing locks to create corresponding critical read sections
> - fix mix between RCU and SRCU API usage
>
> While at it, since SRCU API is already in use in the driver, any fix done
> on RCU usage was also done with the SRCU variant of RCU API. I do not
> really get why we are using SRCU in this driver instead of classic RCU, as
> it seems to be done in any other wireless driver.

And even more so, no other driver in drivers/net use SRCU.

> My understanding is that primary SRCU use case is for compatibility
> with realtime kernel, which needs to be preemptible everywhere. Has
> the driver been really developped with this constraint in mind ? If
> you have more details about this, feel free to educate me.

Alexis, if you have the time I recommend submitting a patchset
converting wilc1000 to use classic RCU. At least I have a hard time
understanding why SRCU is needed, especially after seeing the warning
you found.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

