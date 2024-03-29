Return-Path: <linux-kernel+bounces-126101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDC89322F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E34D1C218F4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29467145B17;
	Sun, 31 Mar 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0A143C75;
	Sun, 31 Mar 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900922; cv=fail; b=jRzPrVPdWujcUl0ecMKjF3kprfmGsgGhtFOvmnDTrBjxxjIy7d0z7XdvMvp3XBb2iiyzQH3+IcKbUvW9/gIveKFTa6U+anlc0ObMQIdsDIiCNydVzZvV9BOOYaXRPdVWgJKx/mrWTgOdW4/Plb1QCROzzT9WMQdXYE5/g1vOz4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900922; c=relaxed/simple;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ewu5XPU/hl+T+/YtT/t+WF2PUIXhx7nFLKB0DYwKopnTTl6qyTuzI3t+sKOm8MwKOYhoidU6NaqJmoHzRQYiOjUPROUPmzTa1IigHZtzi8VFcsvQDW5aqSb8gQMRLlKwITn5jPKqgBqkPV00hC2xM4FmYusoH3l4vHuO/LmINT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5D241207D8;
	Sun, 31 Mar 2024 18:01:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuWLbJ7uf3Of; Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D96892067F;
	Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D96892067F
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id CBCAE80004A;
	Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:01:57 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:41 +0000
X-sender: <netdev+bounces-83471-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAvgxrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAKAAAAzIoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10773
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83471-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 06BB8200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749678; cv=none; b=TOauJdfJGKU0duUd8J4pHoHhAwsXcDn6HiMRRbIxMC8w4F8N/R6CuN8UW0dSXad7zTr71uirgCxvjz3p8yWCCy8Lua4blaGweObu3zF4POrf+k9u15OLletc265FFN5y6QWVgkTghnrO2lA7BPEgSHApf/YoTu1URgNAYZ6V86c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749678; c=relaxed/simple;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0voKxc3wu4aN9dqdlqCvCcRErWY477ia2U3s+zapOl4w1ETHJYUStVobjEYNexg0unHlP7Tb6mRFUmIC7L9k9Abt8vOwswUXlovEv/RYRNqCZh58Etm9FyIYE6rOXh15uvgsy9g+fHu21flV2ooGENu10WR0Qfm9Eo1N8RV3k8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749677;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCDVp1+6GYWN8GFmGWMO5xXfiuZa6bY/GlLwKiqaSa1TLzIxcYJihxRE0e5VLztHR
	 5zX4huDJPpeCfgrjlALPODEyY9ok6t6XZyC94u9P4uGbsdD+Vf7/goAP4qAxHkI24l
	 Vp+Ec9ugCQi0u85nWx6u6+59B7MSXHvK7H7/fZ+H3lv3tvBPDnMR4RgmsEhvVyxon1
	 xplQn51eQjcegvhK7Sath6j4gOuf2pbrolfo17ILhabO8CfloJKPB+aXedyLdVRpG7
	 sAjIkjQeyiL63kut8QYGl9CThsDY1mDSdXu6r8nXPwWsINSIlXd0gVG41OCygsqiwZ
	 FdtrYL4sDV2IA==
Date: Fri, 29 Mar 2024 15:01:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable
 PTP RX HW timestamp using CPTS FIFO
Message-ID: <20240329150116.67da2b07@kernel.org>
In-Reply-To: <20240327054234.1906957-1-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, 27 Mar 2024 11:12:32 +0530 Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
> of received packets from CPTS FIFO.
> 
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_find_rx_ts()" function and timestamps the received
> PTP packets.

Maybe i'm unusually tied today but reading this patch without reading
the next one makes no sense. I mean, you say:

  CPTS module supports capturing timestamp for every packet it
  receives...

How is that relevant here.

When you post v5 please make sure to include a cover letter, explaining
the overall goal and impact of the series.

> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);

list_move() ?
-- 
pw-bot: cr


