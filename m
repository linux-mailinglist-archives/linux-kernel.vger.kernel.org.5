Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61680E0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbjLLBKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbjLLBJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:09:59 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED7C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:10:04 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231212011002epoutp04d24c5480079bf55fe1fc565e62515f54~f8E47qD7a2877828778epoutp04N
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:10:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231212011002epoutp04d24c5480079bf55fe1fc565e62515f54~f8E47qD7a2877828778epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702343403;
        bh=53SGPNwqJDNwkpSp/kpKMKy0RNs23DJQx/RtIVJ1gj4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=XKEvYUiK348lOYmed/f/ibcOBjhXBwEzEJV/jkERElkSRv9GVjOyAlwRp+724C2/A
         Y7h3dpVOQLEV1/Iy5XRS77Gz6iekK/3eAxwBWv/gsn19EeFiD5DyDTE5KZseHGrVDi
         loAWqas1i+L+V5ktaLPU47NRcFtk1zo/ISZRN+rQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231212011002epcas1p22c116deaee3c252421f7c15498cf98e7~f8E4oKQ9R2269922699epcas1p2p;
        Tue, 12 Dec 2023 01:10:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4Sq0s64LH4z4x9Q8; Tue, 12 Dec 2023 01:10:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4] PM / devfreq: Synchronize
 device_monitor_[start/stop]
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huangzaiyang@oppo.com" <huangzaiyang@oppo.com>,
        CPGS <cpgs@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1296674576.21702343402595.JavaMail.epsvc@epcpadp3>
Date:   Tue, 12 Dec 2023 09:27:02 +0900
X-CMS-MailID: 20231212002702epcms1p6a18b626aee8f700957dbc2855d1711b4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231206105023epcas1p443ebecc35010d2577b86c3fa23e24e45
References: <CGME20231206105023epcas1p443ebecc35010d2577b86c3fa23e24e45@epcms1p6>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2023 2:41 AM, Mukesh Ojha wrote:
> There is a chance if a frequent switch of the governor
> done in a loop result in timer list corruption where
> timer cancel being done from two place one from
> cancel_delayed_work_sync() and followed by expire_timers()
> can be seen from the traces[1].
>
> while true
> do
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "simple_ondemand" > /sys/class/dev=
freq/1d84000.ufshc/governor
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "performance" > /sys/class/devfreq=
/1d84000.ufshc/governor
> done
>
> It looks to be issue with devfreq driver where
> device_monitor_[start/stop] need to synchronized so that
> delayed work should get corrupted while it is either
> being queued or running or being cancelled.
>
> Let's use polling flag and devfreq lock to synchronize the
> queueing the timer instance twice and work data being
> corrupted.

Would you please identify the resources to be protected by this lock
and specify them in the devfreq->lock declaration?
(it seems the list of protected resources is growing, and
we need to track them.)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
