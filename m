Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B607BBF78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjJFTEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:04:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A7683;
        Fri,  6 Oct 2023 12:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ19SNap8mkaH95iLBlvLjjoMZl5P/4rvSwNZdH84z+lcT0gStNlRtP2lpf3IBxnStzwlqkvbV45NzDC4XmWpRUqBqSDBCiuCPxmIduypMy1hCmI5R4hwzg1PqUtIx6HgL3mq8gCgmxtVW47Sy1oZMu3UNHzDDeknT1GnuDC+XoP1wnQtFXFFzxFqW41S7poMYRJWVH0H7Dxv7kGgScK1aoDuOOlDtyk1KGl1KjJolxtDuxSyJJ3v2yi0NjoqCDnlc2keIF6QgUIM9mCXt45dE5K7B0AcOEE6aW3AgPQwvpvYU0BtHkBuvfpk8vFr01b3JlNQzhvVC9llI+QGIAkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj5xQ+/I9exFZYwnSkMvqQTDSnzVNaDIU3+M/Q6B2sc=;
 b=kRk9g8x79MqdUQY7rvMjLXsRRHYKgz5g/O0sasuSynB3In/cgRjoACcyOlcQEckMyb+E5eFaZioPddQNlINhMvZcodrnPEhd8mM9UDpNfDmaLw6hEErSDg989gZt/GzV+ap9ABJVGs4X+PpByZ6Kg8mP0NgSvD1kMCPL4b5tJzM3Ze2mwDgTyG89ssLA/cOwfh9xT6XGDu1/dcxRu3GgKfZAhUErS+W45TawBV7KQfZxqMsY7rike0eH51kSTTJK9X85dNWKjE+3HOGHHvJCediJpAEEpTefM2qdaoP9M8qfa6et8b3Rk3L8nQF82hOPw6OPs2eWDNQLwNzDSvZ94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj5xQ+/I9exFZYwnSkMvqQTDSnzVNaDIU3+M/Q6B2sc=;
 b=0vswq4VWmK8ahqyYyxN+s+WOx7AmFP5XL2he5YuXPtk6TCxbroK9g8i6tR2d0dVk9DNf8+1gC/ZmNRE04fYIOGdt/wW0kP3h3Ftwq9a7CqoTeRa1vhZBlKyrczGTzPy6CZqGKmwXlhuszHAOqIRueKAg3w+eJ8FKuNr6FdOnZK4=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 19:04:30 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 19:04:30 +0000
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
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine support
Thread-Topic: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHZ8XmjDysNxqIG3UGZtitzZHc+JbA6JqaAgAL7GNA=
Date:   Fri, 6 Oct 2023 19:04:29 +0000
Message-ID: <MN0PR12MB5953B3DD4936EAFC7BBD944AB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
 <20231004135317.2b460acf@kernel.org>
