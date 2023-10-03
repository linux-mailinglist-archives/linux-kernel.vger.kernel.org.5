Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72B7B7527
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjJCXhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjJCXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:37:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD576AC;
        Tue,  3 Oct 2023 16:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2dBFByFiUMnVEIAOX88wwW9yTpdwUN4RWv15FjEvlbFu4WYnj8V4n5Ku3VGrTXLrb8eZ82h60dpIvfB3TGNzwsi3YrU14zAE/LS8u4iVXuQ+qVI5VlcpNspeJ7RZWAns5+e3DIOkw1ySe8WiCqTfwJFv/pWSxDD+vV7j5qrRH4TSUCNkRf/pJDb4uQte6QHpLYXmWxPaD4aqDNHqezdnp8+aIO0gYuSftvrhe50xJbCwB+HB4cTRv080fE/+XTz/8g/ooJNz6AkFV14ho3cBsBL0YhaSbf0jwQIUK6Y9q2p/aethrrxlzkIH6dappdOhe2E2GYDKs6HxRMq8Sj+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GQE5y6qbcGwxSdTOva9AnZHoZpFkZFOwcN3pNNv0kU=;
 b=R3bJVoJ983Lhbz7xxftFtwF3C0fSvx7YYn+bI/agFg3fRAWa3++096ofswBWMVO8WUb9FjUuByQsrQrsKrFsatcZTFzXPu9X3/pJYHfLpMSLE5+6oD9SWl3TXrgwEIC+KvEY9vXqHVaDpcbCqhIpuGqFmkgGNNpJceMeY4hE3Qvb8xMrpvVqWtaMdvnIMkQBm5uBwvlNAzQMk09rlBo1SLNQqrNL/j54oTGolZ4N2Y+GWQl7ljWrhvqyHVQk/T7r4yc2WHhYxu01EAMHx5EZSDMtqZ5Vz8YYzlDf8oNdkcbXMJMQBEV5csfiruJqXkdqLQXpDHX4v1NU6ftILekT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GQE5y6qbcGwxSdTOva9AnZHoZpFkZFOwcN3pNNv0kU=;
 b=Ff12HbDws6sWjL9eI+NdgjlepYo79c6VO81wOKU0Pm0H6Dy1IUHh0mgBiD26E+B+YOGEcVC64XYypvXCRZrIV1WvnaTlbMBmGQIpx0PNfNuzXHrlkur6DQzK8AVPXi3Vdg4RjLsnqBmShWHmwOhxytVoTShgUsmz8Q/BzCJNST8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:37:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 23:37:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/2] firmware: arm_scmi: clock: support parents commands
