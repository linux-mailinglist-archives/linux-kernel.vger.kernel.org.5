Return-Path: <linux-kernel+bounces-17229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25E824A26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA841C228F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC72C6A4;
	Thu,  4 Jan 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HR4ebhCh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B612C1B5;
	Thu,  4 Jan 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404L0uH7008842;
	Thu, 4 Jan 2024 21:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=dQ/JHTvaWK6L1BzBckOKy
	fMx62b/1aDP820BHSs3Pzo=; b=HR4ebhChG16tFWKX92VEpKHCVeS90FEUgi+xk
	Pah3WvhzpX7vM2WURm4d88nJPCLm/vykISG7N/3WrhvF+zmj74yRsEZB9NyM7FVC
	otHbjtwz2+PWwKy2OfdUdNMsY0qJpmVtlL8Xu8hWR0V/a+1gliKNcm1VLjplD4EH
	4qEUXGpStTnC8/cEaIO0PZYD0XkOKIX20cmnmYti2gMU+yAmpVRDWgKD1lGz3fIf
	Ft1ceGeD9S1t+WL4v9O4Gx72ZDCNe8mtpnTEiOvHjB/8PIWWSw2w3Te2dwOzJ57C
	xds8qnjDqIkHdfcsWWsfKvqDSxKdIZHGXT4oSznPLEqujm+Vw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve1418fk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 21:19:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404LJ0pO020856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 21:19:00 GMT
Received: from hu-jackp-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 13:18:59 -0800
Date: Thu, 4 Jan 2024 13:18:58 -0800
From: Jack Pham <quic_jackp@quicinc.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
Message-ID: <20240104211858.GB4127689@hu-jackp-lv.qualcomm.com>
References: <20240102055143.3889-1-quic_kriskura@quicinc.com>
 <CANP3RGeirg+f8cBbw_3YR5AvuB1ZxJC_9-wcn+Tb-GXf1ESKCQ@mail.gmail.com>
 <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
 <CANP3RGf5dg14DNuKOn9pqWd4oSBDsPhwwBB7AJ0c3qHbDT0sBQ@mail.gmail.com>
 <572c21f8-e642-4d30-84aa-673051be6bb4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <572c21f8-e642-4d30-84aa-673051be6bb4@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: khRM8CFDqD_hI6VnILsFEqGL7o0jMTNv
X-Proofpoint-ORIG-GUID: khRM8CFDqD_hI6VnILsFEqGL7o0jMTNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=612 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040167

On Tue, Jan 02, 2024 at 05:04:01PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> > > The above might work. But just wanted to check why this 1 byte would
> > > come actually ? Any reason for this ? ZLP must not give a 1 byte packet
> > > of 1 byte AFAIK.
> > 
> > I'm not a USB expert, but... my (possibly wrong) understanding is:
> > (note I may be using bad terminology... also the 1024/16384 constants
> > are USB3 specific, USB2 has afaik max 512 not 1024, I think USB1 is
> > even 64, but it's likely too old to matter, etc.)
> > 
> > USB3 payloads can be up to 16384 bytes in size,
> > on the wire they are split up into packets of between 0 and 1024 bytes.
> > [a Zero Length Packet is a ZLP]
> > A usb payload is terminated with a usb packet of < 1024 bytes.
> > 
> > So a 1524 byte payload would be sent as 2 packets 1024 + 500.
> > While a 2048 byte payload would be sent as 3 packets 1024 + 1024 + 0 (ie. ZLP)
> > 
> > A 16384 byte payload could be sent as 16 * 1024 + ZLP,
> > but since 16384 is the max you might be able to get away with just 16
> > * 1024 and skip the ZLP...
> > 
> > I think this is why the Linux usb code base has ZLP / NO_ZLP quirks.
> > [but do note I may be wrong, I haven't gone looking at what exactly
> > the zlp quirks do,
> > not even sure if they're receive or transmit side... or both]
> > 
> > Different hardware/usb chipsets/etc have different behaviour wrt. ZLPs.
> > 
> > In general it seems like what needs to happen is much clearer if you
> > just avoid the need for ZLPs entirely.
> > I think that's what windows is trying to do here: avoid ever sending a
> > usb payload with a multiple of 1024 bytes,
> > so it never has to send ZLPs. This seems easy enough to do...
> > limit max to 16383 (not 16384) and add 1 byte of zero pad if the
> > payload ends up being a multiple of 1024.
> > 
> 
> Got it. Thanks for the explanation. Atleast this gives me an insight into
> what might be the problem.

Hooray to MS for having open-sourced a reference version of their NCM
driver on GitHub (under MIT license)--and I think this might explain it:

https://github.com/microsoft/NCM-Driver-for-Windows/blob/release_21H2/host/device.cpp#L902

which states in a comment (pasted line-wrapped for mail-friendliness)

        //NCM spec is not explicit if a ZLP shall be sent when
        //wBlockLength != 0 and it happens to be
        //multiple of wMaxPacketSize. Our interpretation is that no ZLP
        //needed if wBlockLength is non-zero,
        //because the non-zero wBlockLength has already told the
        //function side the size of transfer to be expected.
        //
        //However, there are in-market NCM devices rely on ZLP as long
        //as the wBlockLength is multiple of wMaxPacketSize.
        //To deal with such devices, we pad an extra 0 at end so the
        //transfer is no longer multiple of wMaxPacketSize

If so then would be worth calling this out in commit text and/or code
comment.

Jack

