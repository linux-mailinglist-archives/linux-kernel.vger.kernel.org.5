Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDDF807A00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379611AbjLFVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379567AbjLFVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:02:55 -0500
Received: from a10-70.smtp-out.amazonses.com (a10-70.smtp-out.amazonses.com [54.240.10.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6CD46;
        Wed,  6 Dec 2023 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896580;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=2XArwbjiyn8c4sOmfJ9h02yrv193lZYzJiMl45UR4yc=;
        b=tFkQxUJbXhIgZmPvbp9ANbcHJzJn10zhgBudO61dc8WKKb99lX89VTWM37UWAC2X
        8+gclvqyP3A4/XmBPSRoU9D6RfDr12AkE7rMc4t9BM4wVIkmdjC0J62G0EvXQiNEfFA
        iuBVYRxKp0uwMSUZKVYR5VvGYKMNZWDPACPwt87E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896580;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=2XArwbjiyn8c4sOmfJ9h02yrv193lZYzJiMl45UR4yc=;
        b=bSSicDJfYgnFNeiWDYLaRf3Ka/mlxzQoclr0D1diRr+7KMhGGkV5UkKaSt94iOKa
        HqyfhSog2bD0zeBoxOM8FM5p57fGjv71oTYTccYYKg/UxrLOdZCCHE2Wu+BOc6hJlw/
        wTYbsYuGCwNtnEfagNTmtpnSR3QXT2OkC0jU0nzY=
Subject: [PATCH RFC 1/4] dev_dax_iomap: Add add_dax_ops() func for fs-dax to
 provide dax holder_ops
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
Date:   Wed, 6 Dec 2023 21:03:00 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231206210252.52107-1-john@jagalactic.com>
References: <20231206210252.52107-1-john@jagalactic.com> 
 <20231206210252.52107-2-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRAAAAFz1
Thread-Topic: [PATCH RFC 1/4] dev_dax_iomap: Add add_dax_ops() func for
 fs-dax to provide dax holder_ops
X-Wm-Sent-Timestamp: 1701896579
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f0ed86-72d9b4a3-07c3-41c5-b495-190d21cad33c-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.10.70
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

From: John Groves <john@groves.net>=0D=0A=0D=0AThis is clearly not the ri=
ght way to set the holder_ops; where &=0D=0Ahow should this be done=3F=0D=
=0A---=0D=0A drivers/dax/super.c | 16 ++++++++++++++++=0D=0A include/linu=
x/dax.h |  5 +++++=0D=0A 2 files changed, 21 insertions(+)=0D=0A=0D=0Adif=
f --git a/drivers/dax/super.c b/drivers/dax/super.c=0D=0Aindex 0da9232ea1=
75..3d4e205c1854 100644=0D=0A--- a/drivers/dax/super.c=0D=0A+++ b/drivers=
/dax/super.c=0D=0A@@ -467,6 +467,22 @@ struct dax_device *alloc_dax(void =
*private, const struct dax_operations *ops)=0D=0A }=0D=0A EXPORT_SYMBOL_G=
PL(alloc_dax);=0D=0A=20=0D=0A+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)=0D=0A+=
/* famfs calls this to add the holder_ops. There is probably a more elega=
nt approach */=0D=0A+int add_dax_ops(=0D=0A+=09struct dax_device         =
  *dax_dev,=0D=0A+=09const struct dax_holder_operations *hops)=0D=0A+{=0D=
=0A+=09/* dax_dev->ops should have been populated by devm_create_dev_dax(=
) */=0D=0A+=09WARN_ON(!dax_dev->ops);=0D=0A+=0D=0A+=09/* Use cmpxchg=3F *=
/=0D=0A+=09dax_dev->holder_ops =3D hops;=0D=0A+=09return 0;=0D=0A+}=0D=0A=
+EXPORT_SYMBOL_GPL(add_dax_ops);=0D=0A+#endif /* DEV_DAX_IOMAP */=0D=0A+=0D=
=0A void put_dax(struct dax_device *dax_dev)=0D=0A {=0D=0A =09if (!dax_de=
v)=0D=0Adiff --git a/include/linux/dax.h b/include/linux/dax.h=0D=0Aindex=
 b463502b16e1..31b68667b3cb 100644=0D=0A--- a/include/linux/dax.h=0D=0A++=
+ b/include/linux/dax.h=0D=0A@@ -57,6 +57,11 @@ struct dax_holder_operati=
ons {=0D=0A=20=0D=0A #if IS_ENABLED(CONFIG_DAX)=0D=0A struct dax_device *=
alloc_dax(void *private, const struct dax_operations *ops);=0D=0A+=0D=0A+=
#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)=0D=0A+int add_dax_ops(struct dax_dev=
ice *dax_dev,=0D=0A+=09=09const struct dax_holder_operations *hops);=0D=0A=
+#endif=0D=0A void *dax_holder(struct dax_device *dax_dev);=0D=0A void pu=
t_dax(struct dax_device *dax_dev);=0D=0A void kill_dax(struct dax_device =
*dax_dev);=0D=0A--=20=0D=0A2.40.1=0D=0A=0D=0A
