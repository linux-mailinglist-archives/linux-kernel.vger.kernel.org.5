Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345087F908E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjKZAxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKZAxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:53:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EEA189;
        Sat, 25 Nov 2023 16:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn3FL/BZWL67ul44pMT4sAODUbCTI9YwJ98dBXwpWAixKXnjUiirEIY+bTYbCxOqmh6SaPqVwFeaixaDeffePQx2LufXE8hWoChMUygH2tmYbXFZxYD4iQBPUlMJ3iZIJNL3vqgAV8lfvGPI6Q9D2PqNmpHpm4NTeQcc6e0PGzpKhH+qKHJfbrYrAHT0cDfjL5k0Chxywk+nZR6pQdQ7PgCUzS+Zn2yBUSmg7VFHA6QvZ4zS/ur3/IEpdSwKNazRHGFNLvXhQv4u/LLXNeUMT2G5g30mnvWgEkyOqlD4527/QmeZMFQiQD/tNQEGpNdTpk6FAkpSSkrZis8PV0FGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4TH76FzeGW42qZsUWOSHYurEo8Fpp8Bo8W9cHZgC/A=;
 b=IQLfl/osSf/qDV0LyLIy/hgcnNRuiifvpOcUFwUjCvtxge9hoJqQSRo+NtkM/qHZuOn2rZmC3rejT23+Wls8h1xFegssudwOs6QWwuPK9y3x+NEh2egGEb6zKz0PTkD+o/0AjiEPOTJ+Epl9jD+m2IR7Pv9PH/8eXnBLWnTap3Aq35s17gUGxhciZr9xnFqGjb7+Q6e6YZOxN+8fSkywMX3n4A/VcZSLxU9SYl8g7jpRK3lxd5udyliiY48AraKZRUj5iMFAdnLPrWJbTT4IwLSFaVe1e0u8iBwtKKp1FMaxdtzSFMrQUUZZoUS5un4CxT0YatD5f5T7T/MjIL0nlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4TH76FzeGW42qZsUWOSHYurEo8Fpp8Bo8W9cHZgC/A=;
 b=K7Jo5J15VMoWUuorHnGAEAXPPvjZrkcEmyWT+dOk3HDSGoNXh7EKFDkpM/hIw9qbV6iA7/vlvTStuVRVCZpVbwNE92QTAv4orhSnMBEip+IFjGfKxPnk5C5sm0Xfcw2cOw4D/+a8+5evnmAA8lhwG35OWLQsMLJ/I4rBuqLvAp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB6756.namprd08.prod.outlook.com
 (2603:10b6:303:91::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Sun, 26 Nov
 2023 00:53:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 00:53:03 +0000
Date:   Sat, 25 Nov 2023 18:52:56 -0600
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
Subject: Re: [PATCH v4 2/4] Input: cs40l50 - Add cirrus haptics base support
Message-ID: <ZWKW6BY9C3a9covT@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-3-james.ogletree@opensource.cirrus.com>
 <ZTh3qSAjIaj/oonc@nixie71>
 <6DECA9DD-B464-446A-B6A1-5EECD4FF5E0B@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6DECA9DD-B464-446A-B6A1-5EECD4FF5E0B@cirrus.com>
X-ClientProxiedBy: SN7PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:806:122::10) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f0a12e-74b1-4621-5fbc-08dbee1a0b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmUfTf4489jVMae5LGhj2eVyxeHSLXk/7j9LxGYkmh0mVQYxK8ByIYpldHjbX1SIDKJtjos+Oajua+VyNKt5RSq2B61FZCKFefWestpS8PltyZwksvLwarKaEFmVbaabuBshqrzFh58W6HKus45+2vptQYFzOpM2s6NWjifvKww+rpcUQDEfJ1mPTmq7FmNecL9XrWKAWjSex+s6WIk013eg2+WA9t2bMibPh/OKJaKBL0Yoxa4z4IQPQUsrrhlTfGUe81fy74CsLaB29RCNoV2gJPsm+BUVf1Yd22nbCHtrZ7HcN0qS6AarpUefNDaxC5W3zuahm8VE1nF3+iSbBKpk6424VTWNy6979W8IP7XQdFeYAr9umB9gyTPrMLQ+fP2/PWBBMILtjkNllJIz5TqS28Wl2zwbL0mymhF/n1s28odJ8w0B5LQ8eks1pAE5znG64uQuCu7gh8K1uhuU7t4W/CvPzspJYEqOGgZThJUUblZUW6P219f1FLkB2rt/9cMGEL7RELuer3vlRT8QBmg2tyj1HcfyHTM5Ffx6Lg0ph0HIxnL5nCOkPiiEu6wc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39830400003)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(8936002)(8676002)(4326008)(478600001)(6486002)(7416002)(86362001)(5660300002)(41300700001)(30864003)(2906002)(38100700002)(6506007)(6666004)(53546011)(9686003)(6512007)(83380400001)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NndkJaeHcvN2N5TDFoeEZaclgvMU5lRmhZZVpZb2YvNkFHMTRkK3pCejdD?=
 =?utf-8?B?L1ZaMkRqNU9QMk9XeUJEYXZlNVA0QlJPQU43WEZwREVpRHppYlY1OXJIVEhK?=
 =?utf-8?B?Q0NHRFZlaUZCYnpXTmp5VHBEQkFtK2JGTEFvNXhLLzdudEd6QmFuamd6akl3?=
 =?utf-8?B?cEwwOGdQRmxpVVQ2SlE0N3VVV1ZWOGlFaG5zVDRYalV3aGZzNkNuaHhkZnhE?=
 =?utf-8?B?UTBFdDN5TWNWUDZuUzlGZ0FycXRZRUlQZHlkK3JqOTZiZFFTZlhYRXBLamRQ?=
 =?utf-8?B?T3Z4bTJoU3Fxb0pBMW14eGI3TXBicVd3Vlh6RjFFdGxDdnFzcWYyUStMS2Nv?=
 =?utf-8?B?YkNyclp5cFJPdUJGYTk3R0t6UGhqOEtwSVQ3Q0JwbUJMYk82dmlSdkkrVmNJ?=
 =?utf-8?B?M2w5US9MS2xTOTlDZUQrQnJMK2o5cmhvUXluelFqQVJpTUpRSTBPL2Vic295?=
 =?utf-8?B?VTlTWmJBYWNjOEFNdXNoVnBCRWRnalFHcFptWERLYWVJUkF0T0ZUVXNMb0Rm?=
 =?utf-8?B?ZThUWmo2TXpRaGlTM2Q1SHNmMGg4S3RZZDF6NkNmMXlYRERjand0Wk91dDZ6?=
 =?utf-8?B?SFpTbTAreW1hakt0N2RiOVZSVVBYL1JpcjdpeGVlOXlhOVlnOHorUEtiSWpr?=
 =?utf-8?B?NlB4Yy9kV1M1N0gvRk1ERXdMS1AzS1hNaUN6SlZlaEowenh3TnlzR2JOSE11?=
 =?utf-8?B?cHR6NkhjVWRJeUNqZzlHWXhkY3VYMm9sNVk1ZmNramNMKzVxV1BJOE1lNVVF?=
 =?utf-8?B?UW5saUhTclR0SHMrWi9heFNTalZvenFMQVV6RzIzREpGUi83d3RmdE5JYW9Y?=
 =?utf-8?B?ZVU4ZFRSOGw2S2VJUjZXMWJLemhpcjQ0Y202bXp1NlR3TXBTb0lLaG1vQ0ls?=
 =?utf-8?B?VjA1eXFqTmY0TkFMSyt1UVZRSWR6cC9FMUREZUJ4YWFLVWVIUDNUbS90bWJZ?=
 =?utf-8?B?L2lsaTVERGswV0RNYTlscm12ejZDMUw1Ky9URGJnRE1ra1Y2YzdSRm5XSzJL?=
 =?utf-8?B?K3NzWTlGTzB4c3kyRUk1QVFIeTd0T1JHZitoWGQwWDdsWCtVUDFkWVB2bnBn?=
 =?utf-8?B?c2FnbEkrWVBlY29WQUtSZDR1c0hRbGFMWnFUMTRNbDN4Y3cyQXJ5ckhIbVRs?=
 =?utf-8?B?MEhUdHNwWW1YVW9iWFBaRFpMWjhYOUl0WURySktuNzNTVkZ6c0FrbXNiVm8r?=
 =?utf-8?B?UW1RNEdjOEhNRlUwZTl5L1Z5VnVObEM1N3pNVjZVMFRYVVpqaVhNay9ZUCsr?=
 =?utf-8?B?blJvTzBuUkNydExubmxPbStFU1Y4Z29hWnorZkdjdkdDNEZtQjFqUFNUU0ow?=
 =?utf-8?B?WkQ1a2JQT3c4MEZncE5VMFpmZjh2UnJIWkI4L0xpRVBYRmJTWHZHWXJHMUto?=
 =?utf-8?B?QXI2c3FuSDcwZFNqL1FYS2tsNXJZZjgrc3JQbkwrK0cxZkFJTytTMC9yaXZ0?=
 =?utf-8?B?MDNicGdSL1hjSEI2WWJkTVRoclFQTDlEYnBaQ0EzWEZvRHNsWW01V3Z3UU5Q?=
 =?utf-8?B?S2ZtWTR3SjJsR2V5MjFKRlFBV0orelo3MkszZ05PcmIvMkR4dW1kSTNFaHpp?=
 =?utf-8?B?eDFSYXltZGtucmR4Z3V5QzdkeHA0NCtlbDY4ZDYxc3MvZXhPSmRYWUc4RHhS?=
 =?utf-8?B?VnBHdUJsWkdEazI4MThwbFd2NlF1ckFxd0l3R0xSZ1FFNll0aHo2NnVNTElm?=
 =?utf-8?B?YjJNUm44a1VvemlLVGZsMGdmbnZ4YnJFMU13NzM2SVdCckhlTVZON1FPVUly?=
 =?utf-8?B?N0NjQjdrSGZSN3FkWEg1SXJUMjlhQ3J4ZVlLZk1kTCtJQXBjRjRFMkhKNnF4?=
 =?utf-8?B?Z2NEM1I1RVVGZ1FwZFlxa0Q3eDJFUkM4S0lVUjlrN1NWL2lZeVRlWnNNclBw?=
 =?utf-8?B?eG5nVElLTzEwL29vOWpJbW9ycUMwWHFtaUppR3J4ZGZNMXpCVVd2MmI3RmZX?=
 =?utf-8?B?eWM1R3dpV09pZ3VCQk8rYkNmN2VJN1AvSFhvSGdrb0svZE5pRFR3cWpDemFv?=
 =?utf-8?B?RVNUTkZFYWFMcHNUS3oyYWVNZGVLdXFMRXhsZEgxUitEQjVIMHFQMW9EbjFm?=
 =?utf-8?B?RkdHN2JSTGxnNVoreWtEL3dlWVhWaElicUZ2L01RQUh0dVNVdE5CVmpBUlpF?=
 =?utf-8?Q?jJaSKGsEoHOQFlH2DWkk45s/8?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f0a12e-74b1-4621-5fbc-08dbee1a0b3c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 00:53:03.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u26Ui9E5thpL3s5JnSgMsvzjGeWKMau4gJOyFWexeKgobs/XVr5Bct89ZteiIfUrVnj54t/jOffXzq731bMvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6756
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

