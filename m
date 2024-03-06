Return-Path: <linux-kernel+bounces-93444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D0872FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61840288ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7715CDD5;
	Wed,  6 Mar 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bSMsCz7o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47E5CDC7;
	Wed,  6 Mar 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711306; cv=none; b=dlo6JAaxoV4U7XXTYJo5YrSmLQBLqikW16qXI4vWuLptB0OBPOoKV1cwjMI5GgdrLiNP9So6tdj2a7BB0r9dutJ5rLUGuzUci3IYxhLiqyKdk2hkRMD+grY0hRzXwJHczDi+tzq0sBoufouTc929AaVWBoi5HjkNsAtKNiJrX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711306; c=relaxed/simple;
	bh=zKsqA1pAJvhmvqEZMhUe8iVqIHHxg00Oib15XuSlKYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TwH/Bj0/KSUoGfOhu/tgJ2mkcaLqlnIgAW4sq8qrH6bMfnXqmI2+uPII+dvBAAwD0aEdccg3KTJz2Uk7KPsWixc3BAFy1r43U+xZ0US0okwT3DjTXZCBxB2z+VKWvugS0BUC9wdTKU+ZyNQ0XMXedcvy/Bs36XjCQT4KNFuRlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bSMsCz7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266eo43007902;
	Wed, 6 Mar 2024 07:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+B/7g0tG6NUnlo/P/56J6JpCkzOToX5rkwtWvIw3rkU=; b=bS
	MsCz7ouCML/XI++i+Efrx5U2pdhfcxAHZVRr1d6jSCMyjzCt5swh0IJpi6U2D3Eb
	zBlEF6f5+xy5HWtKBDxGWB2qwtMzSFi6/7d2JoCOUFSTtMrXW0tM5FO9hXXyOAWr
	hXIn9qTGkD6TfraNEZkpdMae29xJ7FjxG9MguH79HZ9I1LsG9hmGlJWMA+EMz2xD
	fW43qNFbyLLC5wStcSwEbsYwMRCzxHJ/b3ICy3co1oh0w4oPDAjgEttVWHE32/Tk
	b6r4P42hUFmp9twUuVW99rJsuHpc2/HjDgxxOTl34ozHBeIFFu1GQdDhicBcJrDa
	gRJ1vBRjwbLveXIJPWBg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpke384xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 07:48:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4267mIOP005245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 07:48:18 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 23:48:16 -0800
Message-ID: <a8e5463f-787b-44c3-842f-c2d7f703d26e@quicinc.com>
Date: Wed, 6 Mar 2024 15:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver. -
 Correction
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Mark Brown" <broonie@kernel.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
 <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
 <c7c939c9-50e0-4d86-bd44-d8b4b90ca14d@quicinc.com>
 <7bfbf09f-67d1-43d0-8ecd-aedf3b9e2287@opensynergy.com>
 <58d1487a-fd3b-4b31-a133-3181359e0c61@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <58d1487a-fd3b-4b31-a133-3181359e0c61@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C3QuWy2dZGjdwQKYdDEH2g07UEXq5QrY
X-Proofpoint-GUID: C3QuWy2dZGjdwQKYdDEH2g07UEXq5QrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060061

Hello Harald,

     In current driver, spi_new_device is used to instantiate the virtio 
SPI device, spidevX.Y is created manually, this way seems not flexible 
enough. Besides it's not easy to set the spi_board_info properly.

     Viresh Kumar has standardized the device tree node format for 
virtio-i2c and virtio-gpio:

 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml

     In this way, the driver is unified, board customization only 
depends on the device-tree node. It's easy to bring up spidev automatically.

     Look forward to your opinions. Thanks a lot.

Haixu Cui


On 3/6/2024 1:54 AM, Harald Mommer wrote:
> Hello,
> 
> looked again at my tinny setup and I've to add a small correction.
> 
> It's not the way that I've no udev at all there. What is in place there 
> is busybox mdev.
> 
> Relevant part of /etc/init.d/rcS:
> 
> #!/bin/sh
> mount -t proc none /proc
> mount -t sysfs none /sys
> depmod
> modprobe spi-virtio
> mdev -s
> mdev -d
> 
> If I kill the "mdev -d" process my small script below does not make the 
> /dev/spidev0.0 device node appear any more. Of course not, there must be 
> some user mode process which does the job in the device directory.
> 
> Regards
> Harald Mommer
> 
> On 05.03.24 11:57, Harald Mommer wrote:
>> Hello,
>>
>> I took next/stable as base giving the exact tag/sha of the current 
>> next/stable so that it's known what was used as base version even when 
>> next/stable moves. The ordinary next tags are currently not of best 
>> quality, gets better, therefore next/stable now. We were on v6.8-rc7 
>> yesterday with next/stable.
>>
>> VMM is qemu for the driver you have. But it's a specially modified 
>> qemu which allows that we use our proprietary virtio SPI device as 
>> backend.
>>
>> Proprietary virtio SPI device is started first, this is an own user 
>> process in our architecture. Subsequently the special internal qemu 
>> version is started. The virtio SPI driver is compiled as a module and 
>> inserted manually by a startup script by "modprobe spi-virtio". The 
>> driver goes live immediately.
>>
>> In this simple setup I do not have udev rules (no service supporting 
>> udev => no rules) so no /dev/spidevX.Y automatically after the driver 
>> went live. What I'm using to test the latest driver before sending it 
>> to the mailing lists is really a naked kernel + a busybox running in a 
>> ramdisk. The udev rule I've sent are used on some more complete setup 
>> on real hardware.
>>
>> So without udev I have to bring this device up manually:
>>
>> In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 
>> manually:
>>
>> #!/bin/sh
>> SPIDEV=spi0.0
>> echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
>> echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind
>>
>> Afterwards there is /dev/spidev0.0.
>>
>> In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
>> (somewhat hacked locally, and I mean "hacked" to be able to test 
>> somewhat more) are used to play around with /dev/spidev0.0.
>>
>> I can do this on my Laptop which has no underlying SPI hardware which 
>> could be used as a backend for the virtio SPI device. The proprietary 
>> virtio SPI device has a test mode to support this. Using this test 
>> mode the driver does not communicate with a real backend SPI device 
>> but does an internal simulation. For example, if I do a half duplex 
>> read it always gives back the sequence 01 02 03 ...
>>
>> For full duplex it gives back what has been read but with letter case 
>> changed, in loopback mode it gives back exactly what was sent. With 
>> this test mode I could develop a driver and parts of the device 
>> (device - real backend communication to an actual SPI device) on a 
>> board which had no user space /dev/spiX.Y available which could have 
>> served as backend for the virtio SPI device on the host.
>>
>> Slightly different module version is tested on real hardware with the 
>> virtio SPI device not in test mode. "Tested on hardware" means that 
>> device + module work for our special use case (some hardware device 
>> using 8 bit word size) and the project team for which device and 
>> driver have been made did until now not complain.
>>
>> Regards
>> Harald Mommer
>>
>> On 05.03.24 08:46, Haixu Cui wrote:
>>> Hello Harald,
>>>
>>> Thank you for your detailed expatiation. To my knowledge, you took 
>>> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
>>> further how do you test the SPI transfer without the Vanilla 
>>> userspace interface? Thanks again.
>>>
>>> Haixu Cui
>>
>>

