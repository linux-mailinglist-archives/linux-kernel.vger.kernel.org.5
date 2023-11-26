Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC047F9134
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 05:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjKZEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 23:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZEKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 23:10:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA49AF;
        Sat, 25 Nov 2023 20:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmjC6CKacskh5wIIq3uQ2imKUnCth1HT6E2HFahnlgKyIC4jFgI3+Yn8q4tg5LTeJzauarQ4XaU3+huZ7fg4nCn0CrSusA//ibTthuuDFAyzMHNmZ7MQfWh9AFasJS9iFm9sfCUuEmRL1W21cTFMWZkQdBdmYsowzTSZYFBDD2173JOhEDyk2/lkPxokAu9V+q/5XfwZmTGN84peDkYTtypjRZIkg1UwGVeu7FAQ/OEiT0fWjlgj8owBKqI9G9Wf/Lcwfqex99oyjlSUSjRNAblOPNSlFgyJ+N2YprJ7rlrcl2sxDhG91Zds2s5hj1//1Y/V/wgnPUHlDAJHNp1MOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOx43Rm564whuojAtVKnnB22TdJx4wnlEB6caKxekrY=;
 b=ggKZpM5dcRnhacMQajPU63/DYvZeRQO1LFC/irUpQyz6Qcz8Am+N6yIOTj0GYZ1pZtDSIUEtmJuEWxlDPrKUKqUVA8mtQRj97BsyMnfVVHQQPrM2TTrc07xcfDY7Qf9k4e1SfsB33SkyR0ASkXlzc6slN9MMpQ+6ijpM1fSZfR9n6z5RLlkZ7Cy9wQ5Ek8M0Kwi2gjoxpmZyomcJjBSwT4+T23sZCxTj1adIYxD+0v8HJo1VlgNmUekNEIi4nTGb01V03fHoeuqVtKTWiEjVJ2a6rGVss5/Z3HG/8zU47AeeN7/X/UJPwTlid7/Fl5WrQWtf0dS6cIZfNNri1ccPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOx43Rm564whuojAtVKnnB22TdJx4wnlEB6caKxekrY=;
 b=vFM4tTWmybjovR/L8byD4QEywL73SufMfiPmTp7PfpqQ5vOlpDj1MyjoMrxGbYIm9KeL8eHNFOEtkRT866oQx1IyEvQ5BviBJAz/+0Ewm1ZQJY8yuBIxbojBwO67QydvzBQTRtzvHY5JvewPUIM5MX3JCe0sG6HzpD3ypGRhaYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM3PR08MB9645.namprd08.prod.outlook.com
 (2603:10b6:8:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Sun, 26 Nov
 2023 04:10:40 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 04:10:39 +0000
Date:   Sat, 25 Nov 2023 22:10:33 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v8 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <ZWLFOV/U90bhm4ow@nixie71>
References: <20231108005337.45069-1-anshulusr@gmail.com>
 <0defc0e3-dc15-459d-9e71-64f3c38a6931@t-8ch.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0defc0e3-dc15-459d-9e71-64f3c38a6931@t-8ch.de>
X-ClientProxiedBy: SN7PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:806:121::6) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM3PR08MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be0dff7-ff30-4186-4fbd-08dbee35a662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whkkBWY1IYyE5Tkk0QpvkpcJjF4Xjo3VuKfr+bl/KgvSCQF4qDnVtadlRZa2NQBzUNudOtDfjeNbmTUxTeUBcy9eYMfVRK7z3GfjNIpMkPeZkQrHQJ4zoaSDJP+szzEtk1Qnujwg4Y5UQK5IxFJZ+ZQfhJYJnw+BgSgnjaIirW82P754RZ7zClkUzJh3zRbEraC/lQn8ed96u4DlJRqmQPgnrYWw0Q4PHYsJYKw3IG7yFl0iNYnfPZJkhcAs4PExxw8readcEh9oenT1ptMPF40k45AXekanh55fpFpoAOdjlFgAu8Cs7Ce6+3bIwRykNlO9Pf/bQdhIVNYM7cDSJ+F1N+KIAPwazwXdOX6G+KVEKDmeEYKu3fCKpLFdsjWZXlWbcxqP2hokQv3u2fv6nigX2WYPoTXNTVUNBq/oM5kuLFoOYPAecSDO32M5PSA9zVVP132ltkYSCoM+knMFmsjRldm3biG3dDOEzftdGhu568MSKJY7mPjOfTU618KcNWGHIkGq/Fa7XeUqbEF4xVHUm40syKLIjeiH7dzcG8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39830400003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(38100700002)(66476007)(54906003)(86362001)(6512007)(478600001)(6506007)(6666004)(33716001)(6486002)(9686003)(66946007)(2906002)(7416002)(66574015)(316002)(26005)(5660300002)(8936002)(41300700001)(8676002)(6916009)(966005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+ytXkehfYEaVCzuQlgU2OSjeAoNFUDRA3hRSydBszJzZ18EG4jlqsXc+Y4?=
 =?iso-8859-1?Q?ROCRQQQS1ifstgPhZVytKmdFIOMAECagGTJRanTWwgivA1ubuH2KykjIJ4?=
 =?iso-8859-1?Q?gXs2MOBmNaMnbD0RCr2EsQsDKx4nyi5jjqViKYz13R2l4JxpYEkoFkDyZD?=
 =?iso-8859-1?Q?k1Eye5jARPq8d74zfqbCDnKaz6hhbq/6BIssyjSg1Q4C8Mqk0vtpHOSHAk?=
 =?iso-8859-1?Q?hMKfUL7+328Pz1ylkbsQ16egnzxxSiQCOUAuX+mWSKWMqzOV6tpWAtLVyi?=
 =?iso-8859-1?Q?ZSBBed+my3KR8kttzk1fFjwuoHBMgEf71N0CRYRzxjjrFMnjBaxrhcetcb?=
 =?iso-8859-1?Q?BdxcEUqCN73eGnYN7cHIyPEK7sYj1/rm+3DRjVrCw3edFcZm5D/7iO2Tu1?=
 =?iso-8859-1?Q?PL00KU9Mtwg0B4OYG63OqtVKBhCkPb9i9qA5e32E9g/5PHOVEwojtE33Nv?=
 =?iso-8859-1?Q?kHi8azzL6THK+Y6WzAEGdxJSpwkjtXCft4Man+e9Pnf+6NkCoumQH5Htdw?=
 =?iso-8859-1?Q?1sx3XeQeHMdymLwxrK/ds6TaoC96nkisgar62oN/pxvE6KWxwJ3ZaJlPuZ?=
 =?iso-8859-1?Q?ypFSvTUBTpWIF2NOimkzG5X7HWR7NBCZSg6XBL+fQWHxZrVTX2ir/eJdQI?=
 =?iso-8859-1?Q?RIUf68dYHS/BUqrDaXRKgKc6SYGeWiNYIu5q7Tlvscwy5MmmdT2uxzYhfz?=
 =?iso-8859-1?Q?OPhPP5tnDpgp0seo9dBWTlpvc1d/u5vbXIvkIjZl1o2El6dv2/FHQltBhu?=
 =?iso-8859-1?Q?VBl+CYZBYz+dPwF1OA3+cocVPSgeZtce87oTRiPs80qzh3XtAcsUXHzhWV?=
 =?iso-8859-1?Q?MWcaRfc/0/Mt8/XvB9kbZu81sqThOOi+YJ/BmoRKRrd//UwNyxyAelAHuM?=
 =?iso-8859-1?Q?mDLXmZRs5m9r2w0gQluqVCdutqN93xDC+UDtMH1tK2h0dR6tTW2qyOfVGK?=
 =?iso-8859-1?Q?WkGO6fdmEvaRg/+BCFrjjixJnVj+lw9gA6ID0HWKQ7qd2JpsXTsndXqXEh?=
 =?iso-8859-1?Q?CAaDY+2ewUN/cCutxiuyS+LpdqS1ghztMS7eUtb3CF7hRsEKprNHno7Pgg?=
 =?iso-8859-1?Q?rQqMMWMBzKtY9NxO7ujOuarMlGyQdnCBdVxUyRgkvv56oy3kWIHttRFRjr?=
 =?iso-8859-1?Q?5k8UUHPhQdHBaIXqLWu085NC7AKraRDvUVrHpsXkqf4WfrfQIsnjKKa1Zo?=
 =?iso-8859-1?Q?nL1k7EWX4gG+klAttgklErZ0upYKC3c/0yETDcMJPvJXYXpH9yGiqRhCRE?=
 =?iso-8859-1?Q?tl+GFKWtw3H4HF1X46NDrdr1iHXmZzTIVD7DzBDvHhamZyZvXVck4FYn4s?=
 =?iso-8859-1?Q?XCTJh+qUGPNngrWJK4vXqj0iWGFq5li3CmOMRGK/vG8Io0UW/FxUCcxro2?=
 =?iso-8859-1?Q?VZpuD3ynj9+X3qcdG57NoTEQ2xOHeuUZWv0EA2IgJmnwXBxCGt2IPQzDOA?=
 =?iso-8859-1?Q?f5gFbNkoeEWHhuRfESsLa1WM2rVR9p17EeJla4KTorHYBjtE3myAafI6SE?=
 =?iso-8859-1?Q?L4ZuJsmrAnkpVQyUpFAYFmaOW5Eu82TaeP8CZavd+77kYKBAKZh9VJCi8A?=
 =?iso-8859-1?Q?GHyfDQYq1BkEa+VWV4czOj6E2BtN7QId4YmSgAbwUUU9abQye5Yaj/gniU?=
 =?iso-8859-1?Q?uHcXZ9ilKPTE6azG6ljC1DN0oJq/JZVqBF?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be0dff7-ff30-4186-4fbd-08dbee35a662
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 04:10:39.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeZFvRfx+K70dYnEV8wtl9ys3fkeUkTjUWYt9eIxTOmI2O4IhpVootleH2wY/uRH6FxTpDm6Z6jPzwNfMAyCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB9645
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Anshul,

On Tue, Nov 14, 2023 at 08:20:46PM +0100, Thomas Weißschuh wrote:
> On 2023-11-08 06:23:35+0530, Anshul Dalal wrote:
> > Adds bindings for the Adafruit Seesaw Gamepad.
> > 
> > The gamepad functions as an i2c device with the default address of 0x50
> > and has an IRQ pin that can be enabled in the driver to allow for a rising
> > edge trigger on each button press or joystick movement.
> > 
> > Product page:
> >   https://www.adafruit.com/product/5743
> > Arduino driver:
> >   https://github.com/adafruit/Adafruit_Seesaw
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> > ---

[...]

> > +properties:
> > +  compatible:
> > +    const: adafruit,seesaw-gamepad
> 
> I don't really have any clue about devicetree, but shouldn't the actual
> driver have an id-table for this "compatible"?
> 
> It had one up to v5 of the patchset.
> 
> Jeff had some comments about the OF aspect [0], but to me the state now
> seems incorrect.
> Maybe the DT can be dropped completely?
> 
> Jeff, could you advise?

My original comment was merely to say that this driver doesn't need an
entire binding because it is easily covered by trivial-devices.yaml. The
whole point of that binding is to save the trouble of writing a new file
such as this for trivial devices with this same set of common properties.

I don't feel strongly about _not_ adding a new binding for this device,
it just seems like unnecessary work for all involved. If the maintainers
do not mind, then I don't either :)

Taking things a step further, this driver really doesn't need to define
an of_device_id struct either, because I seem to recall that OF can still
bind to drivers with "compatible" strings specified in the i2c_device_id
struct.

At any rate, this version is most certainly broken because the compatible
string defined in this binding does not match SEESAW_DEVICE_NAME specified
in the driver's i2c_device_id struct, and there is no of_device_id struct.
So there is no way the driver would bind if this binding were followed in
earnest.

I see this has been addressed in the latest version, so I will take a look
at that one.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
> 
> Interrupts are not supported yet by the driver.
> Should the property be there already?
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        joystick@50 {
> > +            compatible = "adafruit,seesaw-gamepad";
> > +            reg = <0x50>;
> > +        };
> > +    };
> > -- 
> > 2.42.0
> 
> [0] https://lore.kernel.org/lkml/ZTWza+S+t+UZKlwu@nixie71/

Kind regards,
Jeff LaBundy