On Wed, Nov 01, 2023 at 08:46:12PM +0000, James Ogletree wrote:
> Hi Jeff,
> 
> You’ve given such great feedback covering many aspects of the
> driver, on this patch and the whole series, which has required very
> careful consideration, so thank you for your patience.

Your high-quality submissions make the review process efficient and
productive :) Please excuse my delayed response.

> 
> > On Oct 24, 2023, at 9:04 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > On Wed, Oct 18, 2023 at 05:57:23PM +0000, James Ogletree wrote:
> >> 
> >> +static int cs_hap_pseq_init(struct cs_hap *haptics)
> >> +{
> >> + struct cs_hap_pseq_op *op;
> >> + int error, i, num_words;
> >> + u8 operation;
> >> + u32 *words;
> >> +
> >> + if (!haptics->dsp.pseq_size || !haptics->dsp.pseq_reg)
> >> + return 0;
> >> +
> >> + INIT_LIST_HEAD(&haptics->pseq_head);
> > 
> > Anything that allocates or initializes an element that is normally held
> > in a driver's private data, like a list head or mutex, belongs in probe()
> > in my opinion. It's less of an issue here, but for more complex cases
> > where we may set something up in probe() and tear it down in remove(),
> > the driver is easier to maintain if helper functions such as cs_hap_pseq_init()
> > only manipulate or organize the data, rather than absorb additional work.
> 
> I agree with your reasoning, however, doesn’t this then turn on the question of
> who the rightful owner of the write sequencer code is? If the pseq code
> belongs in the MFD driver, it ought to be moved to the driver’s private data
> structure there, however if it fits here, then not so. A counter example would
> be cs_dsp.c, a library which contains within it some INIT_LIST_HEAD calls.
> Perhaps the dust should settle on that dispute, and in regards to that, please
> read my comments below.

I think the list head belongs in the MFD's private data (cs40l50_private)
because the pseq code belongs in the MFD; more details as to why below.

> 
> >> +
> >> + words = kcalloc(haptics->dsp.pseq_size, sizeof(u32), GFP_KERNEL);
> >> + if (!words)
> >> + return -ENOMEM;
> >> +
> >> + error = regmap_bulk_read(haptics->regmap, haptics->dsp.pseq_reg,
> >> +  words, haptics->dsp.pseq_size);
> >> + if (error)
> >> + goto err_free;
> >> +
> >> + for (i = 0; i < haptics->dsp.pseq_size; i += num_words) {
> >> + operation = FIELD_GET(PSEQ_OP_MASK, words[i]);
> >> + switch (operation) {
> >> + case PSEQ_OP_END:
> >> + case PSEQ_OP_WRITE_UNLOCK:
> >> + num_words = PSEQ_OP_END_WORDS;
> >> + break;
> >> + case PSEQ_OP_WRITE_ADDR8:
> >> + case PSEQ_OP_WRITE_H16:
> >> + case PSEQ_OP_WRITE_L16:
> >> + num_words = PSEQ_OP_WRITE_X16_WORDS;
> >> + break;
> >> + case PSEQ_OP_WRITE_FULL:
> >> + num_words = PSEQ_OP_WRITE_FULL_WORDS;
> >> + break;
> >> + default:
> >> + error = -EINVAL;
> >> + dev_err(haptics->dev, "Unsupported op: %u\n", operation);
> >> + goto err_free;
> >> + }
> >> +
> >> + op = devm_kzalloc(haptics->dev, sizeof(*op), GFP_KERNEL);
> >> + if (!op) {
> >> + error = -ENOMEM;
> >> + goto err_free;
> >> + }
> >> +
> >> + op->size = num_words * sizeof(u32);
> >> + memcpy(op->words, &words[i], op->size);
> >> + op->offset = i * sizeof(u32);
> >> + op->operation = operation;
> >> + list_add(&op->list, &haptics->pseq_head);
> >> +
> >> + if (operation == PSEQ_OP_END)
> >> + break;
> >> + }
> >> +
> >> + if (operation != PSEQ_OP_END)
> >> + error = -ENOENT;
> >> +
> >> +err_free:
> >> + kfree(words);
> >> +
> >> + return error;
> >> +}
> > 
> > My first thought as I reviewed this patch was that this and the lot
> > of pseq-related functions are not necessarily related to haptics, but
> > rather CS40L50 register access and housekeeping in general.
> > 
> > I seem to recall on L25 and friends that the the power-on sequencer,
> > i.e. PSEQ, is more or less a "tape recorder" of sorts in DSP memory
> > that can play back a series of address/data pairs when the device
> > comes out of hibernation, and any registers written during runtime
> > must also be mirrored to the PSEQ for "playback" later. Is that still
> > the case here?
> > 
> > Assuming so, these functions seem like they belong in the MFD, not
> > an input-specific library, because they will presumably be used by
> > the codec driver as well, since that driver will write registers to
> > set BCLK/LRCK ratio, etc.
> > 
> > Therefore, I think it makes more sense for these functions to move to
> > the MFD, which can then export them for use by the input/FF and codec
> > children.
> 
> I think the problem with moving the write sequencer code to the MFD
> driver is that it would go unused in a codec-only environment. We only
> need to write to the PSEQ when we want to maintain register settings
> throughout hibernation cycles, and it isn’t possible to hibernate when
> there is data streaming to the device. So the PSEQ will never be used
> in the codec driver.

