Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A257A5BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjISIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjISIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:00:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE2102
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:00:30 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J7ipAZ018956;
        Tue, 19 Sep 2023 08:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0bceML/i58WwwsQscnbj91zarxAyKh6soCndidZMHMw=;
 b=smcY9z5Jh1ovie0w83txAM2AkORyEh82eNeFqU8JeGEVAMiyRrn30kpJL7f46kCgY+EK
 iIfPUAILmiuH0GB1EGuVR0z4amOY0+MXph9bkPacDfqiVLNRxLQRQWcMNU7cDwrEB/29
 FzDjPSWliOYzLHcBiQ0JBpmdlPkcL13w8CHtpEJO2YV3wI3Wdaa7G8i1NUPfznvgWSAa
 QOcKYZhhx3NoBZ9USzdJBl1KlMSdb7yDHvbFbViUrrba6W09mrC74h1qTFEMbTctnHTV
 gvj2En2CGZ4UC1wpFApXypXNHaxrHWwF50Uir3PpbiagUH1BAmx4gC2sAJXtengqkRUb Lg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tk99m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 08:00:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J7k92v016478;
        Tue, 19 Sep 2023 08:00:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1smu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 08:00:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38J809Pu17564188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:00:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C78002005A;
        Tue, 19 Sep 2023 08:00:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36C8F20040;
        Tue, 19 Sep 2023 08:00:09 +0000 (GMT)
Received: from [9.171.62.55] (unknown [9.171.62.55])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 19 Sep 2023 08:00:09 +0000 (GMT)
Message-ID: <b5e1427715aa20736791cc9378935dfd5e917ebc.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Sep 2023 10:00:08 +0200
In-Reply-To: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
         <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
         <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LPFCv785oA4iiG_jPpvOxJ_wQUTTW59K
X-Proofpoint-ORIG-GUID: LPFCv785oA4iiG_jPpvOxJ_wQUTTW59K
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=621 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 17:37 +0100, Robin Murphy wrote:
> On 2023-09-18 12:51, Niklas Schnelle wrote:
> > Pull out the sync operation from viommu_map_pages() by implementing
> > ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> > elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> > it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
>=20
> Is it really a requirement? Deferred flush only deals with unmapping. Or=
=20
> are you just trying to say that it's not too worthwhile to try doing=20
> more for unmapping performance while obvious mapping performance is=20
> still left on the table?
>=20

You're right there is no hard requirement. I somehow thought that
iommu_create_device_direct_map() relied on it because it does
flush_iotlb_all() and iommu_map() but that doesn't seem to be true. If
you want I can resend with the last sentence removed.

> > Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@li=
nux.ibm.com/
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 17dcd826f5c2..3649586f0e5c 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viom=
mu)
> >   	int ret;
> >   	unsigned long flags;
> >=20=20=20
> > +	/*
> > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viom=
mu
> > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > +	 */
> > +	if (!viommu)
> > +		return 0;
>=20
> Minor nit: I'd be inclined to make that check explicitly in the places=20
> where it definitely is expected, rather than allowing *any* sync to=20
> silently do nothing if called incorrectly. Plus then they could use=20
> vdomain->nr_endpoints for consistency with the equivalent checks=20
> elsewhere (it did take me a moment to figure out how we could get to=20
> .iotlb_sync_map with a NULL viommu without viommu_map_pages() blowing up=
=20
> first...)
>=20
> Thanks,
> Robin.

That's what I had in v1. I think this is a matter of taste and Jean-
Philippe pointed me to moving the check into viommu_sync_req() I added
a comment because it really is not entirely obvious.

>=20
> >   	spin_lock_irqsave(&viommu->request_lock, flags);
> >   	ret =3D __viommu_sync_req(viommu);
> >   	if (ret)
> > @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *do=
main, unsigned long iova,
> >   			.flags		=3D cpu_to_le32(flags),
> >   		};
> >=20=20=20
> > -		ret =3D viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> > +		ret =3D viommu_add_req(vdomain->viommu, &map, sizeof(map));
> >   		if (ret) {
> >   			viommu_del_mappings(vdomain, iova, end);
> >   			return ret;
> > @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain =
*domain,
> >   	viommu_sync_req(vdomain->viommu);
> >   }
> >=20=20=20
> > +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> > +				 unsigned long iova, size_t size)
> > +{
> > +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> > +
> > +	return viommu_sync_req(vdomain->viommu);
> > +}
> > +
> >   static void viommu_get_resv_regions(struct device *dev, struct list_h=
ead *head)
> >   {
> >   	struct iommu_resv_region *entry, *new_entry, *msi =3D NULL;
> > @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops =3D {
> >   		.unmap_pages		=3D viommu_unmap_pages,
> >   		.iova_to_phys		=3D viommu_iova_to_phys,
> >   		.iotlb_sync		=3D viommu_iotlb_sync,
> > +		.iotlb_sync_map		=3D viommu_iotlb_sync_map,
> >   		.free			=3D viommu_domain_free,
> >   	}
> >   };
> >=20

