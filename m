Return-Path: <linux-kernel+bounces-82093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB98867F19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7984E29B950
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340D130E26;
	Mon, 26 Feb 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M832y/Kf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108012E1F8;
	Mon, 26 Feb 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969326; cv=none; b=tbsUG+L10Uq1TlDT6l3t1a+ii1OsAPFUnAv7m0gqhjjK4XGopS1GSw1LCiduTHq0l1qs7A2Db9/rHQjTWeRXVocPeeg4K90ZUYqDj7cdTy6fAsVlrKOTz8ztv1cnUD3RnS+rBftmyGuK8ZkPB/WxhPrFN1h7/915QbP1Zxe4Qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969326; c=relaxed/simple;
	bh=iwCMXGQsbQGxiwJHs3E7w0+xefWy7qifrPJJKX5kaWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDSvpPApulPUj9DpmPRRIOGDP13+JoR9zQcH4KuNpwmBZl0NaMw1bk5X5WbXdvZ7k/90P3teYHHIlHxmVrPgXC+BOA75YHbk9avQnX/dJGVuWZkw4vlflBT2VmjBbrCH8QDIFCpIsQBSoZeztscUZ8Vlyp9VTzIRFeY7/kTmAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M832y/Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91435C433F1;
	Mon, 26 Feb 2024 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708969325;
	bh=iwCMXGQsbQGxiwJHs3E7w0+xefWy7qifrPJJKX5kaWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M832y/Kf5o1+ndCigTMjJT0fqyP07vheldOXHsrUIazVUsDR1n2cK1kUPBNZJ32tI
	 GqPO/GOeqgoHtwrWa28KMr+p3w/oHNMyBKu4+FshHmfKOHClC11AY1UMrhC77B+dDt
	 UvpOd7A7Xb9p94SZmSp10hBvODDMZO2OyOSgh8XW0cEdskgxj4lGQLxxSeNhj+Wojr
	 PzrbU4Q5ISYRdIlG4hyDAPSH8yvGFMOsbAVKBk/LchidazNKTboLZwyCxyb7JLYkEF
	 xgcBRTlePUqNPjwz8nx9jdFtb6Q8cLlWhyTy76KBtLOWEDfx+DFmrm0PZ6DR9dXIf1
	 GwjHvFAT250og==
Date: Mon, 26 Feb 2024 17:40:31 +0000
From: Simon Horman <horms@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: mptcp: explicitly trigger the
 listener diag code-path
Message-ID: <20240226174031.GH13129@kernel.org>
References: <cover.1708515908.git.pabeni@redhat.com>
 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
 <20240222131338.GA960874@kernel.org>
 <22424f1c-3f76-454d-9de4-486c3f2f2478@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22424f1c-3f76-454d-9de4-486c3f2f2478@kernel.org>

On Thu, Feb 22, 2024 at 03:49:44PM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for the review!
> 
> On 22/02/2024 2:13 pm, Simon Horman wrote:
> > On Wed, Feb 22, 2024 at 12:46:59PM +0100, Paolo Abeni wrote:
> >> l The mptcp diag interface already experienced a few locking bugs
> >> that lockdep and appropriate coverage have detected in advance.
> >>
> >> Let's add a test-case triggering the relevant code path, to prevent
> >> similar issues in the future.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
> >>  1 file changed, 30 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> >> index 60a7009ce1b5..3ab584b38566 100755
> >> --- a/tools/testing/selftests/net/mptcp/diag.sh
> >> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> >> @@ -81,6 +81,21 @@ chk_msk_nr()
> >>  	__chk_msk_nr "grep -c token:" "$@"
> >>  }
> >>  
> >> +chk_listener_nr()
> >> +{
> >> +	local expected=$1
> >> +	local msg="$2"
> >> +
> >> +	if [ $expected -gt 0 ] && \
> >> +	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
> >> +		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
> >> +		mptcp_lib_result_skip "many listener sockets"
> >> +	else
> >> +		__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp"
> >> +	fi
> >> +	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
> >> +}
> >> +
> >>  wait_msk_nr()
> >>  {
> >>  	local condition="grep -c token:"
> >> @@ -279,5 +294,20 @@ flush_pids
> >>  chk_msk_inuse 0 "many->0"
> >>  chk_msk_cestab 0 "many->0"
> >>  
> >> +chk_listener_nr 0 "no listener sockets"
> >> +NR_SERVERS=100
> >> +for I in $(seq 1 $NR_SERVERS); do
> >> +	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
> >> +	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
> >> +done
> >> +
> >> +chk_listener_nr $NR_SERVERS "many listener sockets"
> >> +
> >> +# gracefull termination
> > 
> > nit, as you plan to re-spin anyway: graceful
> 
> Paolo sent a new version on MPTCP ML only. When applying the new
> version, I fixed this:
> 
> https://lore.kernel.org/mptcp/e98b8b07-558c-498a-97fb-dd5cab11e439@kernel.org/
> 
> >> +for I in $(seq 1 $NR_SERVERS); do
> >> +	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null
> > 
> > I'm not sure of the validity of this but shellcheck complains that:
> > 
> >   SC2069 (warning): To redirect stdout+stderr, 2>&1 must be last (or use '{ cmd > file; } 2>&1' to clarify).
> > 
> > Also for the same constriction slightly earlier in this patch.
> 
> Good catch!
> 
> I should add shellcheck support in our CI to catch that :)
> 
> I just applied the suggested modification in our tree [1]. The new
> version that will be sent to netdev will no longer have this issue.
> 
> https://github.com/multipath-tcp/mptcp_net-next/commit/31f1460d552c

Thanks Matt,

much appreciated.

