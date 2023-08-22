Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5365784113
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjHVMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbjHVMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:43:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076D1BE;
        Tue, 22 Aug 2023 05:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR/wJlSRcbZKT3h/yjn6kqZNI0NuDTqdaD1bn40wuvvBnfzlE+Ks3cUQUkMe8QqoxmOmmsfFOjSAvfO75yHGGPtguCT95vWDNVn3e5blVeKV0YKklOqDBfhJBTrR3HyIXw0sa5wlzFKI9XlB00gZjgjqgK8jvddMTOzkZ/MGc2G4z/fSt7GMouplOX2OhL/fUbCHugwvTAjPw2DfOn0RKfIXmBs244ouzEyrwuEP/gJfhGGQAkSmHBtAfaDIZJotiWo63rUnCLNS/xD31qyKjdZ05gnD46zUZiDhhGZceTP4KzL8p2lmGkb8HLXryrW3X7zoZ+4iBBE/RLhTx4wJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Odd+VUWQIGOuHcEumkAuLEvZzK2xOhY/7vEFTn/pk=;
 b=XjP4LQmgacOGboLXHghwSGlDFvmIrvyp9/zZpEOW2GApVNczlQtbM/bdeVmCOeTZ2oohGgIstDEagGErSRb9RsSvv3E/IG94kpMLpE71OhmhoyTDoXz6041pDMyHCjZpQTn1WCQNc9y81ejaeUXVcvY949cLeavviSTP7pSqnGDe4wN4imhxcy81o69NZiAPfH8LP89M8RnVU9n/XN5AOWEQzODHJH6lBH5FjV2xX2/lSBcULRwKsaOZqY5ulqIFi1lKTcxN5yiv8RxKDT4r2MnQxACYnMRfi40//UMdRUuNNle1/WOHR5fWnNNf0J6oDLuatkTi9wJ1Ob1jW5zI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Odd+VUWQIGOuHcEumkAuLEvZzK2xOhY/7vEFTn/pk=;
 b=gFo2ojdgxlRjkVvNxFhnxfClTUnAKdxOeB0usxln1HZ3TM+4WIsH0woncKVff/wgABXMS9rmnev4STwca5Nwfd371Zt7Qdx4p2w0OYVmtBrFvNwJ4fkR4glA1Ew9WFXEEsoi0VYmNuRv/dwUH8HLA8DVq8mi789r0gKoMx36u4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BN0PR08MB6837.namprd08.prod.outlook.com
 (2603:10b6:408:12f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 12:43:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::69d8:51a3:96da:38a4]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::69d8:51a3:96da:38a4%5]) with mapi id 15.20.6678.031; Tue, 22 Aug 2023
 12:43:25 +0000
Date:   Tue, 22 Aug 2023 07:43:06 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Bai <ping.bai@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Message-ID: <ZOStWl7LG72XgYcc@nixie71>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <ZNWz7F7qLeNKDlG/@nixie71>
 <7C3D1F80-556D-463E-85AD-AFA48CADAF5E@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C3D1F80-556D-463E-85AD-AFA48CADAF5E@cirrus.com>
