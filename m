Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55EE807A07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379668AbjLFVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379610AbjLFVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:02:58 -0500
Received: from a48-177.smtp-out.amazonses.com (a48-177.smtp-out.amazonses.com [54.240.48.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD54D5F;
        Wed,  6 Dec 2023 13:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896583;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=e0bZT30UH1862XrWsVHqzzsCoSyaKyeDEuFIkGW3TKY=;
        b=Gh00IKI6t9fOKgjqE6YFIhcjyQor578P/1MegN/5vV9/jtEyl8cfP3Lheqzc0VsI
        NRgb8mB8GwqxqlBcW1Vn/0m+NMV6B4h3/m2UxxR0w3mHPxNIco2Ev6A6U6idxfsuyJ4
        gOyTUP6/x2OtP7nRZSTw47BFWyT1VUNdZ13bqnhY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896583;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=e0bZT30UH1862XrWsVHqzzsCoSyaKyeDEuFIkGW3TKY=;
        b=NW7tCRxlP/1HBef1QmUwjcm9DfQkebr/ip8jTKUj0UIv7PxfzNq0pmXkm+6Sca+s
        qVP0dQC9V9l9Qf10Nlmq5JLV8kZuhy/TgXLFj6RKaEAGDsjTW82pD8PddbhiY8KE/LP
        /yTfu2c4+9KP7eQAv3oob9ay0e0ew5UD28HZWMtY=
Subject: [PATCH RFC 2/4] dev_dax_iomap: Temporary hacks due to linkage issues
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>,
        =?UTF-8?Q?John_Groves?= <jgroves@micron.com>,
        =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Cc:     =?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>,
        =?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>,
        =?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= 
        <nvdimm@lists.linux.dev>,
        =?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= 
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?John_Groves?= <john@groves.net>
Date:   Wed, 6 Dec 2023 21:03:02 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231206210252.52107-1-john@jagalactic.com>
References: <20231206210252.52107-1-john@jagalactic.com> 
 <20231206210252.52107-3-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRAAAAKIK
Thread-Topic: [PATCH RFC 2/4] dev_dax_iomap: Temporary hacks due to linkage
 issues
X-Wm-Sent-Timestamp: 1701896581
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f0f6d8-1460addc-79af-4f6d-b791-147340e4c972-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.48.177
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Groves <john@groves.net>=0D=0A=0D=0AThese are functions that s=
hould be called from outside, but I had=0D=0Alinkage issues and did this =
hack instead. Will fix in the "real"=0D=0Apatches...=0D=0A---=0D=0A drive=
rs/dax/bus.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++=0D=0A 1=
 file changed, 50 insertions(+)=0D=0A=0D=0Adiff --git a/drivers/dax/bus.c=
 b/drivers/dax/bus.c=0D=0Aindex 1659b787b65f..1b55fd7aabaf 100644=0D=0A--=
- a/drivers/dax/bus.c=0D=0A+++ b/drivers/dax/bus.c=0D=0A@@ -1324,6 +1324,=
56 @@ static const struct device_type dev_dax_type =3D {=0D=0A =09.groups=
 =3D dax_attribute_groups,=0D=0A };=0D=0A=20=0D=0A+#if IS_ENABLED(CONFIG_=
DEV_DAX_IOMAP)=0D=0A+=0D=0A+/*=0D=0A+ * This is write_pmem() from pmem.c=0D=
=0A+ */=0D=0A+static void write_dax(void *pmem_addr, struct page *page,=0D=
=0A+=09=09unsigned int off, unsigned int len)=0D=0A+{=0D=0A+=09unsigned i=
nt chunk;=0D=0A+=09void *mem;=0D=0A+=0D=0A+=09while (len) {=0D=0A+=09=09m=
em =3D kmap_atomic(page);=0D=0A+=09=09chunk =3D min_t(unsigned int, len, =
PAGE_SIZE - off);=0D=0A+=09=09memcpy_flushcache(pmem_addr, mem + off, chu=
nk);=0D=0A+=09=09kunmap_atomic(mem);=0D=0A+=09=09len -=3D chunk;=0D=0A+=09=
=09off =3D 0;=0D=0A+=09=09page++;=0D=0A+=09=09pmem_addr +=3D chunk;=0D=0A=
+=09}=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A+ * This function is from drivers/dax/=
device.c=0D=0A+ * For some reason EXPORT_SYMBOL(dax_pgoff_to_phys) didn't=
 result in linkable code=0D=0A+ */=0D=0A+phys_addr_t dax_pgoff_to_phys(st=
ruct dev_dax *dev_dax, pgoff_t pgoff,=0D=0A+=09=09=09      unsigned long =
size)=0D=0A+{=0D=0A+=09int i;=0D=0A+=0D=0A+=09for (i =3D 0; i < dev_dax->=
nr_range; i++) {=0D=0A+=09=09struct dev_dax_range *dax_range =3D &dev_dax=
->ranges[i];=0D=0A+=09=09struct range *range =3D &dax_range->range;=0D=0A=
+=09=09unsigned long long pgoff_end;=0D=0A+=09=09phys_addr_t phys;=0D=0A+=
=0D=0A+=09=09pgoff_end =3D dax_range->pgoff + PHYS_PFN(range_len(range)) =
- 1;=0D=0A+=09=09if (pgoff < dax_range->pgoff || pgoff > pgoff_end)=0D=0A=
+=09=09=09continue;=0D=0A+=09=09phys =3D PFN_PHYS(pgoff - dax_range->pgof=
f) + range->start;=0D=0A+=09=09if (phys + size - 1 <=3D range->end)=0D=0A=
+=09=09=09return phys;=0D=0A+=09=09break;=0D=0A+=09}=0D=0A+=09return -1;=0D=
=0A+}=0D=0A+=0D=0A+=0D=0A struct dev_dax *devm_create_dev_dax(struct dev_=
dax_data *data)=0D=0A {=0D=0A =09struct dax_region *dax_region =3D data->=
dax_region;=0D=0A--=20=0D=0A2.40.1=0D=0A=0D=0A
