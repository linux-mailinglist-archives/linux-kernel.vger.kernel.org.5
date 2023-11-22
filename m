Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380767F5108
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbjKVUD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKVUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:03:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785718E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:03:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtTtt42WfG2XIA7AqmOWGyemk8ZhZ9BAnqLtEYMJoT6m4QepgR5nChMjdM6vpmbj29+7j0/mP9EbNYcLgBb5bobXfkSVBPD5Aum31zJzsXkT3bJcv5hxRc+b6bQtPsARNJDgPcPwu/Y3LKXmDk8jySn+mXdNdwp5brCGr50W0FGdQDnp8VZESCagRmI8xEhkkDGRmGxih6auzvmwhri8YkXBWIvsm2QEAxLHLfENZv0LLctt9zle2fqWw3FaREVPfs1qfLtlsU7T+74ttn8jz+tUgork8sBNo+lZWHwWW+h/T4u8tmTsdot9pp1cbfxsW1kxJ/BY9Fkve4KRIo2DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82WC1Qjg3bcWEXWYWitYCa0EyEY7pVXBXoIISihJ0LE=;
 b=GZWQMQ2TTzGt96cnv0KMp0V6N6oGWN2+lyeiaRK91CVdbIMwkm+/F0/URmj21ojOrycV8Wjg90DClJzCBGRLpKLaqmhsKQPFwrInL+J4HQ6acPWsTOv51NezpPtefLtr5HjloCOv9FXoLf03msaOHb26mBWrhclcTEs/kwm+cDKjR1c4gTfEb4E4XXajFhy712PLNLANKaPxj+/wRQbikNNGmLJduv1AhhJkeEa29CMTKc4TYAZ/4NIKbikAe5zY9V1bHVvi8NdYsTBYVT87WG+7v1kf7RT5d3veJ4fuBth4PKXeVhQfRf4NMZs5+6GzskPQ3OKKWIHhrOCr1UbWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82WC1Qjg3bcWEXWYWitYCa0EyEY7pVXBXoIISihJ0LE=;
 b=PsxY860FfMIBbgph/jjUJ48YaL9dcABPacdKbH/5SH4XbLvym+wfZeyrCUPlyo1OQp18NwF+HYFwCdWdbEdYuQ3CN6L19BrAFtgLXyN424W5++idPmIdB5TG875aBgeDU0tdVDx/0kY6F0wYKA5ppYS073BQhpP38tc98l5NzuTCgn+QCRK3sahtZCJveI3S5dACFZu/PIaCG4hjVSVtTLSMh04taWP4y7KPn5aauPalUkze6XBc6LKMhOW+wHQ0n+kLNjdK+7zcfMMKIAUJafn3iblXWiAnJQzHIA4tNhM3MOE0zVBGS83JhI+B6fHccGsCkImEZWP3nOFiWffEkQ==