I agree that in practice, the write sequencer would technically go unused
in a codec-only implementation. However, that is because the ASoC core
happens to write all pertinent registers ahead-of-time each time a stream
starts. That is a property of the ASoC core and not L50; my feeling is that
the driver should not be structured based on what one of the subsystems
associated with it happens to do, but rather the nature of the hardware.

Some specific reasons I think the MFD is a better home for the pseq code:

1. The write sequencer is a housekeeping function derived from the way
the hardware implements its power management; it doesn't have anything
to do with haptics. My opinion is that facilities supporting application-
agnostic functions belong in the MFD, for all children to access, even
if only one happens to do so today.

2. Over the course of the IC's life, you may be required to add errata
writes after the IC is taken out of reset; these presumably would need
to be "scheduled" in the write sequencer as well. These wouldn't make
logical sense to add in the input driver, and they would be missed in
the theoretical codec-only case.

3. This device has a programmable DSP; it wouldn't be unheard of for a
customer to ask for a new function down the road that begets a third
child device. Perhaps a customer asks for a special .wmfw file that
repurposes the SDOUT pin as a PWM output for an LED, and now you must
add a pwm child. That's a made-up example of course, but in general we
want to structure things in such a way that rip-up is minimal in case
requirements change in the future.

> This leaves either the input driver or the library, and it makes more
> sense to be in the library since it is shared code with L26. This was
> my reasoning, let me know whether you think it is sound.

