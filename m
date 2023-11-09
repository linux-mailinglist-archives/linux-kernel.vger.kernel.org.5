Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661F7E6A89
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjKIMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:25:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C94270C;
        Thu,  9 Nov 2023 04:25:33 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9CIbbI014238;
        Thu, 9 Nov 2023 12:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=r52TuHjOh2ZP6lSZRSvfxTIaePHgLmjlG0173xyI4pY=;
 b=T1yQLinqgtG9qw+j/iNU8Hv78xc9XbuVznPvBNV+gPCxa8/aIsa64TfI9O2ktBW/ZQj/
 rZbc/BzdQLQyaCM3rn3jx30Po4XT5Jl+AnPCF9UJ/XxSkwlx9ljA7/ihs6u8V8MfvtR0
 2KJDcDCXdaAG1BYXsiyqRGxuvZSM0buclegu5BodLGcNiwsWG8KWDh5OQGW4wEsEoFl9
 gt6RIhEpjHFgfOpGqTqKNXBUoIJsTCfNcRYZpqXU3/+zK+BD1cYe/oM73HNdHPM88bsL
 wDtNl8THNo2bJAIs5Xhfy8fmAuubv7KN2MgDd2ryCZNxL8oTISGSzOGcyLTGOZd5plx5 IA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8y1x0r93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 12:24:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9AgP7x014320;
        Thu, 9 Nov 2023 12:24:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w223pwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 12:24:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A9COmK517236576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 12:24:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D780720043;
        Thu,  9 Nov 2023 12:24:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A978C20040;
        Thu,  9 Nov 2023 12:24:48 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Nov 2023 12:24:48 +0000 (GMT)
Message-ID: <32af4ed531a6cf8e289d4dc9e1dbc5fb14bc1813.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with
 CONFIG_SWIOTLB_DYNAMIC
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
        Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Halil Pasic <pasic@linux.ibm.com>, stable@vger.kernel.org
Date:   Thu, 09 Nov 2023 13:24:48 +0100
In-Reply-To: <20231108132120.0538a778@meshulam.tesarici.cz>
References: <20231108111249.261-1-petrtesarik@huaweicloud.com>
         <20231108132120.0538a778@meshulam.tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H8BwPvaDeN7rhk65lV9qf2uhtoVCO0IM
X-Proofpoint-ORIG-GUID: H8BwPvaDeN7rhk65lV9qf2uhtoVCO0IM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=843 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 13:21 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> On Wed,  8 Nov 2023 12:12:49 +0100
> Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>=20
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >=20
> > Limit the free list length to the size of the IO TLB. Transient pool ca=
n be
> > smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
> > assumption that the total number of slots is a multiple of IO_TLB_SEGSI=
ZE.
> > As a result, swiotlb_area_find_slots() may allocate slots past the end =
of
> > a transient IO TLB buffer.
>=20
> Just to make it clear, this patch addresses only the memory corruption
> reported by Niklas, without addressing the underlying issues. Where
> corruption happened before, allocations will fail with this patch.
>=20
> I am still looking into improving the allocation strategy itself.
>=20
> Petr T

I know this has already been applied but for what its worth I did
finally manage to test this with my reproducer and the allocation
overrun is fixed by this change. I also confirmed that at least my
ConnectX VF TCP/IP test case seems to handle the DMA error gracefully
enough.

Thanks,
Niklas
