Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC37F7569
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXNkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjKXNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:40:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5A93;
        Fri, 24 Nov 2023 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700833234; x=1701438034; i=wahrenst@gmx.net;
        bh=wDCiSJTXhXpQsFxIqaxtzqUh0f8rh9J+42vGz//6r3g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=mbD6rW591axLO9nG6RjUecFaWGmMuTdFBcXjDnx8A+sMTuj6ZJm6lPKjPJMJuoPG
         cQ0ymjXO19HnByg2TcbooCQMQDe4aFd0INX02weL7dgSIuhmG90qvEKoikqHokh9c
         FL3rmSd4LcVR1uxzYIHO7YMroVHWCeN4YxjQCiyFJgdVScWvHxXy7kPBvAsQ5z+Vf
         LEI6ayHelbGrMKTLKtXH6NgJidsEDHO+s513YT8D1YL6bi9bz5Iu8xBRFwwoMiDBB
         YFQ3lCdX8PfOmMnIlHKDqIT2bnXeBZqHIm9e88A8RjZkydRIRGyWl2JgGWE7XIGcx
         QjSWkIK6GmPqYcEq4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1rbAHK2b8y-00meq2; Fri, 24
 Nov 2023 14:40:34 +0100
Message-ID: <d4385cad-41e2-4adc-99b1-45a5b75a2ad5@gmx.net>
Date:   Fri, 24 Nov 2023 14:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 net] qca_spi: Fix SPI thread creation
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121163004.21232-1-wahrenst@gmx.net>
 <20231121163004.21232-2-wahrenst@gmx.net>
 <5327988fc5d02f3352be66b5f0a2ca9a468ef1da.camel@redhat.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <5327988fc5d02f3352be66b5f0a2ca9a468ef1da.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOYujk5KfdaYRyp81U2Y1DK6veGK5ZiNBC/FBsxTxudFRfwtFvj
 O5RdCgz8/qaP92o9SEfJ360pINm5m03oUL5ETTRIKmXg/y+XAXLDjFj5lNdFvmOU1v+ccA2
 nV1yNrR9pS7pyUo3ZQJ2AG58I3WqUaVem7gDHpjFkDd3FDcruOJPMeRhJ65KRiA6A32oygB
 uYZyBphMSbVNKtEdeSVPQ==
UI-OutboundReport: notjunk:1;M01:P0:xFBEfOC/kqE=;PB3XY0Mnx/3uowLtM/iMpiY5kva
 1o9dLlQvXukvrJvwcp5afFJKgZDczmqWRUPS/rybM8hjRcHAKh86pJO1bcA948/RCYKYtlzXR
 oR/LXs+R7K7VoxOdicqj4qTBeBHaVO2NQvYQ8JMDDS/G5i4QMQJjprKFtMf5uNDwiXRk9Ilh2
 EoYj8v4ICvBO6DXDgLbW42Ib5UPoxGdHTu8mO0Smy0bqxmIqJRwSBTaVjKwhfvs3O8zoFTIOR
 TXjvwRolxYqonyf7kHkhr+9b+ZJDEuVSJdFMKpxe1jmCYo6ir3Jlu3s7r4j7/1pLJ0HboiuFW
 X5Guq3E6C6Djg4PtmnhHkgca4N3xxYJUlPG/I2JV1ubCTkHWMf5mAzVCPwLvQFM2rG9VosWne
 UV+RtwwDcLIGvguSiaSqKnsY5zxLfV/XC/v+lHpg8lv0hljDAPaYmRH2Tt4QGPXUwlBO605MB
 JBG/ixuoV7J8TlrYlA2hxtv0UmztIz4I1PVyASKH77tf2sFV8Rr0SBjMBdHqndTIxPu9bpYbo
 Ug3OatU92DmNQjFfyddiHDKnTyWaXY0tnUrGQCC3dvKXNRSu1jdX5vsEIBHU1HeNaJrgCGZ6R
 w4yFXNai/4KH0YXTkFYRg1pjhV5g/1elX9kAs0d9x6F4+r52PFi765JKua9naP/rMMgM3zjmr
 ldA9TrHtA/8qOvYzBeDGQfWH+XYW+4yecpM134sdbwytWiQ0hSskAs6jIHL1xwrH6d7hfZj58
 NikjFPZWac8XLypXQ1AJWroj9z46mcb5Zv7sstgsPqHX/D0QUvz+aJDh13FOx16SQsa95Cq0K
 l6hNrqCJVgOZyoy/zTnxrKLQhDFZRv5gd7JzK1J10N9yO0C009XqQ2c57PotzAtRmwEZ73EgA
 TVmtzUxEWgBypJkVOLNeXjifGum4GZlHry5RMPNDGjLmwYW7lWgZ2kj1B3SEUHrxWSDDmfq+V
 qJ2L+w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Am 23.11.23 um 12:26 schrieb Paolo Abeni:
