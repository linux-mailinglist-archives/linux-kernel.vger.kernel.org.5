Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529177C5A76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjJKRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJKRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:45:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16593;
        Wed, 11 Oct 2023 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697046298; x=1697651098; i=linosanfilippo@gmx.de;
 bh=UVwy6rGjkkRmwuK46ZAz8hsnVp71vE+KNQWIQjAfHBQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=BGNTrv9k/GzG77rpEzJEdxVTIN3NdGER1o2ZZ9OSM3llah5UWLAK7XmpTDW2XZq1xEpTf6GcRUH
 AK+mP4jDss3ZibbvQzGdZjYi9+qylHwSnxkmxgjql4S1ie6ts4NWbRA/T0hVpxu/jGS3kNziAErjU
 FVsGJ6E0hKtMKjoOAyLrav9yhN05tPuIWnL3fBjVXUl2796g6vtFTVkVtRTFW9SRBcaKbGzplRBHn
 9QpzGFoBYiGlcjqUKaHzHJq8auk5qJyQh7efoo+tztwSrD4cyZeqvO+6iVwqPvACTEWSpla/LN+ZN
 MdCWo1TqUmD4TcBJpLMgzrgNM1823A9HdC7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1rhDv019m4-00r0rC; Wed, 11
 Oct 2023 19:44:58 +0200
Subject: Re: [PATCH v2 2/7] serial: amba-pl011: get rid of useless wrapper
 pl011_get_rs485_mode()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
 <20231011173829.10508-3-l.sanfilippo@kunbus.com>
 <2023101134-theater-oversleep-a58b@gregkh>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <20d22e11-b9be-b547-ec4e-9964a57924a4@gmx.de>
Date:   Wed, 11 Oct 2023 19:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2023101134-theater-oversleep-a58b@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u8B74tV49e9+gaS44twA10TgbsUMqVsAaC1TznkmpYCf9jnOjej
 cN3th8iNGHBuH444Wtr8ts/0hKAAPBHafXfoM7jloxOKomKbOTolVuXHj5emdP85DSNgmyx
 EvekJ2vEHFd0a1bxlJSlqun7O/fxy9zC9jhd9FPh9a7KKub1xrJPKyfqmVcYQ8AlYM6mXu8
 G4fiALXCsf2EBaqRp7L4g==
UI-OutboundReport: notjunk:1;M01:P0:Hjmy0vdrhM4=;lCtslM8a4Xh0e5FLhh4FRudlg9E
 2zL5H5QMHijoG5dK8WLTjDyQSoUeJpH58O+7bB3e2zGZ1myHc9AIJKYAZ8p+5fNdw/R2PzZid
 ael+5bhm3jShdm/YUGh5jaSii9FayOjBUfSxFLe6SkiVeK6MlCq94NRs3cKdq+mQaG6zZC2o7
 El/soumIB33UexP0SMkUygZHGiv/KIwsWfV3pjb7++uHL5RiUu07lwCbIX48t9FiIA8JW7hhe
 6uyqKkNYQTJhk3tuZrDsufytNjaJQYY5JetBGAJu0oa4HrxdQIYtgS0F3aW7Ee/luc95MYCMX
 mL4kD7bv7zgD+/1cov6ZxeS+Hqlia08zaq66CTZ3+38dnSvOI7WrN5Rh0gSpCw9MVID8dDmAM
 ih9cKR470sgjLshr3PASsofc15yywYg9W1Pwfql1Plz8HV64/Bb249mC7CGSjLcj3uJdhIZP+
 yvHS7LTnZDvXGyYlq4aLVDS2O0jfUTuJoTYfE2pxQi5oF+zeBy/bciXD8UlHUHt+O714tnYnq
 UT+B35wFIaOTm10PVDRtb8yiC621Xf1H22YzEkSvy0Al2zcBCz2HtbYldBlwZjYQwoN/x/zQh
 eQDCGGMS3F29MBAx6gYkqJ+AaRm1ClsvgN6I5DXbuAWk/X78SiIGVVIGH4nWzOLdLNgDfxI8C
 crKoPDD4GGsamxJiRK+L4kq/pQ+7gNtq77/CCrvNcQRcrw6/pgVLRzfKG1wSxDzHJna9gzTDS
 k5RUi/cfWTw5sPID9qm5zmbeLXYkJccIa7FBFfsxDmryJn4PPDOgCl5mK3gKIyRFz0RUf/Zi6
 y64HXGKWOOUlcNMtpExFLW2KwznXnX1rjRDn0H+6qnwT3feL9UIGydGwbAt9SC/VCEYOdAJds
 EKYt7Om7/54um9zAfz7q7ryEbmHr1PlMk2rGgJDVmxPmWEVmfJqgivbol1C/E5vvZ9W41I0it
 rCYDfA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 11.10.23 at 19:42, Greg KH wrote:
> On Wed, Oct 11, 2023 at 07:38:24PM +0200, Lino Sanfilippo wrote:
>> Due to earlier code changes function pl011_get_rs485_mode() is now mere=
ly
>> a wrapper for uart_get_rs485_mode() which does not add any further
>> functionality. So remove it and instead call uart_get_rs485_mode()
>> directly.
>>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> Why is patch 2/7 not cc: stable, when patches 3-7 are?  Either this
> patch isn't needed in this series, and can go later (or to a different
> branch), or it also needs to be marked for stable as the later patches
> depend on it?
>

2/7 is really only a cleanup patch that does not provide a bugfix.
Should I remove it from this series?

Regards,
Lino



