Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A357CB3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjJPULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjJPULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:11:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB6B4;
        Mon, 16 Oct 2023 13:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l68yh6nLUYnJbmkEvW7cX+0HlB3kyyi/oHv9N5KOaJcFoirJU9F30+agtU3KdrVfFkRppDOdPKKVTu6ef9c5ezC0Z6IIsd4kw5bVHcyzr1x3pw6vZzNoYpDaO4VyTvzZhmSE4cuKlB+sbHM00RNpm095LETyVKNyahWMxPmCHeoXJ4gaV4CtwykJw7j214P5h6GHUtpchTeS3v7fpi/SNwIThV5ohDTn28UhEKbH9SivF6l5K0ebkjEWcZydZJD/PcvQQBMo75s8AVArtMfxF89eZOfR6aceEFaYQodfz/o9IZgFs1kkRLdinDINB4ECYuHOVeW1/BsNnJ9/5xlYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhb4LjXjhDZDJp0MoMB8JuFceS9wzZpkrKQ3rUx7Z1g=;
 b=HUkJCAVqzNOOFoAC5XDRlTHRUWcUbVGD05tcVu4IsXp0smfUI3iSOutK9GzTgYSj1spSgK0ZuaBCU8R/mO5NIeTtEezczConmLIW7nQzgW6l8WxB+FeyV0V3FbjR5+GOPMzj2af8qG/grbZdGL6chLODz0LRN7y5lIC9kjDgQJQFhQQ9iQCAygFOeSZI9w2kHc2H4MpSEj3kavUArtblF/neROgfgoou4/+DhR1jiKGNhwhAIQivkIakXs4m+29fqCNNEiggOq050vYUsLExBp6DOkVXQWl4YqQyqSf+/zDe/KEazsB/LVwyuT4HSi4NKnj/AKzpjAZ2JQkvYfX6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhb4LjXjhDZDJp0MoMB8JuFceS9wzZpkrKQ3rUx7Z1g=;
 b=p+qUTjSDi10UA4MLZJ7FrXytmwDwcZq4eqkuyK8YB7JrYRdNPlOqIyVfhCodQinsTVg0sXtjOa8kYMfIJbcrD/3CbL8SJuViOR2+158/nnusq3vg2Pj2jPuAgF1avnsTmJtwPCRRbxumJbFKpEplsTpROANN+BFn9FsQg6I1GG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 20:11:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:11:08 +0000
Date:   Mon, 16 Oct 2023 16:10:57 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        joe@perches.com, peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        sherry.sun@nxp.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Fix silvaco,i3c-master compatible
 string