In-Reply-To: <20231004135317.2b460acf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH8PR12MB7159:EE_
x-ms-office365-filtering-correlation-id: 82b29d00-c9a1-4a8f-d00d-08dbc69f1193
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q27N2z4atwS1wLet4bUB+sZcWQ+xibkIPDzG07nE8t5Sv0VuPwT0DsU/Vtrn1KN+zx9uv1lRyL6WAu+XZB0FBcfGG16ktscBwx3Qhur26QEPG4fA4+oBttQk8zy7aGg7lLtv/bnF+ARIEgunO20gx/uliwOAsBG7dx7EXH0QkloehtQXv2WsoeoeyLi7EVH04M59VzfBFDfHly4E7VMQ2OoaluYt8s23cSwas6fSb0Om3h5zq8HYuWUgbRMLbWFll0+7uLbpzHNHCni83R06LOxwuoFHlDTr7Qn1O1f5nZvxSWKL66gmOpFLiAQjEeQSs9Q9S7xGKoOyRwmEA3dhtbeov+8f7k/GhZcub6xBHv+Yh8walyevwLC0acFeT2wEDB7NDj2niUxz7OlnSP17gkPvsdfVVqm2twa5J0D9WTWtBfrr568ZcENzulsHY9I5JmEywBlWWFbXcQFe0+6u2/W2bRfz9aVHAjAkYy6z/DA96IUm/qLVRIjyA49Wws7O6QM52w3nwoBGRaB9p+SatJlmXQvHhrJ04JoVH0oHSbF/zq7HXNvf/wtS11ylawkb2A/zRGYVwtJm3opCQKrn1JT6YP4elMOm8Ch2/y9T8WRF6whQ4pTEYZlGRJBuptNE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(478600001)(9686003)(6916009)(122000001)(4326008)(83380400001)(26005)(38070700005)(38100700002)(316002)(53546011)(6506007)(66946007)(64756008)(52536014)(41300700001)(54906003)(66446008)(7696005)(8936002)(71200400001)(66476007)(66556008)(8676002)(86362001)(5660300002)(76116006)(33656002)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fewVneIn6Dk/J3yQvoGq3DH7Ty+qbRYtebNUfqnDqnL72kiLsZ6L6azt9G9A?=
 =?us-ascii?Q?hprtwbXWhNH9VU63Bgp3IGJ6cuAjb84CFbfmT+uShVmab+/nIRblSrg+e59j?=
 =?us-ascii?Q?QIXnzc714ZFlXFF/Q1sZPN1HpboAFi+hlI4bZVaAgo7tbPs1yjBDNFuvGued?=
 =?us-ascii?Q?KD/gr+BXjPkQWVyYXCoMqHuTdgrzF7y84V39/GhgDAYPvVpUgIEliU9NBi1I?=
 =?us-ascii?Q?XWsJHgOMNno7E6c26ERu0P5zLqPFPkjrXud7UzlulZ7GDDV+14UA9X8B8uq8?=
 =?us-ascii?Q?Vvnd/qInLx68uH4Q2KCr3biQbGPzSQYuQA0uDXGuP1gxCQUYjwG5+dubfXRz?=
 =?us-ascii?Q?YIb076fMi0wGyn2S0S4IyYxaPGCm0N0+rYIycfe7l0Ct1AVdyDy2Q/6cgcg2?=
 =?us-ascii?Q?BhX7tCtRXgYLF2ra/5BUxj5ie8CMjxrBLieXJG9ohaUBNBsQmqEtFU+Sk48P?=
 =?us-ascii?Q?4Q+x+NfERoU46I7JQPs/YxRGg5iVInVlhmtLy2NAele9IKZ3QjHBzHiaZwiI?=
 =?us-ascii?Q?uzYOlZcdgXRI1AHyaYI7zko92FXZUo2X4BUs/BmO64heCRE3dZvo/yAK3vMh?=
 =?us-ascii?Q?YONWN2PQDO87jFCG7ZMItMs9539rblENZ31Qh6LWMJa5Wka5MKFBQgh8b0vb?=
 =?us-ascii?Q?DtGGr+P9xux3xSCXsc0x9uQBrfZm4c/yzaiP/xUUDI8AVEymUMUntdW14Pw5?=
 =?us-ascii?Q?yYeYYKmpD9kN6Rn1Qpr419j+PZyEL5sMsD8JPmKO0vCHlUFspVs87bD6lNPG?=
 =?us-ascii?Q?6QUBx96n5NFr8/f7Qzm2TIPj2f1Sw6HcpSF/De5U2a4Cyv47E6Eh/9mKn1kx?=
 =?us-ascii?Q?s3gkUayqKfjMGzpc3O9OyWWHTvNq+bC2iNmYX3lXWlgaXVEIJi8md4sa1fZw?=
 =?us-ascii?Q?qeqOOFGsYJUj/CDRM89P09hTncZULMGQNDGBbi+oJVZBw8hTlx57mtwmwxpP?=
 =?us-ascii?Q?WRk8DBzGFTovIX7otwCdZu+VoAw5i+8SQG6L2cJyWeFxtPLBLvyyrr2v8uLL?=
 =?us-ascii?Q?RDPrGZ3x3fw/3sih8hdykqeYayUb7wDQHvOnhJ/vG6sZ9huYRJsi2tzzO+SY?=
 =?us-ascii?Q?A6aE3px/CVa8I8h7bNeySdVdRhB68ukJkNpiQLUVyE1n8D9hxNfe5URDg3Vu?=
 =?us-ascii?Q?rKjxroKYlwXUcrEu4cvIUf6OWGqroLxlF3JsHANbBaD5uzm+Y6CZokmMi6Do?=
 =?us-ascii?Q?OyI3k1NQ7/cUeM4A9xe7lIm0XO0QJCodCcKXotF2YJ/P2LmGJkZqbVaMHjcP?=
 =?us-ascii?Q?CcYU6lZOmSxWBMSDRDnVmgXtItfyB3Wd9PZDGR8JME7TZslxQPuCfbeffbIz?=
 =?us-ascii?Q?MnswrKU979AuhFppM3SKZOoafApFfNInFkz/Aa5RrRl2HoXSdfJM4PXTmVVc?=
 =?us-ascii?Q?qphQhe/N1nQ/v/tw2vIKTB1h2iycEY+CjmY/i4e7o4xJ5/esZP1k1x4Sxvbp?=
 =?us-ascii?Q?9Hvphu9C+DWNpKvDqCv5ywqAmD3RjSTX5rHfZeaYelFonqixmmM1n3ZfbRa+?=
 =?us-ascii?Q?daXOOPHihZL6W7Wly64iCis4cstjaiZs6zaL/bIrhJA33VnLzNraZuqeIOI1?=
 =?us-ascii?Q?7vIFOpfKWGGPWYq3kqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b29d00-c9a1-4a8f-d00d-08dbc69f1193
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 19:04:30.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jabn1RkvoEAXYL/YSHfOSERIHOgGVpwGO14ly9UyzIKsE7Y10QBrtnhHyHa32eFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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
> Sent: Thursday, October 5, 2023 2:23 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> linux@armlinux.org.uk; f.fainelli@gmail.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
> support
>=20
> On Thu, 28 Sep 2023 01:02:31 +0530 Radhey Shyam Pandey wrote:
> > +static int axienet_rx_submit_desc(struct net_device *ndev);
>=20
> can the forward declaration be avoided?

