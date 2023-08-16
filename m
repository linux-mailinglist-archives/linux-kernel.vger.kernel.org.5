Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DA77E748
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbjHPRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbjHPRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:10:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6F11FF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:10:01 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G5L6WC023417;
        Wed, 16 Aug 2023 12:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=k8FECQ69+aGbUYRS1sMlaMZF2LSEprEh6aORDIpMYDE=; b=
        B7T396nGMgUfrBrpw2IxC3nlxp4rF013Mbif+T4X6UT3OnnJjJ7yhz8s9ti7Kl97
        UbC/Bbie+jDZy0CNiVZh6Mlbq5NKStH58s39iUuG7DXtwG7pOc48cxMuOAi/8ArE
        64Ex26LHU2p8iqWm4bFL/bfbclP3RLvyrRsCC27j/w6MB9riu1pR3dxGTQrp1Eeo
        SLvm+Q1sIXumFHJ17qKIRb1nPHIyXyl2o+jprARO0h9V5yU28f1Ousx4UzwVUytm
        qXBQhiBY/AxO+o/n4C/cutIi1sFphztPcyOFtyYIWoj9hkXfPilktW1CneS7n52V
        vapFIelVsQKYHKUviFrQZw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqw9dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 12:09:55 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 18:09:53 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 18:09:53 +0100
Received: from [198.61.65.68] (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C31E53563;
        Wed, 16 Aug 2023 17:09:52 +0000 (UTC)
Message-ID: <b244708a-414e-1f56-61a0-7c183f8ff45e@opensource.cirrus.com>
Date:   Wed, 16 Aug 2023 18:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Read firmware uuid from a device
 property instead of _SUB
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
 <20230816164906.42-3-rf@opensource.cirrus.com>
 <c3e42efc-9ddc-4788-85f7-cfa350d75d43@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c3e42efc-9ddc-4788-85f7-cfa350d75d43@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4vGE2lD6PzOIbC-5BV0ze471vjVGr2eN
X-Proofpoint-GUID: 4vGE2lD6PzOIbC-5BV0ze471vjVGr2eN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/8/23 18:03, Mark Brown wrote:
> On Wed, Aug 16, 2023 at 05:49:06PM +0100, Richard Fitzgerald wrote:
>> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
>>
>> Use a device property "cirrus,firmware-uid" to get the unique firmware
>> identifier instead of using ACPI _SUB.
>>
>> There will not usually be a _SUB in Soundwire nodes. The ACPI can use a
>> _DSD section for custom properties.
>>
>> There is also a need to support instantiating this driver using software
>> nodes. This is for systems where the CS35L56 is a back-end device and the
>> ACPI refers only to the front-end audio device - there will not be any ACPI
>> references to CS35L56.
> 
> Are there any existing systems (or might there be given that the driver
> is in released kernels already) which rely on _SUB?

No. Nothing has been released with CS35L56.
