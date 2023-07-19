Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D231758E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGSGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGSGtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:49:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2511FD5;
        Tue, 18 Jul 2023 23:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAQzotEr4WHWKTe1rCepzL9Lfc5b9h+AnlSATMSPqx3WTA9e6Jjw51IE955hi6/Pr4d597Jzm3BlmyITnzsy08+h7fwq3y6kVS7m4e1ugAfatcicqaxJucdMMR/gRIuDuQDImNtbqzmut/kq7KEFFjvpq6AgRYzInATQMwnIOBzz2fPrUyMu9u6m231fpjQGrq+HYwy+EHv6VuZKBToaYOnLKtIocky9Fnc/kjZQkTTITewlvrjsemS+U4PtawLEkI/e2cQEClA1cLAESBKiWVsk4FYp4XvTEdS3lBRWVKfbJsnQLQEtS02JmRsT98mjg+cqXl9TidGZGarD9rN+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG3G4X4wet9mVDaBbHWB6H8W5Ldx2lq68jrywAy1ml4=;
 b=g5nVQ1lVjh7CKQc3v8HVotLgxDE326Lr+ZhdVXVrsWYBnx5NEihVR6x2bxy9OCEVpc7yyC6iUavKYjcE3djB/UuIQ3GJF206WIfRSrnLCdKqBIy7R7eERHCbJoRAAb6VS1ZL4elBvlheYPra53sYf9qJTwEsTmUn1wMskcmjDmsb1jpruY3MLgToYIjb7ang8fdLP9w8/aZ7JKILnAsQq5KZA4mPMYTspuCjQj+00wUgpMsuH0b4UDteevNY4HMl+c+MzO47LywpqDQA+V2g/VRLfLmfmSESqTOa9YxC2kgfTChqndl68jv4bPX/pADePBJxmtSjXWOBIC3yIt77aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG3G4X4wet9mVDaBbHWB6H8W5Ldx2lq68jrywAy1ml4=;
 b=dwh7DQcQkAeb6u4Uw5UXEIr0OMIShvPCYItB39WpQ5qZ1XuUC8NJNau7kMgIXQLMtdinDWqLy8/JBA0a1vWaLxY70ESKeYA9kgX+fwjNUVvSNkWQHV/tQdCZ8RCmMLZHpOplDKhfL1oaqOGLtFgQZpJUJGVNoxz2YTEah8BRoEE=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 06:49:44 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::2ea3:f48e:b694:b86b]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::2ea3:f48e:b694:b86b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 06:49:44 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
 configuration
Thread-Topic: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
 configuration
Thread-Index: AQHZuJH0ncIy31BdHkWYGt8pxhxs8K+/rf0AgADt+gA=
Date:   Wed, 19 Jul 2023 06:49:43 +0000
Message-ID: <BY5PR12MB4258543534215430BC2F8FA3DB39A@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
 <20230717093347.3869167-4-sai.krishna.potthuri@amd.com>
 <20230718-jitters-excretion-fe18c820c102@spud>
