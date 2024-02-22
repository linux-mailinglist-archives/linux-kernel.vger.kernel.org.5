Return-Path: <linux-kernel+bounces-76479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B18B85F7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CED21C238F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F75FB84;
	Thu, 22 Feb 2024 12:07:01 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C025788B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603620; cv=none; b=CXAgacouQbVxNOhqHZwAkZtMN5DyU98K6a375+HE0KQaAoDwfrm9XtO8pQjlJ4YMB2Ce2Iy/0fUVgTsRIEdhqTrFNyNfHvZ/GGBAvGWkrHqeVas9UZt2Hw38Iz2ovf4QQ9B5kmUmvQtBS+uNsPEuCcy/98GaC1v7rjg6IBfcVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603620; c=relaxed/simple;
	bh=Xo7w5lVDrESHPh5uB2qKdL/YvecJ2Z78km/I9VxVRE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nbEeXmkrt7iy9iCep1FNKuvGPYtGFX2lrYjbybNrPGDEC61kPujdWA7Bznq+So7qiD5uYsZ5+9q95fEqckyTFynXBZZ/PMFJnAsDbOCbKaL0yuipRuxTwNNVoNG8vZ0ta1MlH1niqsShXdgLf36WRvVsWzs+b1Co3lkKbdaS4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1708603609-1eb14e0c7e461f0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id Xw3wrZUAYdcf8tPN (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 22 Feb 2024 20:06:49 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Feb
 2024 20:06:49 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Feb
 2024 20:06:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <41daf1a9-590a-e220-84a3-648eb895272b@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Fri, 23 Feb 2024 04:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] USB:UAS:return ENODEV when submit urbs fail with device
 not attached.
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] USB:UAS:return ENODEV when submit urbs fail with device
 not attached.
To: Oliver Neukum <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>
CC: <WeitaoWang@zhaoxin.com>
References: <20240222165441.6148-1-WeitaoWang-oc@zhaoxin.com>
 <3ff16f34-07a9-4b7e-b51d-b7220f08d88d@suse.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <3ff16f34-07a9-4b7e-b51d-b7220f08d88d@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1708603609
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1923
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121174
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/2/22 17:47, Oliver Neukum wrote:
> 

> On 22.02.24 17:54, Weitao Wang wrote:
>> In the scenario of entering hibernation with udisk in the system, if the
>> udisk was gone or resume fail in the thaw phase of hibernation. Its state
>> will be set to NOTATTACHED. However, usb_hub_wq was already freezed and
>> can't not handle disconnect event. Then, sync cache SCSI command will be
>> sent to this udisk on the poweroff phase of hibernation, that will cause
> 
> Wait, this seems like a contradiction. Are we in thaw or are we powering off?

This fail appear in poweroff phase of hibernation.

>> uas_submit_urbs to be called to submit URB to sense/data/cmd pipe. Then,
>> usb_submit_urb return value -ENODEV when device was set to NOTATTACHED
>> state. However, uas_submit_urbs always return "SCSI_MLQUEUE_DEVICE_BUSY"
>> regardless of the reason for submission failure.That will lead the SCSI
>> layer go into an ugly loop and system fail to go into hibernation.
> 
> The thing is that the SCSI documentation explicitly tells us to return
> either SCSI_MLQUEUE_DEVICE_BUSY or SCSI_MLQUEUE_HOST_BUSY. Now, it makes
> sense to tell the SCSI laer that a device or host is gone for good,
> if we know that. But we cannot just introduce new error returns on our own.
> 
> This needs to be addressed. That means that the SCSI layer or at the
> very least the documentation needs to be fixed. Frankly, this is not strictly
> speaking a UAS issue. Any thing hotunpluggable should have this issue.
> 

Maybe, my description was not accurate enough, here not add new return
value to scsi layer,it just add a case to tell device is gone in the uas
driver internal and the ENODEV error code not return to scsi layer.
Here just notify SCSI layer of device loss through flag DID_NO_CONNECT.
This is also hope to fix this issue in the uas driver internal.

Thanks and best regards,
weitao