Received: from PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 20:03:20 +0000
Received: from PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::3bcb:91ce:4206:c579]) by PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::3bcb:91ce:4206:c579%6]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 20:03:19 +0000
From:   Chun Ng <chunn@nvidia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: [REGRESSION]: mmap performance regression starting with k-6.1
Thread-Topic: [REGRESSION]: mmap performance regression starting with k-6.1
Thread-Index: AQHaHPR0v+xZPq8pBkqP4B8aQrrfrQ==
Date:   Wed, 22 Nov 2023 20:03:19 +0000
Message-ID: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7937:EE_|SA0PR12MB7073:EE_
x-ms-office365-filtering-correlation-id: 467935c2-c525-42fc-f082-08dbeb9612c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpOkz4b6y4/R49oO0P7rwubuS0zCzl9L1X93VBPjpaEq0PpwKlwjoB+zM6Ljg5IoREf1GwO5+i3WZQagMLoqZxUo8AOiAfrxmthIDGgyExhiq1nfJz32AqHfdNWobGl/V/+pDrd5ULIjv6+023Ypn8Hd2WwchJiaoUZeKSdPGIz6HcM0o4MDyB9Cw36b/vCN9orWBHzAvnl8Mi/SVA6Q0JiDggBOCP8bDMOtREHTrmBOBp7sUvaOTG0k12NZx9AHKFS02v6wG3dILWITDi7fw8rg1JsuCR/pf0m9zF7vv5RkrDn6UYXHSPHwbWvYTc3UT3eoDMr5VOpnY8D/AJOha8TlT6IvFzBDl1eyQvG1VTpJtT2IdZMuQJ6AFnCPRwGZaP90gE1rWMBfyv95L1Yw6byftgtze/EtzdOSLLpgBQ2svydNZCmmWIBW9M3RFQK4KvLn3gwgmQhr2rDeStEFz0j2WnG7JXu1+LqpFTVIcsluPUxa77i1m+5olIcydenVjI+mWOCx9/934bJzzAkcwIkO+Cg13Qs36xKbcIVllmcG49zn870nJsoH2ZiZXPEekQpsErcgm6La0pyMoNpWcF3NZx5TliBGjHi1lM8j3IgEFcviQQvro1R38Q1oAwvn5WcUSXZ/kAQ2jPr/veq2NQoBCOT0Jgxn9EzLRVbOyRzoY19QlRPBP1cuPN/FrKn8qMCLZaaDrmKtjfDep2IZP5nwu7Uzk9TuxlBRCt13kcQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7937.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(55016003)(8936002)(41300700001)(4326008)(8676002)(52536014)(5930299018)(5660300002)(316002)(66556008)(6916009)(64756008)(66946007)(54906003)(66446008)(76116006)(66476007)(91956017)(107886003)(86362001)(966005)(26005)(71200400001)(9686003)(38070700009)(6506007)(122000001)(33656002)(478600001)(83380400001)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FM9P10Z/q3nspeN6TRBROWilXUJWbfWU7cT/mmXTBN8YyV7kCaIzD79M8c?=
 =?iso-8859-1?Q?hwvdbtElfGlY3ZOByJFYevP9hEhNCMfpg4SkBK0f7qs11yjNLoe4Dxl+5i?=
 =?iso-8859-1?Q?YYkNmHkCRL1A/ByzsjWz4xkyWN7siiAg5NfPivt/NVZmEF7syuaPwVQZ0F?=
 =?iso-8859-1?Q?SLKaRZ8Mc6kq3I+8nI4Rm+u7RfqUFT07xRxjAP2RrrpCEObU/zB3HN6Mvz?=
 =?iso-8859-1?Q?Y1Mk3jKXdZSwS593FHMN1mma/dKkyPW6lU1EcJQ8CwtSa8oSvwUr+ZY5fY?=
 =?iso-8859-1?Q?w3QAcIAVSdZofHFKkMsPmtbqbwEDyRYsgICcbhQiSLwuNv9U1yfxwMpnVO?=
 =?iso-8859-1?Q?CWKWeq/ULPUYF2rEkY9mM+NU0HYofh7vmDpLM/WenWrciM5xCEfl8Az65y?=
 =?iso-8859-1?Q?ziycqYem5o9v1rspbVyHNHgRlroZldGgQSPnN+v98Jcmcus8oQCO5l+J4y?=
 =?iso-8859-1?Q?BPGjK0ZV5jjbaWTaMylqpKxo19ixlFlmZ7lypiiYQxkunOiPO0BPrLFWx+?=
 =?iso-8859-1?Q?nqb6NFDTFnieYvgyWc6qI3HqBd6hCXrkx7tP0f3dOU34CJWUSbaaP+7fTa?=
 =?iso-8859-1?Q?sZt/Z18CelbJyZyQDGCC+xvsbUHujD1JK2pHcQiAIOrSKIKljqQstu1AWh?=
 =?iso-8859-1?Q?LUL4lA+mB/Npn51/I1F4Rjem5JnBhPREbc4zr/bx9JlLwFOFa22TJwrwjI?=
 =?iso-8859-1?Q?baD4Kv3lKAtG83k7lM8N5VV3RlpY+fcJ1L5dlXe/OCRlfvSPEDRblcoMIl?=
 =?iso-8859-1?Q?qdNHBTpqKDJRNWuOOiIH1vxNRYkUOvbkgz87IsjCTTOBj+fLMpMd9x3JPN?=
 =?iso-8859-1?Q?Qitf1Sg92Xum7a5gjsMhgNwALYfO8yDtuJE59ivf/C6cHW+pFRwZyjkvzH?=
 =?iso-8859-1?Q?n8gnAIy/qD2K9GdfmY5wDZduNtE0vi2og810d0Xgtcl7FN7yfFDuChsF8p?=
 =?iso-8859-1?Q?BJu/5V/gC79Wub5X7W+mg2d8QKgiuYGTlJF1VylGDaZD5DnJJ1E5CqaNpu?=
 =?iso-8859-1?Q?TLaALl0bGfjlot0XKnWRQEPLBZPNA8iL5tGlfHNFLspMU6vpNtiFMC93+I?=
 =?iso-8859-1?Q?qCvfKxOY7NYx9ozJuBVwuSCkggJlmLDpby6XLIv6tUoOYoKmC7281B6kO4?=
 =?iso-8859-1?Q?laOcKiQrV6GGxChS6MNtlG0p695/Gr8fMtCg/3NFwM7nt+00cHZfN81hol?=
 =?iso-8859-1?Q?RkTsrR29aQNB3jSG9VHjSBtlXJdkT2O+qEsMTB6TIxIQ0MFRm42coGycKG?=
 =?iso-8859-1?Q?X3uSRDQsFoknrnvzJc+G6NFcvc3f0AFpHxpMNfZbDSSzI6hlqllSl/sUtW?=
 =?iso-8859-1?Q?A0E3o4WOWwxZzT3dOeezJwzK2Zm7lLGSL29BAiZUm5OFBTbDCnSvCOqgiK?=
 =?iso-8859-1?Q?EV+iV21QDc+kqeJZQRyMJVwSubNQbYqoxJLz6i98qj4bE+WNpChjyo+OYI?=
 =?iso-8859-1?Q?XPMVsUjbu5FrjnDwdb5TKIt6p0WGeC2Lv3MbO2/MSpwWYBs0hqliQ0d33k?=
 =?iso-8859-1?Q?Mq7tRUvzP65R+aRkJEFXE229hjtOow3fW7V3QWk6L2cdAsDDeeDuymzVnz?=
 =?iso-8859-1?Q?y+PtrfJpfzhMlYAQFkvPN+Jf6U87ecYCs+u4zgi2HvkQAkGuCNGyCX0HaS?=
 =?iso-8859-1?Q?YGjxkeaL551tY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467935c2-c525-42fc-f082-08dbeb9612c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 20:03:19.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrvWHV7RYh7ES6lv5Kold3VUB6OAvj6ik3kmM9uoC+n8ITnvAKCB53vr1OeFD6iTAHSHNUpaX0f85DchtQs0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
