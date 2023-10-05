Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796E17BA015
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjJEOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjJEOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575ED24E93
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWmfdB2skpsEo0ahBhDtEfcIaVeTp7FnYcfMdwDC518tGABO3HSfmsMg4xZqDr3B1uNsSa5nr/kkXHoBEflocxhynP/ANYb3v8znsdR4Tp4yql/lnxKR6HDBFKNyYi/4Q77sB8c+45hFaQNrqu097LHHsLXPy3H4Sr4KTGXRWLLFHkd7gtQjT4dVf5Hw9jx6m0CKmWZSakfgLfeqqe3uuAmSzPLtPOK2/Tc0pmM/VrW5Xvsye/8Nqlz8JnCOdJ1ec17hDKoT5+FFsYQe7wJvqVDAYyxN/Wz8/5PaWN60EEN7Ms0Zt3p5gJkIBdbCYXC1M+EHwhkRu9eNalFLzLulVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW34th6qeIjn9vJvs0qiXtR5NaNImu2GeJDHaHgL9OY=;
 b=Ck2354I6df+dyJwDrhdmmesqY0YfsYR43aYx1omJEGe/yTqsO9mpD7N+S5DDGfEQHnprwrxPQRPT7Gpug9MsRGKyVJUviDYTh7TcA1pWT4ycLyEkWgmlotzzKhjFTbjQshTu87SUTNr4ikwAmDl7pBhN2oVnbeFHZFbGN2bKxPjEs4mjlfhig+vzCrTIKtH1GKqTTmaEV0N+SAATRz/nV3epuw8+P/wSZWg6/BvC4FjeO5UTum3zLq6bPXKLM6W4BJDSM7/DSoWwBHe5KGyJbz5tupgUwWmHiQ9B0n7pF6xP+ewcXnPI8FNehpaMPyvjsFZ3OoymlEAAFvz6mjWmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW34th6qeIjn9vJvs0qiXtR5NaNImu2GeJDHaHgL9OY=;
 b=obnqH1om0DnCA1P/PcIcljBYbGadLOqpjkWLqsyUF6Nl2ow76T95zuCDxDs58xDsypamDjnM9njRIzDZB05Ykkinp8sN1CEmQikpXceED8aU54OH359QQ1MJWyVByAhWcJD2fIxviYuXyutH1wt0xQYhmqh19CI1qXG9k8ZhBQk=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37; Thu, 5 Oct 2023 11:30:08 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::6d3c:55ac:112d:537e]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::6d3c:55ac:112d:537e%4]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 11:30:07 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH v5 3/5] cdx: add support for bus enable and disable
Thread-Topic: [PATCH v5 3/5] cdx: add support for bus enable and disable
Thread-Index: AQHZ7T5gah97RCqkD0iJBQh4CLPocbAs52gAgA40jgA=
Date:   Thu, 5 Oct 2023 11:30:07 +0000
Message-ID: <DM4PR12MB7765F5E32490D551BD6C572D8FCAA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230922101828.33456-1-abhijit.gangurde@amd.com>
 <20230922101828.33456-4-abhijit.gangurde@amd.com>
 <2023092613-clean-antitoxic-077c@gregkh>
