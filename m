Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CA79B90E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377773AbjIKW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjIKM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BCCF0;
        Mon, 11 Sep 2023 05:57:07 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BCrdc1032516;
        Mon, 11 Sep 2023 12:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wvGh0pNsTBLh0Kf93IhAIqmiReVVhgs4lmJ4PnxOVr0=;
 b=LmyMekc0/Ps1Z8mmwc0IwFef84LxjsHRGAH/ydoUF6QIuf/8Q2Y6ZOSfxoTYsMjhtwfq
 Yk6qfUttnP9KUltUCgfoN97j5GCB89m84IuQGAnDMH/uBzownfnzCWGmiAio4YsJUjgJ
 Nx8tf9n5scLphwlHs9CZJa1hVBRsCdBEikFgYj3ZwQ6FqxrD0Pb7d/cI7mqS5N6Lnmh4
 gMtPbXWg9u1efqwwpc78FEoqTBM9iiQNCi7VaQlQbmzIRZCsKUwlO3ZvswKxl0jAFhq2
 JOjggBVOg8iXNdQsmV0ZoIiuzhVLgNJ1m5RNMP3aQbKApy8XdE9aZ1SFD/yI+D2qXMkG RQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23a402pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:56:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BBD8cN002362;
        Mon, 11 Sep 2023 12:56:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158jt5uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:56:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BCurdm44433938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 12:56:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DEBB20043;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3075220040;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 12:56:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/3] usb: pci-quirks: Handle HAS_IOPORT depenedencies
Date:   Mon, 11 Sep 2023 14:56:50 +0200
Message-Id: <20230911125653.1393895-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4amhqSOo1p_SR_jFK_FxRWsf5IVcSh2f
X-Proofpoint-GUID: 4amhqSOo1p_SR_jFK_FxRWsf5IVcSh2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=436 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Hi Mathias,

This is a follow up to my ongoing effort of making the inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With about half
of the per-subsystem patches merged I'm changing over to per-subsystem
series. These series are stand alone and should be merged via the
relevant tree such that with all subsystems complete we can follow this
up with the last patch[1] that will make the I/O port accessors
compile-time optional.

As for compile-time vs runtime see Linus' reply to my first attempt[2].

This series is for the USB subsystem and incorporates the feedback
received for the previous single patch USB subsystem change. In
particular I split things up in a preparatory code movement patch
followed by two independent patches for adding the HAS_IOPORT handling.
As the pci-quirks.c and hcd-pci.c files handle a diverse set of devices
I sadly couldn't get around ifdeffery but at least now it's contained in
smaller patches.

Thanks,
Niklas

Niklas Schnelle (3):
  usb: pci-quirks: group AMD specific quirk code together
  usb: pci-quirks: handle HAS_IOPORT dependency for AMD quirk
  usb: pci-quirks: handle HAS_IOPORT dependency for UHCI handoff

 drivers/usb/Kconfig           |  10 +++
 drivers/usb/core/hcd-pci.c    |   3 +-
 drivers/usb/host/pci-quirks.c | 144 ++++++++++++++++++----------------
 drivers/usb/host/pci-quirks.h |  34 +++++---
 include/linux/usb/hcd.h       |  17 ++++
 5 files changed, 131 insertions(+), 77 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.39.2

