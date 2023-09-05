Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1C792892
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjIEQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353730AbjIEHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:42:15 -0400
Received: from mx2.spacex.com (mx2.spacex.com [192.31.242.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946531A8;
        Tue,  5 Sep 2023 00:42:11 -0700 (PDT)
Received: from pps.filterd (mx2.spacex.com [127.0.0.1])
        by mx2.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3857ehrr002119;
        Tue, 5 Sep 2023 00:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=dkim; bh=Fe2kVIqYuP87NBZP7GEV+E/4WDl2D8+n1T4Yzpbk7rY=;
 b=ixYmNHf8MWo9WWg9d2AkkRkSgz8uQGcomhyfRIA5864YwhHY+ieiAu4CzUmPcVzfLvwo
 01hJx7XpZpJT+YUM9qgxKRap9qW6tWadUcT87wl5056u+GbmAWdYfBb7mUIyThToEppI
 L8tvVppZGYslNqfxlllcssWueXCFJ8PUSmMD7aO5XWzf67EQby/VZXv6lX/qRcgzTm+V
 Bwem+HbeX273mcMT+x4DrC1F6Ppr3wNTK7kXM3opru9f4SWgOrlpp1ElK071WvaP5ZOg
 t62u2D/fsrYgLnjjrYftgKpAlgAhCO1gxjyiuOdELauiv0EgbI37PxJVDWbEj3vLsZFo Cw== 
Received: from smtp.spacex.corp ([10.34.3.233])
        by mx2.spacex.com (PPS) with ESMTPS id 3sv2fgkd8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Sep 2023 00:41:37 -0700
Received: from spacex.com (10.1.32.161) by HT-DC-EX-D2-N1.spacex.corp
 (10.34.3.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Sep
 2023 00:41:37 -0700
Date:   Tue, 5 Sep 2023 00:41:37 -0700
From:   Andy Spencer <aspencer@spacex.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Bosien <kbosien@spacex.com>,
        Jim Gruen <jgruen@spacex.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RFC: iio: lsm6dsx: Support temperature channel on
 some devices
Message-ID: <20230905074137.GB10702@spacex.com>
References: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
 <ZPBa40RHJ93proj0@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPBa40RHJ93proj0@lore-desk>
X-ClientProxiedBy: ht-dc-ex-d1-n2.spacex.corp (10.34.3.231) To
 HT-DC-EX-D2-N1.spacex.corp (10.34.3.233)
X-Proofpoint-ORIG-GUID: pa2NSxCAJI-fXhH5FaYlmeCpNT_8wUF9
X-Proofpoint-GUID: pa2NSxCAJI-fXhH5FaYlmeCpNT_8wUF9
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=966
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Thanks for reviewing this!

Regarding the TODR and ODR_T_BATCH settings:

> > +			[ST_LSM6DSX_ID_TEMP] = {
> > +				/*
> > +				 * NOTE: this ODR will be capped and controllerd by the
> > +				 * gyro and accelerometer don't have any reg to configure
> > +				 * this ODR.
> > +				 */
> > +				.odr_avl[0] = {  12500, 0x01 },
> > +				.odr_avl[1] = {  26000, 0x02 },
> > +				.odr_avl[2] = {  52000, 0x03 },
> > +				.odr_len = 3,
> 
> please consider we do not support low-power mode iirc (just
> high-performance - bit 4 in CTRL6_C (15h)), so even enabling accel
> sensor, the temp sensor will always runs at 52Hz. Here we should add
> just one entry, like:
> 
> 				.odr_avl[0] = { 52000, 0x03 },
> 				.odr_len = 1,

I didn't see a way to configure the batch data rate in the IIO driver
aside from the "odr_avl" table.

It seemed useful to allow reading the gyro/accel at a high rate, such as
416 Hz, while still allowing the lower temperature sub-sampling rates of
1.6 and 12.5 Hz. My original intent in adding the lower ODR table
entries here was to reuse the sampling_frequency sysfs attr to
configure the batch data rate, since that seems to be what most people
would care about.

Alternately, we could add a separate "odr_batch_avl" table along with a
separate sysfs attr (e.g. "buffer_sampling_frequency"). That would be a
lot more work though, especially since the actual ODR for the temp
sensor won't be configurable anyway.

Note, I don't have any specific need for the lower rates, so if 52 Hz is
the only rate supported, that still "works for me".
