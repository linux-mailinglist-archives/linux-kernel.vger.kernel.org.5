Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494527D2B58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjJWHaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjJWHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:30:15 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E027E6;
        Mon, 23 Oct 2023 00:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U243ho0uq7kO9nLXU5Ckk2o3mkmnhYsnJLXimKq9nyr7EbKkPwZAI9NmU/oWscpjxKjf6PxdZtNU8wmYmSM2X6S1EnX+B/INQa/d3avm+JJADH5/LWKNjrjguxgv/qYZg/BWDRT26yowIhwTYlyzAzf2KDsszQuSiwhZGSNItTkxEEixgYEUgrFD8cVbD6Qn8rvXB1MMvjHcQkXsFiC95fSwdV0hUIBrK0c02E3eIffxk5cfeXwqcjN/Q50MZypDX5Jc4C9w4Kxur4wPsm/eqollZUqRm8q7S0CLdQLA6yupwh+doKlMm9AFWERGRpEYG+m/mV2YHRBk7dzdtQjQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA0B5+9vla7RkJjLL08h2Rl7qh5vyCx/YvW8oHzF3YM=;
 b=mE9RkUhYfwPA6q9xeIkPVLuQTL/9CvmyTjrQK+Wqk83zGSOdoNc5LSV2T28QfZNYvyNLI7PWaG9wedpAp9+uTOT8srgH6Ir7Xp9wLWGt0VRrwXYo6kcMs1zC8QkJSYNKQO6Tf4cOHZ4yxzNe/FJ8dkXsvfHTPiGFba1r0P/mLVvOT48SLhiAmpwT7g3zYnK1nf6nIqzkGBWNafcb5KjqcryvWyVGXJXbLNd9+RtdQ7n3A2KYOJavjo7KlkLZ+/6p1zWZ257BitXcmHfTocwlN4exiZloV03RU9Q9cFH1sM0NqWiO0JPIVl8rCKXBAiHWcDmzPDzhO5I58nJ+6fXtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA0B5+9vla7RkJjLL08h2Rl7qh5vyCx/YvW8oHzF3YM=;
 b=cOyl4lzW+C4C2+qWfj/TI+obTMYAhl6HfCPhlzaCS4FqLii96noMSS2zmT+ecDybgcwCfxXS5H18lodLs3WS4fYdgl7qSUFAGr4JBBDlDGbMPneyyfUYK4IgROlFL5e6HpbhgpHUAJO7s6pd2pUaSrO9WCdJTVapAJttwBQGln8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8858.jpnprd01.prod.outlook.com
 (2603:1096:604:154::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 07:30:09 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 07:30:09 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the pci tree
Thread-Topic: linux-next: build failure after merge of the pci tree
Thread-Index: AQHaBUS2jhNEtIx03k2RKE91Wq09irBW+UZg
Date:   Mon, 23 Oct 2023 07:30:08 +0000
Message-ID: <TYBPR01MB5341114CB14098217765790BD8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231023110556.6f704b95@canb.auug.org.au>
In-Reply-To: <20231023110556.6f704b95@canb.auug.org.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8858:EE_
x-ms-office365-filtering-correlation-id: 69bdeab8-a81b-4c53-8a75-08dbd399e2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86RV8CTwbmOoPhMIKODAKijwCvDqxmOT/HrLKI66NNpy90gx+zAclfpxDYbHktjc9NKPfhzET6zdRM7bswf80VWIAdMIuCZYzxCaS0hDDCSYLm/Lm+/BGd9fyP1AIc6dJVe5Jnhpx1bUkEw1nrfGFpL6asV9/JG+leZu5EI2rqZ/kMjBmp5pqV4RD47N0ZexUPcjWtH2KBA2Rd2a0WpX2a4L7y+60fynczLO7wZrYEdjOnCXNadgBWjNkt9rJKcnbVSDueMjEytZfPRrUJxYqk8kW/Wv91FYlG408Z16HjGkeqv4LZhOKEy71YbZaIAEXS/7zQ9kDhVrzIfD5wgczVAxzSYd+jqqNl9hSqO87llYyeWOCdY8QS7QyJ1VmKPXPw+Tm6VNgz081aDqIvbfU11xC2RRQ1lTXU9PPDIsWexuMsRVrwXZmH3bxebHFHzyLv3Up4dvCtToGYWKWWOGQmZIhYpf/NFtwX65s1hdq6ozmFpJseTBWAuSEigcLZpC7Vmt7e1u+DMH0G51lNv72ywHCVVgTf8iuUTVJqCn6843opWD4Dakm/cVR7OaXilJP2Y+1t000JtGNXV9UirjKssrZQTSCIdiTZS1DMNKJYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(38100700002)(2906002)(4744005)(55016003)(41300700001)(5660300002)(86362001)(52536014)(4326008)(8676002)(8936002)(33656002)(7696005)(6506007)(71200400001)(478600001)(110136005)(122000001)(66476007)(76116006)(316002)(66946007)(64756008)(66446008)(66556008)(54906003)(83380400001)(966005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ywkaWFTdmnGQLZnsNL1YEWykc5UZtFnmm7o+Y3vkL75yvz+Dnwg8xIhxzT?=
 =?iso-8859-2?Q?lktBy+LuyA93SZtPQzlsLCfJjiyW1BN3BrVbFb1oOPQyF8vZcBFU9ivhER?=
 =?iso-8859-2?Q?qoRNq3mYF+cRdpZBuoGDUloV9nNqlTfnK740hfWpmGQ2Wz1kgsoPf2AQhz?=
 =?iso-8859-2?Q?uzaUGR5QXmASMALTENq7D/0qn30dRRuieW0ACTsAy24s3fMgN7r+vkvdYt?=
 =?iso-8859-2?Q?Ply0zua6U6v42mcF3LTnXfd/E0B4wobkHbnqmVqZYBsipGhUybqjUTXuKX?=
 =?iso-8859-2?Q?GYK27MMaLbEQNijq3tONmA6QKd+vgrqqDOMmPVhjRzNbD+w9pyyaW+EZMc?=
 =?iso-8859-2?Q?Beo3KOgVsTdp9VL/mJ5sDm6jtiViL+GQNyrGqS4cH8saJacipc6cxYvPZn?=
 =?iso-8859-2?Q?j2OuiaCFIwlqud7rF+kEAaE/aZC+u5MNbzr7+UPO13O7KeK6KQ0Hpk7aUf?=
 =?iso-8859-2?Q?aWWnHihpfweDBchf2pdiw6GPbf4ybZJmhBUxCudt2Lp4HTcTiO16/Y+moL?=
 =?iso-8859-2?Q?OS6A2pHJmvMA1pdDbUixpyTOp66fSlrN+Ei/l55JHizbG+T8Gfw9yM2fFY?=
 =?iso-8859-2?Q?xNdi3bezClPeYFIgns/MowfiqU6hgd22mbo8xreTBvB8zxz7BXugFZjFcH?=
 =?iso-8859-2?Q?cjvVgThGGbun5hC/k8XiwT8dTYMC4WaVdGFSs3siZIi33xd7tv8Pbv1aaz?=
 =?iso-8859-2?Q?tFmpT0GKWj4a+ogLMcNNYYrw+vsGMbyjH1Odzpg4sbrpeLQloaw1BjwIUU?=
 =?iso-8859-2?Q?EX3+rXjXE1W1FPoGbb9XQUNGCgX5IUQQHWSqJ1rcVsa5hjQzYxawpbppbr?=
 =?iso-8859-2?Q?j6VU6dPvAXctQuLoPBDpI4yKTTSRtkLdpsNm3LPnya/XYrg6a6+gaLWTDn?=
 =?iso-8859-2?Q?tFZuOdtQ0rL3iJlnEpPGL22X5muTS47E4bR0iq9Me6fzmF3GFgVMna2CzI?=
 =?iso-8859-2?Q?RS0D04SI0x4xoVXu21M46Qnervqhp2IANR3flWJe+9pxuv9YXW0RPzrMj1?=
 =?iso-8859-2?Q?3iFBGejX96cz0Mjb99wxwhXE0PxcDsX47T7Ym9v+N2qOSLjGSrXSGHkOGI?=
 =?iso-8859-2?Q?31HLxy51Ls+e4wTZxgZNrAObXPbAcDfF9fQjUGpTigBRw5ozjBsjbNHl2f?=
 =?iso-8859-2?Q?1kCr1rUaKgtIgmx9PBEdwWqHnyg8xUIL95X9G3CVqxJNSHnWTPZtSeGE+k?=
 =?iso-8859-2?Q?A/SOAFrQgZ4jDYpnzZpW0tt7Hf8rLT116RFcsIZFNQnYI5ahIgCRMf8Ygp?=
 =?iso-8859-2?Q?TrOutdpZYCkgul9oUWPwtT+FWcrcbzJj9AK+uR772jZ8mqat4Q8INn7rjX?=
 =?iso-8859-2?Q?owQz/YLC/WNzER4KM42kqCxqHS6J8yVWFFLAIQgFf96TonzLBLVpl9xvOL?=
 =?iso-8859-2?Q?gLlHFmfoYO3co8FkCMTfJCmb0Veipi5Hc32T8BmUq9Zzf2QZQoLPS8gtQe?=
 =?iso-8859-2?Q?xJ56nrgQrLuYVxsf7ga75UEcDkBLRmiDkVaisWn+ZwbE5MVbEB8si5ib1o?=
 =?iso-8859-2?Q?287JyU6RHiLW8f3GI6JnYYVCrjp6TuxUEEfEHYxVPQX7Bfv/wV0mRI4Fp4?=
 =?iso-8859-2?Q?xe0aHafS56WSR6SaEHpySjfnTowMqHTrJlnAhQi7cxuvwZ1m6VnHHaBIc8?=
 =?iso-8859-2?Q?oOsEZ3hNOtppOXwl0+WE1Vrd6Xht3RZGAZUe/QZM0GIpO8zRZM849pyKvs?=
 =?iso-8859-2?Q?WhcZGCuyuia3UsIQARK6jyiocvP8PvMqiQ8//I2UAtyonOSMccBnlGrn62?=
 =?iso-8859-2?Q?wlHg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bdeab8-a81b-4c53-8a75-08dbd399e2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 07:30:09.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6LeiNE2M4H7viRsB/Im0oc8V8oa2PPKCS1gcd0EZyyGzosXoJuHz27CYDdgEZgWNP8AGP7M7oTO3Wrhui94hpxCeTDrRjtxty91C+g257b/8JT3C2jZQQntOGtybL/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> From: Stephen Rothwell, Sent: Monday, October 23, 2023 9:06 AM
>=20
> Hi all,
>=20
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig=
)
> failed like this:
>=20
> ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie-rca=
r-gen4.ko] undefined!
>=20
> Caused by commit
>=20
>   8227bf7a81e6 ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support f=
or host mode")
>=20
> or
>=20
>   d3c54d8ba855 ("PCI: rcar-gen4: Add endpoint mode support")
>=20
> I have used the pci tree from next-20231020 for today.

Thank you for the report!

Bjorn, Krzysztof, I should have added the following patch on patch-set v25.
However, I completely forgot it...
https://lore.kernel.org/linux-pci/20230926122431.3974714-8-yoshihiro.shimod=
a.uh@renesas.com/

I confirmed that the patch above can be applied on the latest pci.git / nex=
t branch.
However, should I resend whole patches with the patch above as v26?

Best regards,
Yoshihiro Shimoda

> --
> Cheers,
> Stephen Rothwell
