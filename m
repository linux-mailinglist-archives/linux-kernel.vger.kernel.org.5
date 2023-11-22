Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC77F3C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjKVDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:00:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C841A2;
        Tue, 21 Nov 2023 19:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD9lGPITQJ89M7chuGVRgHjMCm32FqVwhJI8cRxZ9JkjVELOsMUJylEbHjqoVXFicqX3IObRwhL7GOfssmHeRrEiQHn6fdfZilat6mHKEXY7ivNatQr1buMGDvCKZEzy5LBnMbavDpLqy2ss0GXyu6Fl+C7MQiE7KMmzOcYT0Ytez0QeBKtr5EhDlJW522iXXFpjAHnKmoePtu0JYUhiYjBTauFqo0Sv0+kU6QYTLFeKjJwtBpFJDHHS5SCt98kYKnMNnwSsJk5p16Y1/TwAebLD4v7s53W5gC6dYOVHsyYZ4G3KyF9nZbtTPvafGV0DuOC1LbGArUYI9SI3D7vnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGUoz3iOZLba0HUTtsGXf1mvMjaH1EWF/aqX1/3HHFM=;
 b=hQeWcyf8phznZiWVRw4LT1mSHZ0RG6UbOWTF827AMem0xI12HYO+R6KTvMAac6+VR6xlr2+B0yXKuRh77tsuYIBvMWS1RzUi+cj4BysfQkJF+qMz+6hELNdhka4QOgseFnV1WCUkzhtjxomrQN4r1pJITrgyy5O+18F/zdTbzSZGqpDPtBoFCI+f+Dh/dU2C546toV5+1GD+czqq9W+VN0roTzzYeHdNMVp5U6d7+lChp1oUHiBuxuj0N3lIDYHBdXEonRabK5Kd8jw2APruDG0XVXSKmSSCuo8FooyrKbsvjZKcWglxPsYAhNKWNQJUBUlblzYUagTYoy3f0qkdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGUoz3iOZLba0HUTtsGXf1mvMjaH1EWF/aqX1/3HHFM=;
 b=ceZSGeCeWTdMNqgaV+XCptI8Usx6BwBSIvzBl022u2TStszY8CAGVrXRKIVN2ixifVHwwBtYh4KmEP9uSo8pCKypWtStLGT6EuXaHzLK1gClbpbHz11xaEKn8Iai9iCOMEOHsZkjqccpHfXCkzZxva5SUYQA301L4tq7wX1MjUk=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:00:20 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5c47:dae1:11f6:5188]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5c47:dae1:11f6:5188%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 03:00:20 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Samuel Holland <samuel.holland@sifive.com>
