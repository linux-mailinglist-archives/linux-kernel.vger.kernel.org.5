Return-Path: <linux-kernel+bounces-16250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895C823BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9EB24D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394331D532;
	Thu,  4 Jan 2024 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="bD8WH9+R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D881B28D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1704344723; bh=fgG3RR6ns0CBYeFcOflZPGhr9fVyxh18ERVWnEeDq2I=;
 b=bD8WH9+RlN16hufHYZMF/07I1gDRj1hle6W3s03f4PUUs5TBcdZMWg77G81nW8IXnYW8zJrfp
 qffgW/rBq5U7pmDVGhhjtmfDdMJzvwTSaJ+SfojoB3cKBohlCltfDhDbMKjCNEHCsricsYsCEA8
 uf/zDa6ghvZxxOjsMcdnUbo=
From: Brad Cowie <brad@faucet.nz>
To: aconole@redhat.com
Cc: brad@faucet.nz, coreteam@netfilter.org, davem@davemloft.net,
 dev@openvswitch.org, edumazet@google.com, fw@strlen.de, horms@kernel.org,
 kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 lucien.xin@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org
Subject: Re: [PATCH net] netfilter: nf_nat: fix action not being set for all ct states
Date: Thu,  4 Jan 2024 18:04:52 +1300
Message-Id: <20240104050452.808076-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f7tle97eppk.fsf@redhat.com>
References: <f7tle97eppk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65963c921192512af6adefb7

On Wed, 3 Jan 2024 at 04:10, Aaron Conole <aconole@redhat.com> wrote:

> LGTM.  I guess we should try to codify the specific flows that were used
> to flag this into the ovs selftest - we clearly have a missing case
> after NAT lookup.

Thanks for the review Aaron, and the sensible suggestion to add a
test to ovs to avoid this problem occuring again in future.

I've simplified our NAT ruleset and turned it into an ovs system test,
which I've submitted as a patch [1] to ovs-dev. The test reproduces
the issue introduced by ebddb1404900 and passes when e6345d2824a3
is applied.

[1]: https://mail.openvswitch.org/pipermail/ovs-dev/2024-January/410476.html

