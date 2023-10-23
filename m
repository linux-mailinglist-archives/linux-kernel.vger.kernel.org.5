Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43B7D419C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjJWVYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:24:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E95E8;
        Mon, 23 Oct 2023 14:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DROzQqXfXKtJvmi9ScTdgSoqAZUvmfiKhgeAKZli2WkIQKLSHGq6neBfpkW/CMJmipYo7/dQy6z2fTegrWoZ7lIQci480PJPECFsGhN66PaQyAOhCZbFap/fQBFF8IzPBZNSMgN6KxrsIVr+EuDB8fKz4Xd4uif0BF9NXhaaIqQMnKYKT/FmWkg9NcDA6Vi2m7/DRvRzlHnwv8poR7JCbdyaONG8/61j2pXCPhzVnBFf+8IZhx0LyhPTiFeww5lATeFcFN4exSk9JzMdCRCXRZ26cJi6nYSZh8tjiSwdkpsOJ0BAP/5wDqVg6v4vej65M3LPke4yG6lO6/uvYVe/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjo69AYbvgkMUv/7Z7u3J7b2W9jtJHSbzu1Tsi9/774=;
 b=UbpqCmXtpvVtxqNFf53MsEJdoeUFcWdv8HmYe1mI4Mz00ZboUGndgCBYpb6oNvYxDg5xc4izqsKzPtVUmhvdaFl02VJMeM6AmKuHD3hxxWDdB3D+CthFpBOtJURBK3qpqcjO8VVcL9vSqRQlPImF+nB8A5fOVviGPa3cUUZ5N50RTvsdGHD5XhkgcFPlomBpACX2DC2rDt4gJrJ9yp7A8OkyjXumHIxR6OkD7Outs8ioWLynvdPM8D+0xXvS21F3e7w2+nsqHk+K2ihO7zSatmZRDwklCnf2CeKnW4FulRi11GxgDpvzjugTYTf9XD8CTumw19MN8Y9GGGtj78cyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjo69AYbvgkMUv/7Z7u3J7b2W9jtJHSbzu1Tsi9/774=;
 b=GONCJMSNYkuZ9UW+F6H1WrUJaVF1gvWfgTQjCHqbpl3rpXpL1JNIT9HVyN0gxGfBYjHWNdAIN0tpfhxZ3QMVIesq8RxU17ma0DE9uyHj/AnyMfxDKMFwPxkJxVg4/a5cbzBJqtXX69zssyapXzPWWyYorb2pBnTBj9Odyzsv3k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6825.namprd08.prod.outlook.com
 (2603:10b6:806:fb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 23 Oct
 2023 21:24:46 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 21:24:46 +0000
Date:   Mon, 23 Oct 2023 16:24:38 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <ZTbklpRhpMIPey2j@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <20231017034356.1436677-2-anshulusr@gmail.com>
 <ZTWza+S+t+UZKlwu@nixie71>
 <00d2fcbc-3fd8-477d-8df1-afec20b458b6@t-8ch.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00d2fcbc-3fd8-477d-8df1-afec20b458b6@t-8ch.de>
X-ClientProxiedBy: DS7PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::17) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0d83dd-d803-4d23-598f-08dbd40e7af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dV0d5w/QmzhrnvJsbv8x6/uoQOyg0BNul+2OBdCXCu0jpVENqzhEs+Lh3mu0HyRSXqf6nGmTr404/Kveb0GcXsl7Mddk/cDbUP2+QMiwfHLM7qDIMFcp83047/wwjTSmpf+LPbYMPsL5ZaX67QrNwHg6N9byxWTTh/z38Wdf4ACF7XaWG+Iw2LllH0k8ozK8FRlifd6U5BHv3b7CvpdThO9OldkqYHZ9DBd0zc8RrzchKvivvWsz25Y8+yxcKW1rzxiwAVlwUp9obl4p6X2hGtxeiOBqwYLyq694CXSep1uDzxNMuF19VrNOhch1lzfJrXgQeAxlJuI1M9ok/GNZagff0BPTXZKKpPDLo7Gj+TKuFYVKuIoPGgNAK2VdBELqZgRZSS5trd6c/sE5KoaZ+YhVSyQTe3xGeiQTTX/NFx6gsutTtjwScMTsOwa1oAkDv38s4SjSfiITtvQNYa5sOWJtVMrjm214bbX3Xyxwn5j1sHxyuLtfGbMcjBKenkqzsyn1SVs5VF2HWVNfKQQ1VaK9nZPP3waTgk3EZK59ZFkBgBl6I6/jPsixzN5hVAZP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(9686003)(83380400001)(26005)(4744005)(316002)(6486002)(7416002)(6916009)(8936002)(478600001)(8676002)(41300700001)(66946007)(2906002)(4326008)(38100700002)(66476007)(5660300002)(6512007)(66574015)(54906003)(6666004)(6506007)(66556008)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B1w05ouDFUd5ChwCGM+lU/3nfSguebna4esxvJp7A4VIROsrzPxI4Z+9j2?=
 =?iso-8859-1?Q?ciyFTVtzz2/kb3uU+smvdiIOEp3NGL5VMEpWXPhrwyZdkGsnu6Ieh2wspt?=
 =?iso-8859-1?Q?q3v32R3TvT7Z3SIuHA/E6aHu94HPEzdStJYLlKOfg1pna35ybZY+hOoUMm?=
 =?iso-8859-1?Q?9d0drEhsiwGP66SjQ5VF1b02k4kBGhYawWdVE78W1uDISOFh3azPKs9241?=
 =?iso-8859-1?Q?9qJVXBBLV4gsmzrN2TzzkPtVUIs6Wgd5i49qpYOER4RYBdC+JKJHFCRG33?=
 =?iso-8859-1?Q?hBF8zd5SOant6djaN3JjhPk50GdPxvQ07O8jVFYE9d5Upfl/dBcXs4HnD5?=
 =?iso-8859-1?Q?nQl3wKbKcxI/lJIR2jLywXDLBbQmIcEiV+eg+WeL98V4p6Ftzm/YGI+nHC?=
 =?iso-8859-1?Q?TRfqImsG8NrHiEtTHgMX40sVAg4UwNrsD9yXu44ZdhcdDlmlResSSp9Pk2?=
 =?iso-8859-1?Q?L7iQ0+V+2Uy5zQc0hi7IwfnxdU19nw1kPdeTmFB3oCNdEEf/MJoVr1jWZa?=
 =?iso-8859-1?Q?2CilQagPxp9S2D5tko7g494Qzl3E7iS95Saelc9Hhb7HV7kIzWCTydzhq6?=
 =?iso-8859-1?Q?lFU08wJMs/swDz02KPzsIoj0k00Bf01f3HlnLCTnvhZUr0muSMLLCD7EL9?=
 =?iso-8859-1?Q?JCrvgsi8eVzpyHSXqIEAWskL4Mg8inyVNgXb+TpMq7jHqfqdI57CwTwMzo?=
 =?iso-8859-1?Q?Xcb1b0w1GL2x67ZgkkNJ6KB/fyxWAOz8tdAYjWH/onfg27RcuArZMXKQPk?=
 =?iso-8859-1?Q?IwkWDRdLfMX4Wb2Gd5t/FJcTPpMBcJxo3JUyGp8KuQMOR/QJ5OkpcSdqan?=
 =?iso-8859-1?Q?P7z693EoxAzVMMEVKJmrQn7xpbcZ9ro+tymm8hCx/7N9JMP0EkZruL/ncr?=
 =?iso-8859-1?Q?5cdGONwFWqZXi1892xNSkYh67NpXZHTYgFM1piKid+x5AWsEahkWgSKovE?=
 =?iso-8859-1?Q?sWSKNiRhdKYbC/VB1uYQ4JvuaFlwigQq7+p6/mGmScRr1+U9K5baDWRNVa?=
 =?iso-8859-1?Q?8ogYe1y33WbUNDkOrH48lC8OL6Z1K3ianSFQWRlJ7/Nl/vGxjrdS1Ycx/k?=
 =?iso-8859-1?Q?OujMqnNE3jmXWhbdc5WK4tLhMAYVNgOkmsRNXzDge95BEsC2xm9UAKiugW?=
 =?iso-8859-1?Q?5D/f6s2kyFD/4nTYt3i98waeNck8MTKsIzISdP3Yih4QT1WY4QZhagmD4G?=
 =?iso-8859-1?Q?Fbh7Y15lVRoZyGfe1lRP5TcnvwiVz3+QvASPihRxuQB4Du541eSgVNwJeS?=
 =?iso-8859-1?Q?tewXg9hzUYfd979QvUYLs2ZDXsh3YIgM2TIdwDjfVlc1FPCEGen7SS1K/K?=
 =?iso-8859-1?Q?zqo8zqvRbpp8i4bGYUFttxedGi6bTODfSqvLLuG/xx5fKlQF2/glW7MXMu?=
 =?iso-8859-1?Q?zm2bUM7AFq451C6I4CqFYlYkxatzLxXSt/8eNuWqMbl7fmpr994oNucgLO?=
 =?iso-8859-1?Q?LQN5/FLBFE3kLKbstFu84Pyo/nQqtKbGrp0vN5IknxHU+jdZUvtXRM7bW1?=
 =?iso-8859-1?Q?cTFTt+4uAuL1RSNIGHU2eBPxsGH+7lQz1sAU/dAk8yTKJB0gOwIzoVmUoa?=
 =?iso-8859-1?Q?iNq27v5PH9vyE/1d90pV/FWISB0my4yDbepng1N5ZRF0dwGBG68EK+PovO?=
 =?iso-8859-1?Q?0BUAL09NZ6NXY+KsAhXEv2C03T0Iy3QDE2?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0d83dd-d803-4d23-598f-08dbd40e7af6
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:24:46.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln+7meh0rOgDU9it9j0RiqYcmgH6Zzc7TKw9jvBvCd7ZEDyrsU3QSw+9ATvUFkbZgglIrWhQFcrIjBoVn1IDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6825
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Oct 23, 2023 at 07:55:52AM +0200, Thomas Weißschuh  wrote:

[...]

> >> +   err = i2c_master_send(client, write_buf, sizeof(write_buf));
> >> +   if (err < 0)
> >> +       return err;
> >
> > You correctly return err (or rather, ret) for negative values, but you should also
> > check that ret matches the size of the data sent. For 0 <= ret < sizeof(writebuf),
> > return -EIO.
> 
> The driver did this originally.
> I then requested it to be removed as this case
> can never happen.
> i2c_master_send will either return size of(writebuf) or an error.

Great catch; indeed you are correct. Apologies for having missed this
in the change log; this is good to know in the future.

That being said, it's a moot point IMO; this driver seems like a good
candidate for regmap. If regmap cannot be made to work here for some
reason, then I'd like to at least see some wrapper functions to avoid
duplicate code and manual assignments to a buffer.

Kind regards,
Jeff LaBundy