In-Reply-To: <20230718-jitters-excretion-fe18c820c102@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH8PR12MB7375:EE_
x-ms-office365-filtering-correlation-id: 3da968af-4a5e-41ac-1a56-08db8824558c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGzPeQoSeBUplyagj2dOn0VSfDegxXvJBuXM17ptzLLKNFcfzCse5GHJDogHPfH4J2dAykYdyoHQumngGByEqIjkdn6XEYtBnVIfvT2vMVZHT421F7ayow3Cdw2vwjmt/4z57YyO5h7Wg+Kuz8c76Z6I+6yNV6smWDCIxsriGoLRFcyBEUOPhQ4PBlkq1HoO5STutWqtRbL33my7cnmxNPVci5RkIKXiG20pPwbZnFn7Hmjh6+pRbLZ0Y4XdSqCWB65kVAC3HcQvlWurwUtqmFxkM1+fnOC/6h4V1ujDou59WQJNFSKWdt4qZcxarXIrJx2u63O3cNrEmnDRcsMUZY2skNZSFOLyinwZ/K/Gim/OBjigAz6+jqL0vcgSBJxs3tJHW7wIPDzDWHyVCfgjwUgSpnifEPqqySGK71vq8puoW+c45vFYaCvFToaIceZinNKQCEYVhGG6Nvkk0XX8Nd1Ew2rTa8WHTEz7+Ug4oIXieCs4qmdoOASNwYkII6WfCqO0QqpXPPc2c8WqD7/r1CYo/UrwxCXSSQi7GUELng46xYxhWjSTA6zDrK+lP3qGeMu6SRZMKEzqGuJUhY9Nx3O9Rt3R033T1SzUAoVmv42e+C19xeRVTt+gP9DMrYUv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(71200400001)(7696005)(478600001)(83380400001)(6506007)(53546011)(26005)(9686003)(66556008)(54906003)(6916009)(66476007)(4326008)(66946007)(64756008)(66446008)(76116006)(122000001)(186003)(38100700002)(52536014)(7416002)(5660300002)(33656002)(41300700001)(38070700005)(2906002)(8936002)(8676002)(316002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ANkd4igqL0Uh3TDA5q1a2+kood00xlhQrWOdBTPBRSsNfrppC6LwClOvUEON?=
 =?us-ascii?Q?Oxv0cDcVvsJFCpWkv+udhz6tHuibdP+JVWibmIDNvijIaVjd6ssmy9dArqIK?=
 =?us-ascii?Q?FC803HtqT7eCrRoYa25xQF7rtCpSGT5F1mCkJ1G7PkWgTC9hJuqgg4fBgEvv?=
 =?us-ascii?Q?U5gTLNpWhp0J9+mcW5Oj9oXTFLS3cGMpau7GYfhdzQYAxxQ+aBgcV0XzOCyF?=
 =?us-ascii?Q?ZeDDcCQqbz/RrloAPVP5nIT87o8H02XBvAGXl+bTK671nDKkJnc9/q8JL66M?=
 =?us-ascii?Q?ibkEcJIrt6AUebsPmyqd664EtJ1387ZOizWaxbSnXCPmiQK/Pxu4XIgjH9e5?=
 =?us-ascii?Q?l8KxIg1+W35VVANCbJ75FusxXc6L35kI2IXtkDEqeQMUSbb6eEExfSDTjTIk?=
 =?us-ascii?Q?HvL9VYE1pRcxirViOPtlXFNqFcHr2MX/xX/Ly4rFLfYYlECF0X7GNNlz5vY3?=
 =?us-ascii?Q?clHBtumKRCGfc22SGIbONMthxu2Lu8PaEWs3EQ9xT5cvx0geIYZ+86Qb8MTP?=
 =?us-ascii?Q?hDfFiB7S4Mam0VZPgpwxQ72cJbW1wEPnplR1JaTCbBSU3absBZKzwhgZe61s?=
 =?us-ascii?Q?sT1E4c/Flpze3VdSklRwaTIBfPRAJJZ1OJXblNPlyh2gznO1DL6B1PM+6B2F?=
 =?us-ascii?Q?kiJtxjO72OG9/y5is/ibNpRWm3cYEidUjyGW4yC8mkYDtB5q40MGtLpskLPY?=
 =?us-ascii?Q?eCyjiscGSCyY5JXu3XTlIyu17wZvDeIOkBlrgHT1bER2VZNd4XDn8ywvAjvS?=
 =?us-ascii?Q?8kBEWyHDe0LJLi7fzST4RUZFcPNJXy8clGuz6QN8V63iyyEiPNzykLQ/0K2i?=
 =?us-ascii?Q?P/i8OSDfEN6/Tn9TPLsVWsYcgbwSYJi2TqfG/prLvKoFR8Dt39qTfgvxJYQ+?=
 =?us-ascii?Q?NFiRgPAZG5yZaHxbALbD/6+Gknt3HAeAQJvOi8+ZcbBtgkM8J+SiULDjsDDk?=
 =?us-ascii?Q?9QyQ/NMPbrqHqxSLYWAS3RIkxpV6Lx1edEA64EIPnPNvoRle8/FF7yr1mADZ?=
 =?us-ascii?Q?RFeVQxiojkahETPyjvAfxw9ZNV4wTQ16nC3RyNakj6F29yfJjc2rW9QOkwe1?=
 =?us-ascii?Q?5Zz/m2nkuzQSKzALPA2+PuYD+2rkNcTrUBB1W7zPEVbsqYRaqbBqZCigVUBo?=
 =?us-ascii?Q?ayYAT8IK0BqN3NvRrdKsErbLyPVgU2bYqIFt0kdjbB2/kdpcjKqYhg0hMQJQ?=
 =?us-ascii?Q?GGILW8mzxe8cXAsvxwA5XdzJfCQZD0L0qisDybKKLwpqaCjgfY+5e0bIK1zI?=
 =?us-ascii?Q?S8Sm+ACS2B30MIGD+7VH7ipeKQwSqtE5mxEw8z18qu4o72nKaoj7OvmMIOtW?=
 =?us-ascii?Q?mFTHey+xCO2zIQ7v6d63irtfZAjE/uInYD8eOcg7dtBUs146aN22QuBaHVXE?=
 =?us-ascii?Q?1g2OylCIifMXZCnp97jAQokbmvIpvXGF0SI/pjiyOnzt6RfHxFzlmEbuK3Dx?=
 =?us-ascii?Q?2FHLzM+wocnWouJMHNB7YYVpq+v39Zi/Gs9kWbIGujXgxljOcV8TUWVIySQu?=
 =?us-ascii?Q?/LxqmhtRLDCay8TWTxlXBI2LS5KRPpXgaJx8X/gRL/tqARFhEFnd70dLaBrr?=
 =?us-ascii?Q?O+TMxNH3AOVu+cSDE/Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da968af-4a5e-41ac-1a56-08db8824558c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:49:43.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2/Bn+l1ICfnRvxUi8/o4sSxw882KRFi8PgW2mlFXvmLfytIJAPjf8VTzNYAOldGNNmjJt35960qSeGOQ1sPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, July 18, 2023 9:20 PM
> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Simek, Michal
> <michal.simek@amd.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Mathieu Poirier <mathieu.poirier@linaro.org>; Shah=
,
> Tanmay <tanmay.shah@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> Marek Vasut <marex@denx.de>; Roman Gushchin <roman.gushchin@linux.dev>;
> Arnd Bergmann <arnd@arndb.de>; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; linux-gpio@vger.kernel.org; devicetree@vger.kerne=
l.org;
> saikrishna12468@gmail.com; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
> configuration
>=20
> On Mon, Jul 17, 2023 at 03:03:46PM +0530, Sai Krishna Potthuri wrote:
> > Add 'output-enable' configuration parameter to the properties list.
> >
> > Using these pinctrl properties observed hang issues with older Xilinx
> > ZynqMP Platform Management Firmware, hence reverted the patch previousl=
y.
> > Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
> > output-enable configuration"").
>=20
> And what has changed since then that makes it okay to add?
> Is the old firmware not still in the wild?
This time when Linux firmware driver get the request for TRISTATE configura=
tion
from pinctrl driver, it checks if that configuration is supported by the Xi=
linx ZynqMP
Platform Management firmware. If yes, then calls will be made otherwise it =
returns error.

Regards
Sai Krishna
>=20
> Thanks,
> Conor.
>=20
> >
> > Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> > ---
> >  .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> > b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> > index 2722dc7bb03d..1e2b9b627b12 100644
> > ---
> > a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.ya
> > +++ ml
> > @@ -274,6 +274,10 @@ patternProperties:
> >            slew-rate:
> >              enum: [0, 1]
> >
> > +          output-enable:
> > +            description:
> > +              This will internally disable the tri-state for MIO pins.
> > +
> >            drive-strength:
> >              description:
> >                Selects the drive strength for MIO pins, in mA.
> > --
> > 2.25.1
> >
