Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFED7BBEA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJFSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJFSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:24:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268AEB;
        Fri,  6 Oct 2023 11:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egrfIYRyEEQxK8X9S6PvJRejhjQYwwwyEwgkhq0ZDnVJX4HSs3qsQcxzlxZ/0OyHvIcfdW7B6ojnpANYBGxNM/yb/xD9DDgAwcSS31dv54iMCDvvgNCAsU1xa+IqyuTRvagp230enOsPawBvJkf3UEW4PI31DUqS1XxCTNUzMMn4KMCKikpRY/8NKMKbz79aEqJmxjr60t82HZWa7TWBXboaZRigRLdraot8gu7ETU1IDlOlDCzPMZWItIswkVutpymclZJOTQT4X+PqvwTpyCcWmfAmY3r2I5QT71pZMHUB8/QY1+SxR3kJ2HAMOyLV+G17fNCuEa8uEHgF+4FqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeX+HyVgMfpwARNhniuED/Q0qHE6M9BSxEEBcv2GYhk=;
 b=dF+fjgQLGEZbzUgOoRczgINzKHWYynJovNwiQXFXXXL9Ty90ac3D9XXgJVaILDk5ruBwxdY4D8k1/XeGER0uLp90lcNt1bAgvIiiJ+mLjGU8DeII9b+/dpEMvXmqMnxNLQSq2KkDLpfYv4nHYBnrOEfECF1FzYrweOJL6duUTdrSm2wtZez456YodTDwg/lkwo0m7bNn4pXGz32SBwkJ3zisi5kKBkYWUJAPy9xDuPwwRIp8Ezy8lxWBkwgGt8fPK5Q2HdsXBKElOmz5pVH8/0V6vafKnzk+CxTtdKF7u9LeILc61zfVBglbYEE9wapVFK3/g8JdizefBX3ChZRBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeX+HyVgMfpwARNhniuED/Q0qHE6M9BSxEEBcv2GYhk=;
 b=dB0L642pNAgIsBLMIlwDMlFdg1gIE9e78Ef0Fixq6Tht7Vn7FD0u9fPQgXXu7ZXaRrhsIezBDfIQRewUWdvenvnpdBil1lLiOknnViN3DLpq2BextqN4YdlsxwA4eDVz6QN0dxPuUR/TCQ0T62Df6I6ikyPw6uEWotOQE98L3sE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 18:24:18 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 18:24:17 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Subject: RE: [PATCH net-next v7 2/3] net: axienet: Preparatory changes for
 dmaengine support
Thread-Topic: [PATCH net-next v7 2/3] net: axienet: Preparatory changes for
 dmaengine support
Thread-Index: AQHZ8XmgCUAYsOlDC0Cdo8yNtnUiNLA6Iz4AgAL99wA=
Date:   Fri, 6 Oct 2023 18:24:17 +0000
Message-ID: <MN0PR12MB5953CC0DAA4E8BA1C3B9CC76B7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-3-git-send-email-radhey.shyam.pandey@amd.com>
 <20231004134106.7779c29c@kernel.org>
