Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF85E768AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGaENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGaENT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:13:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B955E66;
        Sun, 30 Jul 2023 21:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIbNosl+X43zANRlS6hhAFvX1lmw7hFlATPmkufW/MlmeFNYiUMWOoa9CsY2DPmLrpQvF92gfL6b2jAnFax/uXOnTFT8OKmSM2lYAm5YMa7zhKvWmQBXPykoS4usdB0kpOl/WKjyMvbjYVkLJWIeGMBBOp2a7Z0BQQutbCySwkXS4rrhkmQUNLK4GTodnGyeNLdGqHccibsZBaWv5VhQ5Mpwkw6YOhPyQjFazVYOAgwl7Dj4WT11SXQ4BCD4cOlToFZ+OT6gjhlj2/z8WRgiufuaymXW8DoF+flvjemxQKLkG/StmfQewXOMlUEpYrchO1eZoBqPqtJ0aQb/6QJznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S46MoIUqF+Cffugwc+OdaUDRKmub6VxBs/Zsc7zdvQ=;
 b=RXf/GYmeSTxg6HHcPVKdSrgxDJVgfsFb0tOX1WqTA22GmLbFjm/xd4jBJQCWRckUzzwxKIHajMH6vqBbVEQ9yunqxU+2Do8/5VS5gdHoVr1PIJsLVTYlrT5zTGnpfgG8wPAul17rXAiAGP08VPdYRKOuYbqpweyTR8pA6F4SmUpyyBn89pFxawvw1JjRmKTlOs8cz+mkV05D7e3o0r+3MUOlZ4cxagC+kiJs8jUjnEPWFFK+4gIO6iyNDZIPe0lESXEoQ+q7m9JEXeebVl0k7LCR0/kiqjjRNgSXZdPNdMfA/fqm29oW8GVL965PAZYsPOtNJ+zwP+/VRBDlApSVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S46MoIUqF+Cffugwc+OdaUDRKmub6VxBs/Zsc7zdvQ=;
 b=A6LyRxXNqSgj9oC1qxFHY+wf3p98OdlgTIdq1gWF9U2X2D5AvXRjfWBE3fgwVtDLBuKAK/ldGPwoD/kDQJBFdihNTb6deDnANcKJcarcu9qt5g3ygwMCScZZtHK9vYNlP2TOaxNxG/O2OL3NDHOSV5HgJtch8ci9XzQTiIHvI6c=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 04:13:11 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::dc59:ac68:adf2:62ba]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::dc59:ac68:adf2:62ba%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 04:13:11 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: xlnx,versal-clk: drop select:false
