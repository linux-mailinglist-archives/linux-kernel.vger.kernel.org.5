Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661C5775CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjHILb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjHILb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:31:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0E1FEB;
        Wed,  9 Aug 2023 04:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djk2CMkVqbvLnj/pVCXkAkYfotHrYB9w9rg8gfFys8l7PKOyBkrmz6yaDZ6WWtIfI0zn15e8sR4wqftIsDecR/5qdaj4+ttgHiH8U4VWOJzuQjZCoRRt5Ww6uuToJ90nqDw8llht0iajSzw4tcRZMOrWfC5Kp4VC0UW4HqkElRexPZM8HVqwjUOfhcuFaeXqJs92P0KcL0+b/LATirffTteriI57v+z/MaLGniSKYzMKR9nNWP/La3NOoSG9vcXmNDtrSFggf7OzypuihCf/8IO17MkjIPHuz3y6nJCR5Mq2bAfa0JYGhQsTjlKOIg+ffZWd7T85/H9Qc6d0ZMsyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIUXfwA2fA5HMPn2vGxy/i7o/zNouOgYPpxpURT00DE=;
 b=EeVUy3ePH/aR3589JYxNnu8yBz3GnXVW1q7mB5Q2qeRPYtsAgfzwIJ9eGjQusb0UNG4OKKCO1RshaeblKnhEamJos0wprB8d85rZMjkxibqxTE06NxB/A/dq0bk57GqP7sTLOi/uZ8ma+i5xDxHcOoG7/tBAj5gER566W8t+/H5FJ1hix2bcdeXehhIYrCrLblDDGUAZpuDAypkc0AiQN4eHODpI6qcADrzRvoNG9PvCgTWUsMzyHV6yqsYlUtqQupCo87tjG/hde737KI3dD1vEiuE38OeGq9mwk3B0GITWbRalBxHHWxhQm4hg9sV8Xj0wp/Gl97DVxTkmHfV7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIUXfwA2fA5HMPn2vGxy/i7o/zNouOgYPpxpURT00DE=;
 b=UeCnHIOYH/wOwCYSSkOivlzouxT793sd/qFO6MIRmr+JLNggpOmc++ywIDrZbH/yx5g8ctpg8XiMfX9KGDWx/tXSWUmbNum8iILtw4TYZk2RBy/KpgLA2TC3c6FEIMF2zHQ0vSPEqehcq8BXMw0J9z/DC22gOnWR/4Ygm5K5wc8=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 11:31:25 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::6a4c:b0d9:9f2:d986]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::6a4c:b0d9:9f2:d986%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 11:31:24 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Thread-Topic: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Thread-Index: AQHZiWymuzIqz3Ot8UaPrMu6fkQ75K9nn7Iw
