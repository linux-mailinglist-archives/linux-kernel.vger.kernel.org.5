Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73D812511
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjLNCME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:12:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D31D5;
        Wed, 13 Dec 2023 18:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn5q0hfwqI0dhpTw7BP5PC4vtlfFnCb3e7OR+MrMnkFJn1cVtFv4AmqtSp2qX1/sz0S8hHNasV6cqQ+mSTKTlVKOhH6ZTPLYy4jp94yPkeWuUoXapv87gEO7G4scgdzY/l5ru623fmFwQGHAQqTM7lqIhYp6vrsdIXGM7H2PCTaH0BnDvmkjjjAdhJaZGmkimmpER9jxtfzX93yL0m65jTV4zeLKjLmDNTPXvwsfwk1rCslvRluhlt2IiOOzhgnaBhX3QTih0Ogf/PP6G9Swq6IRioYtgoEFVLiKy2dGA8Hf5xixIxDvxG39VT2LAuSY92EuZNJCGoQtA3bBos9LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFJa7jZ6jzyysMYtVaoVkojB+dM9rfbKr57BZp5Uce4=;
 b=meOOahMKEdtJEdX5NGhr2lnB88BnxQTVk9SmsyxZ8/wtUAji31AG/GQqcOBm0kf9EnxDoQGfI2NT+VLmGncMwb3indNTyYHhBxFOOMDE5JBT8PRBLfujcsaM9Ue6AP8PNFDbPrJOOeyIcRnJrIhZ+N7uS9zmV3FCgKgbGKVzWJB/gkx2ve0S/e2GbijXArvmEssT1eb6HL6I6yySQF1wmOtf6DHsljCljXrwm0KUxFsKIWaavJQQSUi0OLQBAkcK9HazJU7mxLNNc+IKVDYZ0M3c5esj3HDr47J9JgSdtP15Yt12LRqqzunJ3qXOpZF1tamZsC1/f2EnO/BydFsxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFJa7jZ6jzyysMYtVaoVkojB+dM9rfbKr57BZp5Uce4=;
 b=XCvwCceP4bIRNJPrm3N2O0goVt7qmrQCIJ5B1RxKyvEoGYTwXie23RKU2+67CiL0j9VsyeegaPtQ2QsLkDenHVUiq3PVgTwusI0VfwBPeGVtygDwmO7somUIHPaNttL9RBEiCMe09SjgFnBrxY6IJouEWOKzDGq2pIknN+uJ/OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM6PR08MB6203.namprd08.prod.outlook.com
 (2603:10b6:5:1e3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23; Thu, 14 Dec
 2023 02:12:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:12:03 +0000
Date:   Wed, 13 Dec 2023 20:11:57 -0600
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
Message-ID: <ZXpkbbFs6iBg0GCA@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-3-james.ogletree@opensource.cirrus.com>
 <ZTh3qSAjIaj/oonc@nixie71>
 <6DECA9DD-B464-446A-B6A1-5EECD4FF5E0B@cirrus.com>
 <ZWKW6BY9C3a9covT@nixie71>
 <95C3C010-DA09-4848-A5AB-635AD93DCDC3@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95C3C010-DA09-4848-A5AB-635AD93DCDC3@cirrus.com>
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM6PR08MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc04738-78b2-4e38-3e39-08dbfc4a0fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cY8r9eNWbRa1xWJyXvip8qCKM5aqn2uoeAdS7IJAHFDeQ2AofVF0a8e6C2IsrVJojorEfJuQLcylTOYc62X4JXYsYFNwWnt+yI/0bdgn0l2USJmPwJCHvwnhAxWBSA9kOBZd0I7zEQsnZ7nFHB0XnycXru7bEU4e9FsaCXsqZ1Rlzu25I9sZ65xT/pFSKxChH3771McsY7lbwotcVCz0++mrQnK1jMnN+NBlwxE0KxWnT7NTYn5bjB7E77Kjr/GY1OZKutc3tMhJKQ2CB2Crxo+bjvigfu3M1x9dmiQMVaM9W/8Do4m3RoMb5wuySEF8NlxVhe4mpAwLLzi4mwLxmGRTiDo1Gb1Fjlyhf7Zk9NYsm/YGLagxUVFgJElH5k42LHAn/kk78lBwheYuddrSzSws0ZHAuEP/kPV/1bfr5XFCI3ER/MWJI55WFaep/k76swnLAL8GBC0XzKjhmuFK7pf2lduhHN671ddrUQ8EJ5S1tcz2k5MrdUgir49yLV+6R5ueNR/BheZHW65ckx7xCM1LHwvVryD8ZjNi1FOisX3SE78PrRfcHpZzZP2zt6T2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(346002)(39830400003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(2906002)(478600001)(86362001)(41300700001)(66946007)(30864003)(54906003)(6486002)(66476007)(66556008)(7416002)(6916009)(38100700002)(6666004)(316002)(8676002)(8936002)(4326008)(6506007)(6512007)(9686003)(33716001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JiZWJGa3d2MDhmYnpjVUM5empBQ1RTc1p1c0xaS0VqZXVtTC9nOEd0WFlW?=
 =?utf-8?B?S0ZFdGZkN21CMXB0ajNGZFBnUGxTdjNFVlcrUlM3cDg3RFFsOUsxOVdtNER3?=
 =?utf-8?B?V1RRcjdYREEvdHdoQkpJUXFOK2o2TlBodmRFZHlFOTl2elEyNnZLT1h2M2RS?=
 =?utf-8?B?RGhnaVJ4Z2pWMU5PR2RLTnBoN3QwSW5oeWVkaVcxTTYwMU5Xb3MyRWZDZDgw?=
 =?utf-8?B?VWd6dVZzVHNSS2hNVWJkekJUUGRoQ2lXSUdyNE5Canh2bHkwd0dTRFlOSEtQ?=
 =?utf-8?B?SmxEZTlRcVd6SGJWNVA0MWtLZDc5T2RISUFUUWI5cWMrZklOc2g2TXo1MW9B?=
 =?utf-8?B?UUkvcVpOYlovSWgwWU1QSjdLQW11emx6c1FDenNJSDV2K1dVQitLaXBWM0dj?=
 =?utf-8?B?ZlVxSDRZOUZJUFJKZHFnYW41SGM3VG1lYUx6bHVPMjFHVHlpSUdoeENRd0h2?=
 =?utf-8?B?d0hyZzV1SzlrSm5mTCtMZ2FNL1FPaXVENGN0N1MzT0M4NEMwYWR3Nmk4MnND?=
 =?utf-8?B?MzBLOWl0QXFPYUI3WE1adjhueWp3c2VTOWtMRldzQ2pXcGwwVHVFd2orOURh?=
 =?utf-8?B?TkVhamw5R090WkFnSC9Sdk4zUXdQU0RKaWpXQmFEcmQ2cUdiaXFyM2V6WHdt?=
 =?utf-8?B?c2FBUURmRFBOOGhXMXZrbWVFVzEza2J6dFl1UEJvdmZYMy84ZklzRmtYY1BW?=
 =?utf-8?B?WEV3REo2Tjk5TzY0MFZIM25VZ2dNeFF6YWViZVNiMTBJR3BRY3VSWi90bVZ0?=
 =?utf-8?B?c2JiUWN2Z1pXeWhlc1FPdUNZQ1k0ZHErckh4ODBla1VZc0ZMVE1FWHJGemsy?=
 =?utf-8?B?NFhIbGphTXhXY1BqZGU0ZkhFRzh5VG1lMEZzemJQc0VvdTZST0NZbWRycHRT?=
 =?utf-8?B?VnB2Z21PWmVoT2x2OE5DcnVCUjJ6OW1ueHFQbGhWdnVPSFRTWWhpalJFeVhr?=
 =?utf-8?B?WkcwSCs0THVMUCsrcnkxL2ozaXdSbGluTU9hblJZYjRkY3ZtOVV6YnN4aWhR?=
 =?utf-8?B?SUdHOEQ5TWw3QWVZUHROM0N6UnNtS3U4MFlMMW4xYWFrVHQ5bWhUWEl0T3dP?=
 =?utf-8?B?ZUtwSzliOTV4SDNOLzNkeXJqald5QXRxdDFuOGx3SC90NUN4aDNuSzJ6MmlR?=
 =?utf-8?B?VVBMdk8wQzBvQ3BxVmlOSWdQb2l1WGRSZDlzRzZwazVJdUtnamNTcXlPaUM4?=
 =?utf-8?B?WFB0Z2g1UG4xcCt0STZWZFk5cGVIcVd0c09pamhnci9GQ3pBRmpBY1VKOU9k?=
 =?utf-8?B?L3NxSjE5WVY0eEdQNktlN1g1Nnh2am1uVTVQcHM3M3FsMHVjZDNnSnhJeHJ4?=
 =?utf-8?B?bThxd01pek1CMkJid3lmWVFBOC96YWFHMVpPa0ZzOFhEa2h4RzZya2c4YlFa?=
 =?utf-8?B?cnFRUXRpVEZZK2tPVU5BWjhUQnhjbmxQRFJ3V3pNZ215bHRhYktQNndydkpG?=
 =?utf-8?B?d3dsSWFVYmNzNDNEMUdtSkc0KzY1b1pjdnhyYmJ3RHFjMUhuSi92bVJVL0Qw?=
 =?utf-8?B?ZzlNR0UyVmk1K1FrZ0dzRXEyQzN1bXJHcVhzOEh2dFBQNGdpSDZ0Z1JjMXFM?=
 =?utf-8?B?UmgyNzhNSGFYbUU5MHB0RnJnT0xOT1VLSWNiYitjdnN0TGcvS2N2eEhKS2VZ?=
 =?utf-8?B?K1JxQW1uSzJRVFFqendUZ1MyWmxDY2pkNGJyaEJpTURzaG41M2hCczdaYjZN?=
 =?utf-8?B?MHRtNVg4by93NGhEeERGM2gxTkd5WFArWjJrTWlReTRvTHUwMzlsSWptdER3?=
 =?utf-8?B?OXMzTUlNRjFsZ0FaTXpISkNLdlV0TUVuKzlhZE1OV0kyOFJrWEJOMTdpVVhJ?=
 =?utf-8?B?Rk1ia0JBS0JuUUlBcnl0SWQ5RkdiMVY0Ym1VaUIwcHB1dUtzQTlXd0xUcDNM?=
 =?utf-8?B?SXYrTnRSWmpSeEc3SEhNUkJYeGZQaStnUTl5ZFZSWnFpSXN5ei9pUkllTzRR?=
 =?utf-8?B?NEJDMzcyanhmU0FNbXNOZ1dzTDZmK0ZBaU5UT3BReHVCTEVHRjJ2SzZXNUhV?=
 =?utf-8?B?aEkwSWwxMnNNS0p1R2pNUnV1MzIxbHNYVFFvdUxZZjBGVVlWL0E4bkhpMGJ0?=
 =?utf-8?B?SmtkbWhLV2pldVlFUTg3cTg5NmsyaTZ1aFVJZ1JSb1B3VWViU3p1RUNGd1Bm?=
 =?utf-8?Q?6Z5ePLA5i1T5TPtulq7am0AeF?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc04738-78b2-4e38-3e39-08dbfc4a0fed
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:12:03.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rfEVCRgFsw0h63OexJ25A3C1KXZzRhXtawMWp/cvggAEVtXp2U4xDQtxkN8B4uQLe3YSNqNEE/ajG67VzPcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6203
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

Apologies for the delayed response.

On Wed, Nov 29, 2023 at 10:22:16PM +0000, James Ogletree wrote:
> 
> >>>> +
> >>>> + words = kcalloc(haptics->dsp.pseq_size, sizeof(u32), GFP_KERNEL);
> >>>> + if (!words)
> >>>> + return -ENOMEM;
> >>>> +
> >>>> + error = regmap_bulk_read(haptics->regmap, haptics->dsp.pseq_reg,
> >>>> +  words, haptics->dsp.pseq_size);
> >>>> + if (error)
> >>>> + goto err_free;
> >>>> +
> >>>> + for (i = 0; i < haptics->dsp.pseq_size; i += num_words) {
> >>>> + operation = FIELD_GET(PSEQ_OP_MASK, words[i]);
> >>>> + switch (operation) {
> >>>> + case PSEQ_OP_END:
> >>>> + case PSEQ_OP_WRITE_UNLOCK:
> >>>> + num_words = PSEQ_OP_END_WORDS;
> >>>> + break;
> >>>> + case PSEQ_OP_WRITE_ADDR8:
> >>>> + case PSEQ_OP_WRITE_H16:
> >>>> + case PSEQ_OP_WRITE_L16:
> >>>> + num_words = PSEQ_OP_WRITE_X16_WORDS;
> >>>> + break;
> >>>> + case PSEQ_OP_WRITE_FULL:
> >>>> + num_words = PSEQ_OP_WRITE_FULL_WORDS;
> >>>> + break;
> >>>> + default:
> >>>> + error = -EINVAL;
> >>>> + dev_err(haptics->dev, "Unsupported op: %u\n", operation);
> >>>> + goto err_free;
> >>>> + }
> >>>> +
> >>>> + op = devm_kzalloc(haptics->dev, sizeof(*op), GFP_KERNEL);
> >>>> + if (!op) {
> >>>> + error = -ENOMEM;
> >>>> + goto err_free;
> >>>> + }
> >>>> +
> >>>> + op->size = num_words * sizeof(u32);
> >>>> + memcpy(op->words, &words[i], op->size);
> >>>> + op->offset = i * sizeof(u32);
> >>>> + op->operation = operation;
> >>>> + list_add(&op->list, &haptics->pseq_head);
> >>>> +
> >>>> + if (operation == PSEQ_OP_END)
> >>>> + break;
> >>>> + }
> >>>> +
> >>>> + if (operation != PSEQ_OP_END)
> >>>> + error = -ENOENT;
> >>>> +
> >>>> +err_free:
> >>>> + kfree(words);
> >>>> +
> >>>> + return error;
> >>>> +}
> >>> 
> >>> My first thought as I reviewed this patch was that this and the lot
> >>> of pseq-related functions are not necessarily related to haptics, but
> >>> rather CS40L50 register access and housekeeping in general.
> >>> 
> >>> I seem to recall on L25 and friends that the the power-on sequencer,
> >>> i.e. PSEQ, is more or less a "tape recorder" of sorts in DSP memory
> >>> that can play back a series of address/data pairs when the device
> >>> comes out of hibernation, and any registers written during runtime
> >>> must also be mirrored to the PSEQ for "playback" later. Is that still
> >>> the case here?
> >>> 
> >>> Assuming so, these functions seem like they belong in the MFD, not
> >>> an input-specific library, because they will presumably be used by
> >>> the codec driver as well, since that driver will write registers to
> >>> set BCLK/LRCK ratio, etc.
> >>> 
> >>> Therefore, I think it makes more sense for these functions to move to
> >>> the MFD, which can then export them for use by the input/FF and codec
> >>> children.
> >> 
> >> I think the problem with moving the write sequencer code to the MFD
> >> driver is that it would go unused in a codec-only environment. We only
> >> need to write to the PSEQ when we want to maintain register settings
> >> throughout hibernation cycles, and it isn’t possible to hibernate when
> >> there is data streaming to the device. So the PSEQ will never be used
> >> in the codec driver.
> > 
> > I agree that in practice, the write sequencer would technically go unused
> > in a codec-only implementation. However, that is because the ASoC core
> > happens to write all pertinent registers ahead-of-time each time a stream
> > starts. That is a property of the ASoC core and not L50; my feeling is that
> > the driver should not be structured based on what one of the subsystems
> > associated with it happens to do, but rather the nature of the hardware.
> > 
> > Some specific reasons I think the MFD is a better home for the pseq code:
> > 
> > 1. The write sequencer is a housekeeping function derived from the way
> > the hardware implements its power management; it doesn't have anything
> > to do with haptics. My opinion is that facilities supporting application-
> > agnostic functions belong in the MFD, for all children to access, even
> > if only one happens to do so today.
> > 
> > 2. Over the course of the IC's life, you may be required to add errata
> > writes after the IC is taken out of reset; these presumably would need
> > to be "scheduled" in the write sequencer as well. These wouldn't make
> > logical sense to add in the input driver, and they would be missed in
> > the theoretical codec-only case.
> > 
> > 3. This device has a programmable DSP; it wouldn't be unheard of for a
> > customer to ask for a new function down the road that begets a third
> > child device. Perhaps a customer asks for a special .wmfw file that
> > repurposes the SDOUT pin as a PWM output for an LED, and now you must
> > add a pwm child. That's a made-up example of course, but in general we
> > want to structure things in such a way that rip-up is minimal in case
> > requirements change in the future.
> 
> Great points. I agree now that the write sequencer code ought not to go in
> cirrus_haptics.c. After talking it over with the internal team, I am considering
> moving the write sequencer interface to cs_dsp.c. It’s an already existing
> library with both Cirrus haptics and audio users. It seems to dodge your
> concerns above and avoids a new common library as you suggested
> below. Do you have any concerns on this approach over putting it in MFD?

I think that's a great idea. Not every DSP-equipped device has a write
sequencer, but most, if not all write-sequencer-equipped devices have
a DSP. Adding the write sequencer code to cs_dsp.c seems like a natural
union of the two facilities.

> 
> 
> >>> This leaves cirrus_haptics.* with only a few functions related to
> >>> starting and stopping work, which seem specific enough to just live
> >>> in cs40l50-vibra.c. Presumably many of those could be re-used by
> >>> the L30 down the road, but in that case I think we'd be looking to
> >>> actually re-use the L50 driver and simply add a compatible string
> >>> for L30.
> >>> 
> >>> I recall L30 has some overhead that L50 does not, which may make
> >>> it hairy for cs40l50-vibra.c to support both. But in that case,
> >>> you could always fork a cs40l30-vibra.c with its own compatible
> >>> string, then have the L50 MFD selectively load the correct child
> >>> based on device ID. To summarize, we should have:
> >>> 
> >>> * drivers/mfd/cs40l50-core.c: MFD cell definition, device discovery,
> >>> IRQ handling, exported PSEQ functions, etc.
> >>> * sound/soc/codecs/cs40l50.c: codec driver, uses PSEQ library from
> >>> the MFD.
> >>> * drivers/input/misc/cs40l50-vibra.c: input/FF driver, start/stop
> >>> work, also uses PSEQ library from the MFD.
> >>> 
> >>> And down the road, depending on complexity, maybe we also have:
> >>> 
> >>> * drivers/input/misc/cs40l30-vibra.c: another input/FF driver that
> >>> includes other functionality that didn't really fit in cs40l50-vibra.c;
> >>> also uses PSEQ library from, and is loaded by, the original L50 MFD.
> >>> If this driver duplicates small bits of cs40l50-vibra.c, it's not the
> >>> end of the world.
> >>> 
> >>> All of these files would #include include/linux/mfd/cs40l50.h. And
> >>> finally, cirrus_haptics.* simply go away. Same idea, just slightly
> >>> more scalable, and closer to common design patterns.
> >> 
> >> 
> >> I understand that it is a common design pattern to selectively load
> >> devices from the MFD driver. If I could summarize my thoughts on why
> >> that would not be fitting here, it’s that the L26 and L50 share a ton of
> >> input FF related work, and not enough “MFD core” related work.
> >> Between errata differences, power supply configurations, regmap
> >> configurations, interrupt register differences, it would seem to make for
> >> a very awkward, scrambled MFD driver. Moreover, I think I will be moving
> >> firmware download to the MFD driver, and that alone constitutes a
> >> significant incompatibility because firmware downloading is compulsory
> >> on L26, not so on L50.
> >> 
> >> On the other hand, I want to emphasize the amount that L26 and
> >> L50 share when it comes to the Input FF callbacks. The worker
> >> functions in cirrus_haptics.c are bare-bones for this first
> >> submission, but were designed to be totally generic and scalable to
> >> the needs of L26 and all future Cirrus input drivers. While it might appear
> >> too specific for L26, everything currently in cirrus_haptics is usable by
> >> L26 as-is.
> >> 
> >> For the above reasons I favor the current approach.
> >> 
> > 
> > Likewise, if the input-related functions of L26 and L50 are nearly identical,
> > then it's also perfectly acceptable for both drivers/mfd/cs40l26.c and
> > drivers/mfd/cs40l50.c to load drivers/input/misc/cs40l50-vibra.c, which
> > supports both L26 and L50 haptics-related functions. You're already doing
> > something similar, but I disagree on the following:
> > 
> > 1. Rather than have a library referenced by two drivers that support children
> > which are largely the same in a logcial sense, just have a single driver that
> > supports two children.
> 
> Your point here is clear and makes sense to me, especially now with the write
> sequencer interface moving out. After considering the similarities and
> differences closer, I am still a little wary. Maybe you can help me with these
> concerns:
> 
> 1. In the current implementation, drivers would be able to configure their own
> input FF capabilities, and selectively register to input FF callbacks. L50 does
> not register to the set_gain callback, whereas L26 does. I anticipate future
> divergences, such as one driver supporting different effect types (see
> the L50-specific error checking in cs40l50_add()). This would be exacerbated
> by any future additional children.
> 
> 2. This may be my lack of imagination, but in the current implementation it
> seems much easier to develop new haptic features that don’t apply to all the
> users of the library. One would simply wrap the feature in a boolean in
> cirrus_haptics, which clients can take or leave. In the one driver
> implementation, it seems you would have to find some clever, generalized
> way of determining whether or not a feature can be used. This would also
> seem to be exacerbated by any future additional children.
> 
> 3. The current implementation provides for the individual drivers to setup
> the haptics interface in whatever way peculiar to that device, whether that
> interface be static (L50) or dependent on the loaded firmware (L26).
> 

Maybe the solution here is to define a "descriptor", that is a struct which
reserves members for all things that can vary based on device (FF callback
pointers, input device capabilities, etc.). You then define an array of such
structs, with L50 being the only member, and L26 and others to come. Then,
cs40l50_vibra_probe() would simply parse the array index based on the device
ID hinted to it by the parent MFD.

As the person not doing the actual work, my naive opinion is that you face the
same problems whether two different drivers reference a library, or a common
driver supports two devices. The problem is therefore cosmetic, and if so, we
should tend toward a design pattern that seems to be most common in the input
subsystem, which is to support as many devices as possible with a single driver.

> Since I am moving around a lot of code in and out of both -vibra.c and the
> library for the next version, I think it would be helpful for me to wait until the
> next version is submitted to decide on this. Would that be acceptable?

I very much support moving in incremental steps; if you still feel strongly
against my suggestion, let us by all means evaluate your approach in the
context of the other changes.

> 
> > 
> > 
> >> 
> >>>> +static void cs_hap_vibe_stop_worker(struct work_struct *work)
> >>>> +{
> >>>> + struct cs_hap *haptics = container_of(work, struct cs_hap,
> >>>> +       vibe_stop_work);
> >>>> + int error;
> >>>> +
> >>>> + if (haptics->runtime_pm) {
> >>>> + error = pm_runtime_resume_and_get(haptics->dev);
> >>>> + if (error < 0) {
> >>>> + haptics->stop_error = error;
> >>>> + return;
> >>>> + }
> >>>> + }
> >>>> +
> >>>> + mutex_lock(&haptics->lock);
> >>>> + error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> >>>> +      haptics->dsp.stop_cmd);
> >>>> + mutex_unlock(&haptics->lock);
> >>>> +
> >>>> + if (haptics->runtime_pm) {
> >>>> + pm_runtime_mark_last_busy(haptics->dev);
> >>>> + pm_runtime_put_autosuspend(haptics->dev);
> >>>> + }
> >>>> +
> >>>> + haptics->stop_error = error;
> >>> 
> >>> This seems like another argument for not separating the input/FF child
> >>> from the meat of the driver; it just seems messy to pass around error
> >>> codes within a driver's private data like this.
> >> 
> >> I removed the start_error and stop_error members. However I think the
> >> erase_error and add_error need to stay. I think this is more of a symptom
> >> of the Input FF layer requiring error reporting and having to use workqueues
> >> for those Input FF callbacks, than it is to do with the separation of these
> >> functions from the driver. Point being, even if these were moved, we would still
> >> need these *_error members. Let me know if I understood you right here.
> > 
> > Sure, but why do adding and removing waveforms require workqueues? The DA7280
> > driver doesn't do this; what is different in this case? (That's a genuine
> > question, not an assertion that what you have is wrong, although it seems
> > unique based on my limited search).
> 
> The reason why we have worker items for upload and erase input FF callbacks is
> because we need to ensure their ordering with playback worker items, and we need
> those worker items because the Input FF layer calls playbacks in atomic context.

Got it, that makes sense. Presumably, the act of adding or deleting waveforms
directly manipulates XMEM and YMEM regions of the DSP, and we cannot do so while
they are actively being read during playback. Acknowledged on all counts.

> 
> Best,
> James
> 
> 

Kind regards,
Jeff LaBundy
