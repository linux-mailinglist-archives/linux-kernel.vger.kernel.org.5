Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7A7CC702
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjJQPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJQPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:07:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C05B8B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhmujtX2J5qkU70UcQWv7fBr9oy5DCHx5eGrYo55f7TO5wzYmrU41lavDlEN7+iT4h7KcVHhRAwMutXVadgYg1RApysOTiEtUoyfAZl312ePQVkSeIyLVnFRNLWmjj5gkmuupK/drk6DwNmE9uU7brNR5kLhlGi/tTxtL0+DIbEmB0aM0SIHqtaSC/+oHpcPmYmuoa9daeFMuEIRtElDbVX69TnYmNyTCdyhywWmko2W2UNwwjuyE0RyBQ++/Pe2AB6/rdf8NTgUgxdOdPhgTt52LOyGSRoH9+avnf1UTAscxKQXxBW51cBqnBE1UbymzfjBLdcWCK3CPs31Mc/2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSRX9AOe4w7GT+PDzYAWMN/w7bfTbUeaFjIVukr5Hk0=;
 b=QIltvn//32eDdi5mOfZA/5eErlVHTVCvk4GD1rXbuJwugnMnx4JpOy5ZADsSTJ83f4MVjBnYfRYnvf9JpeF662F3nYI1tVWnibZ3TCRUridZ3kr+ylf4oonG95A5tMTDLXx9JCSGdCFL+d9W1MtEGlXjnjEnSqbjiEPorq6nvqdn2mQpWwp7AOBTWXP2DJujpDKIAh0DjZ3/j+zQCzj9+XIUxT2p9FRu7vybvkArahUkPV0WOkT6l4Lec23sXeQMmwP4mhR64i6Yw/Ng/vtkhkFLvKplIOtAltQKf+ez9SlqiMzKL22LcX9pgyPjM1YflsuxZaA5B9UaX915bdf3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSRX9AOe4w7GT+PDzYAWMN/w7bfTbUeaFjIVukr5Hk0=;
 b=LC69zAANS+vFusXTII5k0C7JB/YKXA5JCSH6KIwXmZnYHDgdsB5klIE6ffNKGGo7PP9pdhO6nrjpmAHcY60gsSbVLBRvr+/bs3H9HKuRTbAZ0nrG3Rye3UqLGjDH6F2N7Q1tc0cWSgoe28TCMXsQwy7We1vrU6OmsnZN7f88xHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:52:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:52:05 +0000
