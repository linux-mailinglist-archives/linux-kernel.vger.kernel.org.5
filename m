Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075E79B702
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377573AbjIKW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbjIKQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:16:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886B1B8;
        Mon, 11 Sep 2023 09:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfrQobkP+XCH/q/Rd2XsQuOEDyzDog3ckwkTZKYNDiT6dZ+cIAFDwzCuUU3EU9/Ax/1K52sKMI7KZboy0HClsqlFN5oZF3A/WjRJhMJgLtgfW8umiGtYwlXM9bmoxv/OLVn7SGvke5abyI74Rc8JN1+czk5karHyn+jYCZ+wE7rERbTHGPL+heLxgCBh9WtLf/QS/Z67z7OlBwRZird+DNCvbEX+gVYVUD//isj5CvWRTUfk57+o7qOhgRcxpVvll+cIFJG0eaSeo3nlM3MuNVjs+QQtOITyftbuQSUiXFeOnkqczKVTEpgtr+ytupKLh3JwiJnTZ/nVZ95z5JejYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB4qXlChKXG8c63sQi0EVUaEAq8VIJ3RRkfBH64WjqM=;
 b=eWOareB4DD3qIVxJlHkjfQNy04WoN7Mkh7rWGjhmFEb6JpURvKirRiRdXepYZH3NVhZVxo/gVJ2ZWymlE37tl9h/4zOsIPNXGH9hOxv0gCHtN5o1wseZVomlXRe2jHBH+JmqkyFOSFqgrFpGIsTD6PFJNVJlga+uH8Bzr4OOrE4DQpLD/yCk0lbl9jK3ibieoud1HJ9SPaQHchVF5hsn+xzB12uTIrAUD4GtT3g+gXUNnMW8on9HVnFKKDNZFpYAJfZcLeJRMPSxrisAGvjdicNWGve5/s8XwJaRcE8ROV7Yz9E8mxCWpjFTxD/NHh9zLIj3xZ3Kr8S+a58gu5l/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB4qXlChKXG8c63sQi0EVUaEAq8VIJ3RRkfBH64WjqM=;
 b=S8B9bSacZo43Q7MwkuRtj34xuLuTs8K/qDpoLnVIDUZJXodOrs/FzTG8xVCHQ5gfc3LdX790aE2h8vKxJ4/pcgohX5a+DARsxV6rD/cz+fauotLQnaZAPxzI+3d7aN6tEhWOV+8NXyDv/0RMkTaCCAj6J7aOFEoY1xgSo8UeDyH9nqE3AeuxDUlnT33u4u0e1ZVcBqW4vKq7Hs813OAQEnTxR0O131bfUQlHAOa6+y85SiJMr7QupwlWBw+aCMJALXJ7fzMa6ReznIbWDxLAMumLGmgC0hdf/wReDp/TzY4PeHpLLp+oE2Sk0muKEHRyGlgjp06vKoCbHzrwVZ3MrQ==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 16:15:59 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 16:15:59 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkIAVd3TwgCWuaxA=