I'm not sold on the input driver and the methods in what is now an FF
library living in separate files; more on that below.

> 
> > This leaves cirrus_haptics.* with only a few functions related to
> > starting and stopping work, which seem specific enough to just live
> > in cs40l50-vibra.c. Presumably many of those could be re-used by
> > the L30 down the road, but in that case I think we'd be looking to
> > actually re-use the L50 driver and simply add a compatible string
> > for L30.
> > 
> > I recall L30 has some overhead that L50 does not, which may make
> > it hairy for cs40l50-vibra.c to support both. But in that case,
> > you could always fork a cs40l30-vibra.c with its own compatible
> > string, then have the L50 MFD selectively load the correct child
> > based on device ID. To summarize, we should have:
> > 
> > * drivers/mfd/cs40l50-core.c: MFD cell definition, device discovery,
> >  IRQ handling, exported PSEQ functions, etc.
> > * sound/soc/codecs/cs40l50.c: codec driver, uses PSEQ library from
> >  the MFD.
> > * drivers/input/misc/cs40l50-vibra.c: input/FF driver, start/stop
> >  work, also uses PSEQ library from the MFD.
> > 
> > And down the road, depending on complexity, maybe we also have:
> > 
> > * drivers/input/misc/cs40l30-vibra.c: another input/FF driver that
> >  includes other functionality that didn't really fit in cs40l50-vibra.c;
> >  also uses PSEQ library from, and is loaded by, the original L50 MFD.
> >  If this driver duplicates small bits of cs40l50-vibra.c, it's not the
> >  end of the world.
> > 
> > All of these files would #include include/linux/mfd/cs40l50.h. And
> > finally, cirrus_haptics.* simply go away. Same idea, just slightly
> > more scalable, and closer to common design patterns.
> 
> 
> I understand that it is a common design pattern to selectively load
> devices from the MFD driver. If I could summarize my thoughts on why
> that would not be fitting here, it’s that the L26 and L50 share a ton of
> input FF related work, and not enough “MFD core” related work.
> Between errata differences, power supply configurations, regmap
> configurations, interrupt register differences, it would seem to make for
> a very awkward, scrambled MFD driver. Moreover, I think I will be moving
> firmware download to the MFD driver, and that alone constitutes a
> significant incompatibility because firmware downloading is compulsory
> on L26, not so on L50.
> 
> On the other hand, I want to emphasize the amount that L26 and
> L50 share when it comes to the Input FF callbacks. The worker
> functions in cirrus_haptics.c are bare-bones for this first
> submission, but were designed to be totally generic and scalable to
> the needs of L26 and all future Cirrus input drivers. While it might appear
> too specific for L26, everything currently in cirrus_haptics is usable by
> L26 as-is.
> 
> For the above reasons I favor the current approach.
> 

