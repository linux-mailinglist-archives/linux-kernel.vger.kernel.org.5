Return-Path: <linux-kernel+bounces-76568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B685F946
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6261C20DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA9134CC2;
	Thu, 22 Feb 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAeTY3fS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC712FF95;
	Thu, 22 Feb 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607623; cv=none; b=YjHn3DqxCZ2xjQju6PqyiMM/zzYz1bZJi9ggTx+FLuyQN3gB85NCGOMR4yNbBiBkgSCWF29jn6c/ADB15iQ4SMkm180Dc5K2sYH+gM/Cn7cOUYhp1ddSiBPMR7qBGnyGRqB0o9NcpCso2/s/I/uS1B857N9TBv8JxChT8cg9yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607623; c=relaxed/simple;
	bh=6OzfR5St32D1ssiPndCMGGUD7Z7DoQf2u0dqtnL026Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY8bUIncS9L3Y7a1UxHytBU0PT8kQQRymiWAWp3gALPRMCHuUtlQh8FOEDx8zbtwco5EmvX3yjN8GqdH22IoBk91NsUvoYd0hQ0yLl5Qj5yc20lr19ofPZ/EmY0NNFCyS66dI3C9FNUqMZxQMoRnfx6F9wyGRQQ7GB3+Za6rPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAeTY3fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C78C433F1;
	Thu, 22 Feb 2024 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607623;
	bh=6OzfR5St32D1ssiPndCMGGUD7Z7DoQf2u0dqtnL026Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAeTY3fS/OcZeu4gttXoRy4eOkX7GsE7tkpmuOObXKBrKxsP1cLy0sSdOOmEdJwLt
	 bBio7Khp5uxXWBSTmNPmu+KWattjJtUwz9GaLqf83TJF6WQTwR+r6nyFnCGhTGB9e+
	 D/eH69N/XwQmFyyswnQeF98uEnS/xoQ2YvUE+4HThieiyNzAubRL0qJ7175AizmlLw
	 lpxjV3Ho5kv8TIhemS9HkrjVVWzuNu6ArvMTU8oLj6m+DKiOmRu74kgRiQGo8JSD0Y
	 3fREI6cO1lkdXAA9av0+DeI0VMcvVbsz3ciIghVmjUynl5x6vlAlwnZsI6VVHppm7P
	 N/Otv6CbOTTOw==
Date: Thu, 22 Feb 2024 13:13:38 +0000
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: mptcp: explicitly trigger the
 listener diag code-path
Message-ID: <20240222131338.GA960874@kernel.org>
References: <cover.1708515908.git.pabeni@redhat.com>
 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>

On Wed, Feb 22, 2024 at 12:46:59PM +0100, Paolo Abeni wrote:
>l The mptcp diag interface already experienced a few locking bugs
> that lockdep and appropriate coverage have detected in advance.
> 
> Let's add a test-case triggering the relevant code path, to prevent
> similar issues in the future.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 60a7009ce1b5..3ab584b38566 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -81,6 +81,21 @@ chk_msk_nr()
>  	__chk_msk_nr "grep -c token:" "$@"
>  }
>  
> +chk_listener_nr()
> +{
> +	local expected=$1
> +	local msg="$2"
> +
> +	if [ $expected -gt 0 ] && \
> +	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
> +		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
> +		mptcp_lib_result_skip "many listener sockets"
> +	else
> +		__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp"
> +	fi
> +	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
> +}
> +
>  wait_msk_nr()
>  {
>  	local condition="grep -c token:"
> @@ -279,5 +294,20 @@ flush_pids
>  chk_msk_inuse 0 "many->0"
>  chk_msk_cestab 0 "many->0"
>  
> +chk_listener_nr 0 "no listener sockets"
> +NR_SERVERS=100
> +for I in $(seq 1 $NR_SERVERS); do
> +	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
> +	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
> +done
> +
> +chk_listener_nr $NR_SERVERS "many listener sockets"
> +
> +# gracefull termination

nit, as you plan to re-spin anyway: graceful

> +for I in $(seq 1 $NR_SERVERS); do
> +	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null

I'm not sure of the validity of this but shellcheck complains that:

  SC2069 (warning): To redirect stdout+stderr, 2>&1 must be last (or use '{ cmd > file; } 2>&1' to clarify).

Also for the same constriction slightly earlier in this patch.

> +done
> +flush_pids
> +
>  mptcp_lib_result_print_all_tap
>  exit $ret
> -- 
> 2.43.0
> 
> 