X-ClientProxiedBy: SN6PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:805:de::36) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BN0PR08MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 60489dc1-0972-4b8a-7573-08dba30d609e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+vTY99k1Vgu1nXIklQnjIEmyBCwOMuNsTRlvaNnNcT8XPPNb2+XGklmG8VXGss0hmLpn7/TA80/HtP4Jy7gzu63UZALGTXMHn6uf5V/RfmwQM+7IhkWbshvKXD4YgLG9bDuQuXhrYc5HhqxaIT4h7ddVNgWDiWQoFN1SPDygcn7aqEvFEHUakKIqmPfh+LtOkmlxWmFQL0bRLRc1oZQ+vZp2JAkV0AefhGQBoaxuzjnQvhet3JmHYphD9IhWBhtYlb8hyrMS9eUZYTzOij7tkNuGQLP0Ums3HfPfY5EMABZUu0+/qJkuW4lC6s64xD1HgISd3AUaxW0cpF1yV+Fhip5va1qVrBU924c65hFb17Ai9DyEZtQeL7q2XKTNkpNPoqtpjR8PvKQZlIA2FfLYrjoYf2q43QV7lUrmxljMahQMaY0F3+uWMehuM2UW2Qu2nYgFiHkNGojxTS0rWHEed+cTfLgQY9blrfP/mE0/sQzz1nGNvGdo4o0jq+yg/B5JtUTEikAzEQpApH5LDDuPH0Nf+dC9BH35rO6hACbBp0w2NB4l/j6vnoB1aqi7JEO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(396003)(39830400003)(346002)(186009)(1800799009)(451199024)(478600001)(6486002)(6666004)(6506007)(26005)(9686003)(6512007)(53546011)(2906002)(7416002)(33716001)(41300700001)(8936002)(6916009)(66556008)(4326008)(66476007)(8676002)(66946007)(316002)(5660300002)(54906003)(86362001)(38100700002)(83380400001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdWTm5NSlVRUWkxNmM0UmtNWWFKV1MxMmJsK1I5YkI4eFExVkhiZFk3d1BH?=
 =?utf-8?B?NU5NSkZUZ0VHVDBzU0c5Zm5zWS9XSlFoaFkwMEZLNGdnbmhwWjhJcDBqRU5O?=
 =?utf-8?B?Q1VrSitlSWZPTi9WaytSOHNYREtNeDE4L0pzNlFCYTFzRnp2bHV2SHJlZmhV?=
 =?utf-8?B?VWNBYTVvaVRnbGF6UnBzVjdDdlJJMGFCTjNMMFlacVh4WXd4Qkk5NmFtU29H?=
 =?utf-8?B?VnV3UGFuS1NhWlFiY3BpOVpuY0RwbGFBc1I4Q3lRaWZrVVY0b3ZWaWoraVA5?=
 =?utf-8?B?ZEZDcDJPL0ZaTWVNc1dYenR6QzdZVS9MdHVJUGlkVXEyTUR2SFFtQVQ3Rmxz?=
 =?utf-8?B?OUFuMGI1aExFS1Z3aHFtQXNpUEJHWE13Tiswck1JT0Rnc2JLYzJtb0ZJN1Nq?=
 =?utf-8?B?OHRmTW5rdXY1MUQzSnZzQ0NwYVd0dHM5bXQ0ejRqU2d1alRKeGVkcFhnS0Rh?=
 =?utf-8?B?OWM3WEJIQ3BUVEIvTXphaUh0b1ZRQS9lZGhVNWl1S3hzUFFwMGQ3WVg4ZmJs?=
 =?utf-8?B?M1lLNVJ5RTUxUURRQzNzTGxzaFRoUXIvazg3ZDk0RCs3YXdrckZGNUk4akVx?=
 =?utf-8?B?R2Q5ZkwrN21laUZ1SndoWGwwdEt3S3djUEcyTGs5ME1UVDc1YkZtSllndEUv?=
 =?utf-8?B?cHZGQUpoL0NxNi84c3BYSEhLdWRDUVM5STl4NVpzaU9MN0tmK0RkRzhQc2FX?=
 =?utf-8?B?V1cxdkJudHpxY28xcGhQUmxXY21KcnZUcFNRRTU2cDZPUWs5WUtqRnpxK1da?=
 =?utf-8?B?WXNaVVoyWjFnSjNqYUFiRmp2cW4vaVJRQ0R1dU40eGhYSzhVK2h2YlFoSk00?=
 =?utf-8?B?U093Ung5bXFTYnd3WGpvc05vWTJuaXJZRWZVZzloV2pwaEtnQlJOckN0SzVh?=
 =?utf-8?B?Wi9QekgzM3ZFK3BidE9pUDJ1ekNoZDlmRFBiaVdndnMyYlU2R0FvUTEwYkp1?=
 =?utf-8?B?YkI2Mm5nNHdNNmF6aWRnUXppSm5vbllCUzl2eTRvN0d6SnVFaGE1a0M1d2dJ?=
 =?utf-8?B?d2V3K3hTbEx5YU1JZTRFdVdyZ3dMK3lyVzFNOUZ5ZnRCZzEvSFF3cDR4R1ZW?=
 =?utf-8?B?aTFKeEVuNEVBaEgzdFpFa2RodXhXL0x5bjZFVFlGMlVROW0wa0NicFNWSmxn?=
 =?utf-8?B?ZUdaQVZpSTdxcnpqcitnSlUraHB0cHhOQWprNm9CalFBaDdRVmY1dkZSaUdJ?=
 =?utf-8?B?VHd4dmkxdGJBUmFwZVMyaWtiTFFPdjVKVEpVWmY5bDMwckNaamJJSWVDSW1M?=
 =?utf-8?B?VFZGcmRuMmk4ckw4eUdlQTRBWnlKcFZ0RGFsUTNpUjJ1Z01TTWtJVGtSM3Zp?=
 =?utf-8?B?bkRscDgzdm1nSEVZeEdHR2ozNzB4MTdBanY2RXB5eVVjUTNvSWowblYvcXBH?=
 =?utf-8?B?TGZzbEEranRLTkp1VTRGajZ0OVUrZWVZcVJZcTZQZWxzc2MrcWgwalB1M0oz?=
 =?utf-8?B?cTBQYkpkenRWR3hOT3pWcFh2anVpank4Y1lPSEg2Wkc2SWgxK01Mc1kvR1RB?=
 =?utf-8?B?UzdkYWNneTBSZjNJTzBBamphd1pDRjQ3cEpvZzVtUGtNdUh2RHd2UklzSlFi?=
 =?utf-8?B?NnRzSHFqNDNpbXJLODEzZ1FTT2wzdWFYbkNENFJtWGl4VkV6dWNFVGRzVnRJ?=
 =?utf-8?B?ZzVpeWs4c3U0RjdwZzdWd1hMVElWeHhxTWt2M0o2MWk4aHFIbW1VZzU5LzZI?=
 =?utf-8?B?OE5VUlV5bUc4UmdaeXFGcVZwUityaWI1T2JtUXZUeGdyQjY1MG8wcTBab3N4?=
 =?utf-8?B?TVoydTFkU1RuSDg5dTdoY2l2NS9VdkxMRjNSZkk2WW5RTXFNaUxBbXlaNHIw?=
 =?utf-8?B?cm9wQlpoRDlLOGkxRlNrZldHbGhLbzBXbEpVeWpLOFR3N2ExcG4vWFZ4Um5k?=
 =?utf-8?B?R1oycFdMYmt2dTYxTGpTN3piQU1IVHlTZitFUTJVVXpZcnZSSEFFQmRISzMx?=
 =?utf-8?B?Mzl3YytCUDBWNTFkNlN2WGpSS0FLWCs0L2FCaUFwd0dGVkx0RFZBY2dVNXRq?=
 =?utf-8?B?Y2oyOHJHbUFDakJROWVtRjhyWlBXT0lnUWFDMGNZVXNGTDZiNTNDekoxNWhh?=
 =?utf-8?B?V1N6YWZoODhrVEJwV05TMXZFRTZjU2hSeDAzN3lvem93eWhNdUJkTURpNFdT?=
 =?utf-8?Q?VK1aIsQiD8Ap+tVv+VdrVqWTR?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60489dc1-0972-4b8a-7573-08dba30d609e
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:43:25.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBdZ6Za0y+AoXFoLHfxBy8a1abqfdYD8Ve9vizD4YWYvTODVtlHiyjxssR+RjTrxA40umfmo1AEplYejLi4rmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR08MB6837
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Aug 16, 2023 at 09:02:26PM +0000, James Ogletree wrote:
> 
> 
> > On Aug 10, 2023, at 11:07 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > On Wed, Aug 09, 2023 at 07:10:28PM +0000, James Ogletree wrote:
> >> Introduce support for Cirrus Logic Device CS40L50: a
> >> haptics driver with waveform memory DSP and closed-loop
> >> algorithms.
> > 
> > From my extremely naive point of view, some of the code that follows
> > bares resemblance to the recently reviewed L26. My assumption is that
> > these devices are different enough in nature to warrant completely
> > different drivers; is that accurate?
> > 
> > One reason for asking is because the L26 driver included a cornucopia
> > of power-management overhead, yet we see none of that here. Assuming
> > both L50 and L26 are built around the same Halo DSP, why is there such
> > a fundamental difference between the two in terms of power management?
> > 
> > To that end, how does this driver handle hibernation? Is hibernation
> > not supported, or do we simply defer to the DSP? In the case of the
> > latter, why is L50 given this freedom but not L26?
> 
> One key difference is that L50’s Halo Core DSP is self-booting; the firmware
> is burned in and no firmware download is required. On L26, firmware
> downloading is compulsory. This differentiates dealing with the DSP in the
> two drivers, because the L50 driver does not need to do a look up every
> time it reads or writes to a firmware control. The registers are all static.

Interesting stuff; thanks for sharing that background information.

> 
> Minor reasons are that they have different power supply configurations that
> require different register settings, they have errata differences, and a different set
> of exposed features (L50 being much more simplistic). I think taken cumulatively
> these differences warrant separate drivers. Though, I will take Charles’
> recommendation to factor out the similarities into a shared library that both L50
> and L26 can use.
> 
> Let me know whether you disagree on the above points or have followup
> questions.

Makes sense to me.

> 
> With respect to power management, I did not think that that there was any merit
> in itself in maintaining equality with L26’s approach, and I was inclined to accept
> your reasoning for using retry logic over the runtime PM facilities (not that the
> latter way is incorrect).
> 
> Regarding the need for I2S streaming support, signs point to maybe. I will
> migrate this driver to MFD for V4.

MFD seems like the right (i.e. scalable) solution if A2H is on the roadmap.
In early L25 days, very early adopters simply asked for a sysfs control
exposed from the core (then LED !!) driver to enable/disable I2S streaming
mode, but this got hairy in case customers needed to control BCLK/Fs ratio,
bit depth, etc. during runtime.

From my naive point of view, maybe the solution looks something like this:

* drivers/mfd/cs40l50-i2c.c: I2C client
* drivers/mfd/cs40l50-spi.c: SPI client
* drivers/mfd/cs40l50-core.c: common tasks such as FW loading, OTP management, etc;
  perhaps L26 can leverage it as well
* drivers/input/misc/cs40l50-vibra.c: FF-specific support (name as you like, I just
  picked what seems to be most common)
* sound/soc/codecs/cs40l50-codec.c: codec-specific support

In case I have misunderstood, please let me know.

> 
> > 
> >> + return cs40l50_dsp_write(cs40l50, CS40L50_BST_LPMODE_SEL, CS40L50_DCM_LOW_POWER);
> >> +}
> >> +
> >> +static int cs40l50_patch_firmware(struct cs40l50_private *cs40l50)
> >> +{
> >> + const struct firmware *bin = NULL, *wmfw = NULL;
> >> + int error = 0;
> >> +
> >> + if (request_firmware(&bin, "cs40l50.bin", cs40l50->dev))
> >> + dev_info(cs40l50->dev, "Could not request wavetable file: %d\n", error);
> >> +
> >> + if (request_firmware(&wmfw, "cs40l50.wmfw", cs40l50->dev))
> >> + dev_info(cs40l50->dev, "Could not request firmware patch file: %d\n", error);
> >> +
> >> + if (wmfw) {
> > 
> > It is a much more common design pattern to bail if request_firmware() returns
> > an error, than to proceed and check against the FW pointer remaining NULL.
> > 
> > Is this done because cs_dsp_power_up() must be called, with or without a wmfw
> > or coefficient file being available?
> 
> I don’t think that cs_dsp_power_up() must be called in the case of non-existent .wmfw
> and .bin files, so I will take your suggestion and optimize this function. I will also switch
> to asynchronous firmware requesting for V4.

Since L50 can work out of the box without FW, another option is to follow the
approach used by some codec drivers and wait to load FW until the first request
to stream I2S, and/or trigger an FF effect in this case. By that point, rootfs
has been available for some time and request_firmware() will succeed.

This is advantageous because even though request_firmware_nowait() can solve
the deadlock problem for FW loaded at probe, it could still return -ENOENT right
away on some platforms. The disadvantage is that the first effect would be very
delayed due to the overhead of transferring several kB of FW over I2C for the
first time. That's OK for audio applications, but not haptics where delay normally
must be within single-digit ms.

Ultimately, I think the right approach is to look for FW from probe as you have
done, but use request_firmware_nowait(). However, I recommend structuring the
driver such that rip-up would be minimal in case you had to retry FW loading from
the first FF trigger, to support a customer whose rootfs is not available at probe.
In such a case, the customer could work around the first-time latency problem by
triggering a dummy effect early in their boot (e.g. init.rc).

> 
> I will also incorporate the rest of your review comments not mentioned here in V4.
> Thank you for the thorough review.

Thank you for the productive discussion!

> 
> Regards,
> James Ogletree

Kind regards,
Jeff LaBundy