Date:   Wed, 9 Aug 2023 11:31:24 +0000
Message-ID: <PH8PR12MB66758946C395E678B7599FE5E112A@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: 95614252-879b-4670-6e43-08db98cc29d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr/Yy/VSFu3aHcL6mkQZmto0EAeMZBq1VIeKzphZ1v6TyXoRkN9lQKN0tx1C3IPLHuIgLNMHeV/c4dJRLxrJv0PMdvDSvwiaLJ/sEa7PVISdVEd0PLmPzFQm5dV5B09kr5mFJQK8ltAsovlaR6bhdDfBl0rcWR/C+nUKLxp6JLIr/NN9sXi0SQkXidU1m1C7iaeihaSZy7EnwCf4ZhAKn5fS/GIoesNTs4OeH8clxleWtfBEr6+mMcZyrEyE1IVEPqMDDhJAQzgYoUl0t8GoHXAq7mZrHxDIj3wE5zo8ErnIxeDdp1phItvzbZnrh0qbWNXlpvDYMD1+pn6dptskJ9ig5tlCum+2WZxyyH5e5wiPXkKUdPl5s1jndzoeLvYzCPE6Q9T8XJDQoDpHGv9ymlK6HQFXFGkz0kZSr6g3qCmlTNIdCmxkJGEqIgslCJM2bbI5GHQrd/Yy65mmRaw6fDsUmKT7dTssU8ztKvyxKJKFWiHOzazqkxTo7bArEuxxuDjVX0pr/MG+VB+92BEMgSscJTP5gFFKeW+xTyo3ABdkCdpYyiIcXtsdWP8d5HGA4y7FnIPxNENdXtX3JSRPzQ5YgQgE4LiMp9DyLc02QUpdJWaqVXD7u2Z0+neBCQ2R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799006)(451199021)(186006)(38100700002)(55016003)(99936003)(6506007)(41300700001)(7696005)(478600001)(122000001)(86362001)(9686003)(33656002)(5660300002)(52536014)(316002)(64756008)(66946007)(4326008)(8936002)(8676002)(66476007)(66556008)(76116006)(38070700005)(2906002)(66446008)(110136005)(54906003)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eDJXzMdwLZJxZCvzuQsWAHDSJotAwz+32jeg6mgQUcfiNP83EwZf0T7WGLzd?=
 =?us-ascii?Q?YxQ2V4m+kgN4qZBNIwD4RW3UCXwRTTAyZOgiWuihQ4rTMC+KheMCXELW+ORJ?=
 =?us-ascii?Q?f2Dk46+Z6+wa8pZcz9Ytzx7B/UA26BcL383fRSo4hjBiTj9tQ0F2h9kxiNho?=
 =?us-ascii?Q?FsCRJwoVSTg40q7rYlFnD16dwzNVrMbiWbrD2+mbPJF28oH67nn3xhUvSnYD?=
 =?us-ascii?Q?yeniZwkPa1F6deKMT0Aq1kHZVF+75EeUPwusDXPpyIOYJXGosgZXTUYDJHD9?=
 =?us-ascii?Q?l9w31Ar5CNDksBAqBp7TA+o9YYgTAunW1R3Vy47QV+yXOEkJmTlOF+4/jqLa?=
 =?us-ascii?Q?vRCWH/GF5cYtRtZEx3VR7XwPkMuazAGZ0IKfW2t1JeXFND5SGfN8bG4jUkbe?=
 =?us-ascii?Q?LUvWX8unEK4AkedlBn+BT2cEJ964LPlxJFlOyvs4ht8OtNBOONIL9Czlef1y?=
 =?us-ascii?Q?0Fzei01A+hg+xh7OH2EHhsbA43/AygCUbe+mz5SLRkm85Ep7dqqlBuzIN4eB?=
 =?us-ascii?Q?WmWnOnuB+Ic6ceDb9lwYv20bA3vwzcYrW0ZbmVXxQQvwq+0Oqfh1JHIwVAmv?=
 =?us-ascii?Q?B11qy6gpdkBlOecFIneEo8tsJ7+Ul6uBBoxwsXMiYSLUKxjuM8ZhyKBbS+2q?=
 =?us-ascii?Q?ywfc/XDRD6AjJ0kb3qcarZMmlpIhciZZxuG4qv1q3W2qL1DTNXo6yUg2dz/I?=
 =?us-ascii?Q?8r2ymBrvj/zYHTNc24jq3VL1ZCUuUPpueyAfLZdLlKRLzKL7NZBOlvpmuwYv?=
 =?us-ascii?Q?FxL2i/pXr9LZHICQWYIl+ivufVu5aMjxXIeDWnJ12q1MUm/7YxoYv7w+RGUe?=
 =?us-ascii?Q?9cIipnWn/M7bmLgVrTNFtQcUvbL9QN9/IcH+ig3+nlCdIA0f7wQRko3Ixy3s?=
 =?us-ascii?Q?yJqQThFPSRLQMzUhUacRkmCyVFWtSSs7fHcPTpyH73ngmtO4tFFDq+kGZFjH?=
 =?us-ascii?Q?DO3kx1V+aPzaUoDcg3VWVDDCgTdNMxFb+uiRSUWrVy4Znrdvq1iKklx338rA?=
 =?us-ascii?Q?RnxjMbz6waRcHzjrighqYkNDC2eUM2xv4bfxXHvCfR65C+sW5RfyF7lU0AUc?=
 =?us-ascii?Q?B/BgJw5MncPnDLfiOBocXksEY5VJrXTpegnEZJiQO7EeTHXA7cVvNqXey33X?=
 =?us-ascii?Q?2HBUFsBmxmqrQ6FPxs18GGNkBrdXE4bvCLB8JSkHD697CtB13ycWN2x0LNWu?=
 =?us-ascii?Q?wp+kOOOv5ft6J2XWQVz+pV1NVuk6fne/hy8BUD6l6EDacmjIYeCN4EJuVeRY?=
 =?us-ascii?Q?U5QviThrcp0lc/2R8qADMwNAk5tJBfi/puqBC8hTBUjwr6Fc0SdUknpqbBdR?=
 =?us-ascii?Q?gtNkgzihO9p7DYAAnHyQarRfA5x213cdRg9uu/pHQuXaDDtYV8Y9SBXQaZiI?=
 =?us-ascii?Q?2cLv3qGOGw9EIreIolSje7YsrTZXk6qiE1GO5KcnUvafGu/ZkxWpAqHDv08F?=
 =?us-ascii?Q?H7PUteYWzOxhedRMoWHQbclltkLFzsLIvKH0UxLmQwuuL0FhUFBmuCWSSRxt?=
 =?us-ascii?Q?+Mj2xsJOdGkKHoWzRauoto5LGTMW56RTP3MktxV/GMEJAsMmzU3bn1KA5Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_PH8PR12MB66758946C395E678B7599FE5E112APH8PR12MB6675namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95614252-879b-4670-6e43-08db98cc29d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 11:31:24.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+gtvKG4f6oxNpi2qrAG/t0OPR0RdFpisnHIZI3ctTSO/zx63QN3fRhatrojpiZs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_PH8PR12MB66758946C395E678B7599FE5E112APH8PR12MB6675namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Charles,

