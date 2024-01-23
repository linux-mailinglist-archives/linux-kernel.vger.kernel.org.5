Return-Path: <linux-kernel+bounces-35800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC68396C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D568E293ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4B8004C;
	Tue, 23 Jan 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O64Q2j7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7A80036;
	Tue, 23 Jan 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031991; cv=none; b=OKdYVlCEjBmVEh/z/rel16DO5v1bWwAcraETZ3MMHfDP7H4YAxS+PACmNdGAWb622U0wGvG9NfUgRALhwl67pDN1dT/xJbVMDhS46gWgn0nnFRNxz64VOrFpx1XX/CWADoxGyomvrF+vdMwm8Mjby4z61IS2PRe6531o1urpUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031991; c=relaxed/simple;
	bh=NkHE5jAGeam0OhUX55X+rbk7tkRtqWrCjQ1f8FdelE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxPyIRA/JMmGA7zZgCwjwNltP8cUvZ95dXdKEQ7+t+yIDTfBY82Ngvt7QIXAu5KM9PoS/E7MkOWwgzKl0yv7QhQIHJRhvd+6ajDhdS+ou3zRAVpD9HPJu3QSV/T1BoslJ8RNqzItjG1DclyT8yUXqZccbi8K/4UU13IlRmNt0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O64Q2j7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11DC433C7;
	Tue, 23 Jan 2024 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706031991;
	bh=NkHE5jAGeam0OhUX55X+rbk7tkRtqWrCjQ1f8FdelE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O64Q2j7kI6EdmKZ7mFXyWaeNIyGfxeOZHcYsgupC8JpBdUjQ4uxSzkGM7iy2OlXAI
	 tFClav5O4lFK1QzAHICJ3RCsYSqD3vtwnLiplM30pqZG9HwAj5K7nSJXu/3b5hqOQ0
	 O6AMpTl9P6mQr5X7RBSN+aKEThtUtQHIq1u2u8XPrRbGpahBnKi29VSmCYV273ZcwD
	 BASyCD/EeAPIgp29JskMQW9/3YS/LWGUt1C2W82IDPNVkX3DhrpJ+kn2Na36hCstIQ
	 xO4igiLh62T87z4Xw6Z8rRAexLfoL02cWha+ZRkjV+IXP4fzvuwLx2q+4BDCYS3vde
	 mTOUkFOeNenWw==
Date: Tue, 23 Jan 2024 17:46:25 +0000
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>, Phil Sutter <phil@nwl.cc>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] netfilter: nf_tables: Add a null pointer check in two
 functions
Message-ID: <20240123174625.GO254773@kernel.org>
References: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>

On Tue, Jan 23, 2024 at 02:45:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 23 Jan 2024 14:28:31 +0100
> 
> The result from a call of the function “kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus add a null pointer check and a jump target in affected functions.
> 
> Fixes: 8877393029e76 ("netfilter: nf_tables: Open-code audit log call in nf_tables_getrule()")
> Fixes: 0854db2aaef3f ("netfilter: nf_tables: use net_generic infra for transaction data")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

For the record:

Markus has posed patches of this nature many times over the past weeks
and months. They are not fixing bugs - there is no user visible problem.
And moreover they move the code away from the preferred style -
avoiding unnecessary checks around code that can handle NULL values.

Markus, please stop posting patches of this nature.

