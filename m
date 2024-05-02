Return-Path: <linux-kernel+bounces-166873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A28BA133
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DA1283F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FED17F38D;
	Thu,  2 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="X123wMgu"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5371802B9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680029; cv=none; b=thbRbSboKttjRk7jBrORxu/qvSt7BXCnWbd6IF7hzK+QAEKjZ3RLbc9xMJPQsMIgS3RNxJpM0HmTJEz6YMUVbNWf3SZj94tfQvkvs8yq7aovdLm3dA9JVtnrsoxRBMhVziajEr+IKCz95Wf3+y99M2rdoCgA3L+HX/2A6lunniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680029; c=relaxed/simple;
	bh=y1KpRPxi6UUt4YkKUpOu2IplpTg2KomJhl1wC4mF4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTTdCOV4bNoGMWGuNReV5xRfZmjn7tIahyYT2fc7+maG0zN/vSnMTyOq8sFvjrDgeV/DFNG/vK2U+TWUxgXec5Be/8Cgt3baJo4izFxPsC+H6nAEYcJlisHQZ2Nf718bawr9/zdSrpdyRLiqa5hrsSsTdT0HgVTnR6tu7D/0G2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=X123wMgu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442K0DZn006120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 16:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714680016; bh=Lrv6PuMICPe45nG6IQNLMoZGE1syVHnTdlOolvBM938=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=X123wMguaUunrJAloOWDa77yy2QIb7fV4Lgd//omVBOnCzEKInzMUh12QOivEBuIW
	 7BxQ+0LT75xnhak8Ykd37+bu89qUcxfh3LXaNdutZG+Mt3lltQUfB71svFj0Mj3kxK
	 86u12oPqVW0CDEW2ou9UN5aeAUY3XpvlCMC47jXe5dXbIjoZqqeWo9Pew3mWSflAaC
	 jsJQmXepkk5uj1bRw+lR1eQugF3tKInwK6caDvF7nZQ8NUJ+wfopUppkPWUa7n6Qop
	 WCeQ6/U5GoWKekPC22Ez4QJzLG2dxDYP/KjVYZaaSrsVYGZeGWUuvghjS+Yj7FPau6
	 DGJciBMtLNPsQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AD8EA15C02BE; Thu,  2 May 2024 16:00:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com
Subject: Re: [RESEND PATCH] ext4: Remove unneeded if checks before kfree
Date: Thu,  2 May 2024 16:00:10 -0400
Message-ID: <171467920457.2990800.8945743113092787242.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412225026.207063-2-thorsten.blum@toblux.com>
References: <20240317153638.2136-2-thorsten.blum@toblux.com> <20240412225026.207063-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 13 Apr 2024 00:50:27 +0200, Thorsten Blum wrote:
> kfree already checks if its argument is NULL. This fixes two
> Coccinelle/coccicheck warnings reported by ifnullfree.cocci.
> 
> 

Applied, thanks!

[1/1] ext4: Remove unneeded if checks before kfree
      commit: ea7d09ad7c280122a322f408672ab8d75c1a0e30

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

