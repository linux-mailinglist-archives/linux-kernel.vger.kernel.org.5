Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E580DC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjLKVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344988AbjLKVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:02:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68DC8;
        Mon, 11 Dec 2023 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702328533; x=1702933333; i=w_armin@gmx.de;
        bh=r5JwhE7WVnOi0zL1pvBnZD8RDseYzabf8g49jVHn60k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TjPZ8XowpffTga7TPKfRglvgWbusZV6t+GeMi02o2ijZsBOXHeLllYIUj2SzI18m
         +FvAlID7zEXDKrKB1NCxRBw8DH/TF7610gaJbQZTtHvfr1FOsLZEq00BipxEfsmgL
         J44HKU2OccCHVvgiKq9SxCxW1FoADIT51rXVoe9rBek2zG6LIMpQ7glwvqcNSm2nG
         euENf2JdTsGEo28007zoI+FlqMxFlxk8rBetYxwj5F/+hnR3Z7POs33y1851mo6Td
         CrHZ9bRjRbPVz6I6tf23DbcRpi2QZGX3snl7WUJeZ6/lamX/Qn+w2FzZgQY0CowJ4
         O7MMBKa0G9DB/zprQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEm27-1r0un00yU7-00GFIu; Mon, 11 Dec 2023 22:02:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     clemens@ladisch.de
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (k10temp) Add support for AMD Family 19h Model 8h
Date:   Mon, 11 Dec 2023 22:02:06 +0100
Message-Id: <20231211210206.11060-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RbIggH91CFz/XAJwNFKyhG5mZPwntsqz+9ypAA9HPaIqGhpBL0T
 08P3t2gRNu/jk/B556BDzdXSeL+HolRF88fQwtpT5GPMaeN1wDaXcl3ZnFZpDYwgVKIUucV
 zgPOipxbT6O1hGI1Ru9w8e6x0CiVfEkBPGKPsiXltFm0LOy0E534iYYf9Haxx+/RISNV81f
 fekaXLqyK8H+t3W0vKGTg==
UI-OutboundReport: notjunk:1;M01:P0:YuDohJt/SOI=;pWZflexVTv+dqq4CCbj6nbD7xg9
 KvYStuzLunyTgVcytArwjFQlqDb1Zz3Dv1xLosT6h6a6tURGqjpDuTPbwDwFCN2sxXNGOZlgM
 tCsc7IAIxrjc9UjnacWofkFdBk14QPQvUtQBhRbPYMye6o/Qy3i+LZavBZICqqcaWDdIuKp+B
 +fdtsNxUOfrcmuPK1WAK3VSH0xYYMHqv7ECYKyBJrx//O2DTNA569wiwkQXhCi2x/rtmIGAsv
 qGFs1gh/2Rr838ZIu+xbMJzJZHb4pDbXd/ub/Z/Una8OvD+VlVlhh7tKQKDqVoVr/hYjp4u+L
 Vcy+V33W4scCkIRrCRxdUfngDtFjMzoYhKs42TpFwhWFox0ijpYqyOvi42PT8J9c0cuQKZzyz
 ZDmm0FVBxiV7bpblcELaiq6QOqFt0n+t/M7bkpdWWgW8/pVNSi4nH5yAxseEjE1vFrjAz81eU
 Lzko9dqQoi/X9eKyrYMIEhcXcuczHprMrOAVuIF6DEPIccU83r32R+xWV0rWrojtLTbPo2cRc
 apk+xKBF26KkZkapjdMshdLgO/Ke8yKJC46u3jffQE8k+XH1Co+hFnRwgn4SZmY3pSkDN+SoL
 xN4F2x+c2ZbGq1fBtFGiRWO5JUnJyYU5hrJ1xekLWXbceZf+FdW21BCMAwZoXyaOPN7Ry0WPE
 DI1ygk/fWysG4d6n1EguL/gtKK+Ytj6dIwrf5D2dS6skpKMN+C9UaMbpnqKW7k7DACcjwA+t5
 5997mkJWV+vudVFFtO1M76J6vhgQa1/Ng/K8+aZzJl+IPeguVoDJvqJOpiwNyAa/oqBTcj0fN
 mlTUA0rehZW2Bbcrps5gRi4LGM8BJ9jyHT9voHLL7iq1XkPzGSan2SyyT+gvGNV6Lz+jALN/c
 0ErI+oRckoUDxhpdVMGYubI5q1gH70xbgYdwkRQGoMwjAOHGSG+Hg9uiUpBIVFA0s+R/nqkcl
 P0cBwwrddudoGzQwKngERZ1irE4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jami Kurki <bindkeys@gmail.com>

From: Jami Kurki <bindkeys@gmail.com>

Add support for AMD Family 19h Model 8h CPUs, which appear to
be the Zen 3 based AMD Threadripper 5000WX series (Chagall).

The patch was tested with an AMD Threadripper 5955WX.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218244
Tested-by: Jami Kurki <bindkeys@gmail.com>
Signed-off-by: Jami Kurki <bindkeys@gmail.com>
Co-developed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- reword patch description
- reduce changes to existing code
=2D--
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index bae0becfa24b..8092312c0a87 100644
=2D-- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -455,6 +455,7 @@ static int k10temp_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)

 		switch (boot_cpu_data.x86_model) {
 		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
+		case 0x8:		/* Zen3 TR Chagall */
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
 			data->ccd_offset =3D 0x154;
=2D-
2.39.2

