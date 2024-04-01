Return-Path: <linux-kernel+bounces-126661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA8893B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2A1F2205F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099133E495;
	Mon,  1 Apr 2024 12:48:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90919219F9;
	Mon,  1 Apr 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975693; cv=none; b=gSDWUblcEzSu9fUlx1di/vhRwau8Jid2Dql6o2P+RTjlFSyE2wev+VZiR3/kgGcH7QLQta3HNg1+5UfjNEP8VCu3zvIGwH36WFe9ketMrhywkszBIFnkHsKuieJc38Tg8N2XvbPYXtS+FZV998vxokkGF/woUBQFDqZgmK7vkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975693; c=relaxed/simple;
	bh=2BFcbcdVntnlGcJuBtVOzuZjIQk1ui17aXdZS5wM33M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qnzhumR+z2R4p6E3uhsIkmRr2jI25EzS4Rp4PqMopOn8Unn6mHBnYcuL4Y1Hyi03RDSbkI7TxsB04n0SumaCPAaumS97gBPv+jkNwSaEt/YLjUUp+l3hdis8XN1+RSDk1DM1CXHt2Ve6zIEZeySZSk6T69EmI6AME6eHT2Uh9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE8EC433C7;
	Mon,  1 Apr 2024 12:48:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 62A2410608D9; Mon,  1 Apr 2024 14:48:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240325203129.150030-1-afd@ti.com>
References: <20240325203129.150030-1-afd@ti.com>
Subject: Re: [PATCH 1/6] power: supply: bq27xxx: Move temperature reading
 out of update loop
Message-Id: <171197569037.595938.587169149835280734.b4-ty@collabora.com>
Date: Mon, 01 Apr 2024 14:48:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 25 Mar 2024 15:31:24 -0500, Andrew Davis wrote:
> Most of the functions that read values return a status and put the value
> itself in an a function parameter. Update temperature reading to match.
> 
> As temp is not checked for changes as part of the update loop, remove
> the read of the temperature from the periodic update loop. This saves
> I2C/1W bandwidth. It also means we do not have to cache it, fresh
> values are read when requested.
> 
> [...]

Applied, thanks!

[1/6] power: supply: bq27xxx: Move temperature reading out of update loop
      commit: c32c617de8076d8fb2a16a4a2f3b5da5f3df398d
[2/6] power: supply: bq27xxx: Move time reading out of update loop
      commit: 651a620aa4d49f5647e21e55fc71bb049bc03389
[3/6] power: supply: bq27xxx: Move charge reading out of update loop
      commit: 8d846335204f25a2247e5e88e39e1604b6ecc133
[4/6] power: supply: bq27xxx: Move energy reading out of update loop
      commit: 39cf1c4cd03254218a23ef955bd534e19328f618
[5/6] power: supply: bq27xxx: Move cycle count reading out of update loop
      commit: 656489ac90f25f92190a1dd5c4e5c5293bd70323
[6/6] power: supply: bq27xxx: Move health reading out of update loop
      commit: 50f0ff7c8cc4c1d10fabc4b3b3f3b9e942b08187

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


