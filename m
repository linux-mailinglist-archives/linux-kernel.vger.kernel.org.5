Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2127929E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354293AbjIEQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353714AbjIEH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:29:16 -0400
X-Greylist: delayed 1699 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 00:29:13 PDT
Received: from mx1.spacex.com (mx1.spacex.com [192.31.242.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2612A;
        Tue,  5 Sep 2023 00:29:13 -0700 (PDT)
Received: from pps.filterd (mx1.spacex.com [127.0.0.1])
        by mx1.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3856mRwG024661;
        Tue, 5 Sep 2023 00:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=dkim; bh=cq23JOlHgu5rbK1y8IOKTZCBV67iU0GG+0pR+xzjC70=;
 b=QZg0ONkZ4E7pUbbCYrsoh6pe7J9yxNfeTgYYiCerjlg/bC0/ZOnk2aG0HTiNC04kS5y1
 3hEpgQMkcIgAWrjnuQ/bEo1rzQ3HiMqmPnhDlsx5TawS/kq9DvBNsmmNJEaF1hhnQtYX
 iEi3DnmaoIuhP5+m7jOj/c1CuaOkk2Rxspr1cJwCThMIZW4sEmP5JvNhmeJO3HO19QaJ
 Czu4/TGJcAxvKNHPn7NcDv3ZF9cP5uGW7hhfI1Ig9/19tRf5qzHRg/kSQfgCeZasKUMQ
 H/ffqWLtlwm7Q+r3UmlJJ55vSkbII6060ZoSzvxc5q1svptzoFOb2uytiKulZ+uhQQDR pA== 
Received: from smtp.spacex.corp ([10.34.3.233])
        by mx1.spacex.com (PPS) with ESMTPS id 3sv2fgkwgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Sep 2023 00:00:20 -0700
Received: from spacex.com (10.1.32.161) by HT-DC-EX-D2-N1.spacex.corp
 (10.34.3.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Sep
 2023 00:00:20 -0700
Date:   Tue, 5 Sep 2023 00:00:10 -0700
From:   Andy Spencer <aspencer@spacex.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Kevin Bosien <kbosien@spacex.com>, Jim Gruen <jgruen@spacex.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RFC: iio: lsm6dsx: Support temperature channel on
 some devices
Message-ID: <20230905070010.GA10702@spacex.com>
References: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
X-ClientProxiedBy: ht-dc-ex-d3-n1.spacex.corp (10.34.3.236) To
 HT-DC-EX-D2-N1.spacex.corp (10.34.3.233)
X-Proofpoint-GUID: KB-a4pQQh9igq_YYGD7iljXL0vDjqAlF
X-Proofpoint-ORIG-GUID: KB-a4pQQh9igq_YYGD7iljXL0vDjqAlF
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for helping get this into mainline :)


> Changes in v2:
> - Put to RFC because I can't test changes.
> - Added some mail addresses to SpaceX to the header. Maybe you
>   guys can check if this works for you. Or forward to designated
>   open source ambassador or whatever can help. (Addresses found
>   in SpaceX code drop.)

I am familiar with these changes and can help review and test this.


> - Drop the code with strings for ism330dhc as we concluded that
>   this is probably ism330dhcx which is already supported.
>   (Would be nice if SpaceX can confirm.)

I believe we did use the ism330dhc a long time ago but have since
switched to the ism330dhcx. The register maps are compatible, so the old
name stuck around. Adding support for ism330dhcx only is fine.


> - Don't write in nonsense register 0x0a for temperature sensor
> - More elaborate code to just avoid writing ODR for the temperature
>   sensor and instead rely on gyro or accelerometer to drive
>   the odr

OK, we only use this in batch mode, I'll confirm that removing this
write (for non-batch mode) works as expected.


> +				/*
> +				 * NOTE: this ODR will be capped and controllerd by the
> +				 * gyro and accelerometer don't have any reg to configure
> +				 * this ODR.
> +				 */
> +				.odr_avl[0] = {  12500, 0x01 },
> +				.odr_avl[1] = {  26000, 0x02 },
> +				.odr_avl[2] = {  52000, 0x03 },
> +				.odr_len = 3,

As per the other thread, the data rate should be 1600, 12500, and 52000.


> +		/*
> +		 * The temperature sensor has a fixed scale and offset such
> +		 * that: temp_C = (raw / 256) + 25
> +		 */
> +		sensor->gain = 3906;
> +		sensor->offset = 25;

I believe the gain should be set to 3906250 now (1e9 / 256). 3906 was an
approximation from an older kernel that used IIO_VAL_INT_PLUS_MICRO
instead of IIO_VAL_INT_PLUS_NANO.

Also in st_lsm6dsx_alloc_iiodev(), I believe we can/should avoid setting
available_scan_masks, the mask (0x7) isn't really valid for the
temperature sensor that has only one channel.
