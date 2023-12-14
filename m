Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B144812CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443615AbjLNKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443555AbjLNKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:24:39 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D37AF;
        Thu, 14 Dec 2023 02:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkVefg99o4LE747T3nbLEhwYYRLq1QylAdd4lTR0B4ulVSunISLAMNWz1ldi9Frde7BfssAmgOtM3VqZ6SOBExpXyoarYlFDpNlcS0yJRjaH9pI5SflU9QZ6uF80sHhNvv7e6pqxbNl8HOXv3Y6Ru/sXQodntWjnp4IbP+KyWEV9fOx1OKxf5yq9BLCJ8vlM3uSmkYu95HSTWD7sypoAR1gJ32feHfOefGtWNS4d8ATDFFZE2dsSqqcm9xEWMeDU+MkKbUveA//yU9yzTA4895vAtWEh7IfDWh55f2JLD9Vdn1YhvakTAJ7D1BwDszzqJWBsaFnztKKHZ+mn2Cr1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiOimk1oZIn/bwWRx0kWMlf5zDV2wGTUT5OQv4GHfVA=;
 b=kQOSJFF5usnrASOOWSTedQH9XQqPMK/VrK+orc8MECeFHj1grprmti1J++VovqnjCbVbcxfNcdALmxPXuYA04Zh/DRjudo7lh4vGUKc/t8pJp80ZUjngOaffMWDG1qKKN4tAENN8mPnzJuON0Px1VaHvaZ/ImkNn3/7X/thZfQUoqUTb8hiOjPY7VA1igJk/iqe3vR0DZEv7AY2J8XpahZmM0Oqjs6EDpFeXhiQN9n1u3cz9RPg+skcNtzlnRSqHR3vh04gO+haCXhQeIC4etIOlyBbKcnt97vi0v7zUxCS1JlsD0lNqhNEG4iD6dx5pDq7SWdgBv9p85TuLBjcYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiOimk1oZIn/bwWRx0kWMlf5zDV2wGTUT5OQv4GHfVA=;
 b=T9YZgwyGhroIjXTX0psaMbSlzrjlwLyHlbazlE/fKxUUQCRo68TZEa+MfImikZTmZf8AhnWBK3JfDbDDxypFjVyAO004rGvhKah65OU3R8EgXxFoXUo//mZiwkbNCqA9GpuLwtoblvz7SLtJJJaGS/Stzyi+AwIjXvWBNebHxqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4943.apcprd01.prod.exchangelabs.com
 (2603:1096:400:280::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 10:24:40 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 10:24:40 +0000
Date:   Thu, 14 Dec 2023 18:24:34 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
X-ClientProxiedBy: TYCP301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::19) To SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d96746-ac5f-46de-2ff6-08dbfc8ee15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InHd4dTw6S0UZbMC/c+V9vjt3PO0vtrtexVHMGlqYmTs0fByKcKbuXkY6HQhbyM9idsuB5CVKC/zNJ00RqW4ScUTilteVlUrqo95tKKSoAVBIqqeaCyOu/DxtdH6FNh/3LPb4OcwJPVk4L5DLA3UYrPlOVSIXpYmtVLSv21MfpiZI+lLu3TsBb/eEVVKCfFmmYKkDbWwBbp7cSk9+p/jRfRr9dDQkzDgGPCKKzojh5M5tXNnakXcncyi3RE6BILEWKErdJzJtM8iL7ok2r8uF7JZNiy1upBl9nUJtYe5ltCLz6V7TEHLhDgnLAe1g8znfQhQLm/mru2FyH6EaQ4NiXjxZ48pjhV47QBM8S2nGgCmILE6kFayM/xhoXBnyAJDv8gkJGsCsT1KTEvgGNk/YCop6BXaE82RF7Ok47rzZYcBbFTckEIvztxSeCuA5vOTe3Gi1JjU5DD/9ddIGAPIVSJ3ZKSxBiVIrp2s3oz9Su6bLOdJHqYLRUe5tKqnsHJAouIxGhTQxc1JU6VGdYz1LQGKcNyt/8DSX7BLWYGDpvoDodgFU4gSLjtNFyrpxawKVMOGrkNl7O4dHIUXmjET1V8MOW6kS9RrZFYQIcfo1Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(9686003)(6666004)(966005)(6486002)(26005)(478600001)(86362001)(4326008)(8936002)(8676002)(66946007)(53546011)(52116002)(66556008)(66476007)(54906003)(6916009)(316002)(6506007)(5660300002)(33716001)(38350700005)(38100700002)(7416002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFOS2qTCKacVX09tFnnMbCxrv0xLemZ9OrSk3tG2L9+YFoArAw+ROqBOr+wN?=
 =?us-ascii?Q?KFfwZWYoZ4KZI8q4FD9+XyiyLcE1ysUpWqWIW0jdTBG8Y52mjXvriMB0LIRe?=
 =?us-ascii?Q?XUfJ1B7HzISSgQvriWWucU5kpq2thBRuMPe20BJDeg0vuvhdhRPZrIKP/6o8?=
 =?us-ascii?Q?UIIvoy28fMOUD3IFzTiiK95PmaaUWzu+JCcdpTrBjJ4ZrXXJFUKq9rGXbeXj?=
 =?us-ascii?Q?9l9lZxyvJMqJ0YgXTIjYyBep2YIcdxrNxvj/gFLDUjqBOKMcTgxeaTaUmRfZ?=
 =?us-ascii?Q?QYIU6DKXX59wpmlLRg6ku+pbDZZlSBJDlksQdpPpR1klhKpb2qzFtD8HCqDS?=
 =?us-ascii?Q?bd1HhGQjGqUTr1idgxAA9rtnkdzbYrfnqVIiMitO+IA8GoTfC/P8l+O/uwOZ?=
 =?us-ascii?Q?UB1CRw1ec54BGoGhxCgLf3JvPS/JVSWUKbPUc0SdT5FscLX1le7HCxdv4Oqs?=
 =?us-ascii?Q?M4upbzkkZDByCoiGZds2LaIuto0lgP46p0Nb9uijYmJA/PykNGcgsGpESqhC?=
 =?us-ascii?Q?+IzEmp6nvHZ38SPki7uLWAn3HzWpqGmh95Ia/myTjptH2x4e7XHqznMDc5an?=
 =?us-ascii?Q?y9k63+6nWeUYTpHJo+YESuLuy29bFHA0is2fusrk2y/yDQ3jE3fzKg4rxDoO?=
 =?us-ascii?Q?CCphlp1pkpZ9WhEMEdbajMJ6RPwc3OGruSfvK5DAawckqAtDHCYL6HjrBfOR?=
 =?us-ascii?Q?eIMcYDQBJOJ2BJ01NNhZkcoW7ppC5ZFyBWTKdedpi3FPzauEtF39OLvxNoDV?=
 =?us-ascii?Q?uKves+FcEjFHzfujJZDzKKJl24IeDa0plRiaZtawkNMXa0vfvW0Pxqu9hSKz?=
 =?us-ascii?Q?QQ5JDETni451QQ/GbTveKG4qyUJQgc/Nz8AEEZgNmCR1C/zlpQilKhoUKYZZ?=
 =?us-ascii?Q?rZGviqVkO6bNrB5ejsjYfOw4cnZuLj2CFBw58U58tJ8wCqt4BgKu+X44lq3E?=
 =?us-ascii?Q?WBTz0gkxmZaV24NONpWqw9K8r8zypa5LF390ByRvwUfpIVAMfhuqTrZ/FvER?=
 =?us-ascii?Q?IhZMVBNl7m5H+SN/x0gAGPf0OaSojGC/wE6qcjcfl++zyut4TMFNI6VsRTjJ?=
 =?us-ascii?Q?TJ3LxXLVUtUhXyvzUlLDCs6FrQZhaCnaUOAFw1Gw+iPpKiiJ7gf8awTWszCK?=
 =?us-ascii?Q?cHGjgmdHPijU/tJwybrTD6wsHxINdVNfLJr4CXk1ta+0wFX3r4DziimbYyyI?=
 =?us-ascii?Q?9sIyE37rpnl5n53q33LiuUDxMILN2kC9o2hlkm2jBUbfHHYew2h8h7vseoI4?=
 =?us-ascii?Q?nF90ttiBQlbnmT73tNoXxDPTCJiFN9VoinTc4Q94WYuZLSkDU3oYs+9ZxGsT?=
 =?us-ascii?Q?I7JeA5SJDbXDGBbAJobUVALdjPHbHF202QXcUlPUAg/mRcqOgBgbCvEjMEj2?=
 =?us-ascii?Q?PL2sZyXaqykADYWlqe0EL9waYV8z965QVQoBqgHJJpeIRg8HXQa99uG9Kwoa?=
 =?us-ascii?Q?3fBcgttyhlIwiGsVcXrV3ZERsNrMVdoQaOhD9TdSm/efUdW+bIpE6DRf5wN/?=
 =?us-ascii?Q?rgRVilrAXoG9X9aUqDUoQruNPu5sqMIUwqNg7/OfBEMqTH89v8oux3rS2KFa?=
 =?us-ascii?Q?7IJYnXQWzPrxyT6w+nW6XgjhR7YbmFn+sPCNk/jjArGqiNRzVAoTiR63j+ja?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d96746-ac5f-46de-2ff6-08dbfc8ee15c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 10:24:40.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB4+DYWNzYd0eZOwueX8D/2akxLHFhlPQBlyKRp0M3SfUyndTOuPqgwbKju4pbG5S0Sf2w4V5wwZI/vMka5zsH4LDgCP4wpWDh0Qow8LESQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:07:59PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 09, 2023 at 12:47:47PM +0100, Lino Sanfilippo wrote:
> > On 06.12.23 16:42, Lino Sanfilippo wrote:
> 
> > >>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bit
> > >>>> to struct serial_rs485:
> > >>>>
> > >>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa.com/
> > >>>>
> > >>>
> > >>> That new flag was suggested by me instead of using SER_RS422_ENABLED, which
> > >>> would mostly be redundant to SER_RS485_ENABLED.
> > 
> > A cleaner solution would probably be to not handle RS422 with the RS485 settings at
> > all, but to introduce another set of ioctls to set and read it.
> > 
> > An own RS422 structure like
> > 
> > struct serial_rs422 {
> > 	__u32	flags;
> > #define SER_RS422_ENABLED		(1 << 0)
> > #define SER_RS422_TERMINATE_BUS		(1 << 1)
> > };
> > 
> > 
> > could be used as the parameter for these new ioctls.
> > 
> > Any comments on this?
> 
> I have (maybe not so constructive) a comment. Please, at all means try to not
> extend the existing serial data structures, we have too many ones with too many
> fields already. For user space, though, one may use unions and flags, but for
> internal ones it might be better ways, I think.

How about revising the name of 'TIOCSRS485' and 'serial_rs485' to a
general one, and put RS422 and RS485 configuration flags into that
structure?

So that in userspace it could set RS422 or RS485 configurations using a
single ioctl command and one structure.

In this way, it won't be confused in userspace and won't add new data
structure internally as well.

---
Sincerely,
Crescent Hsieh.
