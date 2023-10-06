Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5EC7BB121
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJFFP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjJFFPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:15:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57AFF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGnamK26cV/MouV3BeJB03TVbO7pAY2+9fHOC9IF77M1EyfWYfV8rKGos3h1JDkqrZRrcYpgUBOARAZwt6UHCCQm4ciEzYAuV29qu5U8tdjZ1TN4pyhtpOxanWkNvO5RoxZ9pK3TGC2A7Qd1u5aOk5Yj4R/1durYmJ0RqqGmsbnUDMNSZ/5Eg8THzyGDqd7agLHEWLofCMKJG4c1sCYLUG++L1mhsADzzdQikSNZnAQjaUuMh6B2988U6AlUo3t29rDWGw33F6qOFHIvVQS2wpDshvRt+d0+Q7TZ9/Tb/cFZbv/i0g52Dj2B3F3eIE9wERl3z9GYJKyrFTfyD5J0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+0gJC5k2WEKD3fSUEa6iUywxMoWFeS0U0k7xgavlg=;
 b=DcCEuElFldmvCqRKDvt4n35WmecfbZO2t0+Wa5Koq0Otzz0POoe13Doc7JePMwDpU3+jcih0Ti2eODVtOoOe2b9krR1i5/beI08+ZuW7d9rdIv9yFMQeB0fs1XTfXz+x9U8WuiqmZyAWHNYhNQt7t9JlLwJehRlwIVFh9U0t+gDV30V43dMBfGIDaKED3c1ZCaarffXriJZOGvwerQ/ZfueoC2Q28COtRneerESYOGx75X9GMSBnXOX0+r6RRdEXVXkXMn7TB0a9USrgOJrCtCeiaHpbtpw3DbZLAFoeafxaGKoNya1ab6f/OXpCfE8Qn4Vj0h6hbROri89NxvI13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+0gJC5k2WEKD3fSUEa6iUywxMoWFeS0U0k7xgavlg=;
 b=19utiYDD+7DFjHGW+SHkkv8dyFugzhTWobxw1hrykExY3i3BYWwlcM8j7vGPkUh1tdxlA2iQNstbQEjIg2sE+FC06/HBlw0K0F1IQ3fsg1uV8JfoDk8nR6WxotCGcCdpRvcoKHBWPm9Wv3OIgtOtQbKCY7f/VGxAMxf57eS4vp4=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 05:15:13 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 05:15:13 +0000
From:   "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Simek, Michal" <michal.simek@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "Shaikh, Izhar Ameer" <izhar.ameer.shaikh@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>
Subject: RE: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Thread-Topic: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Thread-Index: AQHZ9qcuCiY/b8yPY0qIylvRj4e2XbA5jA+AgAAQioCAAAitAIAADUwAgAGKjUCAAAEVgIAA/Ezg
Date:   Fri, 6 Oct 2023 05:15:13 +0000
Message-ID: <DM6PR12MB44654A0479C8E24B34C64A399DC9A@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
 <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
 <2023100444-dose-laziness-d488@gregkh>
 <d4ee1dc7-d642-4cbc-a2a6-200cd1fcc96f@amd.com>
 <DM6PR12MB4465D25826A74C22B3FC4C1F9DCAA@DM6PR12MB4465.namprd12.prod.outlook.com>
 <2023100528-dubbed-parole-0544@gregkh>
