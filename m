Return-Path: <linux-kernel+bounces-125129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E089206C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AADF1F2DFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014212B6C;
	Fri, 29 Mar 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCnyz/Xy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93D18EAB;
	Fri, 29 Mar 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725941; cv=none; b=kG32LGxXQ7E1Li2WfOcf+hViEGYF7Uh0FY484dNR1qfrZAfI+ESJwrOoILcLmPN79LN9rhqlAWDEbSutyqPntaAMOkmxhSm3apQ46OEtqGmd3OR6SR30Hwwcq3zejL1laJYNqNfBhDPwCcgqOsZxIJhuHsnq+V1JNYApYFKl0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725941; c=relaxed/simple;
	bh=Y4KS72S4AdNfISG7IsoLtzgQAN6x9e7/OP4CCxCSW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHqkWyXH4rdRA7GA9y4badnjp2pYcn/C9q7rxA39Xek9vODOFHoAO61JQCEpN9i1tAdnLMKw38LBGEZ8Sk8BGFDizNLGUUtWlQNW3je7itbxiqgQbWRrYEVRSDCW6OOiEGVtslBEA+8CX+l5qjrV30TAZncjGZXzfEvKZ9V2vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCnyz/Xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74900C43390;
	Fri, 29 Mar 2024 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725940;
	bh=Y4KS72S4AdNfISG7IsoLtzgQAN6x9e7/OP4CCxCSW7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cCnyz/Xy3zANwU3+vZ0421YGKdSBMLgaX/OsbQTddeI0BTWPoPDBEMd9hLYhRrSbP
	 VbEoqe7/c6iMEzsm04bZVTBypnR8ISpGQNKK7ITQxUJkqtPu7MKSvZ+f4ESd+iKLrs
	 QJZO9DpMGVr2ak4rx3773HsAw09fJ397eUV3V2FilEmwbcrBLtc1REdFtTGUL+44+H
	 WOzuuInC+b2/5NeaqsrInAafaORWvRfbeGyaIoD/s64F5B067MZF99Rhms/HYCW5sb
	 nMSXJ+f2ooSabdkEqgHIOzcuofKmGd/UXR8gLYzu5svDlKVi8Vy0Yx22R+X3+ChJsj
	 L/qngR3c+ja+w==
Date: Fri, 29 Mar 2024 08:25:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Michael Chan <mchan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Michael Chan
 <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next v2] tg3: Remove residual error handling in
 tg3_suspend
Message-ID: <20240329082539.0be1853a@kernel.org>
In-Reply-To: <31ae4628-037a-4ccf-87d5-4cf00ae9c21e@ancud.ru>
References: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
	<20240326183544.488242-1-kiryushin@ancud.ru>
	<20240328181020.1bc21a3c@kernel.org>
	<31ae4628-037a-4ccf-87d5-4cf00ae9c21e@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 14:51:18 +0300 Nikita Kiryushin wrote:
> > How is deleting dead code a fix?  
> Originally, that was intended as a fix of a potential problematic case, that
> tg3_power_down_prepare() could change in the future, returning a
> non-zero status (which would make the removed code not dead, but undead).
> But than, as patch evolved, it became a straight up dead code removal.
> Probably, I should have removed the "fixes" line at that point, but
> I think it still useful as a reference point to know, after which commit this patch
> becomes relevant (to know, if it should be back-ported to some version or not,
> for example).As I guess from the guide, patches "Fixes:" tag has some special treatment in the development cycle, but what would be more appropriate in that case?

You can quote the commit where code became irrelevant by saying
something like:

This came became unreachable in commit c866b7eac073 ("tg3: Do not use
legacy PCI power management").

Fixes tag are often used to indicate that something is a bug fix.
Backporters are unlikely to care about this particular change,
let's not waste their time.