axienet_dma_rx_cb()- make call to axienet_rx_submit_desc(). and=20
axienet_rx_submit_desc() registers axienet_dma_rx_cb as callback=20
func. There seems to be circular dependency.
>=20
> > +/**
> > + * axienet_dma_tx_cb - DMA engine callback for TX channel.
> > + * @data:       Pointer to the axienet_local structure.
> > + * @result:     error reporting through dmaengine_result.
> > + * This function is called by dmaengine driver for TX channel to
> > +notify
> > + * that the transmit is done.
> > + */
> > +static void axienet_dma_tx_cb(void *data, const struct
> > +dmaengine_result *result) {
> > +	struct axienet_local *lp =3D data;
> > +	struct skbuf_dma_descriptor *skbuf_dma;
> > +
> > +	skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> > +	u64_stats_update_begin(&lp->tx_stat_sync);
> > +	u64_stats_add(&lp->tx_bytes, skbuf_dma->skb->len);
> > +	u64_stats_add(&lp->tx_packets, 1);
> > +	u64_stats_update_end(&lp->tx_stat_sync);
> > +	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len,
> DMA_TO_DEVICE);
> > +	dev_kfree_skb_any(skbuf_dma->skb);
>=20
> dev_consume_skb_any(), kfree is for drops
Thanks, will use dev_consume_skb_any in next version.

>=20
> > +/**
> > + * axienet_start_xmit_dmaengine - Starts the transmission.
> > + * @skb:        sk_buff pointer that contains data to be Txed.
> > + * @ndev:       Pointer to net_device structure.
> > + *
> > + * Return: NETDEV_TX_OK on success or any non space errors.
> > + *         NETDEV_TX_BUSY when free element in TX skb ring buffer
> > + *         is not available.
> > + *
> > + * This function is invoked from xmit to initiate transmission. The
> > + * function sets the skbs, register dma call back API and submit
> > + * the dma transaction.
> > + * Additionally if checksum offloading is supported,
> > + * it populates AXI Stream Control fields with appropriate values.
> > + */
> > +static netdev_tx_t
> > +axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device
> > +*ndev) {
> > +	struct dma_async_tx_descriptor *dma_tx_desc =3D NULL;
> > +	struct axienet_local *lp =3D netdev_priv(ndev);
> > +	struct skbuf_dma_descriptor *skbuf_dma;
> > +	u32 app_metadata[DMA_NUM_APP_WORDS] =3D {0};
> > +	u32 csum_start_off;
> > +	u32 csum_index_off;
> > +	int sg_len;
> > +	int ret;
> > +
> > +	sg_len =3D skb_shinfo(skb)->nr_frags + 1;
> > +	if (!CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail,
> TX_BD_NUM_MAX)) {
> > +		netif_stop_queue(ndev);
> > +		if (net_ratelimit())
> > +			netdev_warn(ndev, "TX ring unexpectedly full\n");
>=20
> I don't see you stopping the queue when the ring gets full, am I not look=
ing
> into the right place? Otherwise this is sort of expected to occasionally =
hapen

We are calling stop_queue if TX ring is full. Is that what you meant?
netif_stop_queue(ndev);
>=20
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_head);
> > +	if (!skbuf_dma)
> > +		return NETDEV_TX_OK;
>=20
> Leaks the skb?
Accepted. Will add dev_kfree_skb in this and below TX_OK error path and
also increment stats.tx_errors++.