If the core functions (e.g. firmware loading and interrupt handling) of L26
and L50 are drastically different, then it's perfectly acceptable to have
different MFD drivers for the two. There are plenty of examples of devices
throughout MFD who are close cousins to one another.

Likewise, if the input-related functions of L26 and L50 are nearly identical,
then it's also perfectly acceptable for both drivers/mfd/cs40l26.c and
drivers/mfd/cs40l50.c to load drivers/input/misc/cs40l50-vibra.c, which
supports both L26 and L50 haptics-related functions. You're already doing
something similar, but I disagree on the following:

1. Rather than have a library referenced by two drivers that support children
which are largely the same in a logcial sense, just have a single driver that
supports two children.

2. That common code encapsulates too many things (e.g. pseq facilities). A
library may make sense, but not restricted to input children.

For code that is common to either MFD (e.g. pseq), it is largely a judgement
call and maintainer preference as to where that code lives. One approach could
be to simply include all common code in drivers/mfd/cs40l50.c today. When
drivers/mfd/cs40l26.c lands, it can simply #include <linux/mfd/cs40l50.h>, and
its Kconfig can select MFD_CS40L50. Both modules would get built, but only one
would bind and probe.

Another approach could be to move the pseq code from the L50 MFD into a library
(e.g. drivers/mfs/cs40l50-common.c) selected by both L50 and L26 Kconfigs. That
is of course some rip-up, but at least the code is not jumping subsystems at this
point, which it otherwise might if you leave it in an input library for now.

