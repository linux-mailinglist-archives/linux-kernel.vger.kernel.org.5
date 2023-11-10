Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC787E8171
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjKJS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjKJSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D3A7509
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 05:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTAnIFoZhTm05z2CWMJ3IAWgujKla33h0gK/L4GIFjZ2AA8biDZex3LmjiG+N1to+1ERRfzpAETCMW3wI3b7UGSqn3PZb1X72GaLcw4UL3C0tBzaQAqz5LnwWduW8+Dppu8cdAExisToHRYYY4D/oYNwW7aR46JgLP4ld5AEJOPSZ0j31s8v9CJNrNMFkmdt4aIVJfzh/3xRBAXlDkCKuzTCqRZvI/ZbgnUZ3MK1w2HdKMXNanA02v0/EMXL2GPkqghQOcnRtuKqoslv0TB2uWH6U266hiBmD7O2NlzoIsDH7MhsLop5ZwU5N6PKgZ+7XDdCBPrGM9X5nuUTsApO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIXHyzPIG2j4pFlS5WF88h66Lq2gniCipARsVYEOcpc=;
 b=AUh5oPw1JKkkPeIynVylzB6H1BLXn7GqNhW1rLyPQyyblcQUDexd0d2JP1Kl8GQbSU7d1ySJ9B0z0uRc93tF8yKdbAN6YqTHAu44QdCVDQ7IUKdDdwc368EGMA82bd0Wc8MPSbsx0UeKt+zs02hYuY2plJYLDNEwr7C+Kq4YR4FzeZCAvdiaomfoHRsu3ifKa7TxbiatVsdZw55C2HLUVpSVNQQSwIoAIsgZ6RPUXWEkKb8BuO6E7+VEeCGDs0V2MRx+/eBiE7+mjy0BmpZus5mCY82/zK0N6nUU0P0LiU+HRVz9uhqkXSsP5s7E7x/eORsxjxbpoE5qJUu3oliXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIXHyzPIG2j4pFlS5WF88h66Lq2gniCipARsVYEOcpc=;
 b=AL93REv7Vmg/LaaFeufj3p8ZU/jx7hP/ZzyTjznIEU5OVQUacVewYTE5BV1CnVKDMt+V/qb9JSVGMcE4gN95ibbBCFeOwDjkiI7Ge5vIKd2JtqiocCUN7Xn3+6MXKX1qz5AjXqut4wJ68bpLUbjD9K/DLRN/SPn3T2F37B2Ltko=
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 13:20:33 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb%6]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 13:20:32 +0000
From:   "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
To:     "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "posteuca@mutex.one" <posteuca@mutex.one>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform Add pm ops for renoir platform.
Thread-Topic: [PATCH 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform Add pm ops for renoir platform.
Thread-Index: AQHaE9TJdn8rhslbRkCXpB1In+AjQrBziOQQ
Date:   Fri, 10 Nov 2023 13:20:32 +0000
Message-ID: <MN2PR12MB3661D6802D9B91FE50FFE70FFCAEA@MN2PR12MB3661.namprd12.prod.outlook.com>
References: <20231110125214.2127139-1-Syed.SabaKareem@amd.com>
 <20231110125214.2127139-2-Syed.SabaKareem@amd.com>
In-Reply-To: <20231110125214.2127139-2-Syed.SabaKareem@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b3084c24-50b3-41f2-baa2-de03b419d974;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T13:17:38Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3661:EE_|LV3PR12MB9409:EE_
x-ms-office365-filtering-correlation-id: 0a02f816-4387-4cb8-714b-08dbe1efd12a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MndbeUZhQdCFgph7qRaMkYU9WJ1bNpHWaBChL+hkvmjsy4xRgbUHcmNm8Nx9zrZvl7xni1iDzqNwQ6b3XNklSCsGWinp2tw3zaqfhj7dpqn4EdkErhkzHzFCt27LVCQYeImQ+X4BCKTHBdu2jc4Zl2Bj5pguL/nN9euW3Qxu6TMzCSalfL9FHkQEDI8Lq+aeBNpAKy7TzFIOHYCXQlETwcgg9esZDGmN5+CVn2/R5GF5MfmkZAi34OB11ExACzDtfjsDbFRsnd9rufeocviBREmHl13XNVrkxv1dKC60EpCESIba762W5xoI0zmZyeRx9D1DerVKAZsG1lzlLISEm9R7vUK2MYn2/v8PKvsJzeY/+BX9aTZsoFYkEyTIkhPPMSA4lJ8cbeotElnRJzC8r2nWEKz2nLJc+rJhS+Hfwz5DMMhn5vONYGZBZZnFsE2EwcRQmb0SsHrWagm+2NmU0BxeZQ+NxykPaBAeKWut0ky273d+aQedaIxUKxSa3Gr+o/cTuLgWduXvybmqWvzEjVF3ELmAAAg//pwpVyOd50A3OGCdHFV1GsSlVnvJVW/G0vNJWa4HTO26L90HkAT6G8BlseQOMnJPkNAqOmpwstOp3ZqOc/rFr3J5hqdZbCJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(122000001)(110136005)(38070700009)(83380400001)(76116006)(66946007)(66574015)(66556008)(26005)(71200400001)(478600001)(7696005)(6506007)(9686003)(4326008)(66476007)(53546011)(7416002)(33656002)(8936002)(55016003)(8676002)(66446008)(41300700001)(52536014)(38100700002)(5660300002)(2906002)(64756008)(316002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ppOkUUJmxYEtMcROOvHR70AgkoQlkcl3kOjJTSmGsarHO7XXMdudIO8M9w?=
 =?iso-8859-1?Q?6Lvxfe1O7OcPv+x3W+nW8vL4CQNO7Vl8WU4/MG8yN5Rh45fci7QYTxqAn9?=
 =?iso-8859-1?Q?QoTi7ObNIY2pqiu5lfJTEhA3ztk2eLT4ziogS5chn/eX/bj/64S3VRmgKR?=
 =?iso-8859-1?Q?NXQuKB1loLf+/DLVbPrYvzoLIrW6O/3tGLXslEzmYKnjMVd3f1uizC4N8z?=
 =?iso-8859-1?Q?EBgiVX8XWIQ4RXarMu5vACNoJBLxZsUVl16ReKkMD5ju3VEmPGPqDzkPQ3?=
 =?iso-8859-1?Q?DLiyar6qnk8ssvW7rj6Q9/e0lF8n5yWi1zQRnyWXA1c8b4rF/WgiQdjd/j?=
 =?iso-8859-1?Q?lZJsq8ME52nI6LTe+TB/dEagFecC06TVkYeSyDSzQlDATk23NDANdkhia5?=
 =?iso-8859-1?Q?K9iaUVU4Kleu8BvMcvBasO4DQ6I4zrY+KNE8NN6Q+Jaw1ojDq2ApAyGlfJ?=
 =?iso-8859-1?Q?z/Dv0K7H74Ujt74igrvMhgbmoXc/5BekNU4DRacvYnJeLC6Dz36HTu7B3/?=
 =?iso-8859-1?Q?kC8P9/YVQVx+VVYBQT3czioTyK5qE4etPdHPV5QnfCHO+AMOKWE1mbmSOi?=
 =?iso-8859-1?Q?ET8pCqypkslY9Ovjt/87b4oGlGFElOORKSVBaJOxwk0DCNngMSDndaiPe0?=
 =?iso-8859-1?Q?DxDr31J+qNeOJlhkwKWFtYeBtsqo+p+r0D+IC0AbCn+v8veySp7zecKu9c?=
 =?iso-8859-1?Q?K7lZtT/x9QkByzrHm402YdhyfdwwnUQPkdIPruEJG3+ZAFK6DlbsGH2asv?=
 =?iso-8859-1?Q?BOU/6ES8RBnmPgpedslxs2CfV4S/CvkiSFtdJu/NQRP0hrSZfU+PaWc6NK?=
 =?iso-8859-1?Q?b/Rz3f1NVkCowo8pSoDS8wSdlLPfAiJYtjAh8dzpqSwf4X0Y6sbhrqEc34?=
 =?iso-8859-1?Q?uMw3pgP5NFBPQ20C3UpPHe/lOpjMLHqbQ93BvKMyVj1JT8B0FpZC6ef6sH?=
 =?iso-8859-1?Q?pW8O2e/vXE6zhm8tJem1/0dwaTM1gTaSix6Va2eqBQAu+sk2y6KjiwP6c9?=
 =?iso-8859-1?Q?ma9sRZrpLxEeoLX0g+XqUq1BW+F0+jbxW7BqguzI/FzZx3iOFMhqS0L+ir?=
 =?iso-8859-1?Q?Bp+IOO6uNV4IM6viqqMzHvdwVOkcdaBGDDNAslSiTG32H0IkbhJD8lmLcd?=
 =?iso-8859-1?Q?SvFIYAjtTKFY4MwLAT3hhdPU3ZbvW4OkkRkWiU700LEbPwpljkvgOqVJ8q?=
 =?iso-8859-1?Q?GscShIP2ToPeG1qG1weLovreVFSqrQijy05xvis/EfGK7icJglkv6NnVex?=
 =?iso-8859-1?Q?wG8Z5ofssO6hB+kwJeziS4LxsRptDWAfc1fnnv1/oILaidhtIxxkqGMEDb?=
 =?iso-8859-1?Q?hTRZNRhHJ1Hq1QaLQLwzNlNWcegMwCU12j+O4jjV3zPHKO//P7K35Kw0gR?=
 =?iso-8859-1?Q?3qaMZFMz1LYbLgyu6jlSdIVqwH7t+Pkqho45ghh9Fb/I8AhwbLZk6wYgRj?=
 =?iso-8859-1?Q?GR9D0Fgmj4TVyK7KbvkCV5F71eG/UGGQPk4icVH43JXCG7xfN4tex1GjNI?=
 =?iso-8859-1?Q?AmXjLM/wOa497ZCv9vuc8LUQg0c7jJH99Dmjn72lwMw52LGhI1ePJl5t/U?=
 =?iso-8859-1?Q?MeeNYLSQjfAtD53HcnBNddAI+4RMf92ScCBYkwS7JB82kV5RoAjsuaZtVC?=
 =?iso-8859-1?Q?Jn3pdc6h17ZjQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a02f816-4387-4cb8-714b-08dbe1efd12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 13:20:32.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaTu27zxdUvrdqVaT2qJcWqDbJ2Bbxk/iaiyXAhurnoVmmqQut5ABN7rdwQgN/yl+/TU3khn58oqhynRg5GyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Commit message got mixed with commit title will resend the patch again.

-----Original Message-----
From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Sent: Friday, November 10, 2023 6:22 PM
To: broonie@kernel.org; alsa-devel@alsa-project.org
Cc: Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; Hiregoudar, Basavaraj <Ba=
savaraj.Hiregoudar@amd.com>; Dommati, Sunil-kumar <Sunil-kumar.Dommati@amd.=
com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Gong, Richard <Richar=
d.Gong@amd.com>; posteuca@mutex.one; Saba Kareem, Syed <Syed.SabaKareem@amd=
.com>; Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz=
>; Takashi Iwai <tiwai@suse.com>; Kuninori Morimoto <kuninori.morimoto.gx@r=
enesas.com>; Nicolas Ferre <nicolas.ferre@microchip.com>; Uwe Kleine-K=F6ni=
g <u.kleine-koenig@pengutronix.de>; open list <linux-kernel@vger.kernel.org=
>
Subject: [PATCH 2/2] ASoC: amd: acp: add pm ops support for renoir platform=
 Add pm ops for renoir platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c | 38 +++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.=
c index a591482a0726..8539fbacdf4c 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -20,6 +20,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>

 #include "amd.h"
 #include "acp-mach.h"
@@ -195,7 +196,11 @@ static int renoir_audio_probe(struct platform_device *=
pdev)
        dev_set_drvdata(dev, adata);
        acp_enable_interrupts(adata);
        acp_platform_register(dev);
-
+       pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+       pm_runtime_use_autosuspend(&pdev->dev);
+       pm_runtime_mark_last_busy(&pdev->dev);
+       pm_runtime_set_active(&pdev->dev);
+       pm_runtime_enable(&pdev->dev);
        return 0;
 }