In-Reply-To: <2023100528-dubbed-parole-0544@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|BY5PR12MB4966:EE_
x-ms-office365-filtering-correlation-id: 61e83ba4-92e8-46ce-032a-08dbc62b3854
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7tmyAEFZ8F4bX3zVqDqzWX4f8VOWv26FbUNvma3e0F7gyuEyE97uW1UJ0D4yW75semllRaN9/eQR5LNUyAD09o85ROEX2ZUnd0R+g2/L6VO+h69q6+Ompa9wU8/M6UxXwySRFbfXK5gAkExzelWne1AXMX4hMvINOhrv16PfA4PsBDw7Wkn+Gfar3xyMtQHMNN5RxqCg6jbohNnRHS5qxzrepYfxQJdhz4cMNrUsFDl1sgCL6JyD59VRYElvuzhwdxo7QjDPrs5Yu03M81FNOICzf8VBPbEN8OStS1NH/mM7XYvuytTrMZpDeSrp0OlgbD5YGIRaJjqmeK2sRbA271BHBdgC5kgTM0fJw3o+nC9PZ4lZRB+cN4PYacwLxKzNArbt8IZwU9+C5x8tR8wd8WXiHI9kktuAspWi5RsCyI1Y6HJsP74UW0bIehUuXLfzJoH4Yu6fWxfG9RyLzjASBTZ8aKrSLXlaF7dC9/9TMgVIvjH3JVU5oeLrZhNSvysf6KF04qCcKtJ3Ca+/G180+OiGEHv/fHzq9c4AT0uN5iCQRSCXAeaA9SUj+P28f7a4QxL6f8q3cqpbSBG+pMU15HZ+DoeaOZQGmJkdJ7LmX/Ghd/PYUSYefjBOre8ypAv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(15650500001)(5660300002)(52536014)(8676002)(2906002)(4326008)(8936002)(41300700001)(316002)(66946007)(6916009)(64756008)(54906003)(66446008)(66476007)(66556008)(55016003)(76116006)(71200400001)(6506007)(26005)(53546011)(7696005)(33656002)(9686003)(38100700002)(83380400001)(122000001)(86362001)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMlyUQ5kaCcQSYOkOWJqXgAkoIcTQCH+9t5qV6EHQUxSnekhyABS0Z/ZixPC?=
 =?us-ascii?Q?UMTj7Krt4E5ZwsV2oeDlDJhRsKV3UZCe1aByMZYmdRCVXO9VtjYRwPcA+ANM?=
 =?us-ascii?Q?UlkFt6YttjJ0MqW2DoCEBc01iKK7xf61leX4vF+nxWWlMRH0zNP01/jfuRVI?=
 =?us-ascii?Q?7hUddncoaW8uY8/2am0jZGCd3fOaNmd52MvCoFe1eEC2OTQDvEYYteJKQg4P?=
 =?us-ascii?Q?QFFTyLn3ArRI4RDwL5m+BZW5HcYyolI4fICTeQIcvh+fOI38udiECV4RuC8h?=
 =?us-ascii?Q?1cq8KBLCInLIc2JJhuxxNnJq2fFlJqvVtV002vCR/jrkjd/0+gu72fdURMWe?=
 =?us-ascii?Q?6TUjYyupy2WqkhpShyBTh3lUFenfVJj7ZSW+h+a5aVCIkxX4KBCsSWhw6hMy?=
 =?us-ascii?Q?fP3rFo6bJbcSbpGenGE33+wtCKFfrB+nrIEWCwfqiFcptnB8dx7DNobpeFb3?=
 =?us-ascii?Q?03MTscNfQBR/C/Q5Pm4tZUaB1ICB45CTROJHSlDjb4Tz2Kh1Y26L/jLYFam3?=
 =?us-ascii?Q?4qwkbHpDZmtWO9M3xmL6PZpEjd17hNgBofPVtE713xLyjd7w0E6BwckqEEPy?=
 =?us-ascii?Q?RGUQ9hz73UomjC7Mbb5S6lXGAr8UqU426LHxoTp1oc7T6gykBqFnuG/pl9ZF?=
 =?us-ascii?Q?ewjFnsKX/ZtFtEQDyQ1ZFp7OLFkq5RMSvk/o9/0w40M3KhtA53Z/OEviKhVo?=
 =?us-ascii?Q?2iG3rtfuaK6b0u3B53g40yHCGPfTeywmzFDJ5O8KT0W/3JQPfk5iiQ7UTxwZ?=
 =?us-ascii?Q?2NnT6hx5kSjoVNL8a67yCh5cb1e0y+uYAFQVYs4B0Mw0jajorxxhfcCFUQ6r?=
 =?us-ascii?Q?y9ryiamVe43q1dh+W3v4snsOZCV9Wgh299wr8ZF293BrY7Nkh2Yn+ZptuNf6?=
 =?us-ascii?Q?/Ivq5jtRd6NfyAI+NgOyipG0bl+uZQqFG6jWiCsnbKBzixTk97QG+urFbJn5?=
 =?us-ascii?Q?TVDFHOi2mLvXOqxUjnUwRAn5fPCL7SJin2dV33et01ZigZCe78UewE/EYoXf?=
 =?us-ascii?Q?enG8BFL/hp3X2USApPokAUDHnr9YeUgOF0wGXyMyUdf1o5qYelqfdR+Qyvj4?=
 =?us-ascii?Q?txFRnAOQLX9EePNwth41r4yCAOp1OmFGFTg+yXM5BmkwikY4PiLLJcdKBGt7?=
 =?us-ascii?Q?RPLicci/ngNsV+kQ18Van9aZ70Uw4HjZ2G7k/lj/nciAU9V7RtlMWKb+x+6Y?=
 =?us-ascii?Q?eAMg51Almxpwpc4Oiy529j6ExKjP86djBtcXwVE49yc92211Cvw7mzSVmrB0?=
 =?us-ascii?Q?MwcBzf/12FXvE2qmBf588/rNXIoCnISNk7eS5Hv3yf7zzMtKTXjX75WhQpu2?=
 =?us-ascii?Q?Pl0Xu39ebPRHz64KUE3sgGh9k+Y0qwOdBiZ33Zbpzc+PzgRnpqVfHMcUmzN4?=
 =?us-ascii?Q?mgIh/jJUZ1xKK3tfHjl6KZDX7+jBb0y+U5hWxZxzDhS7cjB2fyMIw4uj5iOc?=
 =?us-ascii?Q?g2CatMbOzxi5J9cQN7GG9zEZSxpsKFCTFpANiuavlw/SDOj2utQQLghB6hXW?=
 =?us-ascii?Q?eIt5rugTXnxsADFyFoK7DKPGG/1RYu+ngFK3kHl24C2OmRITekQiCnV+SQNQ?=
 =?us-ascii?Q?Vq9ymUjj1dcftMKJ7ME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e83ba4-92e8-46ce-032a-08dbc62b3854
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 05:15:13.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAgyTmj9x4LR7wT97PNI/OetEytH414lcCxys2xg5tsvxETt3/9Pd2X0JIYX8g3M7CBiSoCLOyQ5HJag/LbNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, October 5, 2023 7:41 PM
> To: Buddhabhatti, Jay <jay.buddhabhatti@amd.com>
> Cc: Simek, Michal <michal.simek@amd.com>; Shah, Tanmay
> <tanmay.shah@amd.com>; Manne, Nava kishore
> <nava.kishore.manne@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> robh@kernel.org; marex@denx.de; Shaikh, Izhar Ameer
> <izhar.ameer.shaikh@amd.com>; arnd@arndb.de; ruanjinjie@huawei.com;
> mathieu.poirier@linaro.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Kannan, Arun Balaji
> <arun.balaji.kannan@amd.com>
> Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of ev=
ent
> manager driver
>=20
> On Thu, Oct 05, 2023 at 02:09:39PM +0000, Buddhabhatti, Jay wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Simek, Michal <michal.simek@amd.com>
> > > Sent: Wednesday, October 4, 2023 8:05 PM
> > > To: Greg KH <gregkh@linuxfoundation.org>
> > > Cc: Buddhabhatti, Jay <jay.buddhabhatti@amd.com>; Shah, Tanmay
> > > <tanmay.shah@amd.com>; Manne, Nava kishore
> > > <nava.kishore.manne@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> > > robh@kernel.org; dhaval.r.shah@amd.com; marex@denx.de; Shaikh, Izhar
> > > Ameer <izhar.ameer.shaikh@amd.com>; arnd@arndb.de;
> > > ruanjinjie@huawei.com; mathieu.poirier@linaro.org; linux-
> > > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer
> > > of event manager driver
> > >
> > >
> > >
> > > On 10/4/23 15:47, Greg KH wrote:
> > > > On Wed, Oct 04, 2023 at 03:16:15PM +0200, Michal Simek wrote:
> > > >>
> > > >>
> > > >> On 10/4/23 14:17, Greg KH wrote:
> > > >>> On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
> > > >>>> Added Michal as a maintainer of event manager driver as
> > > >>>> Abhyuday is no longer in AMD-Xilinx.
> > > >>>>
> > > >>>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > > >>>> Acked-by: Michal Simek <michal.simek@amd.com>
> > > >>>> ---
> > > >>>>    MAINTAINERS | 2 +-
> > > >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>>
> > > >>>> diff --git a/MAINTAINERS b/MAINTAINERS index
> > > >>>> 35977b269d5e..f36fefd7032b 100644
> > > >>>> --- a/MAINTAINERS
> > > >>>> +++ b/MAINTAINERS
> > > >>>> @@ -23672,7 +23672,7 @@ F:
> > > 	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> > > >>>>    F:	drivers/net/can/xilinx_can.c
> > > >>>>    XILINX EVENT MANAGEMENT DRIVER
> > > >>>> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > >>>> +M:	Michal Simek <michal.simek@amd.com>
> > > >>>
> > > >>> For obvious reasons, we need an ack from Abhyuday.
> > > >>
> > > >> He no longer works for Xilinx/AMD but I have asked him on side
> > > >> channel to reply and let's see if this is going to happen or not.
> > > >
> > > > Mantainerships follow people, not companies, so if he wants to
> > > > keep being the maintainer, he can be, there's no requirement for
> > > > him to step down.
> > >
> > > No doubt about it but normally in these cases people send a patch to
> > > start to use their new email address which is what didn't happen for
> > > quite a long time in this case.
> > > I am definitely happy to wait some time if he reacts but if there is
> > > no reaction for some time we should fix it.
> >
> > [Jay] I got information that Abhyuday is aware about this, but he is no=
t going
> to react on it.
>=20
> So I guess they want to remain the maintainer?  That's fine, but a new em=
ail
> address for them is probably wanted if this one currently bounces.

[Jay] He doesn't want to remain the maintainer.

Thanks,
Jay
>=20
> thanks,
>=20
> greg k-h