>-----Original Message-----
>From: Charles Keepax <ckeepax@opensource.cirrus.com>
>Sent: Thursday, May 18, 2023 3:09 PM
>To: broonie@kernel.org
>Cc: Goud, Srinivas <srinivas.goud@amd.com>; linux-spi@vger.kernel.org;
>linux-kernel@vger.kernel.org; patches@opensource.cirrus.com
>Subject: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read =
of RX
>FIFO
>
>When working in slave mode it seems the timing is exceedingly tight.
>The TX FIFO can never empty, because the master is driving the clock so ze=
ros
>would be sent for those bytes where the FIFO is empty.
>
>Return to interleaving the writing of the TX FIFO and the reading of the R=
X FIFO
>to try to ensure the data is available when required.
>
>Fixes: a84c11e16dc2 ("spi: spi-cadence: Avoid read of RX FIFO before its
>ready")
>Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>---
>
>Updates since v1:
> - Update the kernel doc to match the changes
>
>Thanks,
>Charles
>
> drivers/spi/spi-cadence.c | 64 ++++++++++++++++++---------------------
> 1 file changed, 30 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c index
>ff02d81041319..26e6633693196 100644
>--- a/drivers/spi/spi-cadence.c
>+++ b/drivers/spi/spi-cadence.c
>@@ -12,6 +12,7 @@
> #include <linux/gpio/consumer.h>
> #include <linux/interrupt.h>
> #include <linux/io.h>
>+#include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/of_irq.h>
> #include <linux/of_address.h>
>@@ -301,47 +302,43 @@ static int cdns_spi_setup_transfer(struct spi_device
>*spi,  }
>
> /**
>- * cdns_spi_fill_tx_fifo - Fills the TX FIFO with as many bytes as possib=
le
>+ * cdns_spi_process_fifo - Fills the TX FIFO, and drain the RX FIFO
>  * @xspi:	Pointer to the cdns_spi structure
>+ * @ntx:	Number of bytes to pack into the TX FIFO
>+ * @nrx:	Number of bytes to drain from the RX FIFO
>  */
>-static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi, unsigned int ava=
il)
>+static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int
>+nrx)
> {
>-	unsigned long trans_cnt =3D 0;
>+	ntx =3D clamp(ntx, 0, xspi->tx_bytes);
>+	nrx =3D clamp(nrx, 0, xspi->rx_bytes);
>
>-	while ((trans_cnt < avail) && (xspi->tx_bytes > 0)) {
>+	xspi->tx_bytes -=3D ntx;
>+	xspi->rx_bytes -=3D nrx;
>+
>+	while (ntx || nrx) {
> 		/* When xspi in busy condition, bytes may send failed,
> 		 * then spi control did't work thoroughly, add one byte delay
> 		 */
>-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
>-		    CDNS_SPI_IXR_TXFULL)
>+		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
>CDNS_SPI_IXR_TXFULL)
> 			udelay(10);
Linux driver configured as Slave, due to this above delay we see data corru=
ption issue on Master side.
when Master is continuously reading the data, Slave is failed to prepare th=
e date on time due to above delay.

>
>-		if (xspi->txbuf)
>-			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
>-		else
>-			cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
>+		if (ntx) {
>+			if (xspi->txbuf)
>+				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi-
>>txbuf++);
>+			else
>+				cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
>
>-		xspi->tx_bytes--;
>-		trans_cnt++;
>-	}
>-}
>+			ntx--;
>+		}
>
>-/**
>- * cdns_spi_read_rx_fifo - Reads the RX FIFO with as many bytes as possib=
le
>- * @xspi:       Pointer to the cdns_spi structure
>- * @count:	Read byte count
>- */
>-static void cdns_spi_read_rx_fifo(struct cdns_spi *xspi, unsigned long co=
unt) -{
>-	u8 data;
>-
>-	/* Read out the data from the RX FIFO */
>-	while (count > 0) {
>-		data =3D cdns_spi_read(xspi, CDNS_SPI_RXD);
>-		if (xspi->rxbuf)
>-			*xspi->rxbuf++ =3D data;
>-		xspi->rx_bytes--;
>-		count--;
>+		if (nrx) {
>+			u8 data =3D cdns_spi_read(xspi, CDNS_SPI_RXD);
>+
>+			if (xspi->rxbuf)
>+				*xspi->rxbuf++ =3D data;
>+
>+			nrx--;
>+		}
> 	}
> }
>
>@@ -391,11 +388,10 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_i=
d)
> 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
> 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
>
>-		cdns_spi_read_rx_fifo(xspi, trans_cnt);
>-
> 		if (xspi->tx_bytes) {
>-			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
>+			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
> 		} else {
>+			cdns_spi_process_fifo(xspi, 0, trans_cnt);
When Linux driver configured as Slave, we observed data corruption issue wi=
th Slave mode read when data length is 400 bytes.
As TX empty doesn't guaranties valid data in RX FIFO, hence we added one by=
te delay(10us) before RX FIFO read to overcome above issue.
Created patch with above changes, find patch as attachment.
Can you please test and let me know your observations.

Thanks,
Srinivas
> 			cdns_spi_write(xspi, CDNS_SPI_IDR,
> 				       CDNS_SPI_IXR_DEFAULT);
> 			spi_finalize_current_transfer(ctlr);
>@@ -448,7 +444,7 @@ static int cdns_transfer_one(struct spi_controller *ct=
lr,
> 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi-
>>tx_fifo_depth >> 1);
> 	}
>
>-	cdns_spi_fill_tx_fifo(xspi, xspi->tx_fifo_depth);
>+	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
> 	spi_transfer_delay_exec(transfer);
>
> 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
>--
>2.30.2



