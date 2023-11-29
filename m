Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C17FD34B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjK2JxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjK2JxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5619A6;
        Wed, 29 Nov 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701251579; x=1701856379; i=wahrenst@gmx.net;
        bh=vies0F8Jg1t++keNUgRX+FOgBZdRHEdkEZpAqz4PZbo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=QknhoD+2hkn2qzX8nZoE3bSo9ITWr63co889q863jTS7usC8Y3fjFUmnOTQqVq53
         T/8/Xi2o6rY6X2vNuDMWyleR6CpzqqFbvsjetf538hicdsrEeyUNyfM2aelbc1qfA
         H+tVd+IDj8As/aftvVQWYHRN8uKiJC71ELiAHM6nZMzY3gP2P2iyTpTPD45qxP0H5
         FLv4nJjRp8+sxZAc8fhdyzSEjEuyoWkfsi4olmeHlAhsbr4SMfY28G0oVw+dZpVFy
         7u18nD2GvxnnwrIzEFdtGHy1VKktGYmPS0u3pZh5DPzZ3/1BSnR6nYyDvXcloN12b
         WnyBA08r3lSDskC44g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1qkTl61Xrb-00WjGH; Wed, 29
 Nov 2023 10:52:59 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 3/3] qca_spi: Fix reset behavior
Date:   Wed, 29 Nov 2023 10:52:41 +0100
Message-Id: <20231129095241.31302-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129095241.31302-1-wahrenst@gmx.net>
References: <20231129095241.31302-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4/zh7el0YVAthtFzRf7pWbtQi6p4Rxm5tDQSr9kgPCtd5kJpFS
 CI/7pNcuDiVwPVRsKTmfj1gqDuCOxHtVkj2AwggxLiVzXSTyShFbdhk0TluiDlDc4ChPa0O
 AN3YgY3bwZhUbmRNUfA1gsUGQrNL30WRj9Ikme7BTFqhXJS2eDLYzz2PCHyvB6eHF63bbyc
 NGlzmp+ch9+LKlr2nb9jA==
UI-OutboundReport: notjunk:1;M01:P0:+zZhfyPFhgc=;Fif8m7WzyJ9ywa0VouETtbfU2Be
 4pkUG2z4lNKnqUuJ6YpLI3EiOWqz5m9y54NJk2XpMJAlXneZG4bOw6aahw8FPCrnkZjoxY0Pb
 E5iIE79qu0HTX7EMZClj2imp4hxEuGoj2E8q18X1zSa4PZgtJy+sLh313PQC/DZ2uuGrdYEOe
 4+zRloIDvz+vfl9AK7YzdagQGf1FxKeB1xkChnbJCT0cHPXnYxH5v8hzYlvFRQ8OgjtMClUES
 fWOdL1Fx7gfsnW/ir3W7nyLCmc+La2QYowTltXxEWDa/LhUQfmR0Tm1WmZTbel+dVfxlmjnGB
 WlbKkQOr2IFaxgaCiuifK4ob0C5TNvsJOuLF7zCtGt4rV5EaDstARFqNuccloO8J6DaHhELQr
 LW9Fj6EDsKGJQCLCL+fkmLpgVbGpAphhtOrYhULNgwjpyxcwAUvf+Ed0CHT/Vs1zCXuEZM5yC
 7tYRKQqQW+nhGeV7IcJ4lsNSBsN0PYWOKrBrio6JFEasu5gVCvA4lP/Q8k6IPNtdAxw+RTzZY
 6ApahbnNjheECaofBJ8m4/PSwXRqcBysZuiCF2wqtvQTK0lhROV5jmgdVJBT/6XohHCtx7cOY
 lqREh0e8/gY6o4ugYKCxlkcPUoeWlPWkGfZOtTYTY989550sWBU3L0bMFhI+m7RleseVbhQR/
 V9+X6ckS1TaOAKrjurm3Se1kegAn8Yy822fAcQmcSiBcUgf72N0m4m500OQrqweFvPp5ehXfV
 oH1V+smvPdNS/Hnsi2Bboir1Go0C10809veoOKr6s3dKMZ1k9dOei+cOsNvw7Qf4/VQlvVm/u
 hHz1PRVucUDWTBedpdtKDI5jUtGagJW+BNEecKb1WNtIgopv5Mr3Yaij53Wy+FxU0nAkOlGHc
 ecGrcjtrtg1sqOV98OFNgo/wgRIZ4fghLhOE8B1WSQQ4JnK/KehwYpR6lTHTg+Ts4E1WbE98H
 MtSnnA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a reset triggered by the QCA7000 itself, the behavior of the
qca_spi driver was not quite correct:
- in case of a pending RX frame decoding the drop counter must be
  incremented and decoding state machine reseted
- also the reset counter must always be incremented regardless of sync
  state

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 78317b85ad30..0fe2e24a42b2 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -613,11 +613,17 @@ qcaspi_spi_thread(void *data)
 			if (intr_cause & SPI_INT_CPU_ON) {
 				qcaspi_qca7k_sync(qca, QCASPI_EVENT_CPUON);

+				/* Frame decoding in progress */
+				if (qca->frm_handle.state !=3D qca->frm_handle.init)
+					qca->net_dev->stats.rx_dropped++;
+
+				qcafrm_fsm_init_spi(&qca->frm_handle);
+				qca->stats.device_reset++;
+
 				/* not synced. */
 				if (qca->sync !=3D QCASPI_SYNC_READY)
 					continue;

-				qca->stats.device_reset++;
 				netif_wake_queue(qca->net_dev);
 				netif_carrier_on(qca->net_dev);
 			}
=2D-
2.34.1