Thread-Topic: [PATCH] dt-bindings: clock: xlnx,versal-clk: drop select:false
Thread-Index: AQHZwXTh930+HZKxb0OJKRNByoBOT6/TR4NQ
Date:   Mon, 31 Jul 2023 04:13:11 +0000
Message-ID: <BY5PR12MB4902C87D6CB4442A262FCC038105A@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230728165923.108589-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728165923.108589-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54fa8528-69d3-4fdd-a80f-6804806543ec;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-31T04:12:25Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SN7PR12MB7418:EE_
x-ms-office365-filtering-correlation-id: d9621154-b859-4844-bbcb-08db917c7437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9cJk1zWRbTBe4aCIxe7frQ6YIY34gowds+q5zHG8HduPlgGeZTJX6EOCngH5l8p0q76TaVVOfApkyoWjrO9OJ07bmVvBxscGbgg7UzV+iksrA+dxuw8wulZfG2unVfsZteVUaHiW8SZW3OWgq/mZMf51DN/RsVRggyono0PrgyxhfVrhoqVoB1TbIIddC5eUjstPqxD3bXW2eZzmHGahT0Q/NbYNKYHMacKZ5QPZz7bkqDwNaw6lyA/kmSGQK5i5fUlUhCBdoBAEWWIzYR2I90ZxR0Bj3HqI42LGbq/Z8hqtdWekec/NMq7cSp0cxbmCBWSi89Chy2FJGQkh7S7TYVgu8HyL+ARBTH0FNoAQGJ0Jko5DKr/Zqa5pP3RdaexLwLWWn8BuS26OWkpx5ooJCFTSfSWFqO/CorhS2ASSJ8iWu7EpheUYX1qUMXP2hJCiTMfn2UuG+Gvu7fH6dVIQCwHJbljZmnu0fo+M5bHrtnJsA1yMFIVjwGNShhE3MYXdE7Zzc6txKwlBtbu94PNY1NzxUZMSOAcnMb1mO9ekMj3lSRfG1UI+YCfqu+v4BgVqjYzXNpSXYl4TzWPKxGVCITU/seIKZ++3X0Q3taTJI7qjxXCNJZNGkaz1/22GXNyhSwkMCFqWMcBRf6JJsTcSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(7416002)(38070700005)(921005)(122000001)(110136005)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JnumfhOBNXaEUM4YMJDc8PteJwwOnq5MSH2wSKE4OatocqQcARN7xMOHQQaP?=
 =?us-ascii?Q?mjjKksdy4tOXkreA89lXuzg0/aEZ+nOmcpUpcxbRJM+U0nZbqLjVCvzys7W4?=
 =?us-ascii?Q?3fMHTQXfn2JTkrHG+DHK/n2vq6InaipyAw/SAJyIFMfOSnuvvZtGULWdNy/d?=
 =?us-ascii?Q?t/YHgDAyWAYPrEHeuU3iQszERZ9VFaIe16xU3OPs7avOclbISrPeE8bsf9XD?=
 =?us-ascii?Q?zaOUHds+KMsX0RqX3vwm/zjvDq/cN+HgD0l1maPfhL2eI+8AttjGm2uy4+y2?=
 =?us-ascii?Q?ekoXTYjUONBhDGvO13RiYfyoMVP4PDOvI3pKKB6ozTvCyTyqKWnB2fQpMMX6?=
 =?us-ascii?Q?gueRIHxDP4awbCOAwHkgXqIsw3uGCr8Y/zSNOBzL+yvMvl/Etb88fnSs+jvA?=
 =?us-ascii?Q?BcNjRe6nM5lHT1fLEi/+2S2HQFbaknuJVlAK5kk/nM05CuHQx0YyLvzQe9UX?=
 =?us-ascii?Q?9YOavqDNzr2QBRz2zkWXmzi92BfTU3iksPR5M54FS0DeUparrkh5U7k3F0EP?=
 =?us-ascii?Q?0RNCOpXNgU1qxLG0A/7KdSvpAjmzqB8i4SEAg6GkvrIM9eF7ESVey/hEcQZz?=
 =?us-ascii?Q?ILPN4jkGzJNhvzfpUrioCeEo9Voz+CeWwKmbabP7Q5huPXSgV4mF/0xNDapl?=
 =?us-ascii?Q?2aeqH5pjVu6F1IqePJO7tnoM6dpJGDmnffWoWhTLuNT511dRo3Wv0de2YtOE?=
 =?us-ascii?Q?uGs7UuvHz8larDd+uv5XiVenCxAVmPrY7dfoMQsLTaQt8HfpuiPaOcvwGDw2?=
 =?us-ascii?Q?JkoXKGJL0PfnUboKKSoUw0yc+NUimrdLTvlAPIukn6VXKB+eO9IrGyL69dzW?=
 =?us-ascii?Q?TSElU/1cTY4Qn5r+ldHWG4YkJB+5lVbSVW6DfG1lne+KxEWtkZUlF25J68JK?=
 =?us-ascii?Q?PFehr0jzEwTagrMxVVQdwFL0bNMwECvZwpEnuO5rHCdG04CijlMRQwPcOd07?=
 =?us-ascii?Q?o1idPRTxVjyMETW7sLk8J7rwtjHcnZrY03nUimSdNLeUm9VpyzPvFFnCF2sE?=
 =?us-ascii?Q?4Lo2k6RSJ2IPvIUFe907FdIOqNHNfhUv/hKl7N5Rj9vuZmDrzEcd/K8tEI4R?=
 =?us-ascii?Q?2VV/MezWuc8A23oXwBX9JOqlFYXKg3aKNWQGyk58eR/HXLHVsN/1DS74C9yY?=
 =?us-ascii?Q?SSwXg42kscuZ4MNZ4X4qPk3tchY8w9xuHP0wqScNeEcO0JpTS+Ymfjs8pVuW?=
 =?us-ascii?Q?HC2V9/n+k2KHoX0JugRdHpBg1KlaEd8VG2gv5C6LL28+GMlaRRDDYwYschip?=
 =?us-ascii?Q?MA2JBSGXd/SRAESdvrxX/gY0SF5VvXDgwwWrElZAU5nTdofHKuSZQMWeBSId?=
 =?us-ascii?Q?Yw8XjJXz5rpLOhRNuE+qACcCL3ymnzXHkXht9zaSkIY2LmLLpI7L1tNIf2AZ?=
 =?us-ascii?Q?W1Mm9i1FxsebFJNAWsCui/ynNoFUMVTGafwc7uev7wVDKolBF15RGZWHyld/?=
 =?us-ascii?Q?oVibasewaF8qxOMSIID9E5np30xNDhrCqTfiLzc6P5ynWBTeVYI07cF3VHVG?=
 =?us-ascii?Q?h9t3rKM+BlcnkvJdPmM+yImXP18ieVPYPtw8Kgpvrsg6NxGgqGHYfwJBTYyl?=
 =?us-ascii?Q?/Jc5thBi993mEiBOUO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9621154-b859-4844-bbcb-08db917c7437
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 04:13:11.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIW40JvJD8403CDFBM16p3c9I3Xpx5f2erowPInAuE0UCvhzlx1y8HLo8fjjNF21TSI8ua52X4umzzgcCpDq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, July 28, 2023 10:29 PM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Simek, Michal <michal.simek@amd.com>; Rajan
> Vaja <rajan.vaja@xilinx.com>; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> stable@vger.kernel.org; Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>
> Subject: [PATCH] dt-bindings: clock: xlnx,versal-clk: drop select:false
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> select:false makes the schema basically ignored and not effective, which =
is
> clearly not what we want for a device binding.
>
> Fixes: 352546805a44 ("dt-bindings: clock: Add bindings for versal clock
> driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