That being said, you are the one who is responsible for supporting the driver in
the future, so the decision is ultimately yours. You have a much better sense of
the hardware variants and the relationships among them. It's a delicate balance
of preparing for what customers may request, and any decision will inevitably be
wrong in some way :) I think the important thing is to not restrict yourself too
much up front, and my humble opinion is that slightly redrawing the dotted lines
in your "block diagram" may ease some pain down the road.

> 
> >> +int cs_hap_pseq_write(struct cs_hap *haptics, u32 addr,
> >> +       u32 data, bool update, u8 op_code)
> >> +{
> >> + struct cs_hap_pseq_op *op, *op_end, *op_new;
> >> + struct cs_dsp_chunk ch;
> >> + u32 pseq_bytes;
> >> + int error;
> >> +
> >> + op_new = devm_kzalloc(haptics->dev, sizeof(*op_new), GFP_KERNEL);
> >> + if (!op_new)
> >> + return -ENOMEM;
> >> +
> >> + op_new->operation = op_code;
> >> +
> >> + ch = cs_dsp_chunk((void *) op_new->words,
> >> +   PSEQ_OP_WRITE_FULL_WORDS * sizeof(u32));
> >> + cs_dsp_chunk_write(&ch, 8, op_code);
> >> + switch (op_code) {
> >> + case PSEQ_OP_WRITE_FULL:
> >> + cs_dsp_chunk_write(&ch, 32, addr);
> >> + cs_dsp_chunk_write(&ch, 32, data);
> >> + break;
> >> + case PSEQ_OP_WRITE_L16:
> >> + case PSEQ_OP_WRITE_H16:
> >> + cs_dsp_chunk_write(&ch, 24, addr);
> >> + cs_dsp_chunk_write(&ch, 16, data);
> >> + break;
> >> + default:
> >> + error = -EINVAL;
> >> + goto op_new_free;
> >> + }
> >> +
> >> + op_new->size = cs_dsp_chunk_bytes(&ch);
> >> +
> >> + if (update) {
> >> + op = cs_hap_pseq_find_op(op_new, &haptics->pseq_head);
> >> + if (!op) {
> >> + error = -EINVAL;
> >> + goto op_new_free;
> >> + }
> >> + }
> > 
> > It seems we are relying on the developer to remember if he or she has
> > already written 'addr' using a previous call to cs_hap_pseq_write(),
> > then set the update flag accordingly; is that accurate?
> > 
> > If so, that is a high risk for bugs to be introduced as the driver is
> > maintained. Can we not search for an existing address/data entry upon
> > any call to cs_hap_pseq_write() using cs_hap_pseq_find_op(), and add
> > or replace a new address/data entry automatically?
> 
> There are currently sequences on L26 where we want to write to the same
> address twice. In such cases we wouldn't want the driver to automatically
> look up and update the first entry during the second write call, hence the
> need for the update flag. I think with this use case in mind, updating
> the entries automatically wouldn't be feasible.

ACK. Good call on returning -EINVAL if update is true yet the entry was
never added; that seems like a reasonable level of protection.

> 
> >> +static void cs_hap_vibe_stop_worker(struct work_struct *work)
> >> +{
> >> + struct cs_hap *haptics = container_of(work, struct cs_hap,
> >> +       vibe_stop_work);
> >> + int error;
> >> +
> >> + if (haptics->runtime_pm) {
> >> + error = pm_runtime_resume_and_get(haptics->dev);
> >> + if (error < 0) {
> >> + haptics->stop_error = error;
> >> + return;
> >> + }
> >> + }
> >> +
> >> + mutex_lock(&haptics->lock);
> >> + error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> >> +      haptics->dsp.stop_cmd);
> >> + mutex_unlock(&haptics->lock);
> >> +
> >> + if (haptics->runtime_pm) {
> >> + pm_runtime_mark_last_busy(haptics->dev);
> >> + pm_runtime_put_autosuspend(haptics->dev);
> >> + }
> >> +
> >> + haptics->stop_error = error;
> > 
> > This seems like another argument for not separating the input/FF child
> > from the meat of the driver; it just seems messy to pass around error
> > codes within a driver's private data like this.
> 
> I removed the start_error and stop_error members. However I think the
> erase_error and add_error need to stay. I think this is more of a symptom
> of the Input FF layer requiring error reporting and having to use workqueues
> for those Input FF callbacks, than it is to do with the separation of these
> functions from the driver. Point being, even if these were moved, we would still
> need these *_error members. Let me know if I understood you right here.

Sure, but why do adding and removing waveforms require workqueues? The DA7280
driver doesn't do this; what is different in this case? (That's a genuine
question, not an assertion that what you have is wrong, although it seems
unique based on my limited search).

> 
> Best,
> James
> 
> 

Kind regards,
Jeff LaBundy