Message-ID: <ZS2Y0YRPItYhUBXE@lizhi-Precision-Tower-5810>
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
 <20231016-chatroom-regulator-a75f1d8be809@spud>
 <ZS2Pz1HxUgrx4+0R@lizhi-Precision-Tower-5810>
 <6110c58a-8003-4889-9a4b-6a7d1821c00e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6110c58a-8003-4889-9a4b-6a7d1821c00e@linaro.org>
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 102c6121-8704-4e51-353b-08dbce8408e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZCwhQJ5t83j08Nn4GxGVSlq/ma9EGu5UpVunBwoXF1PhcpJhtIYxU44xoe22/zmOm6+UViqOBJXZONsfOGy1ycjlX+jik2pJOrVvd9RCv4Z6a5kYbuv+U7AGcJGawgRtlhZ16w8aCjSz0jWV825m/4ClkMaitZmZbpgKEo6T41rqNie3NoOrPaimcS9CxQbtiX2hTkV+Tcu/oXDGHg0xGa+jsng3aKKFIVnbHAJAHQBjUeO301nCntlTXgaoZyXBke0/uG8uIUubLNj41Je8txd/P+K/56FAHvOg7KI11Qt/03xJa2r8eRKiRYutKAlTDHaoVbk/JztwWpoXYAFbUF/DCUoKUokBypE1LcnFsWbemn41gzzenBbI7trsteiE7f1RuBnozu3VoAqPbWh8UWT8pOlTHdynKlmEyRXdA4998LtPLcZzFbE7bpdPMmh07Gr/LspPuHCBUfmmhms11kh2wB7mWqihVXZo7B/+JCu5m+EufYR+YQHXuGI3gf0G8tD3fbVyTBZuHTAkQKi1AglJ6EAfyUKgpgIBHZmt1k1k3FD+WYT4dRyxVKPLnHyovuHHQ1kK/BsziaR37GJHgihTtDKJTFLwVBMy2CnEVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6506007)(53546011)(52116002)(5660300002)(2906002)(26005)(6666004)(83380400001)(38100700002)(86362001)(9686003)(33716001)(6512007)(7416002)(6486002)(966005)(41300700001)(66476007)(316002)(6916009)(66946007)(66556008)(8676002)(4326008)(38350700005)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oqE0vA8ycYn9eVXs6qXnn6G5C1s3MQpTvGZZp6zYIHvh4aAaYW9RWcba2VBk?=
 =?us-ascii?Q?pe/0k96DvCc+aHtfzu5T1t5zdupeLGCnk1ZiQXstAGgwdK+Qzg/e+IJOQqCq?=
 =?us-ascii?Q?nQ0lXoCOiJKLIOgBAjjwB2a/Z03DKqxhfBqjMtUfvGhI1dAN+XIOLo4mLDzO?=
 =?us-ascii?Q?c7Qh22oyEpnm96NseOVoliSouhe/yivUNQyPcWNOoKbz49r7ZTIfmmuRrdDo?=
 =?us-ascii?Q?BzsJF9KMCwZ2Fw3+9sUuyngm9bG9ZgDnTvNCa31VJfLKMEcrGTWd0dhsGuNQ?=
 =?us-ascii?Q?xBjiDWsb3w+ve4VrjUMsEn3htG6f+MFfmsjLB1ln9hEqLqtBHkl5peY6cFAr?=
 =?us-ascii?Q?PMquRzrK1k/1A8kUs6qBiCJVDKFbycoRFwmVcyCk4zcH3y3xJGzTXItB6Q7i?=
 =?us-ascii?Q?xEYpYxvU8sCJbyxlP6p34WkgZnsc+49Zczy4oyUV2L1jvYsymuMI0oO8mTqs?=
 =?us-ascii?Q?Jap8wSW9QTenbLAEF9y6SjpuIVBWsDuFJSRLRnngUKRkKRnwc3HN9/YrUNeL?=
 =?us-ascii?Q?TFyDx/XJSKRoigO6O5eZ9QV+BYY7sJCf5TJj8pKq1qU7hoOblv99ujEEgExK?=
 =?us-ascii?Q?y+rgM0m/ADw4Cuc8zE8FgVx6v4DgnYZ17YgR/SaIUCJVWYGG9Gna5OZKpCXs?=
 =?us-ascii?Q?wdGjr+gy+8S0EOZDx4z7t25GkKiqVeyMwqtwsyAT0C8DCHd1ePVB/gINV1SS?=
 =?us-ascii?Q?Sm28EloLz7fe+jWvM0w0CQX529yaPOH8gTypZEzw3hU6tb9r5rbCjDoJW8Nq?=
 =?us-ascii?Q?nZDzpViwGPtc8i9cYXbg05e0009FXKNP4JiqhYVIBauDjY4x0ZGaTVN6pOB4?=
 =?us-ascii?Q?EHbk3sw01FqRLbWD2YPQWP6hQR+nbUQ1/L0DYZXZyX0YRRJ4dO7TJZL1BiXx?=
 =?us-ascii?Q?IzugtE9ahjTAI955Kb0u+6BMJRoZX/bHQDa17DeOTH2QMtGrDgX20+//63DT?=
 =?us-ascii?Q?3E4nRnN998RNw08Ht/DQiFUzWoN/kw+NUUJ/0+T0/wNRsDzpItR0W0jjwR4y?=
 =?us-ascii?Q?HzvLzeMV/5BHrAcdpU8g3liScu/AGyjrnrdEQmpkhuYhUrQb0aD6PUjf0NhQ?=
 =?us-ascii?Q?90wpYOvjFActwvxbTEvffkiwkr5eUBJSyLrycVimuYEU3fiUTDmkwdvzk+Ij?=
 =?us-ascii?Q?bBl/8TudBbPxokFYdzRTC5TqD6mGxQl/yiy18boXa2U3v4NF4qtoOzgeYSK2?=
 =?us-ascii?Q?ZzaDLD7NxR4Zyz2/uxC4T9RYnxh+qA+ivZ9/0Pp1GTrh2T5TopuQZrzMzxNb?=
 =?us-ascii?Q?/D9wFEPrWKn7WnFv0/3jQxUKjsoTJ1ofbaRRZdQ78C4t4VLPy/Nq3ko1QM6a?=
 =?us-ascii?Q?VlhogYNYOsd3RwDB3g09Pac9WzdEFZqInAaFvAEwoMm4l8xspMm6iXJBHTYr?=
 =?us-ascii?Q?lrVr5hKQ5PpKIf/EzFcinUKxPKHxswcSHUheQra+eFTucLzXSPdg2xUQYQvH?=
 =?us-ascii?Q?/ehq7rT2UAMwJnwnILzAFOEacHILcVb3Pt/yP4DAn9uh2Shx/OKp6daYgPp1?=
 =?us-ascii?Q?hewuIbUTeVtQIIunX7pcnt1449Zf8ufVOzjPDxazux+isS+oM/y4xOf9AWpH?=
 =?us-ascii?Q?TXd8yr8c6QCq7kVqUBVU1qU3RLnExaI1a8Fx9niq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102c6121-8704-4e51-353b-08dbce8408e7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:11:08.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJMqZulxdHkH7UxeckmG/xQpOhNaubWXE1I3jfV8bC9prCw7q4Mvye0syxpnzxs2LN0+22990xZ9G7Zv2Ib7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:57:18PM +0200, Krzysztof Kozlowski wrote:
> On 16/10/2023 21:32, Frank Li wrote:
> > On Mon, Oct 16, 2023 at 06:30:11PM +0100, Conor Dooley wrote:
> >> On Mon, Oct 16, 2023 at 11:24:49AM -0400, Frank Li wrote:
> >>> In driver, compatible string is silvaco,i3c-master instead of
> >>> silvaco,i3c-master-v1.
> >>
> >> And what makes the driver right & the binding wrong? AFAICT, this is an
> >> IP sold by silvaco & the -v1 suffix was explicitly requested during
> >> review of the binding.
> > 
> > The driver existed for the long time. DTS files already use
> > silvaco,i3c-master.
> > 
> > There are two options, one change doc, the other change dts and drivers.
> > I think change doc is easiest ways.
> > 
> > If there are v2 in future, we can added silvaco,i3c-master-v2 in future.
> > 
> > If everyone prefer change drivers and dts, I can work on new patch. Just
> > break back compatiblity.
> 
> No, because Rob explicitly pointed out too generic name.
> https://lore.kernel.org/all/20210111200821.GA2978830@robh.at.kernel.org/
> 
> Is it some way to avoid implementing feedback or how does it work?

Downstream use silvaco,i3c-master to match driver. Anyways, miss match
happened.

option 1: fix doc
option 2: fix driver and dts

what do you perfer? 

> 
> Best regards,
> Krzysztof
> 