In-Reply-To: <20231004134106.7779c29c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB8641:EE_
x-ms-office365-filtering-correlation-id: 2afd6073-4f5d-4011-615c-08dbc69973c8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYN4kVLtfvoqZitZdz9Z/jywa7fDuBoBWE4hYB7VqbO5YZPGPP2Mx0ehvaV0zxOvmt7oLwF69La6fwetIwLvNThrevO515P+yGQwA93b7z2ZAQ4pP34uJW/5oAPBItAW8cc91tthg+NM9v7Q1Skow5bAcY5RLpSDFYSxuCb7Dp49KynJu9/Jf4Uo9JqnVnzLQ7i2F6URWyYvwv5/qohAHWri4mjc7P8lFM/Cqn5S45UcIToUY9qtR8ZtA/BIWsuAJQjxLhALL7d8imcUsEGpInhBe70x/KYsHwqmwcXZC7IOIbMnsC1ATSENSmigcFBLbXsrlQMuyCDI+vIc5HSMgK9QAgU+rRQ+D9tNuEa7v83zg8jw3GchVJO/26b/EleicUhVglJyrLg+Vf5O9/z48o+CY7ezrGx2/Yx/6fE5oXJ5wIj/HTY8NkrxJ7rvw9csei3rJ6UEhM26cNsEGtq8i3jk2bU60+ZajlRwRzw8xFWehzGeNo80xisJprJbGYEqITnqX0ET5isIabdrQvp1CtTHbw+wIo5t0PmwZBCesyWhSQFsXuxCo/pcz4Kniw8oulXG6RnszpksNrYeLhk+h64Mv/Lsko9cR5nQHmsZ2Tl7finO07LSrXNLknTWdneH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(53546011)(83380400001)(6506007)(26005)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(54906003)(6916009)(316002)(7416002)(8676002)(4326008)(5660300002)(41300700001)(71200400001)(7696005)(9686003)(4744005)(2906002)(8936002)(478600001)(33656002)(38070700005)(122000001)(38100700002)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zRERp1Y7yI0aDmwTITFl2k/DrjhjkRsajRXrYWutl9+sz+HljhRMX6QVT4FB?=
 =?us-ascii?Q?a0oqa2WjY7QPMkcnTfDjp57YuAQgIWoVSZCHF5karTxd//qgL8r4lH3QAswQ?=
 =?us-ascii?Q?hRoC4QFqGp3Whx2oghT9Mdn1uwu+UGNQpDnHNcy/YWP8gb+z1BCfx2I5oqen?=
 =?us-ascii?Q?vf8XlynJtgF9i+Kxw0G+z5EXBHLuMQimdpCC7OlcgqOIn87ki3R/x60SRYLc?=
 =?us-ascii?Q?EPP12iOz0MsDqyXwwtHiX12y34Ot0YN52ysUx66v1+sabiTOVFTjvzmNhYK1?=
 =?us-ascii?Q?LEOSZJ396MXlGAQOCMVjlsSNuyD4mgNqyapwfgzU+N+KCA7FeOQjDl+IPnPm?=
 =?us-ascii?Q?hIE9jhIzlgt6HCSRVluboCEVrAnD4toRzYDV265Cs8G8UdM7DgJPHEfj+IjG?=
 =?us-ascii?Q?pYknyVckX4bPT5yO+Pfg255VaI+HLkKRe4gWReRMFNb5GfuRr2c3IGHxEoxZ?=
 =?us-ascii?Q?a91FDkC0IBRJUzjcs7M0YfdndC4kBi6fhd1P2PNEadcU05rd35T5ocCLgC4Q?=
 =?us-ascii?Q?1xygHka5S9k1kIxDQSAy0jimyDVRA2DBD0cupinIbN8AkKgQfDbZ0+rmZyFW?=
 =?us-ascii?Q?aeE9/xDZditg5T24kFS1GlOHUOLlEqt4h8zHJ25PjxqG8lQSBvWIBQExvHtM?=
 =?us-ascii?Q?IjHTB2fL5N/MFLQnNrVf9Z0qj82tyiFS8i3l49/CaonAq3izbd16LnL+CHRV?=
 =?us-ascii?Q?Y7+LfePq/LLETtqoL+CQBCodQRMpCR+1EFiwjF+hM+pM/tdr10NwKcZhG2gd?=
 =?us-ascii?Q?tOoYhwYethCNmmoFUk9oUbl0FDE7jfYZLhYjQ3qz9cMEgpD7+fn/OrmmkIVg?=
 =?us-ascii?Q?mRbWtNPr8vEk/flVsCIPNUhrC10rTi+t1v2Gi/fOobQj6qgF3vO5cYSQBjJY?=
 =?us-ascii?Q?bHCd/csLZDeP1CVO0lFUiTH1Xd7I9lSiGn4hI49K3j1HXh+Mo1Ml8rO5WQdd?=
 =?us-ascii?Q?QtHWtOTjn9CkwUz0umImkCyFhNW5b5uAPRdo5u30Do6X1NhC+xNczNA18NWg?=
 =?us-ascii?Q?wr0fJxmvSxpnaUSagPVk4ZlgsDdr0GiQ6jzXImtb5K3V+aCWSW0qQK0/npjN?=
 =?us-ascii?Q?OUGfUoAJ096EvP4OtbleHUbFmgov+vMEPlseXaB73TtGFisxep1x2lG8ZcMR?=
 =?us-ascii?Q?NEILK3qddaO6JJxLEfnHSZJj7SwgDF6VPr/R7uDsbRPK3MUy84NM4uwqquZ7?=
 =?us-ascii?Q?m6FkvhqThcLSmReCIyqxT+a7dZ8T7XMYg0H9bBp33eknCcMT1h4oPe59DDRh?=
 =?us-ascii?Q?gnADumz6FYuVvcXipBmEp+6/V+1N7cUKuNCIdBFMUDEfPWXap8ZVa2tEz4TP?=
 =?us-ascii?Q?C1DnzDqdzdNjFwTSEqtdltggzg1DoEOiP0+Q2n8M3P9uqdsxeDPZ5gpO7H4W?=
 =?us-ascii?Q?viSgGH6+6/BH8hA2OminRPn9Y0RddyWPZymyz7T+iL+9W+iOliCRsDj/F5N4?=
 =?us-ascii?Q?CLk5A6Hiq/C8zOiWgCbb6EHVjGHYML5V2Vm0xot8QTUdXRPVRu8wZ2AswGfM?=
 =?us-ascii?Q?OnUMgPx/7Q1M9PssPLcRgs8d5xxdL4prSoSL2pHu5AtAb74QXOKx/N9c7ONY?=
 =?us-ascii?Q?adH61LFFkhPSyoIjT4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afd6073-4f5d-4011-615c-08dbc69973c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 18:24:17.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvsANzeX9qAT4UVlWLrlwBfyPL28hy++5kelqjFEjx542EWb/fsVqSdhnlqun53R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, October 5, 2023 2:11 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> linux@armlinux.org.uk; f.fainelli@gmail.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Sarath Babu
> Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> Subject: Re: [PATCH net-next v7 2/3] net: axienet: Preparatory changes fo=
r
> dmaengine support
>=20
> On Thu, 28 Sep 2023 01:02:30 +0530 Radhey Shyam Pandey wrote:
> >   */
> > -static int axienet_open(struct net_device *ndev)
> > +
>=20
> nit: spurious new line
>=20
> > +static inline int axienet_init_legacy_dma(struct net_device *ndev)
>=20
> nit: no need for the inline, it has one caller and isn't on the fast path
Thanks, will fix both in next version.
