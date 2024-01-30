Return-Path: <linux-kernel+bounces-44338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF184206F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0841C26676
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F567E96;
	Tue, 30 Jan 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPHfBZJG"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA4605D5;
	Tue, 30 Jan 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608793; cv=none; b=EG4Wv+dbB2ZZk1Z9ihbagPxjvqgnT9bkb3EL70OJEKuYlyBMuCcYASD86qjA4+24bIf73/ClK5szjv2fb7+BXfKnAKhMUvyWiKhe+eCA3SesjGhykPXi4f4UWUEUwzyCi2FNeBuH6CyZbo//hXTYhm7yvN9prgxzEz16HAuq1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608793; c=relaxed/simple;
	bh=6P5FfbFKXvpTVgfjV2JFIycWosCzugB7elVDu3wefxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMK2BF2PUUwtUpjGLXVUIJDy1BUe3Oh8FZioRcMXlZE3kuDk3ougA9I/5Gt6cLzmBKNxwFUesLlG3w8zIHZ9j3q+D8EXwyfDg9TDwfTNNfCIfPnOaKg56r2VdPG1lAPKR3Jjx3/adiWC+xYlzex7YwbezWouPAUzHDHHRa9aPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPHfBZJG; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706608791; x=1738144791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6P5FfbFKXvpTVgfjV2JFIycWosCzugB7elVDu3wefxI=;
  b=nPHfBZJG1kw4TxyPAx+BJReQtlMBJCyo2M8ZUJXATbhuN13eD0Gqykf5
   20JZYfhVN0T7mSkAKzxYrJ+0EbxOA91FIln4cnBe5lLr9pQVFZTdz3FtK
   wlsj4bFeiNfWQmSwruWwRnHDpPWX6VUVggjRJujuy9mkz6UKl4atBfg+W
   R3z2BfYHFEnvJ2c7DOwQIFxaWd9WLAK3L70BFJtWeNgR6S4BtdKu0s0Xn
   GPVdJuskmHJGCVB7xOdm6j3+FHljvarYIiK6A06t+UqXkhXppFh/ckHCO
   nTn5y0y/s89wNy51L9TlgmR/hV56LK9Fqk+XVazIQ8SB6eRJiPhTlPJ9T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393662032"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="393662032"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="911388471"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="911388471"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.34.225]) ([10.246.34.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:59:46 -0800
Message-ID: <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
Date: Tue, 30 Jan 2024 10:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
To: takeru hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org, laforge@gnumonks.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 mailhol.vincent@wanadoo.fr
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
 <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.01.2024 07:39, takeru hayasaka wrote:
> Hi Marcin-san
> Thanks for your review!
> 
>> Do I understand correctly that all gtpu* include TEID? Maybe write it here.
> Yes, that's correct.
> 
>> It would be nice to see a link to the patch that added GTP and 'e' flag support
> to ethtool itself ("ethtool: add support for rx-flow-hash gtp").
> I will send you the link.
> The one I sent earlier was outdated, so I've updated it to match this patch.
> https://lore.kernel.org/netdev/20240130053742.946517-1-hayatake396@gmail.com/
> 
>> gtpc(4|6) doesn't include TEID, so what is its purpose?
> In GTPC communication, there is no TEID in the CSR (Create Session Request).
> Therefore, there are cases of GTPC that do not include TEID.

The way I understand it now, this patch (and the ethtool one) adds hashing on
TEID field in GTP* headers. So I wanted to ask why do we have a case (gtpc(4|6))
that doesn't include TEID? Do we hash on other fields in this header?

> 
>> s/TEID(4byte)/TEID (4bytes)/
>> Also, I think two newlines should remain here.
> I will correct the TEID notation in the next patch!

Thanks,
Marcin

---8<---

