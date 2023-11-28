Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46EE7FB9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjK1MSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjK1MSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:18:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96688A3;
        Tue, 28 Nov 2023 04:18:13 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASBCugr004876;
        Tue, 28 Nov 2023 12:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=M0R7sT0yHbVLSs9KlT1UhPFGTZrBwQe0mpt3AA0irHU=;
 b=GEL8QTyC3NK1msYD5mFAokLAV9OWesv5g9qO52CKWjWnnXHQZKHvfKArVGl0uuZTi74X
 jTCnzw6wCtlDjWSuEJd7FrJ5njxoMVLuDd3PmxS9FFxdtZ39boRYuwUTk5ab8eX68arS
 njyNCSVeFKLsqxohNspWSVJqfoBBpPbUwNw/ugfKNyqWeGRxdn/qUZaTdjmUHifmQMdh
 wfd0TGgh4uN5vWTLaZfWCzP1SbrC7p6BNo3xTLVKNnVXlPZN4X7lXP7lFLfasdCNWyE2
 /8vFxr29Yt/tx5QygOKniXlbXFo7m1rxRKSWDzoT9Pyoy1NcT9Cn6CaR2pzqZuxg0qDt ww== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unf4t9v2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 12:18:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAWfDl031072;
        Tue, 28 Nov 2023 12:18:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8sys7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 12:18:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASCI8fe21037600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 12:18:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A951058055;
        Tue, 28 Nov 2023 12:18:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D04758043;
        Tue, 28 Nov 2023 12:18:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.23.127])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Nov 2023 12:18:08 +0000 (GMT)
Message-ID: <10660ec7032cf66a772ecd0b7cfdbba88849929a.camel@linux.ibm.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, initramfs@vger.kernel.org,
        stable@vger.kernel.org, Rob Landley <rob@landley.net>
Date:   Tue, 28 Nov 2023 07:18:07 -0500
In-Reply-To: <2023112826-cesspool-cabbie-06c5@gregkh>
References: <20231120011248.396012-1-stefanb@linux.ibm.com>
         <2023112826-cesspool-cabbie-06c5@gregkh>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zE4Nml1FFyToPOchE1F8OrpMNtyMU7T0
X-Proofpoint-ORIG-GUID: zE4Nml1FFyToPOchE1F8OrpMNtyMU7T0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=963
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 09:54 +0000, Greg KH wrote:
> On Sun, Nov 19, 2023 at 08:12:48PM -0500, Stefan Berger wrote:
> > Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> > 
> >   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
> >   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
> >   line.
> > 
> > This currently does not work when root= is provided since then
> > saved_root_name contains a string and rootfstype= is ignored. Therefore,
> > ramfs is currently always chosen when root= is provided.
> > 
> > The current behavior for rootfs's filesystem is:
> > 
> >    root=       | rootfstype= | chosen rootfs filesystem
> >    ------------+-------------+--------------------------
> >    unspecified | unspecified | tmpfs
> >    unspecified | tmpfs       | tmpfs
> >    unspecified | ramfs       | ramfs
> >     provided   | ignored     | ramfs
> > 
> > rootfstype= should be respected regardless whether root= is given,
> > as shown below:
> > 
> >    root=       | rootfstype= | chosen rootfs filesystem
> >    ------------+-------------+--------------------------
> >    unspecified | unspecified | tmpfs  (as before)
> >    unspecified | tmpfs       | tmpfs  (as before)
> >    unspecified | ramfs       | ramfs  (as before)
> >     provided   | unspecified | ramfs  (compatibility with before)
> >     provided   | tmpfs       | tmpfs  (new)
> >     provided   | ramfs       | ramfs  (new)
> > 
> > This table represents the new behavior.
> > 
> > Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Rob Landley <rob@landley.net>
> > Link: https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Who should take this patch?  Me?  Or someone else?

Reviewed-and-Tested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Greg.  As there is no initramfs maintainer, I'd appreciate your
picking it up.

-- 
thanks,

Mimi

