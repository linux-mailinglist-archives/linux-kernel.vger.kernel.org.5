Return-Path: <linux-kernel+bounces-151804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27EA8AB417
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A111C20E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA0139D14;
	Fri, 19 Apr 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g+SF+yfr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BF137C50;
	Fri, 19 Apr 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546234; cv=none; b=gTPQFrFiuQWH7auBUvFDgEEKOLxH++1OyzdAY2f4kwOl4jsxnHdZFgj1o3pz0cb9KxYuMFwPY1p8urdI4OIM068pcHZT9QQrJbzSdAvr7S9N0tYRk+2F+jIu2sSfPk6vcX9Ox3wbQnnNgP6uUeQe08BQsOmmNDgJmJYMEF7Cxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546234; c=relaxed/simple;
	bh=QPtcxsnErCPN9wVboSbSwBYD9oCPYNM76lci9KbNS8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FDxAzRHsdlnY5iyWCM4eH5vEjLGsie1mTCGcO/czvvxdlUK1tjqkwcjJLQGjGBV70ish6bdeUhdm4cZFSkVN4vqNnZGcRq1PnVhofmyqPIOGjQAvZ24YohsIVE3UkZvpVTG8zo+EJcQhVp4EpDfaTLts/OULIPJR5xu0C3RTbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g+SF+yfr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JH3Rml007881;
	Fri, 19 Apr 2024 12:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713546207;
	bh=2sBBZySipsaDQh6gta504lCyluXD40TKr8qXo3EeTnw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g+SF+yfrJ8X1kJ7leJTycFefJILN4OJVQCg6/hOaf/wroRyahFdbO+5utb3IMBU3K
	 ZTb2lSnDmXli+C2UhZZNyFqeo1Z9CI/EPrCc39ptrAC7B5KRvlPUr8U9Jw0kWIOGSf
	 hn/2j73TlfD32zvcFeBx+XhVSgcKsG59VC5VpbtY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JH3R1o055295
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 12:03:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 12:03:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 12:03:27 -0500
Received: from [10.168.167.103] (udb0273976.dhcp.ti.com [10.168.167.103])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JH3Q2S059335;
	Fri, 19 Apr 2024 12:03:26 -0500
Message-ID: <1cf9c10b-5cf3-412a-83a5-e6891a18c2f1@ti.com>
Date: Fri, 19 Apr 2024 11:03:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: Fix PTPv1 message type
 on TX packets
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, <s-vadapalli@ti.com>,
        <rogerq@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <ed.trexel@hp.com>, <oem-support@audinate.com>
References: <20240419080547.10682-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: Jason Reeder <jreeder@ti.com>
In-Reply-To: <20240419080547.10682-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/19/24 02:05, Ravi Gunasekaran wrote:
> From: Jason Reeder <jreeder@ti.com>
> 
> The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
> field from the second nibble of the PTP header which is defined in the
> PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
> the first two bytes of the PTP header are defined as the versionType
> which is always 0x0001. This means that any PTPv1 packets that are
> tagged for TX timestamping by the CPTS will have their messageType set
> to 0x0 which corresponds to a Sync message type. This causes issues
> when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
> timestamp that never appears.
> 
> Fix this by checking if the ptp_class of the timestamped TX packet is
> PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
> sequence ID in the skb->cb data structure. If the sequence IDs match
> and the packet is of type PTPv1 then there is a chance that the
> messageType has been incorrectly stored by the CPTS so overwrite the
> messageType stored by the CPTS with the messageType from the skb->cb
> data structure. This allows the PTPv1 stack to receive TX timestamps
> for Delay_Req packets which are necessary to lock onto a PTP Leader.
> 
> Signed-off-by: Jason Reeder <jreeder@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>   drivers/net/ethernet/ti/am65-cpts.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index c66618d91c28..f89716b1cfb6 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -784,6 +784,11 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>   		struct am65_cpts_skb_cb_data *skb_cb =
>   					(struct am65_cpts_skb_cb_data *)skb->cb;
>   
> +		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
> +		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
> +		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
> +			mtype_seqid = skb_cb->skb_mtype_seqid;
> +
>   		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
>   			u64 ns = event->timestamp;
>   
> 
> base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8

++ Ed Trexel at HP and the Audinate support team for visibility and 
'Tested-by' tags.

Jason Reeder

