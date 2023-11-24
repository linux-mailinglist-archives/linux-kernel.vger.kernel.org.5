Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA97F7625
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjKXORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:17:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC2199D;
        Fri, 24 Nov 2023 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700835449; x=1701440249; i=wahrenst@gmx.net;
        bh=0a7YQ4lsvuCcWSyrWmIaRT00/YgNIgJjYXSSYuJHFSU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=GPeFmwbCnGKyVHovdOH2ExKNFKgT+XZCcA3mmhb3ymLLMSaM8g6d/aiueuEgp+Xm
         jUXqnRefuBftIEXAW0UsEisp9zrnjqTZ+2TAxsRwzn4C1QFVsBawlboaCp8P8msUM
         9rohH3DVZ4T3a4aRyMHx9g6Lm5JIp/UeuCXcH08OEDi2mtPdJBKcUa6qOjCZy+NPe
         zAsPdlS/0Vmk1pdD3KZLrc4dZpk69Y11vob5z30vC5E9Vdv1ODVv6FVklJtcY8HHl
         9P+FTvHAuLX/PxQ08Lx4ayEdcZ43tEnbeC6ez4BLK+O07Q2Lxiaq4oM5+0TiAYOfj
         PNbw8qnIIPwYhDLlzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1rO3sf2agK-00qwLX; Fri, 24
 Nov 2023 15:17:29 +0100
Message-ID: <0d1cf97c-abbe-4a7a-a634-312caa882fad@gmx.net>
Date:   Fri, 24 Nov 2023 15:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121163004.21232-1-wahrenst@gmx.net>
 <20231121163004.21232-4-wahrenst@gmx.net>
 <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2FP/ku1jKnGiHWTItr1bg83wGE9T0yCvG8I54CbMYJ8AODEn9K
 ofuzskXR/046hb1Jn+XMcjfj3PICRu7Zz2sIudKCrQ9doIe4z69YiB98cov9rHooNUAtRFR
 4HYcBPCco0Eu97CVwyoO23q4oDbzKdpAH9c71C2/dvshqCq8HJ9FddYYMQyO/q7fugTftx6
 4eLzwAXznEhfmNTC1WEdA==
UI-OutboundReport: notjunk:1;M01:P0:H4YQHzAewko=;D932sCf0IX8wgn841dEIMW6J1ig
 LW1QK+E0IJv23KyL/XXmnZwe4tNuA/XQ+jeV0RpxF28asO9MRemApQcoM93uvTVnMGDios15j
 XIWcq1MS8WlmhhyOg1lv934jIQXuwmiqBCqJs9tIbGkfrPCX1/To+gmzPu0z6POwYkUjmGvUN
 1NUhdXefhIhB6ytaFDHnsSP4N7H0uv6IHW2O/7i9K+fJ0kHYvRQQO3rS4ECYYGO0alnHqrrPo
 0nz2AW5RyhrevKmgtgTK6wdWEcRWR9bDqSjemK6rBRNt//9Kxg8jLYP7ehPLiT2EckBIpMZMQ
 h+k1zcz/WZB2Edc6aqxbWRuLynShW/YaM1wWYdfHPxjF4TEvFhQodzZUb9rXNk0h7HnadvG/+
 oZQTylLDqqugYmIWUvXlmX575+oIfKPl7JXbidp8YeGbm7s4cvZHWPZfXbALo2nK6bTKkDIMl
 Nx1osF4RDZnPg9W6zbQMz7qDScrS0TA6aFV4vA1N0b16gEqIiCaAoDVoZ8TUZ2EBnAwL/0OIT
 eseECf7cswdarh1nL77UJ6WtlVolsmqzIIqyjbJzSbBkcnEc5v+KUNTUVDEP6SDyd4FVBFMce
 dcKqnblFIAh0UQS8P2YGHTcJeL3Xdl+c4dW5jFQH17HsxEZlj+mn2B6S4uPUe7mDfSNrq+1Fz
 HfssF8UejeYxYXXrlSQsKSskQ0ePXuJXb3QRkQlg2Mon4sGMs39ftb0vKE4e60kIEVPkkcL6H
 rhT/1sfT5zrgFYBhb1SBk9+YhVXH2lE1sZXCsoOYsO9TQh5PdWZEKV1uEPC6Aqr/TEmLw9LP7
 0bXB3UfKtZKdIvinSITgM53ICLzsYZwXYWxXi9gJmMRJuE2Gq6z77bhBe0ZCsw7YHMDOrmlnY
 iuNBh6Ai2UDx8nEMijWL+x8g/2cmWY0nEtc+hhfMDd2sHrOucKaafQbd7M+5nT3CuGrwBfhwY
 3bKuWwOqXnAY/U1xDDYYKxOS2u4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Am 23.11.23 um 12:51 schrieb Paolo Abeni:
> On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
>> After calling ethtool -g it was not possible to adjust the TX ring size
>> again.
> Could you please report the exact command sequence that will fail?
ethtool -g eth1
ethtool -G eth1 tx 8
>
>
>> The reason for this is that the readonly setting rx_pending get
>> initialized and after that the range check in qcaspi_set_ringparam()
>> fails regardless of the provided parameter. Since there is no adjustabl=
e
>> RX ring at all, drop it from qcaspi_get_ringparam().
>> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for Q=
CA7000")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/et=
hernet/qualcomm/qca_debug.c
>> index 6f2fa2a42770..613eb688cba2 100644
>> --- a/drivers/net/ethernet/qualcomm/qca_debug.c
>> +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
>> @@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct=
 ethtool_ringparam *ring,
>>   {
>>   	struct qcaspi *qca =3D netdev_priv(dev);
>>
>> -	ring->rx_max_pending =3D 4;
>>   	ring->tx_max_pending =3D TX_RING_MAX_LEN;
>> -	ring->rx_pending =3D 4;
>>   	ring->tx_pending =3D qca->txr.count;
>>   }
> I think it's preferable update qcaspi_set_ringparam() to complete
> successfully when the provided arguments don't change the rx_pending
> default (4)

Sorry, i didn't get. The whole point is that there is no RX ring at all,
just a TX ring. During the time of writing this driver, i was under the
assumption that the driver needs to provide a rx_pending in
qcaspi_get_ringparam even this is no RX ring. The number 4 represent the
maximum of 4 packets which can be received at once. But it's not a ring.

Best regards

> Cheers,
>
> Paolo
>

