Return-Path: <linux-kernel+bounces-146687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF88A6957
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4063A28208C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED927128816;
	Tue, 16 Apr 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnNWPFk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35961127B5D;
	Tue, 16 Apr 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265545; cv=none; b=uGgKSQH5sjRM5LAYtrKaDWbml5DpUjnJOBO6P2sd+sGT+B4wTfO/IBN2muxshJmzgHuYW6n7zOClegGCQBw7tPVbZZmPRloIKWechn89a3EvAJiDWoZ+DqbM7zBZjxSS2loCFJrvkvOnn9lxBNzIYaE2QKVZY8DxHAXIWKY0QVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265545; c=relaxed/simple;
	bh=b+bXT9aw+B73/v9YDMYAG7FfnV6DKgNRfmqZTWXBmro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAceiJeMWoY0cYC/tMYRj86TdD4d/jotBpSRqoHzwG/6J66JIInjfeCn38UQ25+ixWe7kiqXD+bOg6UkTMKaKczhdzdU3xCnxs3q+J2/tPTzLUiaKPZoc/aTuH0aSf6QySBlXBqA9koIlGhi2kykuHUJQ26yvpSwEJZdVKCjc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnNWPFk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0989AC113CE;
	Tue, 16 Apr 2024 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713265545;
	bh=b+bXT9aw+B73/v9YDMYAG7FfnV6DKgNRfmqZTWXBmro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnNWPFk2cPR63aap4cP380v2VxcbontjhUIhUDPw8VjdKLYXol+uDqChzoz/vIqtL
	 CQtNYOSG4NFjgYm9zRpzIk4mWQtwesDabP+lVQv3DvXQ7HHk9ZR1OAOJxu3Laa+Dss
	 ER3dOztV7KK7i3p58jW3/6z1qhX35ggZxlWrFV8PRmnRjYErVyg77pPpHPFnFNQA4c
	 1RjPN1THSUmFrxOFwFqY+ktddtmpprzrSEYJldb280LYiFDLuy+7sKVVV3GSIJ+zip
	 /4q8iaRzwAv7K1qNssIlLRfvzkzyemk7WcqEbP24uViUsrW2oynJePbU1/mSQLkQoZ
	 SRFhaDiceip7A==
Date: Tue, 16 Apr 2024 12:05:38 +0100
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 10/11] net/smc: adapt cursor update when
 sndbuf and peer DMB are merged
Message-ID: <20240416110538.GK2320920@kernel.org>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-11-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414040304.54255-11-guwen@linux.alibaba.com>

On Sun, Apr 14, 2024 at 12:03:03PM +0800, Wen Gu wrote:
> If the local sndbuf shares the same physical memory with peer DMB,
> the cursor update processing needs to be adapted to ensure that the
> data to be consumed won't be overwritten.
> 
> So in this case, the fin_curs and sndbuf_space that were originally
> updated after sending the CDC message should be modified to not be
> update until the peer updates cons_curs.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

..

> @@ -255,6 +256,14 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
>  		return rc;
>  	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
>  	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
> +
> +	if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
> +		/* if local sndbuf shares the same memory region with
> +		 * peer DMB, then don't update the tx_curs_fin
> +		 * and sndbuf_space until peer has consumed the data.
> +		 */
> +		return rc;

Hi Wen Gu,

A minor nit from my side:

To my mind "return rc" implies returning an error value.
But here rc is 0, which based on the comment seems correct.
So perhaps it would be clearer to simply return 0.

Flagged by Smatch.

> +
>  	/* Calculate transmitted data and increment free send buffer space */
>  	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
>  			     &conn->tx_curs_sent);

..

