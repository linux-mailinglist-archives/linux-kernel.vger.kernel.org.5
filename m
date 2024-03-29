Return-Path: <linux-kernel+bounces-126220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBC8933DF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A4285173
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742C15687B;
	Sun, 31 Mar 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFF148FFA;
	Sun, 31 Mar 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903212; cv=fail; b=GcvYg0IGGlB9CTmNEKrfArNPF6PZ5TrdQFzzC8LaQPJ5Ond30/X8T7uVCZHIM8q3JwB9g6OxZ0rylkFWdfC798y4Cun0z5UdHkecuevYhGRU+/4l5KKoIyLf0bBblHCB/Ismbxt5sTzvkLUBS7T/mwGBibivHZ3VnUbSx1R0Yic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903212; c=relaxed/simple;
	bh=SYYZ/ss9lWY4oaoeTWucMIVeeSBVdd2GvFw/KPBOAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0IDr4HV4PcyT/7h+kqZmlquhns6/M6z+obohQgTx7I0JNpdgxxZaAUY8rEdS3dvju2ZCX5ISTZHkHEQMzKv5NuWN3jpR1B7RcLFp7lXQov3HEt8bnBMlODFHueAczKSWHMMewAp5iF0zsDOAaIzG01nSOw+P93s8xoVQyx2TLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6 reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6A1F02084C;
	Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryMa7Yi-p9JQ; Sun, 31 Mar 2024 18:40:06 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1C891208A3;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1C891208A3
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0E61480004A;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:00 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83471-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAa0imlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 7964
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

X-sender: <netdev+bounces-83471-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAbUimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 7986
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:01:39 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 23:01:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id EDC9F20270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:01:38 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=-5.399 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099, DKIM_SIGNED=0.1,
	DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MAILING_LIST_MULTI=-1,
	RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=kernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jx_sz2HJRNgx for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:01:38 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83471-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 4C0D5200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 4C0D5200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB61C213B2
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB513D257;
	Fri, 29 Mar 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDD13CF9A;
	Fri, 29 Mar 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749678; cv=none; b=TOauJdfJGKU0duUd8J4pHoHhAwsXcDn6HiMRRbIxMC8w4F8N/R6CuN8UW0dSXad7zTr71uirgCxvjz3p8yWCCy8Lua4blaGweObu3zF4POrf+k9u15OLletc265FFN5y6QWVgkTghnrO2lA7BPEgSHApf/YoTu1URgNAYZ6V86c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749678; c=relaxed/simple;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0voKxc3wu4aN9dqdlqCvCcRErWY477ia2U3s+zapOl4w1ETHJYUStVobjEYNexg0unHlP7Tb6mRFUmIC7L9k9Abt8vOwswUXlovEv/RYRNqCZh58Etm9FyIYE6rOXh15uvgsy9g+fHu21flV2ooGENu10WR0Qfm9Eo1N8RV3k8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53666C433C7;
	Fri, 29 Mar 2024 22:01:17 +0000 (UTC)
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
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83471-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:01:39.0073
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: c9b42338-c5a1-475a-4f3c-08dc503bcf3f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.007|SMR=0.007(SMRPI=0.005(SMRPI-FrontendProxyAgent=0.005));2024-03-29T22:01:39.015Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 7438
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

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