@@ -208,11 +213,42 @@ static void renoir_audio_remove(struct platform_devic=
e *pdev)
        acp_platform_unregister(dev);
 }

+static int __maybe_unused rn_pcm_resume(struct device *dev) {
+       struct acp_dev_data *adata =3D dev_get_drvdata(dev);
+       struct acp_stream *stream;
+       struct snd_pcm_substream *substream;
+       snd_pcm_uframes_t buf_in_frames;
+       u64 buf_size;
+
+       spin_lock(&adata->acp_lock);
+       list_for_each_entry(stream, &adata->stream_list, list) {
+               substream =3D stream->substream;
+               if (substream && substream->runtime) {
+                       buf_in_frames =3D (substream->runtime->buffer_size)=
;
+                       buf_size =3D frames_to_bytes(substream->runtime, bu=
f_in_frames);
+                       config_pte_for_stream(adata, stream);
+                       config_acp_dma(adata, stream, buf_size);
+                       if (stream->dai_id)
+                               restore_acp_i2s_params(substream, adata, st=
ream);
+                       else
+                               restore_acp_pdm_params(substream, adata);
+               }
+       }
+       spin_unlock(&adata->acp_lock);
+       return 0;
+}
+
+static const struct dev_pm_ops rn_dma_pm_ops =3D {
+       SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume) };
+
 static struct platform_driver renoir_driver =3D {
        .probe =3D renoir_audio_probe,
        .remove_new =3D renoir_audio_remove,
        .driver =3D {
                .name =3D "acp_asoc_renoir",
+               .pm =3D &rn_dma_pm_ops,
        },
 };

--
2.25.1

