Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E235F7FFE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377171AbjK3Wo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjK3WoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:24 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9349133;
        Thu, 30 Nov 2023 14:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKYnUGV5bFWYmO4cny2IUagZliHJ+W6weCz6ekDevp7SsynRze60mmc3ROfeRw37F6e+YRjfI/U0r/yN5fmQlr+32oKM1u6FVVmgfO6dVRbl+sRw6hjFS3rnNUQNNa6Ym44bbIACw9f6tWZzWtUfslsB2ZYgHsm87DSQISH6Loz/tgOQa+14iCNsXRAQi/x+GvczZBoPcwl3AEuNG6htTqQ86vG0N8/8WUyAAEclEr7q96XmqvnAH4E4fkHzZfBCKy1Sb4+sYjo+9TsyAWXuubJJB4w6m1ab8AdnFmY9RceOQNM4dyh2yZSYQF8Ya9161T1VjdCgHkNqnOEWehKZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auhEZvg2cwSUCUZ37pMz5e1rjA0vnD1O945l29ni3DI=;
 b=NN6DjVDIXtW0TC2qdld7IC28Tc7klZqsidk+3XDfBHw/x/tGSTRJqEQQwkr5g4lYfF+EYF5HkQ3REpcuJcOnhzCSVqkRoqrrE1MKtz98JaBWAr22JPXK00Yd9Ht9GWp+JorvrKBP0BAwPAC+lXAxtF23LjPvduLffrU5rUb0EJ/5j2KVIo8XkMgzzmPMCuuH9Ls3vmAk+n/Z/CctqAyYObmYSnR5+QD2Awg83DkC1fpQGjeOtE1Na/uuZRaEGL49vvAf3LXc3cBAM9WnRXUZ7tOYsm5Ip2G8/AGK9GdmbY5de1XhunsCSmQH099i/NBRMzXl12hgTGgWoWvjqgrZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auhEZvg2cwSUCUZ37pMz5e1rjA0vnD1O945l29ni3DI=;
 b=Hzn/b4xQow/TWb1MawUY4koqOkyRNPbRvvIU1unYIQh5tr42DIoEFHyaIBhF12Zbk2DU1t/RLrH09bd/ZFvc2BvE2NDvPO4YUSJjyVlO4vgwXvw5FWDOWWN5EvB4j0/8SEAF8Esnz2TafxW3NqfYCJXtGJUdC2L2paSRahkVVdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 0/7] i3c: master: some improvment for i3c master