--_002_PH8PR12MB66758946C395E678B7599FE5E112APH8PR12MB6675namp_
Content-Type: application/octet-stream;
	name="0001-spi-spi-cadence-Fix-data-corruption-issues-in-slave-.patch"
Content-Description:
 0001-spi-spi-cadence-Fix-data-corruption-issues-in-slave-.patch
Content-Disposition: attachment;
	filename="0001-spi-spi-cadence-Fix-data-corruption-issues-in-slave-.patch";
	size=2497; creation-date="Wed, 09 Aug 2023 11:27:51 GMT";
	modification-date="Wed, 09 Aug 2023 11:31:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MDE1NDkzMmFjNzQ4NmM5OWUzMzliYmMwYjg1YjNjZmUzODIyODZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBHb3VkIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMSBBdWcgMjAyMyAyMToyMTowOSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIHNw
aTogc3BpLWNhZGVuY2U6IEZpeCBkYXRhIGNvcnJ1cHRpb24gaXNzdWVzIGluIHNsYXZlIG1vZGUK
ClJlbW92ZSAxMHVzIGRlbGF5IGluIGNkbnNfc3BpX3Byb2Nlc3NfZmlmbygpIChjYWxsZWQgZnJv
bSBjZG5zX3NwaV9pcnEoKSkKdG8gZml4IGRhdGEgY29ycnVwdGlvbiBpc3N1ZSBvbiBNYXN0ZXIg
c2lkZSB3aGVuIHRoaXMgZHJpdmVyCmNvbmZpZ3VyZWQgaW4gU2xhdmUgbW9kZSwgYXMgU2xhdmUg
aXMgZmFpbGVkIHRvIHByZXBhcmUgdGhlIGRhdGUKb24gdGltZSBkdWUgdG8gYWJvdmUgZGVsYXku
CgpBZGQgMTB1cyBkZWxheSBiZWZvcmUgcHJvY2Vzc2luZyB0aGUgUlggRklGTyBhcyBUWCBlbXB0
eSBkb2Vzbid0Cmd1YXJhbnR5IHZhbGlkIGRhdGEgaW4gUlggRklGTy4KClNpZ25lZC1vZmYtYnk6
IFNyaW5pdmFzIEdvdWQgPHNyaW5pdmFzLmdvdWRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL3NwaS9z
cGktY2FkZW5jZS5jIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkv
c3BpLWNhZGVuY2UuYyBiL2RyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLmMKaW5kZXggNDJmMTAxZC4u
MDdhNTkzYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpLWNhZGVuY2UuYworKysgYi9kcml2
ZXJzL3NwaS9zcGktY2FkZW5jZS5jCkBAIC0zMTcsMTIgKzMxNyw2IEBAIHN0YXRpYyB2b2lkIGNk
bnNfc3BpX3Byb2Nlc3NfZmlmbyhzdHJ1Y3QgY2Ruc19zcGkgKnhzcGksIGludCBudHgsIGludCBu
cngpCiAJeHNwaS0+cnhfYnl0ZXMgLT0gbnJ4OwogCiAJd2hpbGUgKG50eCB8fCBucngpIHsKLQkJ
LyogV2hlbiB4c3BpIGluIGJ1c3kgY29uZGl0aW9uLCBieXRlcyBtYXkgc2VuZCBmYWlsZWQsCi0J
CSAqIHRoZW4gc3BpIGNvbnRyb2wgZGlkJ3Qgd29yayB0aG9yb3VnaGx5LCBhZGQgb25lIGJ5dGUg
ZGVsYXkKLQkJICovCi0JCWlmIChjZG5zX3NwaV9yZWFkKHhzcGksIENETlNfU1BJX0lTUikgJiBD
RE5TX1NQSV9JWFJfVFhGVUxMKQotCQkJdWRlbGF5KDEwKTsKLQogCQlpZiAobnR4KSB7CiAJCQlp
ZiAoeHNwaS0+dHhidWYpCiAJCQkJY2Ruc19zcGlfd3JpdGUoeHNwaSwgQ0ROU19TUElfVFhELCAq
eHNwaS0+dHhidWYrKyk7CkBAIC0zOTIsNiArMzg2LDExIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBj
ZG5zX3NwaV9pcnEoaW50IGlycSwgdm9pZCAqZGV2X2lkKQogCQlpZiAoeHNwaS0+dHhfYnl0ZXMp
IHsKIAkJCWNkbnNfc3BpX3Byb2Nlc3NfZmlmbyh4c3BpLCB0cmFuc19jbnQsIHRyYW5zX2NudCk7
CiAJCX0gZWxzZSB7CisJCQkvKiBGaXhlZCBkZWxheSBkdWUgdG8gY29udHJvbGxlciBsaW1pdGF0
aW9uIHdpdGgKKwkJCSAqIFJYX05FTVBUWSBpbmNvcnJlY3Qgc3RhdHVzCisJCQkgKiBYaWxpbngg
QVI6NjU4ODUgY29udGFpbnMgbW9yZSBkZXRhaWxzCisJCQkgKi8KKwkJCXVkZWxheSgxMCk7CiAJ
CQljZG5zX3NwaV9wcm9jZXNzX2ZpZm8oeHNwaSwgMCwgdHJhbnNfY250KTsKIAkJCWNkbnNfc3Bp
X3dyaXRlKHhzcGksIENETlNfU1BJX0lEUiwKIAkJCQkgICAgICAgQ0ROU19TUElfSVhSX0RFRkFV
TFQpOwpAQCAtNDM5LDEyICs0MzgsMTggQEAgc3RhdGljIGludCBjZG5zX3RyYW5zZmVyX29uZShz
dHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsCiAJCWNkbnNfc3BpX3NldHVwX3RyYW5zZmVyKHNw
aSwgdHJhbnNmZXIpOwogCX0gZWxzZSB7CiAJCS8qIFNldCBUWCBlbXB0eSB0aHJlc2hvbGQgdG8g
aGFsZiBvZiBGSUZPIGRlcHRoCi0JCSAqIG9ubHkgaWYgVFggYnl0ZXMgYXJlIG1vcmUgdGhhbiBo
YWxmIEZJRk8gZGVwdGguCisJCSAqIG9ubHkgaWYgVFggYnl0ZXMgYXJlIG1vcmUgdGhhbiBGSUZP
IGRlcHRoLgogCQkgKi8KIAkJaWYgKHhzcGktPnR4X2J5dGVzID4geHNwaS0+dHhfZmlmb19kZXB0
aCkKIAkJCWNkbnNfc3BpX3dyaXRlKHhzcGksIENETlNfU1BJX1RITEQsIHhzcGktPnR4X2ZpZm9f
ZGVwdGggPj4gMSk7CiAJfQogCisJLyogV2hlbiB4c3BpIGluIGJ1c3kgY29uZGl0aW9uLCBieXRl
cyBtYXkgc2VuZCBmYWlsZWQsCisJICogdGhlbiBzcGkgY29udHJvbCBkaWQndCB3b3JrIHRob3Jv
dWdobHksIGFkZCBvbmUgYnl0ZSBkZWxheQorCSAqLworCWlmIChjZG5zX3NwaV9yZWFkKHhzcGks
IENETlNfU1BJX0lTUikgJiBDRE5TX1NQSV9JWFJfVFhGVUxMKQorCQl1ZGVsYXkoMTApOworCiAJ
Y2Ruc19zcGlfcHJvY2Vzc19maWZvKHhzcGksIHhzcGktPnR4X2ZpZm9fZGVwdGgsIDApOwogCXNw
aV90cmFuc2Zlcl9kZWxheV9leGVjKHRyYW5zZmVyKTsKIAotLSAKMi4xLjEKCg==

--_002_PH8PR12MB66758946C395E678B7599FE5E112APH8PR12MB6675namp_--
