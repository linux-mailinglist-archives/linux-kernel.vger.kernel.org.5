Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F27D81F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbjJZLos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:44:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2FE1A6;
        Thu, 26 Oct 2023 04:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3EB606MU9bAUc+QNCTILDmVnxchk0U0sNc4FJEhqQQPO/xKIwAoCpNqR6I8I2Qfx39EEYR62JEzSoUEO+Jlcm8qNUnyQCqXao7OalTOD3w5L0KGRS9VlIanGrGi5OeANQKGUXdZ1MfViYUlHIUbOVGQUYbclhAet6UXt/tZuMM9Y0CUqHSY78StKGNRigYPVQ6er5YUM2L0ZbVizaiuLM0CgGakctzKy4nA8XflwoGxkoRpurHFFxSsbE/S5nwO5Wj+jouwsrkqhizOyL+aa4N06XdevrJyGctKsWbjl2j0coa/OKjvvskVoUkin0Wb9OZcDkilpwZ4q297hLLoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anNSZB8kW0JJwaYQgdL5/05CboQCmHAn9C8wAnk+60k=;
 b=OJP79xAM/I17jVqbDvdLqzsFy8fx+1N6MDhOIuhq/u8jdmh/osGzCBi29cNVG45RuPYj5PPREdKKiZIGVl4mnCRAWoLk7GO/qK/2OAzQ33bGugvfakJU4oQVjuWRyUjtUWMwu2396djsGOvkJLTR2moBMWla/Oy72S9eSIW8046XW7ZecqRhXFj5SRvfsFitbBl2puxvF6RfT9q0FxTEMOCM4h3xhcIwlvOz6E/TxMWmK05f4WX7PoHalRx/tplqZTDbKZ9RTOqNvWNY1PqIxB4S67kNkTkqEz47thaDJE+pHhN1SjC76M6v5wxLi3bMw02MySnWANhVKXaCDVii2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anNSZB8kW0JJwaYQgdL5/05CboQCmHAn9C8wAnk+60k=;
 b=m4cxudn1ownYpHHEwB16QW7FAY31vL6MlOwlyJuv/zg/JoBHzktKpYVe1iwsKdEZ4IKYBuo5mPD/CgLNXlpokiJfAgyC6Xsg/UIg3WrmEZSAyQj5L566m8efCYqR6+bQAndDzD2lsL4FYog/reTIWJp1AHRYFJnrVxJKgZ49NdU=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEYPR02MB7535.apcprd02.prod.outlook.com (2603:1096:101:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 11:44:38 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 11:44:38 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: AdoIAKmVQtjfA9C4QyyhPkPG4HRlWw==
Date:   Thu, 26 Oct 2023 11:44:37 +0000
Message-ID: <TYZPR02MB508866DABCF200C7687E184889DDA@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|SEYPR02MB7535:EE_
x-ms-office365-filtering-correlation-id: a2c75ac8-4b82-4c09-ef28-08dbd618ef0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLD9+ZM3fGga4hXM/6we4JKSYKHHhTjx3QIy6lO4nQdmH+JjbIwmoGH5OmW3GplR5uVJ8C5wjpoEBLkDIcrJnWF8ei/cQBIJg92lrEMIBvTA+Dtse82FbEdhkmuBq9iNrhATKJlZmLrnNlvNUVuMf5R0p5ydyhLI1ixB4Lo8o4+7W4jzNZkqC2m6+oVuxYKmo/VJ7aH04puGbMX9cobeFoNumUC5Vt+xpq7yBKYlcwX9U0WzzjdaO0EAh2BoLeJarr/HrkoFqN+50sevLDIYHrYyqA8UDAlzmuuidxmRMJlhMeH9Sd/d3z6eJjPcI7EuK4hIzYkMLOMUXXOowy6DxZ0eCNTjTCkR81k8uQ5wkmWe19UaRIzZyvNCv5hCI/5GrCiCDbPFeLrvD/+z7ycMpf+CRyyfYZdRQY5nLqlNelbEg21EX12KuTbIdJAIER6HWtEjmUTMPN7ltLgJPILMy2DZKXY+91YeiEOtsj9U72XNcmRZOWBS5xbrAO5pr5EWUDbNTsNHYLBTfw9mJyfHQQCrQAex+QVuoNfil08fpLG+eTTfZWGmoNDOLPsvrjs+V7MSFuWG4Am0LH02qsEYx+dtwlYzkU9averhsunHDcGw5BJ8LYnpECxSnxGmW5HI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39850400004)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(66476007)(66946007)(76116006)(66556008)(64756008)(55016003)(54906003)(66446008)(26005)(316002)(122000001)(478600001)(6506007)(7696005)(71200400001)(9686003)(6916009)(41300700001)(4744005)(38100700002)(86362001)(2906002)(33656002)(5660300002)(4326008)(8936002)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wkcszcC5/jh2PorPWiAMGe5J3rgxrSj9hHhmd0sRL2OyPgJa4+Ye/x4XcZuj?=
 =?us-ascii?Q?q+z1RH+XFlBWG+LurzlMcBr1SukqgmgRrzybrN3ZZLvGlJC0THVKEaQWDAb/?=
 =?us-ascii?Q?lPA7n5+bR2DgwZEe0qFq4k3dpxWqgr9xSNyWpP3sGeghP+D7114FTIVZNrAM?=
 =?us-ascii?Q?LP62dnOmNaEazXuAhjCrNoI+Erij8AQ43VwzgOMX/7QFutBUA2zBz5MewDBt?=
 =?us-ascii?Q?nTJssjhBA2biEXMrWTe4llettiDK/eHbinY1irwEGDpwnMQ7gRPm20Fsn2e1?=
 =?us-ascii?Q?ruT0C9yA0JQqdXVz1Eb8hKB6v3Rjv6+ITEq6fw3DIMR/xLFLl8hJ1y85qoPv?=
 =?us-ascii?Q?22yYSxQYbk5fAAcFBb+nvGzc2mhf6nousdlGLGCFtTsvNqrQgU3sM54BGbNe?=
 =?us-ascii?Q?89w20iMgAhSa2oIcxR7E93+TKh6pU3pqz72CJhWQOEpPBn7zg8uOBAl0fWX9?=
 =?us-ascii?Q?qBZ+uHOD7JfAlg+YELWgvOaP0nAo9e6oO76pHNzOOTe7h1kZqXdWxcCQgqfB?=
 =?us-ascii?Q?/c2f5lPw1q2tLOCtr9V9rM/Stfml/gTBEO0CrypGdkxb7v8iM/PGSK7Y3c8q?=
 =?us-ascii?Q?3pHrWyNtzkM1fSa8bV8IP70rpasGfJxaSVTExo+jH+GzKjySIJfX7ILVOST4?=
 =?us-ascii?Q?SqWM3uQqRQxSDSKQP7ueX+MGMnIYAtB87k5yFQwESwlAky163HDJfPDx6qyq?=
 =?us-ascii?Q?4bf6UUkB0bAmzUDRQ+fnUkDkQhyYKo2l/ZZ+uSzbEV4Fge1kFu57AQ919LUT?=
 =?us-ascii?Q?f20H8mkckXv/updrzOGL1cYInQl04ctmQWzuv8Gq8nImKP4NXlAlh8Jy6ONZ?=
 =?us-ascii?Q?+cnq5E5d1MONquKYmoOMtZdzbH27DH7iHXeDXXmQOI3FXnz80btfvy75k968?=
 =?us-ascii?Q?vBjXiI1Zn9BHuJIbqGIfiyHnlf7pX2XV6NEUUeqveK/RLI2dKb1qNxe4F7ki?=
 =?us-ascii?Q?CiaiyD+KE6wm/na5gAallTLX4rPoRCNl7HMs4UXj+9qQf5HsNi8jEch/J5WE?=
 =?us-ascii?Q?dtbJHSt82Es7I6SygKi1UiP7lb8/mu9JGlQ0ulA3svP7G6x+s7Yn6v9u/eQM?=
 =?us-ascii?Q?QiD5lGuYtkFg/odUAVQuNqXFiLcKsNM8hjI7qQqA6U0ogoLUazx700RAGsX9?=
 =?us-ascii?Q?fFEcpJe/T4lLJJc6pOKmP6DSpcbVr0sXILrLq9kV1Yu92q54E3f+3tnD7Q1k?=
 =?us-ascii?Q?IssmDJCHuA4jG53YlOWZnCnCr6MYgD+xFzlNEBh9V1tBkHAn2WulZIu9QQlZ?=
 =?us-ascii?Q?yT4voca/VxV2DIUd0BInMEo/cMX5hcUNoP/dsWcHr0L749CD8BzELBjUmwX5?=
 =?us-ascii?Q?Hkoo4BN4rOoi3mhCYwFg/VLrDO3M0v/gOeO0db7f3CHWCH0zAPlAM1XkHyKX?=
 =?us-ascii?Q?vTN6WuXn6mXzgz59WQZJGnoa1hTAQog6zDZimWO6ecYnQe+2nsJo6Z3nsOaY?=
 =?us-ascii?Q?Z9x+nfWZQcPIrOBwZ050k/aShnjHNp83jgjWUyMBUn80Ac6eXZwue/Uh5nKj?=
 =?us-ascii?Q?KWhcTVvK/k16kCabmDuSiLujx+MOEYEtd9hOFbP/zrVAgRFKDvtvvTokS7e5?=
 =?us-ascii?Q?fNdukNwVu7RQjFLBaic81yG/RvPc1qhrhUIiVxX+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c75ac8-4b82-4c09-ef28-08dbd618ef0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 11:44:38.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tVboXKVJ2cpJq9K+uCyuYXo/B0IRhASufEhETBVT9WP+gU2gWAIrtw9656Np42AjlxpS4nkIBCd67jiFU605A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7535
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Oct 2023 09:24:20 +0200, Johan Hovold wrote:

> No, this patch is already in Linus's tree so that's not possible. But
> please do send a follow-up incremental fix.
>=20
> Johan

Thank you for your reply.=20
We have decided not to address this issue because it does not=20
affect the operation of modem.=20

