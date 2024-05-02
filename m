Return-Path: <linux-kernel+bounces-166473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C318B9B27
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45A71F22C35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372483A11;
	Thu,  2 May 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJKYSBr4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A67F7EB;
	Thu,  2 May 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654582; cv=none; b=nVeIaMD2S6rTPg+L750qyfK67x4xWAP+9DR3dJ1Eg5p5/r9iSTnUWp+M9pkPbw1b8YUxtWeykDZRkWY7Qd7NCyiLjQM5ZSXzUWjD9GdGtIwI+kYYpKKk2wNl/mOn1hGjAv/P0hV2IdteKu1Y2f5QNGlYECNOTxuRlzigplelJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654582; c=relaxed/simple;
	bh=TIi7sSskgVYLa6lmmXklkHCJpp6hqvFsA9lF+gfa2P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S7nGgmrPW/6BG7DZlViKKvr54H73vvM84U5Sc4l3oCaPtDiHmFRwRAiiMdCmV3iiCUI0gfwZ6rap4brIq/YDaUFyhNMIYbcYDUlRBuuEKMGvivtBUAEqkOHU32qOzqCFXOpOsEQnp1j9O+3NQgEI4NHbjNeMnYRRA4fokDiiMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJKYSBr4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442Bgl5c026176;
	Thu, 2 May 2024 12:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dtOtjKSA/LVGBH/rAZzQTDcLSshI6gUWpR3EQr/u0dg=; b=FJ
	KYSBr42yQr4aM8U6yw5Xb7YCqh7MamXwwK+EYjsQKqIT1WARHrVnh5t6fBVSckkw
	ojCxfLaRYErFdHDxJGLkRzZ2NrybudnV71SfZMPjbcWns0BS1JTP2VLf0uKyfpSX
	lKLtTUX9SiUfwyy93bNaIS3YvUKaY+9H4VuIvpL7UXsXLvzLp2p9tGgRbR0oq8it
	uV3Ti9OXqzJ7mJYOLAoesU4iIchpHUrQx7NVUFP6Yy2/MSFaCln9dyS2yULIgPzk
	xuFBMY5+pKempf3cJmk0uXo5VdoJTZ11KOn/zzOe5hrC8BM3QDfhgHUD9H+8FWX3
	4dL501TgqhhUVHGflzvw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xup5ktdya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 12:56:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442CuGNw004253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 12:56:16 GMT
Received: from [10.253.35.130] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 05:56:14 -0700
Message-ID: <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
Date: Thu, 2 May 2024 20:56:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA NVM file for the X13s (WCN6855)
To: Johan Hovold <johan@kernel.org>, Tim Jiang <quic_tjiang@quicinc.com>
CC: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jtURl8_2WGhZKtnk6N5knOzhRfeY7i8S
X-Proofpoint-GUID: jtURl8_2WGhZKtnk6N5knOzhRfeY7i8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020082

On 5/2/2024 6:57 PM, Johan Hovold wrote:
> Hi Zijun and Tim,
> 
> I noticed that you have both submitted firmware and NVM files for
> QCA2066 to linux-firmware. [1][2]
> 
> I'm working on Linux support for the Lenovo ThinkPad X13s (Windows on
> Arm, Snapdragon), which has the related WCN6855 controller that uses the
> same firmware (hpbtfw21.tlv).
> 
which SOC type does the machine use?  WCN6855 or QCA2066?
> The current Linux driver is using the generic NVM file (hpnv21.bin) for
> WCN6855, but connectivity is quite bad and I only get 2-3 meters of
> range.
> > Switching to the board-specific NVM configuration (hpnv21b.b8c) that
it seems hpnv21b.b8c is a wrong NVM name.
is it hpnv21g.b8c?
> came with the Windows driver make all issues go away and the range is
> really good, but I'm not sure if that file is fully compatible with the
> firmware used by the Linux driver.
> 
> Could you help us submit an NVM configuration file for the controller
> with board id 0x008c to linux-firmware?
> 
For Windows OS, there are relevant channel to deliver BT firmware.
For Linux OS, we normally upload relevant BT firmware to linux-firmware.

it seems customer would like to use Linux OS instead of preinstalled
Windows OS for the machine.
right?

need customer to make a request for their requirements if the answer is
yes for above question.

> 	Bluetooth: hci0: setting up wcn6855
> 	Bluetooth: hci0: QCA Product ID   :0x00000013
> 	Bluetooth: hci0: QCA SOC Version  :0x400c1211
> 	Bluetooth: hci0: QCA ROM Version  :0x00000201
> 	Bluetooth: hci0: QCA Patch Version:0x000038e6
> 	Bluetooth: hci0: QCA controller version 0x12110201
> 	Bluetooth: hci0: QCA Downloading qca/hpbtfw21.tlv
> 	Bluetooth: hci0: qca_read_fw_board_id: bid = 8c
> 	Bluetooth: hci0: QCA Downloading qca/hpnv21.bin
> 
> It looks like the NVM files should be updated in lockstep with the
> firmware so if you could include that board in any future firmware
> updates too that would be really helpful.
> 
> Johan
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qca?id=2ba1beaae0c649ce8a50baecc8df9e81cd524e65
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qca?id=598f5bd22361d7e92eebe8452d1f8013a1d35b9a


