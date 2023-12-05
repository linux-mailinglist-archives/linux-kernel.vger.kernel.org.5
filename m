Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B633B805B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjLERoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLERoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:44:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6416122;
        Tue,  5 Dec 2023 09:44:43 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Gj8Mr010893;
        Tue, 5 Dec 2023 17:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7Dbf8waRVZWnAgsVdsH/eiTCT+E25OhHyj04Hkrg56o=;
 b=Lh9kok/0AOSA/tfddxmjE5nno6Xt+gIZ8tggXx1BymMcJ69umeN7plU9WlkH5J5wr19H
 9KX0W00ZIND2N9ELN2DACyNzOzPkJjRNnyc8Rie+x3SbY5lCd2Gma8MibbZ6Jbv2JUkU
 Li9AJCkKKoeF0vOAoaeE9rNglTFmUvDWdNpn0bUYl8Gu2O5kda7oL7rYV24hUfhFcPUj
 O5UP9grpDVwW+/heR/BjduyidqLJ4KhrLP0EjpR5u/QQfzr5RHzJ+0TH+q7QMXTuL/zR
 eKmMK5LgDXlI64yElQTcnJ89/tu8+JTJSzJ81okbHcQ7W1XEPW8Fw25yazxRtS+GOaP/ JA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ut71qr91c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 17:44:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5Hi76q002025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 17:44:07 GMT
Received: from [10.110.89.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 09:44:06 -0800
Message-ID: <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
Date:   Tue, 5 Dec 2023 09:44:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package MMD
 read/write
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <workflows@vger.kernel.org>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
 <ZW89errbJWUt33vz@shell.armlinux.org.uk> <20231205072912.2d79a1d5@kernel.org>
 <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NKpqRX8BKlW1hDj0TKoHrwWvOGQGJROh
X-Proofpoint-ORIG-GUID: NKpqRX8BKlW1hDj0TKoHrwWvOGQGJROh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_12,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 8:11 AM, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 07:29:12AM -0800, Jakub Kicinski wrote:
>> On Tue, 5 Dec 2023 15:10:50 +0000 Russell King (Oracle) wrote:
>>> I've raised this before in other subsystems, and it's suggested that
>>> it's better to have it in the .c file. I guess the reason is that it's
>>> more obvious that the function is documented when modifying it, so
>>> there's a higher probability that the kdoc will get updated when the
>>> function is altered.
>>
>> Plus I think people using IDEs (i.e. not me) may use the "jump to
>> definition" functionality, to find the doc? 
>>
>> TBH I thought putting kdoc in the C source was documented in the coding
>> style, but I can't find any mention of it now.
> 
> Well, in Documentation/doc-guide/kernel-doc.rst:
> 
>   The function and type kernel-doc comments should be placed just before
>   the function or type being described in order to maximise the chance
>   that somebody changing the code will also change the documentation.
> 
> That implies (but not explicitly) that it should be at the function
> definition site, since "changing the code" is used as an argument as
> I did in my previous email.
> 
> Secondly, this document goes on to give an example of running
> scripts/kernel-doc on a .c file.
> 
> Thirdly, there are seven references in this document of kernel-doc
> in .c files, and only one for kernel-doc in a .h file. So this suggests
> that "it will be in a .c file" isn't a rule (it can't be because of
> documenting structures!)
> 
> So let's not get hung up on whether it should be in .c or .h because I
> think that isn't relevant. Instead, I think it's about "it should be at
> the definition site" - that being a structure definition or a function
> definition, and not at a function prototype.
> 
> The only exception I can think of is the style I've used in
> linux/phylink.h for the _method_ definitions which look like function
> prototypes - that's just a work-around because one can't kernel-doc
> the structure-of-function-pointers and document the function parameters
> without jumping through that hoop, and it would be silly to document
> the methods in some random driver!
> 

The Linux Kernel philosophy of documenting functions instead of
prototypes has always bothered me since I'm "old school" and am
ingrained with the software engineering philosophy that you document
interfaces, not implementations. This was reinforced early in my career
by working on multiple projects in different programming languages using
processes outlined in DOD-STD-2167A, and for some projects, especially
ones written in Ada, the header files were the design and the documentation.

This philosophy was further enforced when working with closed source
projects (Windows, IOS, VxWorks) where all the documentation was
contained in shared header files.

So in my experience a function prototype IS the function definition, and
the actual function is just the implementation of that definition.

But that thinking obviously isn't shared by others.

/jeff