Recently I observed there is performance regression on system call mmap(..)=
. I tried both vanilla kernels and Raspberry Pi kernels on a Raspberry Pi 4=
 box and the results are pretty consistent among them.=0A=
=0A=
Bisection showed that the regression starts from k-6.1, and the latest vani=
lla k-6.7 is still showing the same regression.=0A=
=0A=
The test program calls mmap/munmap for a 4K page with MAP_ANON and MAP_PRIV=
ATE flags, and ftrace is used to measure the time spent on the do_mmap(..) =
call.=A0 Measured time of a sample run with different vanilla kernel versio=
ns are:=0A=
k-5.10 and k-6.0: ~157us=0A=
k-6.1: ~194us=0A=
k-6.7: ~214us=0A=
Results are pretty consistent across multiple runs with a small percentage =
variance.=A0 Ftrace shows that latency of mmap_region(...) has increased si=
nce k-6.1.=A0=A0An application that makes frequent mmap(..) calls the accum=
ulated extra latency is very noticeable. =0A=
=0A=
Please find the ftrace results and kernel config files in this folder:=0A=
https://drive.google.com/drive/folders/1qy8YTBqxu8Gdbs7IigYbSd4FXldId5sd?us=
p=3Ddrive_link=0A=
=0A=
The test program can be found in here:=0A=
https://drive.google.com/file/d/1tG6_BbQMCHwfKebvAIAg_xqbM_lpPcuM/view?usp=
=3Dsharing=0A=
=0A=
Info on the testing environment:=0A=
cpufreq_governor: performance=0A=
Test machine: Raspberry Pi 4, 8GB DDR=0A=
SCHED_FIFO with priority 99 for running the test program=0A=
=0A=
Vanilla kernels are not tainted. However on k-6.0 and k-6.7, I have to patc=
h the drivers/clk/bcm/clk-raspberrypi.c file with the version in Raspberry =
Pi kernel tree for the CPU frequency governor to work.=0A=
=0A=
Best,=0A=
Chun=0A=
[nvpublic]=0A=
