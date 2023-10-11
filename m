Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E237C5A85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjJKRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJKRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:49:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B468F;
        Wed, 11 Oct 2023 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697046554; x=1697651354; i=linosanfilippo@gmx.de;
 bh=UJJzaerlQRsDqbxZwPZpsK3aG/E9cxNuD4ysd9HCNkg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QxJyHUiVXHjL9yISHHGz34eeSJAOUGCUDN9jFDlsBS/2B3veD2KapeZa+D0reKDZgmvSb2c7YER
 GfrOMrP5LvVmBCKHkZNi8b+etBlN5FIXg2nYBd5+Bda7IAVpir3HmkdcGE4WzopihGnnkYNkL7wlH
 7QtyLdilxY3aFWLZxsmTcWWD66eKzAhdeDQFfOYGX4lznHQg/YWv0tcmS69c5EVjsXHCr5nEipWLn
 ZrVieTrze1tmNMhFrBPx/N/d7NDj7m+xGx/oINLtPZnBW8iNCYfEfXl3WMM5e5PAA4riEGiH7SV6v
 7xkh4xtDOCLbgNhntMa9bx3diXqGa9KRmC7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1r4rMk2oRw-00YDyX; Wed, 11
 Oct 2023 19:49:14 +0200
Subject: Re: [PATCH v2 2/7] serial: amba-pl011: get rid of useless wrapper
 pl011_get_rs485_mode()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
 <20231011173829.10508-3-l.sanfilippo@kunbus.com>
 <2023101134-theater-oversleep-a58b@gregkh>
 <20d22e11-b9be-b547-ec4e-9964a57924a4@gmx.de>
 <2023101101-knoll-dust-6308@gregkh>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <447eecb3-1ebc-e8ea-db6c-9964ef9fd0db@gmx.de>
Date:   Wed, 11 Oct 2023 19:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2023101101-knoll-dust-6308@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4DLX6g8ZGchS1XtTecAHpxYCrURMdVvGDH0mpcd4YoSEcPYub+l
 dp9Ac/1jzfKbTOMhCg4rHrX+lEaiKKp8/0PU9Qi/+s6/2cugeBY4vyyDWOBBpAYZFJlQLdM
 Vczjcp8Mop1GMYiVaYdSP8xQiDzR85/0I2Xdb4JXQ/d3MA8MOWB02xwb9FxDRnwzL7edD8x
 Wtj6q/EEU3RzKosNu3pJQ==
UI-OutboundReport: notjunk:1;M01:P0:IteMFpbMUBQ=;wjRF8QhpTpFpjyp7JvmrW+OQ55k
 bQJkm4Fe86TzUm0nnTrYhzHqb5xqylyYBI/oBLHa4pNXjrtk6uCit6zn6Rxh6LJEWgkRRC/qg
 e5uyFqKYMGLIExRiUs39+fI5RlXMtctsgsc6LNM8wa4SX4WiFdd9udePmFBuTfHGi/H3Mvy30
 oGEIARVkvAwW9wC4T5MOcZ6g4Z2uOAWWjdI9CyDCexwpCA5Qq0L52YVj4bS5yjClvEW2E4jCv
 EPZikOjaTFIWXNWwKwKCJlHXraknTL2sBTzm/OU4+5Tdmpbzap/ni9Pml3pvsJIWqyQDr0wGL
 Lna5OeyAcOJAAKWN3EOf0sZNyeRfGd1/rw3TrPA4JZJit9mIkM7DuyLh21dMUKG6ZAbou72nF
 jDCMqQ52Fkyd+v8RlOG4DWyq1pf8o3rc2SJ90Q1mWwUDRUuiVCI5xQPfPSBUicpipQEggQLPQ
 zuLxT4eiSQ4Oy522Xv8bx4YowcWF5rjkIzK25qULAIP9wOOrjd8Js08jJdUX7yGAKiZBevedE
 jBEGYN/osUHg9kkcG9eaTXCzqTvW2fvaqfd5tQjnnUrkbpLViuDDvJm21j6RJsELG/sz95n0s
 qACNaxBwvT9J8wFA1mns0hJfOZRVBDOh7g33bEb/XDvd9ibIFZGuGrirT6p9IVuAeokO1yy6F
 LeobZ3GW3Wsu9Q4TOQjsFdJpG41QKMz64ougaeVSfck4gffLjk5KIuVTV24jZcvEpO2OpPqEJ
 U/qpfV4zSCzZhpA7HzoQkyKZ39xdM/r1R7ONJRTr/xXZKP4/Z2p4HGldsyzIv1K0LvUJVIlTT
 N6KpMqukaJqq/1HgAm/11CZRulbgiXFg58kr1stbZLdKDWfm4LS+XcZtGTholpp4C+Awy30WC
 lvxLmOE2wQZdRDA4WsHKSCjWLioa6mIUuPpUPmhRsdc1VO4wMgO32qZ4ra7oPMC3XarwBvaUx
 StvmQg==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.23 at 19:47, Greg KH wrote:
> On Wed, Oct 11, 2023 at 07:44:51PM +0200, Lino Sanfilippo wrote:
>>
>> Hi,
>>
>> On 11.10.23 at 19:42, Greg KH wrote:
>>> On Wed, Oct 11, 2023 at 07:38:24PM +0200, Lino Sanfilippo wrote:
>>>> Due to earlier code changes function pl011_get_rs485_mode() is now me=
rely
>>>> a wrapper for uart_get_rs485_mode() which does not add any further
>>>> functionality. So remove it and instead call uart_get_rs485_mode()
>>>> directly.
>>>>
>>>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>> ---
>>>>  drivers/tty/serial/amba-pl011.c | 14 +-------------
>>>>  1 file changed, 1 insertion(+), 13 deletions(-)
>>>
>>> Why is patch 2/7 not cc: stable, when patches 3-7 are?  Either this
>>> patch isn't needed in this series, and can go later (or to a different
>>> branch), or it also needs to be marked for stable as the later patches
>>> depend on it?
>>>
>>
>> 2/7 is really only a cleanup patch that does not provide a bugfix.
>> Should I remove it from this series?
>
> Please do, and send it later, or as part of a separate patch series
> independant of this one.
>

Ok will do so.

BR,
Lino

