Return-Path: <linux-kernel+bounces-76551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C014485F905
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7F21C23B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755F12EBCB;
	Thu, 22 Feb 2024 12:57:45 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15D60B90;
	Thu, 22 Feb 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606665; cv=none; b=tUXwoTmlbADQdD2GfD+mIehuDoyE174+2M58hEoxbRBrn56mOY4FvkRAVrPKi72Cg2CH38mGOmsAS31wrxFKdRtcqXyJK5ouzjTBrt76f9N4pG92U92+Bl4SQnNZ6/dgfO/oNTw5qv7qU3ZZbCVHFhS0vJ2GP0V7n85lG5rIETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606665; c=relaxed/simple;
	bh=+qvvPZXpgTl7G1RN1KLsQKEcGIO6JxzMVv5IwwoubU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTPpFAZxzlje+z0rpMFZZTiK+WdTOP7VEc45DPsgVsjIAsqOdh236oJgTH6uRYDFPR1HczLHAC/Y3dxjxOCBoZKpCRnHpEWNFIdDUOHFyC1CIg6Nnt/e5bl+njp8SsQWGXCeTCTJB9EKtkRcmjsr37qts5rgOD1DQGVwwOPh+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rd8du-0004wI-17; Thu, 22 Feb 2024 13:57:38 +0100
Date: Thu, 22 Feb 2024 13:57:38 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>,
	syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>,
	davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
Message-ID: <20240222125738.GC28098@breakpoint.cc>
References: <00000000000043b1310611e388aa@google.com>
 <20240221131546.GE15988@breakpoint.cc>
 <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com>
 <20240222122324.GB28098@breakpoint.cc>
 <CANn89iJ6UxRPRJeat==LXQS7B7rYpUN3BvBJv3w1_v5y53cfSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJ6UxRPRJeat==LXQS7B7rYpUN3BvBJv3w1_v5y53cfSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> I was thinking about adding a debug check in skb_inner_network_header(skb)
> if inner_network_header is zero (that would mean it is not 'set' yet),
> but this would trigger even after your patch.

What about adding:

static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
{
	return skb->inner_network_header > 0;
}

.. and using that instead of checking for negative header length
post-subtraction?