Date:   Tue, 17 Oct 2023 10:51:25 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/5] i3c: master: svc: enable hotjoin default
Message-ID: <ZS6fbVtbuBH32aRU@lizhi-Precision-Tower-5810>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-2-Frank.Li@nxp.com>
 <20231017160457.4f0c2490@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017160457.4f0c2490@xps-13>
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 116f4e06-77a4-47b9-b4c3-08dbcf20a0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If2tCeFEOdjlLpye3+r9RAP0XUi4FglQPuJPUpf9BWeOespB8wQaHxzWm6zjU7J0GjSVNfk0W2ba+aB0mmsZuVpvPjQACxjD5DA5Hi5PzdDBIS7tkqLD7nTNICTM7VzxM9e+sULkItK4ECfFSLufaPdeJvSN+k6Ljq+XPImqnDINUPKB3HfHSSESXS+IwVfXuwgyNTdCkx14WVSCs/o7sWDnuTsChmCyh/RnfelaAQrgVlfnjepZbNPLt0N51u3hQ+/NznUia8rV1BrXRgkCrStx1FEf4GFUGexUJW2CLAWEWvXasO0eoTUAWbM3d869z8NqDtBUNcxeCFFS8hwLr9KHTwUBV8kSD04WpWNEkwtqI+FHxbsdKJQjAAKUVWR9u5ANL5srX2YeQYS9tilyHtl+XMAhL5x3gwfAi+L5pEKNL3hciaa2CRJe1gNWtJMOLfk1c1nAP9Y3yuqq7vDFRQ+/bPi+T3GLcsRqJAcIW6UvsGg7J+K1qgSRzzhbRTWd8x4WA8Vrn2wD0mbL+6y62eEgNGrlQt+szY2iKpPgVoAhQseaX+rMy9HdY4Up2ap9vTWXi0An0ndKTIdQEu1h8j7vBJSj0i9bFuoJE5t59XUbbArbX+lVMeNxFs5HjHS5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(4744005)(41300700001)(6486002)(86362001)(2906002)(478600001)(66556008)(66476007)(52116002)(66946007)(6916009)(9686003)(6512007)(6666004)(6506007)(316002)(8936002)(8676002)(26005)(83380400001)(4326008)(33716001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?i9P6xqlWxocV2WXbjkMA9DSSbTP04jF06yYcl47IrAap0uhQIh+XDfLPU/?=
 =?iso-8859-1?Q?WoynIdIIyu92ooZWJSSZhDvO+7tcrrXTLEEEi60YJExrO3j6YHJrxUjC/9?=
 =?iso-8859-1?Q?VxhntmrY9lnvamimqGrskeCKQ2mzU/B/TFjspNteUSrRtUM6tx/zv66xbA?=
 =?iso-8859-1?Q?FrCDGFiklOXhyTtl8nVqLo8HRMSs5A+PxUgUSLvnHBbrGhUzhIJVe/01oG?=
 =?iso-8859-1?Q?9GarWdtiLOMAOQU8Aukg97O2q2u5BbjA/xxNajLsnahWBtgr8AwxuHTsmn?=
 =?iso-8859-1?Q?ZcdU9v455YquZtlV3NooajhV9YMpZ3tVRZtfT/eCdObvQzX0HyE61ktr4K?=
 =?iso-8859-1?Q?416LlSXsyYhmgjkrWrMm9Hl+Fe9sswInX0vsly0xxxATCXb0pTgmLGjQ29?=
 =?iso-8859-1?Q?Bod/NdhvA3nuqodPYpYKmbNyFXrdZNlQoAx2UuDiywkXhIyRjZ/fcuEHiE?=
 =?iso-8859-1?Q?VPYN7ZpBlUGApb4ZgtzxJ6qbjR0eUntHjMNXLzeUSW3aLIQj2LCjs6mV3U?=
 =?iso-8859-1?Q?uAkMWxdwWnEg4XZY3A8XU+pHs3spJiVKaHbhpBBMKlt6WegkHKNn0tj8FG?=
 =?iso-8859-1?Q?edc+OFwxTHuuqQ0EoJugM8swRAMv+f4IUvj8k/sgwZNgSd2C/sbDTotiXW?=
 =?iso-8859-1?Q?gj9tnac29bHh+ZTdXrWuZZDpdUhh5omhWN2J74Y7gqbj1CNeWheGr7elk7?=
 =?iso-8859-1?Q?xKHKv4/xvNuT7CugH6kLOHHxb/1V6Go+vl1z61YmsRZ2WOEBq7/LLKDKEI?=
 =?iso-8859-1?Q?DjkGk7mx/I0i58obmDo7y8HXxKLJjftM7KCuRNzEWv1LlqEf9d3z0VLr36?=
 =?iso-8859-1?Q?sOMJGwFXKm5xpVGUK/VRKtsxgP2WGdOEHkxV1DIbpxNfTY20VIHI6EsE7p?=
 =?iso-8859-1?Q?OvKY9Mxi7zj8QF7ITNNy1g4QVsUiriBH0etLlnoDL4uL4Unl/19jUoS2Yg?=
 =?iso-8859-1?Q?g/usYdWa6vi4UbU7NGlJMsiMmUmeQfHKDNhJ/ZgRMZja6u+2NndJ139K3/?=
 =?iso-8859-1?Q?JZw/wEfF2bKHp/eGce+ABCOdlUHV6d54+ddgjH4GAb9RzCfUE8Z+nU0q5a?=
 =?iso-8859-1?Q?GfrOMw11SMWINaqHZ0qq5OOwHM0XBPkXPrGK7K3M4c4QdWpuVowHLoikmX?=
 =?iso-8859-1?Q?VGtnzl0oBrbIAT6tWvscKZ6mU4N4ClWvWiWkdo1I206xRPt77W8lkIJ2ac?=
 =?iso-8859-1?Q?0jbNNFNVbKwIP4TE/P+0pudLHWghUa/oMOvezXbZIYh4ViGipUXqzXUo6Z?=
 =?iso-8859-1?Q?UZZ78rayXqfKQWecZ3oZyuOKs5T/ZQehDabgJZqvgj/Qzzw1xBV33AMpry?=
 =?iso-8859-1?Q?8QBROGMK2103zZ+bGR5eXMwGMw8DbAan1uuodwfLRLmsN/GFiU1YWimwqa?=
 =?iso-8859-1?Q?MNdOK3i0odQW9uTOq2C+Q+HITLCL1QRfck/uW5gYwc/SrB7N9D7ItKr+MO?=
 =?iso-8859-1?Q?NcnBj8sdHC3cibRg4UJGDg0QyKoZVBe5xEIsLorzaPvFetOTSbW0BLzB4J?=
 =?iso-8859-1?Q?dhFLF8txomI/q5x1Tf7tbM/J2fNJ5yT/7YfmQsXC85yNb+SOF9+0BIqx3/?=
 =?iso-8859-1?Q?3tbnkvQrvu65x3q4vk7IJVYGsyEaiPQL/NMxG0PxQe548uNqKngXHj/QeF?=
 =?iso-8859-1?Q?o7qo0xHoyhNfDus7Rvq0w1FPgYrM48cHy8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116f4e06-77a4-47b9-b4c3-08dbcf20a0a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:52:04.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phUMBZ+aHb6fVpVcaOI9jq1LntlybbEBI/MFh+IuaGDpqEKGevkYSBUGd/G0/IvoiO0R2u30mfNnbh+clmz5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:04:57PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:28 -0400:
> 
> > Hotjoin require clock running and enable SLVSTART irq.
> > Add module parameter 'hotjoin' to disable hotjoin and enable runtime_pm to
> > save power.
> 
> I am really not a big fan of the use of modules parameters. Maybe it
> makes sense here. Alex, a better idea?

Maybe we can create sys entry to enable/disable hotjoin. I think i3c
should default support hotjoin, but it exist user case that needn't hj and
want more aggressive power saving.

If create /sys/ entry, it need change driver/i3c/master.c.

Frank

> 
> Thanks,
> Miquèl
