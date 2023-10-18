Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBE7CE099
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbjJRPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjJRPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:00:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC9FA;
        Wed, 18 Oct 2023 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697641224; x=1698246024; i=wahrenst@gmx.net;
 bh=GDar9dZjM0ZvuhoK58WEFzyU2IPAt9QK5mAfWpC2khQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZcTQu3x/trrwEsvTI4kkQAzZ6CLra65DvTZ9Qz2xYiAZerayDEHPij6JGoinAIkSbjPwHMf1q1f
 zkCWZ1PRQroxju15eMziFMHOVI3GL/hIEpLW4KFyrR78lI6yMBoFo+sOUiTG7GUGTgvNd7TcANH6j
 8wX158aupJl+oZcn3K/cOnOPTIEFDUPpdAfblOvYVBsj9wVhSllz9UJUwSrdsQM+WTb4mE2IkUVwS
 ct2G1FIxiimjqaxVJ14RAOiUmhM07+TCZPjziowUPc45xseeVtNbi5M5ZJno88CNzy5EdLWfMA+pF
 QvDY1oV6cDcQ75ZmxNoz++LotucKmxPcwtCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1rOu0q1zm0-00chvT; Wed, 18
 Oct 2023 17:00:24 +0200
Message-ID: <53534015-07ab-4d43-8dcb-be3a08ee6339@gmx.net>
Date:   Wed, 18 Oct 2023 17:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Content-Language: en-US
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1697534024.git.sean@mess.org>
 <c826281c0ceab8ce8fcc453a5ce777444349ff9a.1697534024.git.sean@mess.org>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c826281c0ceab8ce8fcc453a5ce777444349ff9a.1697534024.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMFJLpAqXQ6jJOG7cYeOeJ8OxpduwKPNkt11zixVTbuzRPagIJs
 7VHxVL14qyMYdpVzsd7lYy7J+fx090g1aoYLxg1frOHVpxo1/aSq22lVtpw1ipNXEi6gCq+
 EA8vHxRkNTnjg482vruZwP9eHVXb4kqRUungCx9TJ570ztC6GwZlJPa+faCgvlN4petl/36
 o8lD/slvBXUjHgt8knX1w==
UI-OutboundReport: notjunk:1;M01:P0:WOhQHSskp6Y=;m5xvyugjfcMtJR18+ktj9xTeyUU
 5LMVoKQRSrUpMZFXvHp8dsexhJ5wnd6O6jf3WTGfY5dVelqtPO6Zffanli9qVVMtyfdHfyOiq
 U/m/XkXFXgY9iXuQWst/rRnaf1WzVLM3lDJoHVlg6d6k7BLwQxhnQmeVRfvYO1FkejCGb5RlO
 naKPW8FGFhyfwTUijSg9Nv+PSFzeirEBPeNPV4yczl62hsF9oSv28ZWU6/cXt1Pu4QuDN1n/0
 VygRz/bkqJNt6oQdIstPJvgaDlJA/l5pZZAZn4x62TKBYSCyjWmbxLpAPopuyxmpWmVtB7zwG
 yKab3Kd9kmwrorriEdbjjxriqqeyCgp6xUmpAK25RZmGcmo/X6JVv8tT9i8omaSYV+JxBP+NO
 3S9bYFBxgLZEHn78q8ywS62aPRDFqhOXYwwfpb5FC6Jk9x7nEe3GsMQrP2IEBpX8IB6MJGqQG
 0EemSWH8tGc+zELC54VGn6oi1zT/og10+9JzW9m3jOLSwr5K/rRK+LpEHqdd/iFKljotIeGxA
 ft50/JSvR6Kj5J2QxhLBN7i6X9vjwa7vG6wKtpJb+bgZSvOMbKEYHF/YRL/+9DtEdFefJ+IbF
 rEwMixKivPFiuKScZKuVTgKpLeMS+9mZZWQh32dpAc4toqOCGkkUS0ERy94eUUxmCVlhd+39/
 2WTP9W07C6NAYDwct15MY9kjv3+fEHODjr90avlNfkqUGhwVERRhjyV+8FpzanA3HPWvT/oOb
 oz+UV4pbXdoUlubhfLdlo662uz2QBUmqMzGB/4imUQXAA/JSc9j7wHq0MJVbzA4U1mO0oYYjJ
 Oojbmsd/HNkApc8DYVVvzGLNGUaVRnPKoDKNin85qJAyNxvM0NuprVWKz0snljspdY/zmE5JQ
 l917JEWlTR0ItX1PjTyXXOtROxVTkzlmp/ePGaFJHghYwmHwPVvn/yzuA+DswMKg+uKunJTOo
 5mgjQ5DWyRhGPmulETSp5VeVIKo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Am 17.10.23 um 11:17 schrieb Sean Young:
> clk_get_rate() may do a mutex lock. Since the clock rate cannot change o=
n
> an rpi, simply fetch it once.
the driver changes looks good to me, but could you please adapt the
commit message to your recent changes.

Best regards
>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>