Date:   Mon, 11 Sep 2023 16:15:58 +0000
Message-ID: <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|CYXPR12MB9427:EE_
x-ms-office365-filtering-correlation-id: cd8de1b0-0324-491d-7464-08dbb2e26292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bK6sFXYhxXmL976gkfn48w+VXrk3ESWqzBNu/2Tff8GURxFbikOhAvubSqMay/BdbTyxd3FVxqR7HtV1afY5GsFBWMkG6rgVUeImIwMBGcXLxQyS1DsDhLCBjiLCmdz38FYO8km7O2CPza/Ylmn1xzLMu9LtzsBJ1PV/1z1qKsYuiIXeN1ebC2avMzZCWAEV0TkhxTVV4ponL8MNUJs38zddN5dMIUBf+nyhv2efX7QpBLACG6WmEd3Uh+oNzLHFzOwBOk1PZOSYT9ZFsOQdBDOSq0PdZAGGsbH+da/nahWM4Nra09DUJhlQAaRFRRI9cE7X7mJQ9+M0zvSKp2JYXiNgjIQlW/ELkpssrkZtJq2J/mql8z/GfC457xjgfeNW8m/Zbjkw/UFo7uOgGbWUk4ty3kJK/wfdIITmXFhWvJIPUQkUWPEm252SY/8I7GDj/XV58r3F3mh6lorMbLOTRJYZAC0G+Lz9f8fLcT8GTWpMdCEf7CJquFriEDAvNMFE1N8UVGKo0VGkUzrAIeD0I+l1AOu/c1LZSHhpvDMk3R1/BgZfZlIve1kGrJxsav/mnLPh7qvhx0Nh2LI7keMykJculwKmtDqertYxusNjja1fe1UfyukhFM/q5mM9tIVeuk36Se3OXpLbG93Ev7sy3m4I/0+Iw5iG7GLi+TutkmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(83380400001)(122000001)(966005)(478600001)(26005)(6506007)(107886003)(55016003)(53546011)(7696005)(86362001)(71200400001)(9686003)(8936002)(2906002)(64756008)(7416002)(52536014)(4326008)(5660300002)(8676002)(66476007)(66946007)(316002)(66556008)(54906003)(66446008)(76116006)(41300700001)(33656002)(110136005)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8szRVZlPjXrlD+1So8rcITRJWIHNGFsZOLFNZVF5qkd7Sr8zvUIC7YIisDCT?=
 =?us-ascii?Q?3NPE3OJM8PJwPr1rD72U+Na42XAI7Oduei26Kat8ng5Q8pewWjBTQITsQBaK?=
 =?us-ascii?Q?EBVohtNJTrRbe7RJfLYwWP7D4cbf3bCvDMjYMsqf4iOR63uTRwDTFhdXwoqf?=
 =?us-ascii?Q?pL8LjesTRj22xP9+eNaw1IhTx75UMG/FiGRn2boIT2nIKRt06EjtM2vgqWoN?=
 =?us-ascii?Q?Zm2LceXkz0NezGg8khyBQFU9aGZR5Lj8yw1jj0xgMTcHuCu0JLBSHgeyLsGR?=
 =?us-ascii?Q?CLdDKz+/aFQC7wecsGB3vbhlOaj0HMAH7LzuBjszBeCsWrvAAVlPCkn0kX9G?=
 =?us-ascii?Q?oE9ioLFMpCzG4qO01ayfhtpuxiWZApV4Pv9CFxtCIcRqtHeJThkkSYm+1Ln3?=
 =?us-ascii?Q?Qcczmt1nfTD42Fjec4lDTGaYhsDSryHtOvImSMRD06IZGRf3aqRrRoPnciGp?=
 =?us-ascii?Q?U2KKS7MnxnKBhDa2fRU418F+vgAL4kOOOh3kqpMXXOOJw9juARlNNjYz2Ut0?=
 =?us-ascii?Q?UYaXZVT6JmtJ5v143y8Z7JCutqak1mzjtt9538a94Nnfu8YFzPL+BrDjvsS+?=
 =?us-ascii?Q?rlykSpr7AuJl89P3qg5c5oKjIkhcfzOq/7nWQzLdQIBVxKI9DMXZbnE6KmeQ?=
 =?us-ascii?Q?vZPHja106px6BdyxZ+ROyk1TKxkOoFofuV84TJm60gMNLap5JE/sOYaINrc1?=
 =?us-ascii?Q?2amp3IW08OHe3824rc4JWcg3Zv0XLhuMAFPuKjMyU1jLcPBS8v+BDG9mMG2X?=
 =?us-ascii?Q?lQkV3iHXs3xWMFAfAMmpTZeAYn3SmiRDXJnveVzR4moqH5jQuKbC1u/uWLeZ?=
 =?us-ascii?Q?eyIXfVUdpNZkT0oEYFs1W9KJxzyPsabMm+YZZFP3gz6/8nHFmEC6vu2g6/qA?=
 =?us-ascii?Q?X+L912zvLA9/+wIBjcCXWfzh7A/S2+6UvvMhkQevFu+XBbFIFdKAbOpfWDlX?=
 =?us-ascii?Q?YsXwGaLoi42AQ/8eWoVJP1BpkjCF5tS9tpec4vQWmCy5DiVhP0SbVNLPpu4/?=
 =?us-ascii?Q?i/xuZARat2pqRl8rZjsDnbTFnJBb9PopKzEbqtxK2KQ5t1ZTahHOp8SiXGZI?=
 =?us-ascii?Q?2wIQUe3vKGH9REhSZkV/DDdQFA3B7QF8jMt8OzzxNiBfoSiW5FvHjNnqGlt0?=
 =?us-ascii?Q?n5nmpJwQ37A7Xov2bD9TX6z4KYDhkEm2pfyplRdDGeg07xiT8H0qQUdcZLhl?=
 =?us-ascii?Q?mHd/4sedw3cGCyDIiFTwwELAILVacyBDX43vmm196G9/Lh3RDozxKQA49dGE?=
 =?us-ascii?Q?x/DWaI5PiYYD7B5ssEP4Jj7HfVyOGe5kKEqs7oSRm1P8ZcTB14GdJRffAnDu?=
 =?us-ascii?Q?DuG8D0AH/4m9Htv6rRoAGjq74t4ZOxFx0Iqzs5sHE18A+R1IVGdJOjBdg8op?=
 =?us-ascii?Q?SLaIMyzxrrlYo9GNKe9nZVozkJaoPlUfNHhVsXKe6GGb7qDtrv2gArkM0bj1?=
 =?us-ascii?Q?uQfraLvUiNdYBjtr0RmNyAU+sV7+aHZHxsn4OXCD06g3MGj8FaLHStk/xHkE?=
 =?us-ascii?Q?DKXv/LkAKJZY2hQwbHh1iPeXsTHS5V5o4AS+o6sZzrl1h/XfP/42EedUzzKA?=
 =?us-ascii?Q?ekP2OD1qwkzjqtFFBuWrv/dhhR30o95N3u4R5Pzm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8de1b0-0324-491d-7464-08dbb2e26292
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 16:15:58.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioB81pA4S7GF0hZADHje6f53soflkwcHOckOor/bmoJ6fndxsnVWJDCcuj7J91v01Kqfh6lFxPn1Knj0gnH5aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any further questions? Anything else holding up this patch?

-----Original Message-----
From: Jeshua Smith <jeshuas@nvidia.com>=20
Sent: Friday, August 4, 2023 7:05 PM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Thanks for the reply.

It's not very easy to see. It's just a bit down from the link you sent. It'=
s the last possible action in the Serialization Actions table:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#serializa=
tion-actions

18.5.1.1. Serialization Actions

GET_EXECUTE-_OPERATION_TIMINGS

Returns an encoded QWORD:
[63:32] value in microseconds that the platform expects would be the maximu=
m amount of time it will take to process and complete an EXECUTE_OPERATION.
[31:0] value in microseconds that the platform expects would be the nominal=
 amount of time it will take to process and complete an EXECUTE_OPERATION.

-----Original Message-----
From: Luck, Tony <tony.luck@intel.com>=20
Sent: Friday, August 4, 2023 10:31 AM
To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@igal=
ia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.=
de
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

External email: Use caution opening links or attachments


> Can the maintainers please respond to my patch?

Can you give a reference to the ACPI spec where this timing information is =
documented? I'm looking at ACPI 6.5 and don't see anything about this.

https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-ser=
ialization

-Tony
