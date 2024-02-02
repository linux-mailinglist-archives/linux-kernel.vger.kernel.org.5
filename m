Return-Path: <linux-kernel+bounces-49796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB55846F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F582987D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552913DBBC;
	Fri,  2 Feb 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm5iO1F6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB4137C41;
	Fri,  2 Feb 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874812; cv=none; b=sR/C53dGBOmrscDWYh4jdk1/q/5mq9MRIJcjIAOqvHq5d3mJiT3RVGi8t4y4iDwOTO/5rtZ5ym7Q0Qyr0GMm3BwNo12Zk9S2Byl39AIT8EBp84XESOqp/6ZHdn7Znm0DTcII0WlLkqiAR2ClYjkpKbmA4SDkHLFkL+PzhEAS4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874812; c=relaxed/simple;
	bh=8FJbvHMjVG6Z0qlBqASoN04RLMtzNMOz4IQDAfW493g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfNd9JECnEYJN834j1EAxboQjpmzmPV+srUwZccFcPb329LKEDutF1yCjOSBcJkN/A6L2Xsmu6sE9c7pEifrtQUpkR/83w+gF2Wlt7AE2TkIfCyAc3h6yHrp6OkW+0fPvY97W98ucoFoBGqcwXfNhvYeQzrNN8R5NPPwXHNl8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm5iO1F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF625C433F1;
	Fri,  2 Feb 2024 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874811;
	bh=8FJbvHMjVG6Z0qlBqASoN04RLMtzNMOz4IQDAfW493g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jm5iO1F6vSsYjvJ8Y3s+qC0lwEYJFJQQx28mZ148oT9bqzKiYluVacP4wnrCLQ2O5
	 cJXLiGUPsPpKVD+bohpi1eC0HIHZ/eUsxN3kWUiGkqZBnn8MHfpQncBKlXGEnHrP5R
	 vI4MklfvOqDEtP4yOkYdGGGkhqYksMJsbwyHczJ3f8e65lSowF2gVM3aYORcd7/QzG
	 gYm+njnqiGsVgEID+sYQGk8JcuaT9ofq0i0DAsFuCRZa+ePMS8zfwRC66ofs9MjA9b
	 sUwcuwDA+9Er4YvBRGQ6BZ5TMeu7mbviyJ2vd2ilcFyBNx+1O+mDtNNFPV0KthVSKN
	 jedyXT0etivvA==
Date: Fri, 2 Feb 2024 12:53:19 +0100
From: Simon Horman <horms@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leitao@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/8] net: netconsole: cache userdata
 formatted string in netconsole_target
Message-ID: <20240202115319.GM530335@kernel.org>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-7-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-7-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:41PM -0800, Matthew Wood wrote:
> Store a formatted string for userdata that will be appended to netconsole
> messages. The string has a capacity of 4KB, as calculated by the userdatum
> entry length of 256 bytes and a max of 16 userdata entries.
> 
> Update the stored netconsole_target->userdata_complete string with the new
> formatted userdata values when a userdatum is created, edited, or
> removed. Each userdata entry contains a trailing newline, which will be
> formatted as such in netconsole messages::
> 
>     6.7.0-rc8-virtme,12,500,1646292204,-;test
>     release=foo
>     something=bar
>     6.7.0-rc8-virtme,12,500,1646292204,-;another test
>     release=foo
>     something=bar
> 
> Enforcement of MAX_USERDATA_ITEMS is done in userdatum_make_item;
> update_userdata will not check for this case but will skip any userdata
> children over the limit of MAX_USERDATA_ITEMs.
> 
> If a userdata entry/dir is created but no value is provided, that entry
> will be skipped. This is in part because update_userdata() can't be
> called in userdatum_make_item() since the item will not have been added
> to the userdata config_group children yet. To preserve the experience of
> adding an empty userdata that doesn't show up in the netconsole
> messages, purposefully skip emtpy userdata items even when

nit: empty

> update_userdata() can be called.
> 
> Co-developed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

..

