Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56441800679
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbjLAJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjLAJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:02:37 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5498B1700;
        Fri,  1 Dec 2023 01:02:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/igXNNwIY+Cr1LEJH98nFKVApCQ2O8pwzSUch4G+Qw7BvhOKIoLGI0BVB7hpi0R2z1AVas4w2wEF/+0TAb7+OeXz/j+UL6qxuW2Uqce5vScmEIf3R2Dr1Ona3Zq63ua26ONHeuXXcbDD+sbV+ZhDtC/etrzHFMZETCgv798nVvIMWRjLcmpVtQbfdsUfbQ6PB5XK1Kq5ksj6TTkK3ZJIpM2LuDYXsM0vAaUwV8flPihgoCCUSqzuR9RjiH/lQeg5ivrvpPq7HqcXIwswuo2I4QNT/ymkrTIZ3hZzyu0hs8Etbq9bWz210XgZWQuAXGS6cCh4a6c6y2RJgQhHqSIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOuIVyPSmIqG48W6drq80z1uRp49MF+c0rrMLbGdG6g=;
 b=R36M/onqGAicZIMdOm8Z2K3Yk89N/jOWKLtO/A+MKBtFpIW/DM+i5tUy1fqzQffCbMr7gsa1Wun6PkO8/6vC7jYLrxa8tOvxbx5yGLy472ENEj80wT96eI296sctzpPVaNoDFEc+QzEfofcR+8PyJw4p13VbFBj0+SiXBEQcjkHBQnMlqZ7WLnkApeK9JaST8C0S1j/R+UDBYMfitqPKelBb8XuV4ZmLQBG3s0ef7zi/r7yM7XMDpnS+NHc9uWYq7qKpMTLRDtZvPSoPDU1o/4LryVzZKNI3en1GlSDkhxwDmtmT7vObfF7GK3XXj5Gc2rc5l7pdyOHXvigJGRk9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOuIVyPSmIqG48W6drq80z1uRp49MF+c0rrMLbGdG6g=;
 b=SgBhsABV3e2wUI7rB+1tItR9NKWKwdEL92hoMntRz9dNFU/3k7YhAbXHOmefrNUIPuWDBnSUUvq8YJhVzc4FTZZo1r0irW1fbF/RQj13ikKhiV79HeOiKp9MOgdIe5vqrKgH7xSPLT4BijXL8lCvSKEAB8qKIL+WnU0xh2sMT6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB6494.apcprd01.prod.exchangelabs.com
 (2603:1096:101:204::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 09:02:38 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 09:02:37 +0000
Date:   Fri, 1 Dec 2023 17:02:33 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Message-ID: <ZWmhKS+quI3dmOND@moxa-ThinkCentre-M90t>
References: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
 <2023120146-pyramid-salsa-d8cd@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120146-pyramid-salsa-d8cd@gregkh>
X-ClientProxiedBy: TYCPR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::17) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d603ad5-f4c8-4fd0-1cf7-08dbf24c43b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+hN3qbOtjX0VbyO2GFcvmiv/ENsMFB1dLg6JDR0um9uMjcehKusZom6S2MdLPQRCb/0W8CXKdsjdab73tU49AChOxtze7/ZVsPNnOk+LpOlAdx3i89S4q/vv5WTC0J364/diPUDxgZZcxWbEeaA2aP4nFsBrowYIELfHNJven1Z/JUNKrivDBmokF2M2VaqGL/vGhF3N8RfbVgDtv7HsURLUU91pIKnSxLzNl6r7ZlX6u1FcCs7YMmrJMSqFpBdjNw2gUW4kjhKWauPgEXIyXO75oOMFyDHYEENWE0EuWghLHoEnJAg2pVoEu1nC7m64WXWC2gEqgaUyJ1q0Eb3t4ZOybyR+TbXOe7xGyBEL22CRpo4l+f2Ls1aTG3RzpUx8NrWWiIZGvTDXyZmXT2LkUeyKhABOvVM2B/oRuPMRk4ad1ajV66qGWkptelZx5c6hiOVbJUICsjPlNEmSS9VEacVw7KBT0CZ78L7Bx/m6NkMbJ0rwl/RCRgCjmmsZN14Ecv0yNnq0GeEluVarjS5DB/0SSHs3DSCWiE28dL7sEt+EJJoIMoew5n9oZP4mPabEnZR+xvRKeXx1/zlIJ329A98Mi4DZkxk1lGZ4T9T/pBhYCBU/a68RuxleaT3j+9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(33716001)(41300700001)(38350700005)(5660300002)(2906002)(86362001)(6666004)(9686003)(83380400001)(6512007)(38100700002)(6506007)(26005)(966005)(478600001)(6486002)(52116002)(66946007)(6916009)(4326008)(66476007)(8676002)(8936002)(66556008)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0+sVEhQc47dasqiDYYLzzz37aFp3nqEtcRWAqAulM0i1IctQMFgRgnZXPkp?=
 =?us-ascii?Q?ORzJRxXSyIruhhffZ4D1qMsvgFePX3d2ZxTOlHVwUJ5pvb2MYhsQWOvyGe/B?=
 =?us-ascii?Q?uWkli42xSyMLWI100HUMX8iEsG0HlIDJTlAtB4t5vNliAJF70Oj+c8lxlbm+?=
 =?us-ascii?Q?Z5k5gWn2ZG+W64t3aBYcLUkMK59uWxbpoxebltZkBdAp+sYQQaoqFImBQvM4?=
 =?us-ascii?Q?bHYJOCTHzCIWcaTIeeF1S4eAX+0I+NrX0Rpfxt/LYajh6kOjYEJ/+tvmES+A?=
 =?us-ascii?Q?5TC+KcwLY5QheReJFDibYOofKHpCliZTM8N15j2BxS/AxZO/zmiQ1RV2eshW?=
 =?us-ascii?Q?lS4do+laXoFoX1WTodgdso2gb6dMhAxRK2B3I34vjvgnIwP4C3MwtRAq9cdw?=
 =?us-ascii?Q?gBj19gchzHgRMYhJWaTH/xPbuwI6z8L3TuBzmHHN8GeZE6YZPtF5IIVABRMd?=
 =?us-ascii?Q?ZbM2uiEaB2/30C7eJ9fK3+o2V5MYSwAwMUzjl/MxyZbH/f1aLm+b7v+N3vMy?=
 =?us-ascii?Q?pURKeTsfBoYr8AD8vg+O64Luox81MwH2DpuwUC7B7DdC/wZj4ua8N6HoXqs+?=
 =?us-ascii?Q?PjyEC0apmO/dLdqyk+NcZstPF9r+zUEaA4jZUem27cOdQ/2qYBeiz6QMPFMB?=
 =?us-ascii?Q?TRhwWnlAW3VDAtrSmnvM6p8aHb7SnyNUyPAbPQM2HWLPGb2Yc+BgAnrCy2eX?=
 =?us-ascii?Q?IRqiQF7Vzjeao45VN4SFYECrAsNioU+dXoqXADELLUG3SOTGBqemBFOTrgXB?=
 =?us-ascii?Q?5frMX0nae+nccoJn4hTRz7Vx+UekAYFnRaIGMPwQAlZ0EBIDEUcELEm6Ihv7?=
 =?us-ascii?Q?KD7BiJvC19M3unATQRCmzW9gJwX3T5mU/qcupldvKdpdJKAeK9/GDj0EVKJH?=
 =?us-ascii?Q?KWBiU1Rr9dK+xR5v6cdexOGAjVbRgg8NXLz9MoX04TFF/xWlnh6tW1oAD2/2?=
 =?us-ascii?Q?Zyu+/+TGcX26w3S/6KAomJ6JicNC/MTiqqDOgtGu9n4idvoijTcdN6jK6zOh?=
 =?us-ascii?Q?NOwb3pohePc1sgnsz/s9eRLT5UiUInwNMubd338M432EJa4mtMj/mg5gsnkt?=
 =?us-ascii?Q?7zeYyhKwqz8nA0Y5GTRgzAV1BkuO/ZDfedznPBxGFqnc4wkucUo9NJ8IksC4?=
 =?us-ascii?Q?fhpwlpDSjAhXinlDf4seg9bY1D11fNtdiupllD0npg2sD1TDSCQbCoC4tfdj?=
 =?us-ascii?Q?DR/sNmGB4uNvHilCTycdDQ5ghz4EPjNdBVZEyBVRQNHDBqgjc5t2avJv33x7?=
 =?us-ascii?Q?bVo9F88yusukwSceGwvlszx3+JGj3W95Ltvl54nGanN0wQsDaeJuoeFCCoSM?=
 =?us-ascii?Q?R2XXH2mDseEsA3yMDvmVP+YrlOhQ84ht0vFAMQCOdHjUo9FkNZBrRE2SOPYZ?=
 =?us-ascii?Q?4guyNgRGeuRh893mKGof7IkmLmxcNfRXNwYX163/djZUu7GqzauUDzyvtxtx?=
 =?us-ascii?Q?43LwUwHOZvV2FtYsJbNT/wMyb71Kaw2EOvyi4DnTWliHFGUfwJcHXtqO910p?=
 =?us-ascii?Q?RkULh+qu2laGVWMk8yRw4KEW7L3GYgrSVPtqSNYeFhnfV/kCT0dhNipS0sA8?=
 =?us-ascii?Q?3m6I4p5JwhpEjBiyunFfSUMqeN4E9Dz7LCoxa7NPwMWxZQ5JKVz8cdvw0JLZ?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d603ad5-f4c8-4fd0-1cf7-08dbf24c43b2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 09:02:37.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFj7Zi/ZnOVvUACzNINvObvDChdIKhuYg+Id6uLT3E4OkHrabIJQas93QWSTEVz78yHNAKPpYY6tqAqzMoD9scbRJfNqcyjAvuR7KG+SSTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB6494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:27:05AM +0000, Greg Kroah-Hartman wrote:
> On Fri, Dec 01, 2023 at 03:40:55PM +0800, Crescent CY Hsieh wrote:
> > MOXA PCIe RS422/RS485 boards will not function by default because of the
> > initial default serial interface of all MOXA PCIe boards is set to
> > RS232.
> > 
> > This patch fixes the problem above by setting the initial default serial
> > interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> > 
> > Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
> >  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> Why is this a RESEND?  What happened to the first attempt, did I miss it
> somewhere?

This RESEND patch is the first patch of this patch series [1], Jiri
reviewed the first patch and suggested to split the second patch, so I
split the second patch and sent it as a new patch.

However, the first patch seems to be overlooked, so I resend it.

[1] https://lore.kernel.org/all/20231027062440.7749-1-crescentcy.hsieh@moxa.com/

---
Sincerely,
Crescent CY Hsieh