In-Reply-To: <2023092613-clean-antitoxic-077c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=8c310e3e-2fe2-4686-9c88-14b861fc0f96;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-10-05T11:01:21Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CH3PR12MB9124:EE_
x-ms-office365-filtering-correlation-id: b14e63cd-90d3-4f93-f5f5-08dbc5966d6e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EC+cSTtFVnauXLJrvVL/T659aTO1YHt5s/lmyusYUJg5ZdbZet/LqxYjj56le09bRafsjNm4NeZMp1lIHNurcuLvPp+QKh+mi8hHSjnWlaex3G/gvYAIR10OlhKnh/9hNwerWkjYu4NV7wTHTTS3O7KYe5v9P97eHNGo4+gnbqXGI+RmkEucC4k4a3CDJQkxPNPmhoDC6XLCjMOr1pZUGTKEKxSR1Pf3hAtpIQ/2R/j1l/tk9grXg4OMQpNgQurAweO6eDyhsiQpMOgor8EXeKhZa0Z5lnNH8lPhvkXT0PluhnMc0ueHLaypL7Z9wjlXgjGQnvFazLy1x9Or8wGhCCda7+gppkZ4nFavZP7xDWjvVUnZ+DSkFpQ6FgrBXg0lERadF7WIlKzqAM4Q/HllRikClMmjFri9SZ2ATOaQ/6kZ7q7kxqblfnSFI2mg9UZyiQec6WU5v3Jj7KSmgQzcT+FIbVl38d9Akxtt6zezEAGBBjT9YU1k77NC8NsTlcJguKmbYoequG2yb2pBoCHQ/RACmdiS7kg3nUwHoAEmE1gwxIL0wrz9Q3TVRLmd9UbczPch7K43tPCjERzEKQzzjQVhhOJrqHZzbzvB76U8zmIasm7veSr7uVFZ3l4Am5n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8676002)(52536014)(2906002)(4326008)(8936002)(41300700001)(66556008)(316002)(6916009)(66946007)(54906003)(64756008)(66446008)(66476007)(76116006)(55016003)(26005)(71200400001)(7696005)(6506007)(33656002)(9686003)(122000001)(38100700002)(83380400001)(86362001)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEcxgEzyR8HKJPijs0zUrySdJuqtlIf9Ab0YAoFRlmKWSrvlJCE9XF1hMi18?=
 =?us-ascii?Q?2CV8mi7/eU+k5kDcSxXa8jNmIqhcOJ4Wz4Tuofxn0dQtsArHbVBUlgGYKnyB?=
 =?us-ascii?Q?tthxtenW0zpBXIJLvkw/1CjtG8HckVbtplwc0BIMGwYNlXsAPIoi8Lu9Sedb?=
 =?us-ascii?Q?hmT4UCpc2rGt8rXpIGOYCZR1Aw1rCzrvID1H6nROJIQB1KfMBvgmuvb/nq0Y?=
 =?us-ascii?Q?LC35KUMdyeyzIF7jkAWoX23Ug24gf3VDiertNdgWLjzTT/ffhUVvN5Z9Ur6b?=
 =?us-ascii?Q?TysJr6UPuc7aQU63YLYAT56+0DdnbkwB5dN5hrVd5ofkdSfhSEcHsnfoXtRg?=
 =?us-ascii?Q?t4HL3lTXd2SEJp9YNyw4+hzZWGvX3gWTmUb4xYORiJPFvrpf4sS1SH9DaGYU?=
 =?us-ascii?Q?YKPO0FIK1R4aolLb8AqeeMGSBm3WOBSH1SxBmtP2vS7INIxJYO2fpW9Pnwfg?=
 =?us-ascii?Q?oWsgdsajX6jMdrQD4FpAH0sAH4o/lx1rHaDbyodvGajTDkLzQsJXDdaKLdPg?=
 =?us-ascii?Q?EFye+K4IZfS+oglC+7pV8qwvklQnK8GELrVWikW8rnRoGL9EpaJ4EjCUYIuQ?=
 =?us-ascii?Q?pF6ZxNowj0JA8MPAUdoMRHzYiHq3jrnTMivLN7wau8tIX//a30SrqbGl6XUN?=
 =?us-ascii?Q?JNfqHGQ2cUTkpRtlBZzEyiK3j/ZKtErdLzWKKxlZXGeBTsPN+80A0Hr/WLhk?=
 =?us-ascii?Q?OZHu5g9kAxmMa6c8wktHOrhsmRgTkcLm4zOF6ROV19JxYYVmX9RrXXhykgYh?=
 =?us-ascii?Q?1gWP0RDN8rF1kqQBNa5khrroEBx0T0ClFFEx2aIl1Z5pbtweNnA2e6WNvb55?=
 =?us-ascii?Q?xndfLNk73cvv9QIH4EBCv0kMpg7eN/SQ0Oa0CK/XF1xzRzLl0G2fyEGc3NOQ?=
 =?us-ascii?Q?86IWKV/PwOGdWWu0sr7bTgo0JT7qS8aooKTIYz0zQ1J41rD3yNAzd1ZtZOVG?=
 =?us-ascii?Q?dRF9qmHdV4KGKbZqs8kwomyYAEchw1HoW43R69j0DbzgGpfNuiArbYj99U9G?=
 =?us-ascii?Q?p84T7oYYXX6Ve/EbYJUVGuOfD8THG2ZW2DQ7cEj2RdTw0wPr5OtDKXkhdvsB?=
 =?us-ascii?Q?1US/XpgUlUJhM+Fz3rOiHwahzY5J9UzS69eIBMJXuP3qa4q05qTg9RtQdbbY?=
 =?us-ascii?Q?ki3M/rSqBN8mBRRLxJ9m3xCI+qt9VvQb4tDUWCyYQrSl8FHXPmLNCNCFScsC?=
 =?us-ascii?Q?ecVLB5zEGPD6fzgwWq3SKGpGDXdTWFsLvr4x/emQEwUMSqCmRZ/kM0Q5RNaB?=
 =?us-ascii?Q?YFR9YeqUzVrG585g4trJnsOUxHh+HanFZ595CYkCjHLA5s/61cf9auNtit5B?=
 =?us-ascii?Q?54BeX8IbnTyTTsPkUJHIJK9CVTQeAaC9Why8herzo8J8RgBtIDZNYl3bpfhB?=
 =?us-ascii?Q?juud9S3ghUlDFTsBfEWcXuAMqX3n0DZNw4FVJMZ5q8Dpbc7kRcVooPvvMsXx?=
 =?us-ascii?Q?NHuJUj8Ax1MOq5XiySGPl0wn9GNv/5bR9kGJrf6ARJVZWEIQmCK3/Z039BmV?=
 =?us-ascii?Q?QGNGcxtMvrNc3bxIrnXC97DItqDQeCI7TVXeJlOUe/7GF8Q8637LQwcLNvdN?=
 =?us-ascii?Q?CjOE5Gobd3mzwt4UpD8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e63cd-90d3-4f93-f5f5-08dbc5966d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 11:30:07.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlnFCtlq94r9eVQwoYKjBbmP9/m+EbQE3QCyxm9sAEdobJxmuxZ3twvgf/8GKAxZdAJxkQqZ+dslxLt4ehsmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > CDX bus needs to be disabled before updating/writing devices
