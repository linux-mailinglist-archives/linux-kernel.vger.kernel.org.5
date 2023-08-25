Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56378880E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbjHYNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbjHYNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:03:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E241BE2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:03:46 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PBoFPg026609;
        Fri, 25 Aug 2023 12:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=POTViOirAulYPreEM0hrpdn1z/hSZcOLYNZ/fXXwKvg=;
 b=l/FmHLzFFDm1fyD52GPy6/yEIkvD1TkljsJn9oDexgNYPCimSu0BOaJmzvkK5DIN4QG2
 1bHjD3Nbu6C+GMVgbdK2kGkRQqEMgB/RwSR1oRIHXCwViPhNq6niNJOF6Vq7xA9qDXmw
 kAs66WgrX9Lcb/eKWFELi/nBACT9qlR3CRYWqBOzs/XSOgZm1IdL+/chI+Zvgw7XxrHO
 MiV34PqmnOmayNFgOueOQUT+rsSC7Fx4a9xTxcsT2LwoOKWWeQYDx3r6rkI1Kc/3vypS
 5vkSegHXjd+YYJRm+evQ1hU36gr8FlBA3L/PfIZ8kwaIAfLTgLVodTzYm4tWkcy9RVkr Xg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spugxsf48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 12:22:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PAHS27027398;
        Fri, 25 Aug 2023 12:22:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20sygbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 12:22:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PCMdV118416208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 12:22:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A164A20043;
        Fri, 25 Aug 2023 12:22:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0957220040;
        Fri, 25 Aug 2023 12:22:39 +0000 (GMT)
