Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CC793738
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjIFIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIFIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:37:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B9E53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:36:55 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3868QgV2017864;
        Wed, 6 Sep 2023 08:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YnDFTDf90aBs2exwguGvqRgwZkC4J8Dc1XHTJHyg4b0=;
 b=I+3bLVD3Mh8lQtCBovLds98kBW9Yw/i78QmMsy1eZkBc0unUkdDEa4t73GHLssvddGP7
 2MhtvN/RrDN8XuqT2l0F99ZECWEqlKpItK/cqLufHR/hs4l+jce+MFD0RX+DN/oQcWCU
 rTHm6UfD1q8DSWA6iZkz/KmU/B+S/Vudb+AeC3jNq9We9lDK8V1haTwNI236tJ5pvO6/
 BqQccah0zsoFMFVO6kApEfdx/4K4LM4iCoKFGXyVdUfhNPOhq1z62YXt+tAkmGWDatKM
 j9pVZ2mFovj0HxOEHTpk2atSn1VXpJEBKr1Dg583hB0vDTubeN/Btuaw6G5iJ+bYb3qy eQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxnws88qd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 08:36:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3866IliE006603;
        Wed, 6 Sep 2023 07:55:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkh1p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 07:55:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3867tnT363373788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 07:55:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D84682004D;
        Wed,  6 Sep 2023 07:55:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F1E22004B;
        Wed,  6 Sep 2023 07:55:49 +0000 (GMT)
Received: from [9.171.95.69] (unknown [9.171.95.69])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 07:55:49 +0000 (GMT)
Message-ID: <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Sep 2023 09:55:49 +0200
In-Reply-To: <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
         <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
         <20230904153403.GB815284@myrica>
         <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FJe7WYp4PnWJSw6N4lcZV09VJiFgLNDM
X-Proofpoint-GUID: FJe7WYp4PnWJSw6N4lcZV09VJiFgLNDM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=911 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 17:33 +0100, Robin Murphy wrote:
> On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
> > On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> > > Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> > > dma-iommu deferred flush scheme. This results inn a significant incre=
ase
> >=20
> > in
> >=20
> > > in performance in exchange for a window in which devices can still
> > > access previously IOMMU mapped memory. To get back to the prior behav=
ior
> > > iommu.strict=3D1 may be set on the kernel command line.
> >=20
> > Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
> > well, because I've seen kernel configs that enable either.
>=20
> Indeed, I'd be inclined phrase it in terms of the driver now actually=20
> being able to honour lazy mode when requested (which happens to be the=20
> default on x86), rather than as if it might be some=20
> potentially-unexpected change in behaviour.
>=20
> Thanks,
> Robin.

I kept running this series on a KVM guest on my private workstation
(QEMU v8.0.4) and while running iperf3 on a passed-through Intel 82599
VF. I got a bunch of IOMMU events similar to the following as well as
card resets in the host.

..
[ 5959.338214] vfio-pci 0000:04:10.0: AMD-Vi: Event logged [IO_PAGE_FAULT d=
omain=3D0x0037 address=3D0x7b657064 flags=3D0x0000]
[ 5963.353429] ixgbe 0000:03:00.0 enp3s0: Detected Tx Unit Hang
                 Tx Queue             <0>
                 TDH, TDT             <93>, <9d>
                 next_to_use          <9d>
                 next_to_clean        <93>
               tx_buffer_info[next_to_clean]
                 time_stamp           <10019e800>
                 jiffies              <10019ec80>
...

I retested on v6.5 vanilla (guest & host) and still get the above
errors so luckily for me it doesn't seem to be caused by the new code
but I can't reproduce it without virtio-iommu. Any idea what could
cause this?


>=20
> > > Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iomm=
u.c
> > > index fb73dec5b953..1b7526494490 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_do=
main *domain,
> > >   	return viommu_sync_req(vdomain->viommu);
> > >   }
> > >=20=20=20
> > > +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> > > +{
> > > +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> > > +
> > > +	if (!vdomain->nr_endpoints)
> > > +		return;
> >=20
> > As for patch 1, a NULL check in viommu_sync_req() would allow dropping
> > this one
> >=20
> > Thanks,
> > Jean

Right, makes sense will move the check into viommu_sync_req() and add a
coment that it is there fore the cases where viommu_iotlb_sync() et al
get called before the IOMMU is set up.

> >=20
> > > +	viommu_sync_req(vdomain->viommu);
> > > +}
> > > +
> > >   static void viommu_get_resv_regions(struct device *dev, struct list=
_head *head)
> > >   {
> > >   	struct iommu_resv_region *entry, *new_entry, *msi =3D NULL;
> > > @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, =
enum iommu_cap cap)
> > >   	switch (cap) {
> > >   	case IOMMU_CAP_CACHE_COHERENCY:
> > >   		return true;
> > > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > > +		return true;
> > >   	default:
> > >   		return false;
> > >   	}
> > > @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops =3D {
> > >   		.map_pages		=3D viommu_map_pages,
> > >   		.unmap_pages		=3D viommu_unmap_pages,
> > >   		.iova_to_phys		=3D viommu_iova_to_phys,
> > > +		.flush_iotlb_all	=3D viommu_flush_iotlb_all,
> > >   		.iotlb_sync		=3D viommu_iotlb_sync,
> > >   		.iotlb_sync_map		=3D viommu_iotlb_sync_map,
> > >   		.free			=3D viommu_domain_free,
> > >=20
> > > --=20
> > > 2.39.2
> > >=20

