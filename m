Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621BA7A969A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjIURC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIURCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:24 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBC26BA;
        Thu, 21 Sep 2023 10:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOLJjumgv9kBBDJxbye+CWpv+4lT48Zyw4swrq8f6YXPNYiHO2JTErXQYRJJHbkCdnNXUjQhi3QdPSIGeFNoWdx/QEOEr8YmaEvGLbZyok49te/sbELm7KHNtq7m+fpCtqct+V/zAPLtzQP7Vq93dZyml6dVD9cMzOo8oy/4NHIRstNJrhBuxnNPiW8QMU/HRbVsMAbOq9MX0URLSyE3ogPX+lnetHNSxBp03WOjwceIYOUL2xDCfAigRijPCyKWozJovzQhf5v9lfpAr9lY+yzS6oQaWSPwrapiaLosXsDuTg995rDis0dEVcmEfDlWesqBrt9Uo2BYwEsyP88ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OobzXFiqP/2Nvwkhy56LlXkEQDyiXL1tLmUVQKyx8pQ=;
 b=aZvZNNKzgIGEXHhlgDLm36gqNdsaLGyPmABi/QUJfoz23HHEOQkOuzxC3IEBaUWripwWbvQ5A+1CDlJan89bzQZtU0HKwYpK3/P4aDRJsWqXQAZ3wVkX98dOX/o5HrWVJCwpwKO/TNC9EXbJbHKlTYshZsN8sisjpWlbecdx0o7SwQyYgabdSlw6W8UzXbrNkoqDXRAxin2Om5ttxWXB+NvUiDpMtvmwwFTBPiDNB9gEeqTtob8/Iaf2q9kNB64LK6509VbFx5fNCybjlGBDei13keckcszB3IoiD3lIARkiYaoP2OyEg9NmDG1/pI0oiwgIjA03B39FP5vYY1UNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OobzXFiqP/2Nvwkhy56LlXkEQDyiXL1tLmUVQKyx8pQ=;
 b=TbH3SaWUVBQloK4aq3E6ums86ygFhPLlkq5Lb8KvzsJNWrIgUtXTsB+GjUGUuFhuw7vf8JgUl+HBAu0kLwFtZnoFCKaYZRrkLhiXIkv7WTZlI4sPbqSJ3QnK+zQU22xbbw7waFnIb9AWMIA1hk+jALxI3kUssc5EcPsjCVF8aBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com (2603:10a6:208:c6::21)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 06:24:55 +0000
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::5cef:d7cb:e6b3:5a70]) by AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::5cef:d7cb:e6b3:5a70%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 06:24:54 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        bartosz.golaszewski@linaro.org
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: platform: fix the incorrect parameter
Date:   Thu, 21 Sep 2023 14:24:43 +0800
Message-Id: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM0PR04MB5089.eurprd04.prod.outlook.com
 (2603:10a6:208:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5089:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7550869a-0c10-4812-adcd-08dbba6b785a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8nWJ90xlGd+8Stlw+nqD03n4KTmYY2npWGf4USS5X85nc06bcdQ/eItaLYpCpsH8nYc965Hpf5/4hmk+tCPmxgM5P+yCvPt3CZ2gieZNaOxVIl7s0RBF/3duPyZdALUm9jj4DhDZNbOJALThTZVRSPENogRf3JD7Ym/Il4dA9WVvrrgJ+ZXKywCF6mD3Zbttbg6g6UczxfYBzfkpBYqrhhqSZfjfUHgrwtlXPw03W04T79sirF0lW1H9+5Sj6vUtegZIfDf5WyaqjkYhjXyTAfHCTe2B6xvczB9Z26kn1bNgaDgFGApBrZ0sb0WDaRUMeOz+o/9AxSurXbPw2/wDGuFece7iQQjZhuTbv8bPVEIRifcMez035SJrY4ehYxShitXAO7htNt90I9FOEDkgv1C/+6Vvy+efPyj3hsSksEoCGMNGws6vaJlL0hL5XsxQVwq5UD/0828x/w/34AlFPI5DiWT/gcI4tBSQJijwt5bq5KWkFLEIf1VBSkfc/jGCL05VWphRhFsYolNRXUEZWkaFjFsaLtZSbGCiX1OwtqVHRzkmzB77Lczhmnkx5hxYyw45V9V9pWDz2632iRtOb+a4B2Dxny3U/SUcx7BikTPJ1y6u5BpQ8IDT84ohSAI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(6506007)(6512007)(45080400002)(52116002)(6666004)(36756003)(38100700002)(38350700002)(86362001)(7416002)(316002)(2616005)(6486002)(2906002)(478600001)(66946007)(26005)(1076003)(4326008)(5660300002)(41300700001)(8936002)(8676002)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZAFVEk8ZXaL6cMrIPwfD92k5aK+PjFlX1GPFXer52IpFxU8zKHf2/CDTDcEQ?=
 =?us-ascii?Q?XyLad4jeVvMJesvr1gIhRkNGePkKvgEOUPeamieBYdTp/zJTjEDE0pHKKNlp?=
 =?us-ascii?Q?zbLzSfBIaQ5cK031bmyIpltjZkY/UQXEuUxGdrVXCpUp/U9Llvw58FnWKsmw?=
 =?us-ascii?Q?nRRa4e1YAhjUS2MBtz9dJlhPn8KZ/p3bm5VFferaKgMDQeLGqJBo48ifBfGC?=
 =?us-ascii?Q?KvDE+xI4z1tSGBQmEtdzDGyzsf1EyehAaZJ0q0nkq3DoC6lhri8J8nmjqRqj?=
 =?us-ascii?Q?85qsmR0Tk+PZCqyomDpJh+qcupRYnfkx1xpbJmeDGeX38+52FALRGpo08UUe?=
 =?us-ascii?Q?7JTuv2a4AJMRdM7Bxn9lCZubgPbM6J7tl8lToJSG77Dbn4tiiok18wNnVBuB?=
 =?us-ascii?Q?4aLXNYjb/M9X9aI1kd0Wa8ZT4uCmSW5Y/lNKU1ITpoBuo007p+Cfq68u8WUn?=
 =?us-ascii?Q?GiR+TYICImC5izSwbv1zCtrKQ76YWNoJDwh7PkOkvy4EhY3BbUvWk7DK0Uiw?=
 =?us-ascii?Q?6SJjBasTbosr1BjIQS/aVigXiwyVjCpVQun7P/u5IvjqDMx+rUQOD9HdzCPG?=
 =?us-ascii?Q?j3FA78syhPV0vVURSnnY21VjCkYzL+tO0iIaIH8xDDnQmXTnZ72FU7BFWSPD?=
 =?us-ascii?Q?4thSRHAMGBkLBRby+fu4QW/th41AXBppRygItpVfDS2bF3L8jDwYxcMJyDiS?=
 =?us-ascii?Q?Yo+gsEGSBKyA3jxNshN10DDcOVQ+XySlDVLYsIpRQmfwctVvA7B7uZvs20bR?=
 =?us-ascii?Q?qsUUC61dPCT1ywZI4oeJxOAXsQALLNdDBWGvsmSXFnEvghmccrH0HaR8rweK?=
 =?us-ascii?Q?08beMQbk4akqa3OwvV1P2OPQ9bdRwF3T8MnpFADeomVuePo7IHl9CTVx6Abb?=
 =?us-ascii?Q?sdk2OWIs+xdrzW32khPKJSyIPsLD7AcjqMBTPy6f9aCclvQqm0V0sZf3dOek?=
 =?us-ascii?Q?6k1ab5R6KGGgFCAXbJnvE4f4u6lVHrGHwFYCi/Jfw6KUPAZ7E0tK5lo0C/wj?=
 =?us-ascii?Q?/zOHLJQe3s5FfZN5sInOr/W7j87DWg7ieifiJvor8qv2f7DcakgSQSIuyrjy?=
 =?us-ascii?Q?7TWGOTjTTQFOqeuK81H66EzPaykKxYqqb/x2lbG6nr7ZCiqyCWf4HStQjqDQ?=
 =?us-ascii?Q?RaAFY5iatJukKoR8xjb5nhHgY0gcss5W5jQXaKieQVlag4GnGsYaKf4r9Gwa?=
 =?us-ascii?Q?LQJtVwriWiyvEITq1CVdF2YBHy4ij9FsvjldkcSp2Af1hLIjfwH3RRQBVetV?=
 =?us-ascii?Q?TyuFJGkI1S5RoLOGmhrwgAwxHK0Meq/xlDBkieI6lIeI0sSuU2ums4rpEbAw?=
 =?us-ascii?Q?qx1yvHXeYVc3WWUUv+Pi2FPL/WEzaedmwrOsE4OQk+UM5d23/vkc+5RWu59I?=
 =?us-ascii?Q?mi4QPBYhQ1q+PVg1DHbOwjcybm6WF9wY96GjzwblYLJdHUEb82koDH3gqMsA?=
 =?us-ascii?Q?QNBteLUXQSRmVPaPjO5053YfsM3t52J7EHEiBWbXhb+gJFDlOofcZd0rRXV9?=
 =?us-ascii?Q?lTnhJD8p57n0vSxwRuIQNlX28+13RF5JvYyGJm8QdbR0OCWb08LQbrClq4vN?=
 =?us-ascii?Q?wQ5CmUXUtKmExem/XyWZV3G6oheGComAGRQ5dZzk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7550869a-0c10-4812-adcd-08dbba6b785a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 06:24:54.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IaFqajJ+Vlswm+GBBFLdVWWZBxxVjTXN0e017RrFIsUnJeWGlGGjmCA1QE7P79TPdKObu9WtPBcsU8ZcPKN1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second parameter of stmmac_pltfr_init() needs the pointer of
"struct plat_stmmacenet_data". So, correct the parameter typo when calling the
function.

Otherwise, it may cause this alignment exception when doing suspend/resume.
[   49.067201] CPU1 is up
[   49.135258] Internal error: SP/PC alignment exception: 000000008a000000 [#1] PREEMPT SMP
[   49.143346] Modules linked in: soc_imx9 crct10dif_ce polyval_ce nvmem_imx_ocotp_fsb_s400 polyval_generic layerscape_edac_mod snd_soc_fsl_asoc_card snd_soc_imx_audmux snd_soc_imx_card snd_soc_wm8962 el_enclave snd_soc_fsl_micfil rtc_pcf2127 rtc_pcf2131 flexcan can_dev snd_soc_fsl_xcvr snd_soc_fsl_sai imx8_media_dev(C) snd_soc_fsl_utils fuse
[   49.173393] CPU: 0 PID: 565 Comm: sh Tainted: G         C         6.5.0-rc4-next-20230804-05047-g5781a6249dae #677
[   49.183721] Hardware name: NXP i.MX93 11X11 EVK board (DT)
[   49.189190] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   49.196140] pc : 0x80800052
[   49.198931] lr : stmmac_pltfr_resume+0x34/0x50
[   49.203368] sp : ffff800082f8bab0
[   49.206670] x29: ffff800082f8bab0 x28: ffff0000047d0ec0 x27: ffff80008186c170
[   49.213794] x26: 0000000b5e4ff1ba x25: ffff800081e5fa74 x24: 0000000000000010
[   49.220918] x23: ffff800081fe0000 x22: 0000000000000000 x21: 0000000000000000
[   49.228042] x20: ffff0000001b4010 x19: ffff0000001b4010 x18: 0000000000000006
[   49.235166] x17: ffff7ffffe007000 x16: ffff800080000000 x15: 0000000000000000
[   49.242290] x14: 00000000000000fc x13: 0000000000000000 x12: 0000000000000000
[   49.249414] x11: 0000000000000001 x10: 0000000000000a60 x9 : ffff800082f8b8c0
[   49.256538] x8 : 0000000000000008 x7 : 0000000000000001 x6 : 000000005f54a200
[   49.263662] x5 : 0000000001000000 x4 : ffff800081b93680 x3 : ffff800081519be0
[   49.270786] x2 : 0000000080800052 x1 : 0000000000000000 x0 : ffff0000001b4000
[   49.277911] Call trace:
[   49.280346]  0x80800052
[   49.282781]  platform_pm_resume+0x2c/0x68
[   49.286785]  dpm_run_callback.constprop.0+0x74/0x134
[   49.291742]  device_resume+0x88/0x194
[   49.295391]  dpm_resume+0x10c/0x230
[   49.298866]  dpm_resume_end+0x18/0x30
[   49.302515]  suspend_devices_and_enter+0x2b8/0x624
[   49.307299]  pm_suspend+0x1fc/0x348
[   49.310774]  state_store+0x80/0x104
[   49.314258]  kobj_attr_store+0x18/0x2c
[   49.318002]  sysfs_kf_write+0x44/0x54
[   49.321659]  kernfs_fop_write_iter+0x120/0x1ec
[   49.326088]  vfs_write+0x1bc/0x300
[   49.329485]  ksys_write+0x70/0x104
[   49.332874]  __arm64_sys_write+0x1c/0x28
[   49.336783]  invoke_syscall+0x48/0x114
[   49.340527]  el0_svc_common.constprop.0+0xc4/0xe4
[   49.345224]  do_el0_svc+0x38/0x98
[   49.348526]  el0_svc+0x2c/0x84
[   49.351568]  el0t_64_sync_handler+0x100/0x12c
[   49.355910]  el0t_64_sync+0x190/0x194
[   49.359567] Code: ???????? ???????? ???????? ???????? (????????)
[   49.365644] ---[ end trace 0000000000000000 ]---

Fixes: 97117eb51ec8 ("net: stmmac: platform: provide stmmac_pltfr_init()")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 0d9b2138b60a..3c6fd9027934 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -900,7 +900,7 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
-	ret = stmmac_pltfr_init(pdev, priv->plat->bsp_priv);
+	ret = stmmac_pltfr_init(pdev, priv->plat);
 	if (ret)
 		return ret;
 
-- 
2.34.1