Date:   Wed, 04 Oct 2023 07:42:22 +0800
Message-Id: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6mHGUC/3XMQQ6CMBCF4auQWTumpQyoK+9hWGA7yEShpDUNh
 nB3K3uX/0vet0LkIBzhUqwQOEkUP+WgQwF26KYHo7jcUKrSaKUMRjsK2pe3T0wGO66J7w2R0wT
 5MwfuZdm9W5t7kPj24bPzqfqt/6RUoUJDJ9f0Z113iq7TMh+tH6Hdtu0LU/LGI6gAAAA=
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696376552; l=1929;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VR1ydI96zHAgFUiMqFvBNx35vszsMfG8fXTfJpzQe0I=;
 b=zM7xv1LRBnCOB1p2/c9onEUzBWMjbxYveAXNojXlUxGXc+pcE5rEbeNWLV4xsyTeOVx3C0atX
 axYhEQCSQxXBQQKVAZ0QYvmhwgDvkHG7rmSLIQj0rWwYYt3pdZDkxLc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afaa3e2-c32f-4d17-82cc-08dbc469bce0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiE5hVJ/WXEOmladGkCaaCPFTvW3eCr72PFLKfLAgyXdGjh6rjtcasCkDbPd7hTyGWKKcdzzthlVJBZ8+ekh7QqpAwN+BpWcI+9MFaHDkb9yduBOUblCn01kWP1cai0PBpFARU1FnxxvrZHb7x9dl3M/skMxVOMr+4XmAvCEzap8Q++c2oYB0pZ2pkPb3G1vPRaxRPa/TikO7XEsLALNAWdZxZPnhfgagfgpPu5oxtf41oWrupoZIhkv51BV6Y59gd30tMZji83ucxqOg6feXUoh5QSvlt6NiTH9pxwO44s/M7TW42vfbx0nUpTMM0hAVTkokFp8fhCa+IEyGbVndAMCIztVb/mP29hlcg5gQpYEg3NiejRfJSdGrIKObTNbdEUKv+Rce8em29qf2pkyYjyO1SByg6be2J39GYfwoLf0Wk0kCr3Zz7pkYkqJkrL9YY5nBH+gd5ab9MpYnYGPApfcWgC20llZBZ70Bg2LYIVANOQfi0sJ0L0QfSOqXwpLLP2R4dXmI4f0rSM1TgdiuU69Phd1rHnmltS3qHc4ihYkYdM4o1JrZCh6tlPYVHrp7tzR4X5bFdT020lTvhZtawrRRddsxMjGrs8cc8+1zsmMyd89F2YkSqBfXaLsYUicbDW9CCULma6AO12plmsXzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(966005)(6506007)(6512007)(6666004)(6486002)(9686003)(52116002)(478600001)(83380400001)(26005)(2906002)(4326008)(110136005)(41300700001)(66946007)(66556008)(66476007)(8936002)(5660300002)(8676002)(316002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpCbjVuOXQwVXlXcGZqdmVGVGxid0pka2QydElTcjc1RXJaci95TFRoMTNJ?=
 =?utf-8?B?bTlEYUNsQ2JFbWR1REFhalBoUDBpTFlVTlY3VW5YWUZlcEhLT1ZoL3dzUUxX?=
 =?utf-8?B?SHlLQzZuRlFWQWJhUFFaV0UrclJSZ1FOU2xyeHlMR2xqb0hBTmpHTCs1SXNJ?=
 =?utf-8?B?a29aMUtPUkh3dlFOeUFVaXJpZ3BtQVlMZ2ExMHM3S2Z3N3JRYVltZjQxSFlo?=
 =?utf-8?B?NGkySmR5R2V5Y2cwREtlb29IUzB4VmtOaHVkR0tvdzFNdlhYSFNWWms0eVIw?=
 =?utf-8?B?QWRCNlBpTCtWYTA4Smh3VERjMzYrNGJkcWFXMDlFd1JOWDlhZERsQWhHWDd3?=
 =?utf-8?B?WC9INFNCclhONkJzZUIyZzlqdWZzSVk5MDF6UTFyWXNXVm94VG12aDI4bEZ1?=
 =?utf-8?B?a2U0endWQ3A0ampqRUlDOWhOL2N4K0w5MDhhSjZvK0NZYTBCUWh6UU0vYWQ4?=
 =?utf-8?B?OW5pZFg5bXZ5UUN3NXRYd1VhZG9tSldhVzFvaGNHSWxhV01mNVp2dEM2QVV0?=
 =?utf-8?B?SWgzSmpWYUkrczROYi9hVzNFcjAwT2E4amM2V0dFN0tGWTUxZFVoZHRFYW1q?=
 =?utf-8?B?dllqTEd2Rk92SHJUNTVhNkZQRk5EcVBOaHZhYlp2M09EbVRsdDB2Ly9kaUFx?=
 =?utf-8?B?RlFZbG1zT2tkS25ZdHdkQnNCNURLZ1l1dUg3T2lIV2hkY1oyZk42dzdBa21P?=
 =?utf-8?B?QmJFYzZ6OVV1MjVWR3dESjBnT2JnZGJOYkdUN0MzelA4aEp4eDZNQS9kd2xi?=
 =?utf-8?B?VDQwZXdlK1BwTjBOQXAvNmZDa3Z4eFdhdllDeVZZd3g2SEhBbHIrNEd5c3dE?=
 =?utf-8?B?dFJ0b0NEamp3WW80K3BPZTFYd2lURFZyRjFkUmlLODltMFhCNllXRG9sUVFE?=
 =?utf-8?B?U3hIREFqV2lldkw1Z0VYelZWeGpEcVhZWEtBdGZ3K2F3RnlweG1oZis0STc5?=
 =?utf-8?B?elNxcUlDSjhQdlhYWXZ6WWczZ1YwU0FTYklCZ1BJcDRYQVNTTmFDUEhvUzdz?=
 =?utf-8?B?UGI4QmZPQWllb1hFZTBtcnZzWDhxNEpnZ0dKazdaNWkvTGt4UVhERmN4R09R?=
 =?utf-8?B?cHhZeW5WajE1alN0aSt2aGFwZDYxWXdFRmpQaFJncWNONEtSd29qTUg3VVRo?=
 =?utf-8?B?cDVoVVlkMktvdVppeDdnaU13ZlJHU2ZiOUZWUS9pV3lYWVBCWnJ6RTBFdEpl?=
 =?utf-8?B?cW5jT3NEWGVCUWVHVEhqQUFhejVyMTViNFR2by82VEdJcXIwUWwvRkhvWjV5?=
 =?utf-8?B?YnlqT2hPWEUwNDZDM2owOGxtbGR5Tzd4UGFNMVE2K2grVG54VFZoVWI3L1ph?=
 =?utf-8?B?V283a1VjZHBVL3N2WDhuRDREMVNGd3gydjVpOHZ5TXNMTjNTd2p6b09DWGVa?=
 =?utf-8?B?ZUVGTkhzdEUwbERqSjhmbkdsV2pQbG5zY2lMUGlmd1huT1dTUk8yL1l0cnlk?=
 =?utf-8?B?cHdGeEIxVFVNRlNzelJ5TTJpYmt0RlBJbmVpb0RMUS9ZVnJaaTZQeGQwNmZO?=
 =?utf-8?B?UG1JdlhFcHQvaVBXc3A1NmpEblRPY2plQXo5SDVMaTFHUDZXZjczdk1JRG1q?=
 =?utf-8?B?cjdNUDJpWlBiYjdsYzl3WDdkaThaUnhRdnJsbzJQZVdjQ3hoU0wzWGVjTmwz?=
 =?utf-8?B?RWRwdm10MUZ3MXFPSFlmUUZJK2sycFNVUlhWZW5LcEc5NEVXZHpRSGE2ZHFX?=
 =?utf-8?B?RmpWMFdhTENsY013WnVXcVE4elZPcHJaVWg3dXhuOWlteGJHQzZYaHROOUo3?=
 =?utf-8?B?RG9Lc3BJNHZ6YVRnR09VSk03b1EzZ1hXRTNHTytjeDYyUEN3YW85ZFo0eXMy?=
 =?utf-8?B?YU5CZXpKNUJGM0cvdHY2dytBQ2lqeHRuOXYxVkszdjZxakRISmN3WFFFTnUr?=
 =?utf-8?B?Q3JabGtzUjRIVHQ0QzBJdkxIRC9JdkYrSlZRbWNPMWt2cGZXNDFsZ09ya3ZD?=
 =?utf-8?B?TEg2d2EvcjJBMTlLbi9qT2JXTlRKbTBocUZzdmN2VWg1K1Jqd1lIMGdwWWx3?=
 =?utf-8?B?eUczZWN0T1YwelhmN2xEQ3BDNHFyU0ZZSXJGNFJERENaU3pSUDBlWldEeFZU?=
 =?utf-8?B?ZmtnY2xQQ1BLY1JkQ0p4RndQZHR4N01mZmJZYm9UVlRPVWpFWDByM20zVE5Z?=
 =?utf-8?Q?nVTRBJpsOqOf1xjP6sgeelYHr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afaa3e2-c32f-4d17-82cc-08dbc469bce0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:37:42.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcUkvnCX+C0Jm/c5+6XwDSASSlOfbysYU1VxGjeYFv9LfWFVghEkwH+YxvUpkCbu7kNvHxZOG6SrM4HXkDXk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8754
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v3.2 spec adds parents commands, this patchset is to support them:
CLOCK_POSSIBLE_PARENTS_GET
CLOCK_PARENT_SET
CLOCK_PARENT_GET

Besides firmware api clock driver update, the clk_scmi driver also
updated to support set_parent and get_parent ops.

Signed-off-by: Peng Fan <peng.fan@nxp.com>

To: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org

Changes in v5:
- check return value of devm_kcalloc in patch 2 Per Cristian's comment
- Link to v4: https://lore.kernel.org/r/20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com

Changes in v4:
 Included Cristian's fix in patch 2 for get parent. Thanks, Cristian.
 Add Cristian's R-b in patch 1
 Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi/updates
 - Link to v3: https://lore.kernel.org/all/20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com/

Changes in v3:
  Address Cristian's comments:
   - Drop SCMI_MAX_NUM_PARENTS, alloc memory dynamically
   - Check clk_id, parent_id
   - Add comment for parent_get/set
 - Link to v2: https://lore.kernel.org/r/20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com

Changes in V2:
 - Add determine_rate hooks

---
Peng Fan (2):
      firmware: arm_scmi: clock: support clock parents
      clk: scmi: add set/get_parent support

 drivers/clk/clk-scmi.c            |  60 ++++++++++++-
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   6 ++
 3 files changed, 241 insertions(+), 7 deletions(-)
---
base-commit: 8b6022be4c6e3e0d37c3e1378c9ff0a2c8717b09
change-id: 20231003-scmi-clock-v3-ae65eb755d15

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