Received: from [9.179.20.14] (unknown [9.179.20.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 12:22:38 +0000 (GMT)
Message-ID: <9d7819fd165a1e87ea1dd66f9d0d841f45012264.camel@linux.ibm.com>
Subject: Re: [RFC] iommu/virtio: Use single flush queue (EXPERIMENTAL)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Fri, 25 Aug 2023 14:22:38 +0200
In-Reply-To: <20230802123612.GA6142@myrica>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
         <20230726111433.1105665-1-schnelle@linux.ibm.com>
         <20230802123612.GA6142@myrica>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHkAqKV6I6Bp52YLJfUV2kCS7-W12LAU
X-Proofpoint-ORIG-GUID: SHkAqKV6I6Bp52YLJfUV2kCS7-W12LAU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_10,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 13:36 +0100, Jean-Philippe Brucker wrote:
> Hi Niklas,
>=20
> On Wed, Jul 26, 2023 at 01:14:33PM +0200, Niklas Schnelle wrote:
> > Just like on paged s390 guests with their virtual IOMMU, syncing
> > mappings via virtio-iommu is quite expensive. It can thus benefit from
> > queueing unmapped IOVAs and flushing them in batches but less so from
> > parallel flushes which is what the shadow_on_flush flag introduced for
> > s390 tunes dma-iommu to do.
> >=20
> > For this to work .flush_iotlb_all is implemented. Furthermore
> > .iotlb_sync_map is also implemented and used to pull the sync out of the
> > mapping operation for some additional batching and performance gain.
> >=20
> > In a basic test with NVMe pass-through to a KVM guest on a Ryzen 3900X
> > these changes together lead to about 19% more IOPS in a fio test and
> > slightly more bandwidth too.
>=20
> Nice, thank you for testing this. I played with a NVMe on an Intel desktop
> and can confirm similar results. With "sq" meaning single flush queue and
> "mq" percpu flush queue, "+map" is with .iotlb_sync_map() enabled.
>=20
> Multithread block randwrite job [1]:
>=20
>                          BW compared to host    Confidence
>                           (higher better)
>               host           100.0%               =C2=B10.0%
>           noviommu            99.9                 0.0
>     viommu lazy sq +map       99.9                 0.1
>     viommu lazy mq +map       99.9                 0.1
>     viommu lazy sq            92.2                 0.9
>     viommu lazy mq            91.5                 0.9
>      viommu strict +map       92.7                 0.9
>      viommu strict            81.3                 1.0
>=20
>=20
> Single page randrw:
>=20
>                         Latency compared to host    Confidence
>                            (lower better)
>               host            x1.00                   =C2=B1.04
>           noviommu             1.23                    .04
>     viommu lazy sq +map        7.09                    .05
>     viommu lazy mq +map        7.07                    .07
>     viommu lazy sq             7.15                    .04
>     viommu lazy mq             7.11                    .05
>      viommu strict +map        8.82                    .05
>      viommu strict             8.82                    .04
>=20
> So with lazy+map we get the maximum bandwidth reachable on this disk
> (2.5GiB/s) even with a heavy iommu_map/unmap usage, which is cool.
> Random access latency also improves with lazy mode.
>=20
> The difference between single and percpu flush queue isn't really
> measurable in my multithread test. There is a difference between Lazy sq
> and mq but the variation between samples outweighs it.

Interesting that there is no advantage when using a single large queue.
Maybe virtio-iommu does handle the per-CPU flushing well because of a
stronger CPU affinity than on s390x or maybe it has to do with the sync
being just a queue drain making only some syncs slow.

>=20
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note:
> > The idea of using the single flush queue scheme from my series "iommu/d=
ma: s390
> > DMA API conversion and optimized IOTLB flushing"[0] for virtio-iommu wa=
s already
> > mentioned in the cover letter. I now wanted to explore this with this p=
atch
> > which may also serve as a test vehicle for the single flush queue schem=
e usable
> > on non-s390.
> >=20
> > Besides limited testing, this is marked experimental mainly because the=
 use of
> > queuing needs to be a concious decision as it allows continued access to
> > unmapped pages for up to a second with the currently proposed single fl=
ush
> > queue mechanism.
>=20
> It fits with the iommu.strict=3D0 / CONFIG_IOMMU_DEFAULT_DMA_LAZY setting,
> which selects DMA_FQ domains. That option allows a misbehaving device to
> access memory that has been freed/reallocated, which is what we're
> enabling here. I believe the risk is pretty much the same for deferred
> UNMAP as for deferred TLBI, since mappings that we're removing were likely
> cached in the TLB. Increasing the timeout does make it easier to exploit,
> but I don't think that changes the policy from an admin's perspective:
> only enable lazy mode if you trust device and driver.

I'm with Jason here. I think for non-CoCo hypervisor's
the hypervisor is trusted so may just forward the trust level of the
relevant device. This may of course be different for CoCo VMs but then
the VM knows and could e.g. default to iommu.strict=3D1 or it needs to
use swiotlb anyway.

>=20
> On bare metal, we disable DMA_FQ for devices that can be easily hotplugged
> into unattended machines (through external-facing ports like thunderbolt).
> On VMs, the concern isn't really about external devices, since they don't
> automatically get plugged into a VM without user intervention. Here I
> guess the devices we don't trust will be virtual devices implemented by
> other VMs. We don't have any method to identify them yet, so
> iommu.strict=3D1 and CONFIG_IOMMU_DEFAULT_DMA_STRICT is the best we can do
> at the moment.
>=20
> I'm not so sure about enabling shadow_on_flush by default, since the
> performance difference was too small in my tests. Maybe a module parameter
> for dma-iommu could configure the flush queue?
>=20
> > Also it might make sense to split this patch to do the
> > introduction and use of .iotlb_sync_map separately but as a test vehicle
> > I found it easier to consume as a single patch.
>=20
> Yes, both changes are useful but should be in two patches
>=20
> Thanks,
> Jean
>=20

After sending v12 of my series[0] I'm now looking into sending this
separately. Rebasing on v6.5-rc7 however I noticed that without my
patch "iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM
return" we not only get a conflict with my series but also potentially
miss errors on map since just like on s390x virtio-iommu's
.iotlb_sync_map can fail. So I think it makes most sense to send this
based on my series. I hope that's okay for you.

[0]
https://lore.kernel.org/lkml/20230825-dma_iommu-v12-0-4134455994a7@linux.ib=
m.com/