Date:   Thu, 30 Nov 2023 17:44:01 -0500
Message-Id: <20231130224408.3591288-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b4219-11b3-41cd-9354-08dbf1f5e916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VspzinlyJNj8oyTcqQgimLwNv9muQLujhUQUHHIpwRc6lc0BI+bYhWX0GWeGPe30cHrDlpMt9afvEQuw7n9UzjpNwsAHRd2LydN21jxf8tL/3l5Ut+fYzCaB+O7ByTpM4vGJAy/9zbSIKEV1UKbtfuI3asQx3i0kxk5zgk4rgLhpIWejx/TwqmoLrWYfEss5sTf9Geqxu1Ru2XJ9nQaaMbD/yc+kVn4Csfx+Henu2axHgNV3W4vQ8lkUN6Iq3jYTAoxMHqm4YTH2UaLBGnVCz6gTSqF1dDQrPeFz0kjVyH8V+ZncraIOR5veccxAK6eMOmRlA7f/yFkO+zuX3LH33qgze/Pm5LVXwk1nM/Rgj+YYGT0unJ36qLCCBdu11tFfpnm18BCjz6teO7Ml7B86n8AOr7QvCRHGOc4mrzUs82dN79bTp/kDR6SlrX4/VaD3CZUtMX4TCnY6L75/TjUbGn/eSw8U9VImHOmhY6ogYgtbxKh+uluigCi2Bghgjp13S0o4gJMDrJN2jS/Zjm3WEfqJ6AHAAjYBgq4KXH02IS1PPTuJNdL8Sk0hEeVuyFi4LWNOjZCW4aLbxYXDCQz0tSz31WLOjk6cCOwmkZpM0L26Bk7tQtLPGB9cH1if1sCkzLSym7l4IlhEjrjaXjn96NIdqXCyQCjDKc4V0W/Hlr4qZIXvLswQy49XzOwi55Cr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjljamplanFRek5HTEpUWThmczFzUnNYeVBhb2Z3eFBDZ2pJc1NqeGpMenRE?=
 =?utf-8?B?YzUyY0JXMHc3NG51cWFmdGJtdS9jdFZCdGwwUkZ4TGZjdWtwS0pSNDFEYVdP?=
 =?utf-8?B?cjhNZnNBUnQra0V6Y3h6ZSt1Mm9LejUvR0dCTkdrOTJqTmtka3dVa2JxZzdz?=
 =?utf-8?B?UnlUQzZOaklLcGlzK3cwYmVtNi9obmljMyttSUszODZqajN3RzFyQkNVTnJL?=
 =?utf-8?B?U0dHdUV1QUUvZEh4WHNXaUIyN3VjczBVVkJic0U1OFVZK1FlV0R0Skh4eEtQ?=
 =?utf-8?B?T1ZDejVVWVhpbnpUVGdScmh2d0dTRFZHeW1PVmJSZUhjeXBIekZhaXdEQ2lZ?=
 =?utf-8?B?eG9md3JmTnhzT2JQZDdMNXdid2wwZHVUT0U5bFRwMUpvbkRCemNHbFpMVHJy?=
 =?utf-8?B?M0tNWksxQ2I2cG9Pdk1pYzRKWC9vMlBycUFEbTdrQ3NjZnM5S1NhSE41cnNI?=
 =?utf-8?B?K3o4Z1VZN2tyR1dFSEE3b0hINm91YzJKR0NOdlRianplTWx4KzVvV0k2MjJm?=
 =?utf-8?B?MThELy9nRS9BOHpwdTVKdlJUL1FESTdUSUxxMlUrZStWLzIvQUlHb01TMnMy?=
 =?utf-8?B?UnJwRlRWT3dqdGE1dTZMdVVQOG1tYWZVcm52Y1JMdUVISWdTa08xM1BaM2lB?=
 =?utf-8?B?Q1ZybklKdHdvVjlKdmR1aUYybHIxdjMzblNBcm53elc3Zk5Dd2dNVFBsZzlI?=
 =?utf-8?B?MGxxS0JZNmFjNTUzdTRudmJjdXI3YkdYeXE0akc3VHRQbkxjYnlDNzlNd2pB?=
 =?utf-8?B?ei9QWXFndkpmUWhwVFo4bTVmZEgzdHRGYU1xYVNwb1QzUGVFWmEwSGVYcFBR?=
 =?utf-8?B?QkVRUWVqMnZWWGI3Q2g5aUwzV3czYmNNekdlZ00rN2FnQ0RXL254eUltOEFR?=
 =?utf-8?B?VERzbllKLy81REJEMWJhcHBFWFdzRWhvbmZRVkZRWjNWWC8wdVRUbm9ibWhC?=
 =?utf-8?B?RHNoSU1YM3ZzWW5od3F6SEIzOUUrWmluQnZBV3B3eGt0S2VTM2hTQ3pyU0Mw?=
 =?utf-8?B?ZC9BVGJ5RnJWdkk1SHVYTWZiV0hSOUI1Q3FMM1hJc1dLQzUwSDVySmtGdEdC?=
 =?utf-8?B?cUZvMzlSV1pjZkdGTjlIQUYwRGR0Z2h4QTZQZXlPQXpZWklkU2FvNlp6Yk5N?=
 =?utf-8?B?K09weDlPR04rNlM5bDNib0dtOHRIZktGRXZ5dm5OWGhBYkxWMzRKNjNlNENG?=
 =?utf-8?B?N0l3dWxUUVBCN2dwMFFzWUMrbjRpMWszRVJMbWgwdzJPSnRnOFQ3SlQ0d3dl?=
 =?utf-8?B?WkF4RStJTi9ZWVpXTkhzN1VWbktIZDlrOENwVHhvVGFma1BGM1dkRDdhYzNq?=
 =?utf-8?B?akpWb09EK1h6UWFBdHNGQjB2OE1QYWp6dnVIaE1BN2tOYUI0dHlKdTRMVFE3?=
 =?utf-8?B?djB5UXptNjBWUFZLcGxpMDd5TTN2RFB0cVZZN29CSW1oQXpXa0RXdHB2cmZ6?=
 =?utf-8?B?ZWw2TXMyWnR0SnZ5NlBiR21raUQvTEJ6T1ZreW9RR0JXblp1NENPT3FHVWxG?=
 =?utf-8?B?OVA0a2VGS1dyS3NUVE9FRGRUcnhTZEcxc2gxWExBTk5ocmtUUTZPczlVRDZa?=
 =?utf-8?B?WUVPTERiV2todWUxSHlOOFB1Tm1CWjErYWJyR2JVMHBJVi9mTVNMUUJCbGpz?=
 =?utf-8?B?cTh4NDM0UWtJcDViWXNZcGxWd2d0QTU2bkJrWjlZYlNXRDFTTXpPS05KZmxu?=
 =?utf-8?B?aERtYTMzZDh2VTBtT0tLOW5VVWFCbjZuaVM3eU1LRml2RGRmdzhxOVNQWU1P?=
 =?utf-8?B?N3h3Yi9XVVYrVXhoQzFabmhVTG82WWhYdXFPZHV1OGx0NnduSWE4RUVTNUFD?=
 =?utf-8?B?eTZuZ1pvT0xTUHRLOXNsYjNQNFhyK3N5QWIvNVB4MTlCVnBzTENWWTM0SXVv?=
 =?utf-8?B?T3Z0ZUw3d3d3U1FFbklOelFndnlRbEZpd2ZzcEJFRG9LQS9RK1h3N3VCczIy?=
 =?utf-8?B?RGpodG1DVnJwcmk5RGZBU2o5STlwMjJFTVo2ZnppVGU4RFAvSzBZRTIwYVJE?=
 =?utf-8?B?S0twc0VMQkJOc3dsbUdpbHB4UkVuUU10UGZRNzN2cXR5U2hqekVTZjZYWHRi?=
 =?utf-8?B?dytBRy85cTBXQlBiVTczSEU3bU85WDBETzlnbmc0TkE0Ujl3MWJnSGxxZlp0?=
 =?utf-8?Q?oW4w8TZ0GOqIXIvq67YHarT3S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b4219-11b3-41cd-9354-08dbf1f5e916
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:28.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yH9YLZA1ZWg+446iSxw/o+Z7LMlU+Dkb3OudbAwaHg9ZryTq3b6ASrpFpogJ9JrD8DLojlZG10XGxDQ9aW71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three major improvement

1. Add actual size in i3c_transfer because i3c allow target early termiate
transfer.
2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
3. svc master add hotjoin support.
4. Add tty over i3c support.

change log see each patches.

Frank Li (7):
  i3c: master: add enable(disable) hot join in sys entry
  i3c: master: svc: add hot join support
  i3c: add actual_len in i3c_priv_xfer
  i3c: master: svc: rename read_len as actual_len
  i3c: master: svc: return actual transfer data len
  i3c: add API i3c_dev_gettstatus_format1() to get target device status
  tty: i3c: add TTY over I3C master support

 drivers/i3c/device.c                |  24 ++
 drivers/i3c/internals.h             |   1 +
 drivers/i3c/master.c                | 109 +++++++
 drivers/i3c/master/svc-i3c-master.c |  95 ++++--
 drivers/tty/Kconfig                 |  13 +
 drivers/tty/Makefile                |   1 +
 drivers/tty/i3c_tty.c               | 443 ++++++++++++++++++++++++++++
 include/linux/i3c/device.h          |   3 +
 include/linux/i3c/master.h          |   5 +
 9 files changed, 677 insertions(+), 17 deletions(-)
 create mode 100644 drivers/tty/i3c_tty.c

-- 
2.34.1