> On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
>> The qca_spi driver create/stop the SPI kernel thread in case
>> of netdev_open/close. This is a big issue because it allows
>> userspace to prevent from restarting the SPI thread after
>> ring parameter changes (e.g. signals which stop the thread).
>> This could be done by terminating a script which changes
>> the ring parameter in a loop.
>>
>> So fix this by moving create/stop of the SPI kernel into
>> the init/uninit ops. The open/close ops could be realized just
>> by 'park/unpark' the SPI kernel thread.
>>
>> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for Q=
CA7000")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/net/ethernet/qualcomm/qca_spi.c | 35 ++++++++++++++++--------=
-
>>   1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethe=
rnet/qualcomm/qca_spi.c
>> index bec723028e96..b11a998b2456 100644
>> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
>> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
>> @@ -580,6 +580,11 @@ qcaspi_spi_thread(void *data)
>>   	netdev_info(qca->net_dev, "SPI thread created\n");
>>   	while (!kthread_should_stop()) {
>>   		set_current_state(TASK_INTERRUPTIBLE);
>> +		if (kthread_should_park()) {
>> +			kthread_parkme();
>> +			continue;
>> +		}
>> +
>>   		if ((qca->intr_req =3D=3D qca->intr_svc) &&
>>   		    !qca->txr.skb[qca->txr.head])
>>   			schedule();
>> @@ -679,25 +684,17 @@ qcaspi_netdev_open(struct net_device *dev)
>>   	qca->sync =3D QCASPI_SYNC_UNKNOWN;
>>   	qcafrm_fsm_init_spi(&qca->frm_handle);
>>
>> -	qca->spi_thread =3D kthread_run((void *)qcaspi_spi_thread,
>> -				      qca, "%s", dev->name);
>> -
>> -	if (IS_ERR(qca->spi_thread)) {
>> -		netdev_err(dev, "%s: unable to start kernel thread.\n",
>> -			   QCASPI_DRV_NAME);
>> -		return PTR_ERR(qca->spi_thread);
>> -	}
>> -
>>   	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
>>   			  dev->name, qca);
>>   	if (ret) {
>>   		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
>>   			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
>> -		kthread_stop(qca->spi_thread);
>>   		return ret;
>>   	}
>>
>>   	/* SPI thread takes care of TX queue */
>> +	kthread_unpark(qca->spi_thread);
>> +	wake_up_process(qca->spi_thread);
> The above looks racy: after 'request_irq()' the interrupt handler can
> raise an irq before the thread being unparked.
yes fixing the whole resource allocation issue requires patch 1 and 2
applied, which should avoid the race. But i didn't want to combine both
patches to keep it applicable for stable. My thought was that 2 smaller
patches are more acceptable than a big one.

Should i squash them?

My concern is about the amount of affected devices. The QCA7000 is used
mostly in EV charging stations and EVs. I don't how many of them use
this driver.

> Additionally I think you can drop the 'if (qca->spi_thread)' in
> qcaspi_intr_handler()
Thanks i will check that for the next version.
>
> Cheers,
>
> Paolo
>