>=20
> > +	lp->tx_ring_head++;
> > +	sg_init_table(skbuf_dma->sgl, sg_len);
> > +	ret =3D skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> > +	if (ret < 0)
> > +		return NETDEV_TX_OK;
> > +
> > +	ret =3D dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len,
> DMA_TO_DEVICE);
> > +	if (!ret)
> > +		return NETDEV_TX_OK;
> > +
> > +	/* Fill up app fields for checksum */
> > +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
> > +			/* Tx Full Checksum Offload Enabled */
> > +			app_metadata[0] |=3D 2;
> > +		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
> > +			csum_start_off =3D skb_transport_offset(skb);
> > +			csum_index_off =3D csum_start_off + skb-
> >csum_offset;
> > +			/* Tx Partial Checksum Offload Enabled */
> > +			app_metadata[0] |=3D 1;
> > +			app_metadata[1] =3D (csum_start_off << 16) |
> csum_index_off;
> > +		}
> > +	} else if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
> > +		app_metadata[0] |=3D 2; /* Tx Full Checksum Offload Enabled
> */
> > +	}
> > +
> > +	dma_tx_desc =3D lp->tx_chan->device->device_prep_slave_sg(lp-
> >tx_chan,
> > +skbuf_dma->sgl,
>=20
> Possibly store the device_prep_slave_sg pointer to a temporary variable t=
o
> make this line less painfully long?

Will modify in next version.
>=20
> > +	skbuf_dma =3D axienet_get_rx_desc(lp, lp->rx_ring_head);
> > +	if (!skbuf_dma)
> > +		return -ENOMEM;
> > +	lp->rx_ring_head++;
> > +	skb =3D netdev_alloc_skb(ndev, lp->max_frm_size);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	sg_init_table(skbuf_dma->sgl, 1);
> > +	addr =3D dma_map_single(lp->dev, skb->data, lp->max_frm_size,
> DMA_FROM_DEVICE);
> > +	if (unlikely(dma_mapping_error(lp->dev, addr))) {
> > +		netdev_err(ndev, "DMA mapping error\n");
>=20
> needs rate limiting

Agree. Will change it to rate limit call.

>=20
> > +		ret =3D -ENOMEM;
> > +		goto rx_submit_err_free_skb;
>=20
> is it legal to unmap dma error ?
Will fix this error handling in next version.
>=20
> > +	}
> > +	sg_dma_address(skbuf_dma->sgl) =3D addr;
> > +	sg_dma_len(skbuf_dma->sgl) =3D lp->max_frm_size;
> > +	dma_rx_desc =3D dmaengine_prep_slave_sg(lp->rx_chan, skbuf_dma-
> >sgl,
> > +					      1, DMA_DEV_TO_MEM,
> > +					      DMA_PREP_INTERRUPT);
>=20
> > +/**
> > + * axienet_init_dmaengine - init the dmaengine code.
> > + * @ndev:       Pointer to net_device structure
> > + *
> > + * Return: 0, on success.
> > + *          non-zero error value on failure
> > + *
> > + * This is the dmaengine initialization code.
> > + */
> > +static int axienet_init_dmaengine(struct net_device *ndev) {
> > +	struct axienet_local *lp =3D netdev_priv(ndev);
> > +	struct skbuf_dma_descriptor *skbuf_dma;
> > +	int i, ret;
> > +
> > +	lp->tx_chan =3D dma_request_chan(lp->dev, "tx_chan0");
> > +	if (IS_ERR(lp->tx_chan)) {
> > +		ret =3D PTR_ERR(lp->tx_chan);
> > +		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX)
> channel
> > +found\n");
>=20
> Why use dev_err_probe()? This is not on the probe path. If ndo_open fails=
 it
> fails, it won't get retried later by itself, right?

I see , will fix it, and remove _probe variant.

>=20
> > @@ -1238,7 +1540,24 @@ static int axienet_open(struct net_device
> > *ndev)
> >
> >  	phylink_start(lp->phylink);
> >
> > -	if (!lp->use_dmaengine) {
> > +	if (lp->use_dmaengine) {
> > +		/* Enable interrupts for Axi Ethernet core (if defined) */
> > +		if (lp->eth_irq > 0) {
> > +			ret =3D request_irq(lp->eth_irq, axienet_eth_irq,
> IRQF_SHARED,
> > +					  ndev->name, ndev);
> > +			if (ret)
> > +				goto error_code;
> > +		}
> > +
> > +		ret =3D axienet_init_dmaengine(ndev);
> > +
>=20
> pointless new line

Will fix in next version.
>=20
> > +		if (ret < 0) {
> > +			if (lp->eth_irq > 0)
> > +				free_irq(lp->eth_irq, ndev);
>=20
> can't this be on the error path?
It's just single instance so didn't introduce error label for it.
But I can move to error path.
>=20
> > +			goto error_code;
> > +		}
> > +
>=20
> pointless new line

Will fix it in next version.
>=20
> > +	} else {
>=20
> --
> pw-bot: cr
