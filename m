Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0D7F90A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZBLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:11:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB3BA9;
        Sat, 25 Nov 2023 17:11:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDJY+3QeWIPOtr2y/5P4dar5d0czQ+A8Ws56c3eW4udXnZU6pR8t+yZ85DCqLlqiFYzo171UP+JKhUIEBSqoLlwGXOXCVpbh8NI1ZVi/vbu57vlCCx2fyK42jp4tdE+iQD+MbHYyEUXEvVO0cet+HsBiDwMCCphZEzad8oRUQ8Ci4+we8cGeWhXsd9NGboaE4TVzJamQlXz04bIEiiREs7lhLIR+XNohUuZ8L+5G9kF5gUKGOq8RKZ4sTTi7CPTM0hbBj24uMR7FDKUl+fl7ZEK5i+aG4JOKPpuP38AxAnmWW0ozokpU1C6yRosF4nFCk2GHW409+cokHNE114dehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deTUEiCdMpnT/Dw4s/uzkL6wypLShyTZwWLr8gQRhSw=;
 b=RZQ1yUcbdI2QPQKz1Ef7DSlgGljCpKKlAr4W7U/41vnk3ikOllFNG49LrlChxJTXWquvb8H6u+Fp16zSSm0j4ZJroJ11LFKkTfQprHeiDwTnkOSR+DbD22luA9WXYiy2CXElBwC9RhMG8iPVbLXzAEPwKeXtA+JI+vsHTOnHuj3qMtj0tBn3JdYpqZJrODylwiH4hcbPnIo6dJsjx/76iokko/UjO5Pe5AqYFFee26tPhQTJnxtvtuxxEXQBGwIHiSurmcuP+qst9tjhf6t8k/HY2vEuaSJGsdoPVYhUcMcTwkc2oGfMUW1j4fR+NJooemRlrhETKvPXifNm0kXK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deTUEiCdMpnT/Dw4s/uzkL6wypLShyTZwWLr8gQRhSw=;
 b=eW5sqv+WvXpzQT0fF4QtdG2aXUuUMyPOl7KhxPcfK/jSc7XjJdK9/4+bq2h1xcwR2M+doHE5LMkveig/12nX1czn9sJtflCLwoS0OfVZxsWECMcr98LhT5G/h8HSaWLq9+NLtFOYwj78S7Etl0s+kPpHbEdiaOoZ8we+0FFeJF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM6PR08MB6316.namprd08.prod.outlook.com
 (2603:10b6:5:1e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sun, 26 Nov
 2023 01:11:08 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 01:11:08 +0000
Date:   Sat, 25 Nov 2023 19:11:05 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <ZWKbKT4NjkriuEx1@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
 <ZTiFbmutojF0LRZU@nixie71>
 <120DA9BB-2607-4A85-B96C-5A2490E50876@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120DA9BB-2607-4A85-B96C-5A2490E50876@cirrus.com>
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM6PR08MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: f5215cb1-ace5-43e6-92c1-08dbee1c91e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plYTb/s9dzdZmxH01XzyD1Ash2a+1Y2UWVjVX9du6lJwTi47yHG1/OjxLQ8VFDEBZ1nbXhcPmOxVKHeDuyc7BYNtXUHFbnRy6msi0FRlvVEP0zyIHwbj/NJ3NNJbf4MGeVNKZDMgIujZ58EuPD+rJjvqMj4C9G/J163nZo+D69TM7WMN3eI5BDp22wrbkt7FguR0rjBMx4yulY2EElYMXIgdlq1qzx85NLh4gvGkiV0pE+sA6PRn1QnYEM/Upu37kXLcKLN4Dkg5FsmAUV5InEp/Aehlm5mAJZe8EkFgIXR5rsyNySrJYJRNT4dEfn+WBZglbV+Yu/RpFJUxVUAs0+pD6Um6m6XCxrculPd7rHotkBR4E6s9fiGDnTScYS+wM81rw7i3LvdCAtSqr6ajIBZXbM/TAogC0DD83msn0aIVPy6jbMaEr5l31Mvi4u3rKL/+WrQqUlS8oh5BEvc1kHsJWkEdZMQOFLm/6qQYnSALwf8X896dMAOkpdv5KEL62qptLi/iXiNQH4esAnGH52orjnLZimD4JHxa8KEttcm6IZf32xTYnDK29FnBJxXK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(396003)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(7416002)(2906002)(6666004)(86362001)(33716001)(6506007)(53546011)(478600001)(26005)(9686003)(6512007)(316002)(54906003)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(8936002)(6486002)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1prOHY5SEpBalFUQ0t4clNLWGEwN0dabTNpcHMyTnZ4MzNIaWY5UzZNcER0?=
 =?utf-8?B?Yk9TUEd5YWxBUTVoNEYvbFdZblpTeVl2Qm5FWXpuRnlLVXlVSkhQZDBDd0ly?=
 =?utf-8?B?YUxTbEFmMTVWZWVrdW11dCtiTFlyY1VmSlJxNmFpQnJndE5HQ09ENDRlZUR2?=
 =?utf-8?B?VjB2OXZ2d09PeXFGOVcwNUFUdlR4d0lEcHk2d1RtV09DUzY5UVg2RDljNHRW?=
 =?utf-8?B?ejBxcnRXNEJ1dVNOaXBDZk1HaHlXOFRSd1YvMmN3T2hrbTNjRUpib1lNbWdH?=
 =?utf-8?B?MG1MZU53d3Vnb1Jxc2R5V1FFNVFjK0tYRUhweFl0aENzSVFvRmRhdndIZ2ta?=
 =?utf-8?B?emhyanA2YWxRYjBidjFXZjl5UFRNeW53TUxUMGFibXl0aTd0TS9nNWZOWXFF?=
 =?utf-8?B?bUs1NFdzK2F4R0dxWW9XU2tOUXpoYk9XNUdBb3F2U3JUc0pHV2U4L0d1VlJE?=
 =?utf-8?B?Y2lYSmxOU0NiYm5jbDNCSnp2RlVNTjlMUUVhdThybkQ3UzJqaEFjU29yMGVP?=
 =?utf-8?B?V01IU01ZcEVZdFZla1l1eGpJYy9OeVBDdjgyUVZsRVVyWXU0YWNsS216RVV5?=
 =?utf-8?B?S3hqZzdTSE11WHNWSGZtKzh0SFNDcG0yNE1QUEZiVmdwZzA0RXZUMXZrSS9W?=
 =?utf-8?B?WE85QTY3TnlWNjRvRnRkWWEwZnA1Snp2QWhjWTZTbnhQTDdZb3c5dFZsQ0I2?=
 =?utf-8?B?VXl0dGt2THl5M3orQ0dmRzk5bjBnUUQ0emZ6Ti9zNnN2eHVic2lCQmlSQ0Mz?=
 =?utf-8?B?UDRwRFV5andCVWI2Y0pkc1R0NG9SQXdRU002anNjLytPLzREMTFyL2YyZXNl?=
 =?utf-8?B?aVBDbkpON2syREVXTFVEUmVRREVWa21nbVJqYlpBR092eEZHTU9UajV6bFpS?=
 =?utf-8?B?bmFtLzJnYUpmR01oWXJGcURTUmdicys1VW9sVndlV3JRZlg5SkU4UXd3c2xY?=
 =?utf-8?B?UGl5d0NJQ254NFVOMFFkZXI2ZVk4bkJkK0M2MXJzSDAvVmJJWURqYXMwemtR?=
 =?utf-8?B?WlBTMjlJVXErb2RSWDNBVDhLQzJIUG82VXNMYndHL1BEMEdxc1daVUdMWFp6?=
 =?utf-8?B?dGRtZTEzV2liOXhFTzlQQjY4ZHd3UFk0WXFWM1BWeXlQK29DbWVOT3JZNWxq?=
 =?utf-8?B?RXdIa2g5MXBVSTBVZHZmaHB2TEZJNUR2bUt5Y0dQaVovd1hvWnVKNGc5c3Bn?=
 =?utf-8?B?SDk4NnA1VVphTmVyTjhIcUsvR29NMWJ1dGt3dEU3bXVtbHpEU21zMVRuZ2dG?=
 =?utf-8?B?c29HRjJXb3loZnNnbzBkb0trVUpBODFvQnpYb2xic0JxTTlsMkdhQlBOcXkr?=
 =?utf-8?B?Z2FWckh2RllOV2VoRVdKeUpsS0FwYmtSVlNuM1pnbFFaY0lTbTlEcUtvR1Jt?=
 =?utf-8?B?VGhTNTFxYzlFOEJmRXNjT3NNaUN3eWhBZ2FwQTAzR3p0bTZhRk01RXhXVlhv?=
 =?utf-8?B?KzdEaHAvY0M3NWNTUnBRelZKLzNla1lEZVFDTitPTzhSZmdlTXNHdnBhUis1?=
 =?utf-8?B?T2szUGNZblRWUjdKalUvejEyRjBOUU0rSUxQR05CWEhOZFNUSjZVUXVKbFJu?=
 =?utf-8?B?QkpwZkpFWnVBRHUyODdKb205TmppelBKUTdRYWRBT0hha2xpbVpNOUxjcU9o?=
 =?utf-8?B?NUtBZzZ2bnREUzY3ajh4R3ZDUHlXRUNidExXeG5CK1hZdkNZdGRZKzZPT3NO?=
 =?utf-8?B?NkU5SlpQVlJnbXB3MkVSZURUNUtxS3A0aUJLemYxZ3BzZG5rUWpzN2FSSjZM?=
 =?utf-8?B?R3ZScnF4c252VUs2Q3BiSS9CTmpPZ0JxSUlxUzFVdTkwYmlkbGl5YWI1RENH?=
 =?utf-8?B?Z21UNU4zYnMzNm9zZ2Y4bzdTK2gwbVU5enlaemhxVjJNbVFQWUJLMWoxM215?=
 =?utf-8?B?cVRoZ2YwWkZIdEp3ZkVBWTBZaGNzbTlzUWZieS95a2NHK2U1OTV4c1R1NmZJ?=
 =?utf-8?B?OG5yckkyYlFNOFpZZ0FaOE5FVXQxU29uZUN6WFdMNG1uSmVqSDhBbWdNeGZu?=
 =?utf-8?B?c1hZVnJ3NDFoUE92YllEMzg2Q0ZNWWdBRHduWXJOZVdEOGgwUjV5dG52QUdY?=
 =?utf-8?B?ak91UCt1dXhTVjZQdmNNL2p3RXJNT2l2OXdiVUtHVUVXV0ZUbEZmMWdOcktW?=
 =?utf-8?Q?Pj0ZbMcnZ8sx217hxAXDZW2m3?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5215cb1-ace5-43e6-92c1-08dbee1c91e2
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 01:11:08.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFLPrElm+JYqvbeShhT7J+iR9Th7X9p7Z5n7a9Ahp7AKSOPPnepdbyJU1cIybs8nOUdQEu5WuF0Isb79LL+AnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Nov 01, 2023 at 08:47:07PM +0000, James Ogletree wrote:
> Hi Jeff,
> 
> > On Oct 24, 2023, at 10:03 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> >> 
> >> +static const struct cs_dsp_client_ops cs40l50_cs_dsp_client_ops;
> >> +
> >> +static const struct cs_dsp_region cs40l50_dsp_regions[] = {
> >> + {
> >> + .type = WMFW_HALO_PM_PACKED,
> >> + .base = CS40L50_DSP1_PMEM_0
> >> + },
> >> + {
> >> + .type = WMFW_HALO_XM_PACKED,
> >> + .base = CS40L50_DSP1_XMEM_PACKED_0
> >> + },
> >> + {
> >> + .type = WMFW_HALO_YM_PACKED,
> >> + .base = CS40L50_DSP1_YMEM_PACKED_0
> >> + },
> >> + {
> >> + .type = WMFW_ADSP2_XM,
> >> + .base = CS40L50_DSP1_XMEM_UNPACKED24_0
> >> + },
> >> + {
> >> + .type = WMFW_ADSP2_YM,
> >> + .base = CS40L50_DSP1_YMEM_UNPACKED24_0
> >> + },
> >> +};
> >> +
> >> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
> >> +{
> >> + cs40l50->dsp.num = 1;
> >> + cs40l50->dsp.type = WMFW_HALO;
> >> + cs40l50->dsp.dev = cs40l50->dev;
> >> + cs40l50->dsp.regmap = cs40l50->regmap;
> >> + cs40l50->dsp.base = CS40L50_CORE_BASE;
> >> + cs40l50->dsp.base_sysinfo = CS40L50_SYS_INFO_ID;
> >> + cs40l50->dsp.mem = cs40l50_dsp_regions;
> >> + cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
> >> + cs40l50->dsp.no_core_startstop = true;
> >> + cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
> >> +
> >> + return cs_dsp_halo_init(&cs40l50->dsp);
> >> +}
> >> +
> >> +static struct cs_hap_bank cs40l50_banks[] = {
> >> + {
> >> + .bank = WVFRM_BANK_RAM,
> >> + .base_index = CS40L50_RAM_BANK_INDEX_START,
> >> + .max_index = CS40L50_RAM_BANK_INDEX_START,
> >> + },
> >> + {
> >> + .bank = WVFRM_BANK_ROM,
> >> + .base_index = CS40L50_ROM_BANK_INDEX_START,
> >> + .max_index = CS40L50_ROM_BANK_INDEX_END,
> >> + },
> >> + {
> >> + .bank = WVFRM_BANK_OWT,
> >> + .base_index = CS40L50_RTH_INDEX_START,
> >> + .max_index = CS40L50_RTH_INDEX_END,
> >> + },
> >> +};
> > 
> > These structs describe the DSP, and hence the silicon; they are not
> > specific to the input/FF device. Presumably the DSP could run algorithms
> > that support only the I2S streaming case as well (e.g. A2H); therefore,
> > these seem more appropriately placed in the MFD.
> 
> Acknowledged, but would you consider the last struct “cs40l50_banks” as
> an exception? It would go unused in a codec-only setup.

I agree with you; I should have inserted my comment after cs40l50_cs_dsp_init()
and not cs40l50_banks[].

> 
> Best,
> James
> 
> 

Kind regards,
Jeff LaBundy