> > in the FPGA. Once the devices are written, the bus shall be
> > rescanned. This change provides sysfs entry to enable/disable the
> > CDX bus.
> >
> > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> vuuren@amd.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> >  Changes in v5:
> >  - Rebased on Linux 6.6
> >
> >  Changes in v4:
> >  - Add sparse marking for lock around cdx_find_controller() function
> >
> >  Changes in v3:
> >  - Use platform bus to locate controller
> >
> >  Changes in v2:
> >  - Improve documentation
> >  - Split sysfs entry enable to enable and disable
> >  - sysfs entry enable and disable take bus number as an argument
> >
> >  Documentation/ABI/testing/sysfs-bus-cdx | 27 +++++++
> >  drivers/cdx/cdx.c                       | 97 +++++++++++++++++++++++++
> >  drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++
> >  drivers/cdx/controller/mc_cdx_pcol.h    | 54 ++++++++++++++
> >  drivers/cdx/controller/mcdi_functions.c | 24 ++++++
> >  drivers/cdx/controller/mcdi_functions.h | 18 +++++
> >  include/linux/cdx/cdx_bus.h             | 12 +++
> >  7 files changed, 282 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index 7af477f49998..04c8dfe7e201 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -11,6 +11,33 @@ Description:
> >
> >  		  # echo 1 > /sys/bus/cdx/rescan
> >
> > +What:		/sys/bus/cdx/enable
> > +Date:		July 2023
> > +Contact:	nipun.gupta@amd.com
> > +Description:
> > +		Writing bus number in hex to this file will attempt to enable
> > +		the CDX bus. The bus number for the cdx devices can be
> found
> > +		at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the
> bus
> > +		number for the respective device.
> > +
> > +		For example ::
> > +
> > +		  # echo 00 > /sys/bus/cdx/enable
> > +
> > +What:		/sys/bus/cdx/disable
> > +Date:		July 2023
> > +Contact:	nipun.gupta@amd.com
> > +Description:
> > +		Writing bus number in hex to this file will attempt to disable
> > +		the CDX bus. CDX bus should be disabled before updating the
> > +		devices in FPGA. The bus number for the cdx devices can be
> > +		found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes
> the
> > +		bus number for the respective device.
> > +
> > +		For example ::
> > +
> > +		  # echo 00 > /sys/bus/cdx/disable
> > +
>=20
> I can't remember, but why aren't these just attributes on the bus
> controller for that specific bus, and not a bus-wide attribute?
> Wouldn't that make more sense and remove the need for parsing values of
> a bus number and make it more obvious what bus was and was not enabled
> at any point in time (i.e. you can't read to see what bus is
> enabled/disabled right now with this change.)

Currently, bus/controller specific devices are not added on cdx bus. That i=
s why
these attributes are bus wide. That being said, we can have these specific =
bus
as a cdx device which would have these attributes. Will update the series
accordingly.

Thanks,
Abhijit