CC:     Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: axienet: Fix check for partial TX checksum
Thread-Topic: [PATCH net] net: axienet: Fix check for partial TX checksum
Thread-Index: AQHaHNzERCLofLCv5UOLU+i8bfYF3LCFpijA
Date:   Wed, 22 Nov 2023 03:00:20 +0000
Message-ID: <MN0PR12MB5953E9C46E3927CD76E94C5AB7BAA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20231122004219.3504219-1-samuel.holland@sifive.com>
In-Reply-To: <20231122004219.3504219-1-samuel.holland@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB7646:EE_
x-ms-office365-filtering-correlation-id: 944b064f-df54-4d38-35f2-08dbeb0729d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YZcdcwJ4MaHuon+ToDiZjwjHneY3Cp8ChBe46VLA9c3NNY9Ebta9nbgHDlmVz60WELkLaLKpO09nADtzldQWTO0FVhhoJKhTlnQVIAJYS85wHQcWidXQlhjqdRf2qackX6Pc3etmNarSX3VH1ehmXW3SRUeLYUtdRVfnaXVG8xaTKc19Yi4Wg1KELPY84CKt5O/LX6WN/2dmtDohnuYXNAhmi1OHW9OUImUce3BgrSZjwMWtl31KL74DHXgVinZtgz16ytrhtu3VsxFTIZ0F2rTh8INp+f9fGsZkWfRPtc5gGe/vkYAXNe/XVKj0AgsJRqGgblFGTO8yA2695+4ux3vH5df/JwHj4emTBGJErI3TeJtc3/qDse2N/bUNKsV9jVhzpfFSHm5F1EncxzPiciVv41AMXe3PClKUT6xMRKiXyQj+RoCENmKXUY+FfE2xkpASCWsMNnt9d9KK0DgWBQ8cZxDEoMVMdhhFBjgKy46fprKhzUggANDYz6X9Yvotp5M8JboyogRUSauIOUHEHqorDzY5BtllrVTQ5i3CK7ijUUKQPYiGWu3T2SFan6g15cWpJDFix7NMQyIe2yX/rffmi3JK1MyhomR2a6xnJCKKZr9xlJZIBb6tXkDDSo7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(9686003)(6916009)(66446008)(64756008)(4326008)(8936002)(8676002)(83380400001)(38070700009)(26005)(478600001)(71200400001)(7696005)(53546011)(6506007)(86362001)(122000001)(7416002)(5660300002)(41300700001)(2906002)(55016003)(33656002)(52536014)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ZmG20M9CtxniVpbQd7D2XVaxzWt7jpR+4+jhZWnCIntwG9S8mXGAswZIa8S?=
 =?us-ascii?Q?Er4e1WGtmzcdOvdTZiybP/OlXLG3k+8d3zLRLEhRSWJe+XGHljAyhY6VTQj9?=
 =?us-ascii?Q?AgTjh3e8YAEbWpqXGyQQ+KZLb9V7yaJuZ/hugw3WhWn7sGGmwbJyV8FS0+X/?=
 =?us-ascii?Q?aWyzKTGgYaxEdOvzIH6qch8o6JyUP3iCyd5X0HHb0xHXiIoP9hUDNN1RdojO?=
 =?us-ascii?Q?Kmo1rIE7FvWw0ysVFb+oa+ykCto5Lx/OznaYT582NAwl+r7flhJtsadDSKRl?=
 =?us-ascii?Q?ydDY5HKzY74kZEMc7iXnshereCzcTIIGRKFbe0B/Y9eq4iJVH1LZ8F48mV/z?=
 =?us-ascii?Q?Nhhs0GRsYMgdjaorf9IROfjR+MUudJuUdeqXcZAgul7tjbYiPbdMKiU7Qy40?=
 =?us-ascii?Q?pfONBvGYhXhz9VjV2MZZQKCzat4CXHs0mvBRew6WegO2ToGUC875UVC4+WGi?=
 =?us-ascii?Q?KOqgmW9BVDk2GC60FeP3RSybHZT+w9jsxfQ+cnsTjIr12r2U6kyCfyYkKZHE?=
 =?us-ascii?Q?iR0NVA9pKUAMY6iTI/2sy36dfy9gm+GGy9hEGCeNT2MwgOXonFq3NMlTq6TY?=
 =?us-ascii?Q?aLlz+3k5l1B2ZzqnLrDMpVmyTavlEFgggR8RxNZ022aJwDijojtjU0JAem8/?=
 =?us-ascii?Q?vWID8EpIdCglqjCH1J7hQ8UEXuWUurjIMihcxMXMNDI/mpdWtDjU+PlJ6tVV?=
 =?us-ascii?Q?oeXX0wS1yJNc403mVj1rE94L6feUmQtQPSaijAh2mvC0jnKxvchuDfr1DAIp?=
 =?us-ascii?Q?Rpw6084j11OvqTCwccq6vM6aDm9chMpajQvSpn3KicqkmQ9kf8kchV2ICGbW?=
 =?us-ascii?Q?ZQ89tK9C9zuZvLBlr9d6GNS0nHBaETN9eD53n3G0n/obG3AIRnhlY8CVIKug?=
 =?us-ascii?Q?GHgF1/Aq8HjQMHIJ7Z6klT6Bra0i+t+7ffaLxBWd8I4yDWjB0YAHnFC0fbTk?=
 =?us-ascii?Q?Cs3EBdWQ3ZVqkobXyzIlv/J29FPEHHVGBqY/PInNtUMafJrXD3FtA0NFmEA0?=
 =?us-ascii?Q?NlCMQm4srR9GHnqO+sMibnOz4Id72pQhUSFY92bov7c08XfX4bdBr6RZXXmK?=
 =?us-ascii?Q?Jvt6H++NR0yfWsl4xpFD5tA5SNoHAdaYLJXIt9cfhpo+UndFAOAJAVnfv4fH?=
 =?us-ascii?Q?mswVmUznNUNKO4PbF2epVjywMKnMLmS6z30xcuZUV+ynuyZHuuc/vXQ6Ot2b?=
 =?us-ascii?Q?OWy/wimtUOv6efb7NyAmmE6wIBIYuCo0nW03DGScMtFndlPnR8NmHQo0ut3+?=
 =?us-ascii?Q?B6WB5EsV47f/72iWMAi+mcHVJZV6etosnUALlYdRtQ1ibc2p9YfJrLTYZLRa?=
 =?us-ascii?Q?z6nT3gaLDLXzAxvUmHwxssBdRMx4aoV8qOg5SvouDt5u/oKSqv+YIgkv/sU8?=
 =?us-ascii?Q?5LrZ9Vf28m1cU2LpeMe/B0u8rEfhVJO6nFUVC2GQ0qXZkKJj2nIaDdRTjGJu?=
 =?us-ascii?Q?9rXTLXyjOs8nuS5ghkaL5A6mJWMFJdWt6VWdkb26ELSRbYUkVChcDyejw5Z3?=
 =?us-ascii?Q?XUVaIzix8/n23mdheq7daFMPGCK9wCkpInDcuexniMqJOYyPI5EM7SmWGbF/?=
 =?us-ascii?Q?W5LtHuizlP2T7Zwxhwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944b064f-df54-4d38-35f2-08dbeb0729d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 03:00:20.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jtqlQsTdvvnPGoZbRQ2Ej7JrnZhCHZNaBxpF9OTG17N4Wb1hhMktIisJ4bkCJJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Samuel Holland <samuel.holland@sifive.com>
> Sent: Wednesday, November 22, 2023 6:12 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Samuel Holland <samuel.holland@sifive.com>; Ariane Keller
> <ariane.keller@tik.ee.ethz.ch>; Daniel Borkmann <daniel@iogearbox.net>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Simek, Michal
> <michal.simek@amd.com>; Paolo Abeni <pabeni@redhat.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH net] net: axienet: Fix check for partial TX checksum
>=20
> Due to a typo, the code checked the RX checksum feature in the TX path.
>=20
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net
> driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 82d0d44b2b02..bf6e33990490 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -822,7 +822,7 @@ axienet_start_xmit(struct sk_buff *skb, struct
> net_device *ndev)
>  		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
>  			/* Tx Full Checksum Offload Enabled */
>  			cur_p->app0 |=3D 2;
> -		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
> +		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
>  			csum_start_off =3D skb_transport_offset(skb);
>  			csum_index_off =3D csum_start_off + skb-
> >csum_offset;
>  			/* Tx Partial Checksum Offload Enabled */
> --
> 2.42.0

