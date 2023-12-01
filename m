Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D3800281
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377302AbjLAE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAE1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:27:02 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB281711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:27:06 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231201042705epoutp044f627e45d9b10b8c083f683925d15776~cmqyNUQ_N3196531965epoutp04P
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:27:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231201042705epoutp044f627e45d9b10b8c083f683925d15776~cmqyNUQ_N3196531965epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701404825;
        bh=rDUID7+wO8S6gDUwBZrAJ/Mf3Fc0sfmHHhUiK0Rejpc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=lLIRT4wRyeupUiRtuz+wtXo9McneedrlSCWziSPXTYRQv1gwiLNDpgUJvuwLFAsKq
         0f6jVqDiBVVW2cD3DwxsF0s5J0AOEugAuLRJ3OIQ3awe2voLFoH9+NaRefItHfuSm+
         2jnC7wHu9aO2CBuWjcB2M7aQcDbTQiN2UB8/sjuY=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231201042704epcas5p4f1b57dad7ec41e7193fb03eb01cd9f18~cmqx8PM7c2676726767epcas5p4e;
        Fri,  1 Dec 2023 04:27:04 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-0e-656960980477
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.8B.10009.89069656; Fri,  1 Dec 2023 13:27:04 +0900 (KST)
Mime-Version: 1.0
Subject: Re[4]: [PATCH] input: gpio-keys - optimize wakeup sequence.
Reply-To: abhi1.singh@samsung.com
Sender: Abhishek Kumar Singh <abhi1.singh@samsung.com>
From:   Abhishek Kumar Singh <abhi1.singh@samsung.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231201042704epcms5p5663a96562d942fa226235dba6e40cd15@epcms5p5>
Date:   Fri, 01 Dec 2023 09:57:04 +0530
X-CMS-MailID: 20231201042704epcms5p5663a96562d942fa226235dba6e40cd15
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCmhu6MhMxUg3292haHF71gtLj56Rur
        xeVdc9gs/u/ZwW5x4s8mZgdWj52z7rJ7bFrVyebRt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GcdnTmQumBlYcb75FksDY49/FyMnh4SAiUTDjNksXYxcHEICuxklvkzYydTFyMHBKyAo8XeH
        MEiNsICLxO7XG1lAbCEBRYlFczqYIeJmEpvvvmMEKWcDmrNiOw9IWEQgSeLTzh42kJHMAusZ
        JS58+s0GsYtXYkb7UxYIW1pi+/KtjBC2qMTN1W/ZYez3x+ZDxUUkWu+dZYawBSUe/NzNCNP7
        /cAtqJn1Eqe+TwC7X0Kgh1Fi3txPUAvMJc786gGzeQV8Jc6f+8YMciiLgKpE7zeomS4SN/fd
        AJvJLKAtsWzha7ASZgFNifW79CHCfBK9v58wwZy/Yx6MrSqx/+w/ZphzdkxaBXW+h8S/p0fZ
        QMYICQRK9LzUmcAoNwsRnrOQ7JqFsGsBI/MqRsnUguLc9NRi0wKjvNRyveLE3OLSvHS95Pzc
        TYzgpKDltYPx4YMPeocYmTgYDzFKcDArifBef5qeKsSbklhZlVqUH19UmpNafIhRmoNFSZz3
        devcFCGB9MSS1OzU1ILUIpgsEwenVAMTV+XXVnd70UVz2L4fZpg2Y/33KjehfJPzfr+bT64N
        PPp9Ranx9YQFB/T/9kvKtj5pOrdx4m3t9tld8VZibFM8N2aLWeo+CDFsdH/7zklt9/Rg65J9
        j46YTfHi3tspsE1wuq+c+3feVR3qDb1M2y7d0j2cpcu0ee+ipP8RxnlOwb1Pnn67x3Ersvfo
        9dOTFSX3h0wp3DF5ovzK+YJM6d5H6gL+erNEqfvdt3SRDb67pPHD7zUJZzf5f5nivrWtzqpi
        2yovz093eeMfrjCzcK5N3SebeMSp7/7iHbn8F/fdOFwXoT3lp84daa6rx9j65PW//ZnLbla0
        +5rAEvPcxSLBQYvfH2xWCav/dCHx3JXZSizFGYmGWsxFxYkAEsbgI3kDAAA=
X-CMS-RootMailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
References: <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p5>
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

Dear Dmitry,=C2=A0=0D=0AGreetings=21=21=0D=0A=C2=A0=0D=0ACould=20you=20plea=
se=20help=20to=20review=20and=20update=20on=20this?=0D=0A=0D=0A=0D=0AThanks=
=20and=20Regards,=0D=0AAbhishek=20Kumar=20Singh=0D=0ASr.=20Chief=20Engineer=
,=0D=0ASamsung=20Electronics,=20Noida-India=0D=0A=0D=0A=C2=A0=0D=0A--------=
-=20Original=20Message=20---------=0D=0ASender=20:=20Abhishek=20Kumar=20Sin=
gh=20<abhi1.singh=40samsung.com>System=20Power=20Part=20/SRI-Noida/Samsung=
=20Electronics=0D=0ADate=C2=A0=20=C2=A0:=202023-11-07=2013:59=20(GMT+5:30)=
=0D=0ATitle=C2=A0=20:=20Re=5B2=5D:=20=5BPATCH=5D=20input:=20gpio-keys=20-=
=20optimize=20wakeup=20sequence.=0D=0A=C2=A0=0D=0ADear=20Dmitry,=C2=A0=0D=
=0A=0D=0AGreetings=21=21=21=0D=0A=0D=0AThank=20you=20so=20much=20for=20your=
=20response.=0D=0A=0D=0AI=20checked=20in=20detailed=20again=20and=20observe=
d=20the=20below=20points,=20please=20help=20to=20review=C2=A0=0D=0Aand=20ap=
prove=20it.=0D=0A=0D=0A=0D=0A=0D=0AThere=20is=20ISR=20=22gpio_keys_gpio_isr=
=22=20which=20is=20called=20when=20the=20key=20state=20is=201=20i.e.=C2=A0=
=0D=0Akey=20pressed.=0D=0ATherefore=20modified=20code=20will=20not=20impact=
=20on=20the=20existing=20driver=20code.=0D=0A=0D=0A//For=20key=20pressed=20=
event:=0D=0A<3>=5B=C2=A0=20549.180072=5D=20I=5B0:=C2=A0=20=C2=A0=20=C2=A0=
=20swapper/0:=C2=A0=20=C2=A0=200=5D=20gpio_keys_gpio_isr=0D=0A<3>=5B=C2=A0=
=20549.196126=5D=C2=A0=20=5B1:=C2=A0=20=C2=A0=20kworker/1:1:=C2=A0=20=C2=A0=
78=5D=20gpio_keys_gpio_work_func=0D=0A<3>=5B=C2=A0=20549.196198=5D=C2=A0=20=
=5B1:=C2=A0=20=C2=A0=20kworker/1:1:=C2=A0=20=C2=A078=5D=20gpio-keys=20soc:g=
pio_keys:=20gpio_keys_gpio_report_event=20key=20=3D=20115,=20value=20=3D=20=
1=0D=0A=0D=0A=0D=0A=0D=0APerformance:=0D=0A=0D=0AI=20have=20calculated=20th=
e=20differece=20between=20entry=20&=20exit=20time=C2=A0=0D=0Awith=20modifie=
d=20and=20without=20modified=20code=20and=20observed=20that=C2=A0=0D=0A0.3m=
s=20extra=20computation=20time=20in=20current=20scenario=20in=20each=20entr=
y/exit=20time.=0D=0A=0D=0ABecause=20below=20APIs=20will=20not=20be=20called=
=20in=20every=20resume=20functions:=0D=0A=0D=0A1.=20static=20void=20gpio_ke=
ys_report_state(struct=20gpio_keys_drvdata=20*ddata)=0D=0A2.=20static=20voi=
d=20gpio_keys_gpio_report_event(struct=20gpio_button_data=20*bdata)=0D=0A3.=
=20gpiod_get_value_cansleep(bdata->gpiod);=0D=0A4.=20input_event(input,=20t=
ype,=20*bdata->code,=20state);=0D=0A5.=20input_sync(input)=0D=0A=0D=0ASo=20=
we=20can=20save=200.3ms=20computation=20time,=20resume=20operations=20will=
=20faster=20and=20save=20battery=20as=20well.=0D=0A=0D=0A=0D=0A=0D=0AWith=
=20changes:=0D=0A=0D=0ALine=C2=A0=20=C2=A0311960:=2007-18=2016:50:09.359=C2=
=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=
=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20exit=202=
023-07-18=2011:20:37.573207725=20UTC=0D=0ALine=C2=A0=20=C2=A0312626:=2007-1=
8=2016:50:42.123=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=
=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_repo=
rt_state=20enrty=202023-07-18=2011:22:20.503579404=20UTC=0D=0ALine=C2=A0=20=
=C2=A0312627:=2007-18=2016:50:42.123=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=
=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=
=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2011:22:20.503656644=20=
UTC=0D=0ALine=C2=A0=20=C2=A0313301:=2007-18=2016:52:24.182=C2=A0=20root=C2=
=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0B=
inder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20enrty=202023-07-18=20=
11:22:33.865626325=20UTC=0D=0ALine=C2=A0=20=C2=A0313302:=2007-18=2016:52:24=
.182=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=
=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20=
exit=202023-07-18=2011:22:33.865724502=20UTC=0D=0ALine=C2=A0=20=C2=A0313572=
:=2007-18=2016:52:35.111=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=
=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_=
keys_report_state=20enrty=202023-07-18=2011:22:37.678468979=20UTC=0D=0ALine=
=C2=A0=20=C2=A0313573:=2007-18=2016:52:35.111=C2=A0=20root=C2=A0=20=C2=A0=
=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:699_1:=
20972=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2011:22:37.6785=
66167=20UTC=0D=0ALine=C2=A0=20=C2=A0314209:=2007-18=2016:52:43.598=C2=A0=20=
root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=
=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20enrty=202023-0=
7-18=2011:23:05.925340634=20UTC=0D=0ALine=C2=A0=20=C2=A0314210:=2007-18=201=
6:52:43.598=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=
=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_s=
tate=20exit=202023-07-18=2011:23:05.925439384=20UTC=0D=0A=0D=0A=0D=0AWithou=
t=20changes:=0D=0A=0D=0ALine=C2=A0=20=C2=A0372095:=2007-18=2016:10:24.250=
=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=
=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=20exit=
=202023-07-18=2010:43:38.592548979=20UTC=0D=0ALine=C2=A0=20=C2=A0372344:=20=
07-18=2016:13:45.439=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=
=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_key=
s_report_state=20enrty=202023-07-18=2010:44:11.589164226=20UTC=0D=0ALine=C2=
=A0=20=C2=A0372346:=2007-18=2016:13:45.439=C2=A0=20root=C2=A0=20=C2=A0=20=
=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:181=
37=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2010:44:11.5895149=
55=20UTC=0D=0ALine=C2=A0=20=C2=A0372573:=2007-18=2016:14:13.414=C2=A0=20roo=
t=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=
=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=20enrty=202023-07-1=
8=2010:44:22.606227138=20UTC=0D=0ALine=C2=A0=20=C2=A0372575:=2007-18=2016:1=
4:13.414=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=
=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=
=20exit=202023-07-18=2010:44:22.606490107=20UTC=0D=0ALine=C2=A0=20=C2=A0372=
944:=2007-18=2016:14:26.732=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=
=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gp=
io_keys_report_state=20enrty=202023-07-18=2010:44:29.024121927=20UTC=0D=0AL=
ine=C2=A0=20=C2=A0372946:=2007-18=2016:14:26.732=C2=A0=20root=C2=A0=20=C2=
=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:702=
_2:18137=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2010:44:29.0=
24528958=20UTC=0D=0ALine=C2=A0=20=C2=A0373181:=2007-18=2016:14:30.790=C2=A0=
=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=
=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=20enrty=20202=
3-07-18=2010:44:30.904866770=20UTC=0D=0ALine=C2=A0=20=C2=A0373183:=2007-18=
=2016:14:30.790=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=
=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_repo=
rt_state=20exit=202023-07-18=2010:44:30.905126353=20UTC=0D=0A=0D=0A=0D=0A=
=0D=0A=0D=0AThanks=20and=20Regards,=0D=0AAbhishek=20Kumar=20Singh=0D=0ASr.=
=20Chief=20Engineer,=20Samsung=20Electronics,=20Noida-India=0D=0A=0D=0A=0D=
=0A=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASender=20:=
=20dmitry.torokhov=40gmail.com=20<dmitry.torokhov=40gmail.com>=0D=0ADate=C2=
=A0=20=C2=A0:=202023-10-29=2007:42=20(GMT+5:30)=0D=0ATitle=C2=A0=20:=20Re:=
=20=5BPATCH=5D=20input:=20gpio-keys=20-=20optimize=20wakeup=20sequence.=0D=
=0ATo=20:=20Abhishek=20Kumar=20Singh<abhi1.singh=40samsung.com>=0D=0ACC=20:=
=20robh=40kernel.org<robh=40kernel.org>,=20linux-input=40vger.kernel.org<li=
nux-input=40vger.kernel.org>,=20linux-kernel=40vger.kernel.org<linux-kernel=
=40vger.kernel.org>,=20SRI-N=20IT=20Security<sri-n.itsec=40samsung.com>=0D=
=0A=C2=A0=0D=0AHi=20Abhishek,=0D=0A=0D=0AOn=20Thu,=20Oct=2026,=202023=20at=
=2011:23:20AM=20+0530,=20Abhishek=20Kumar=20Singh=20wrote:=0D=0A>=20Dear=20=
Mr.=20Dmitry,=0D=0A>=20Greetings=21=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=20The=
=20patch=20removes=20unused=20many=20APIs=20call=20chain=20for=20every=20su=
spend/resume=20of=20the=20device=C2=A0=0D=0A>=20if=20no=20key=20press=20eve=
nt=20triggered.=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=20There=20is=20a=20call=20=
back=20function=20gpio_keys_resume()=20called=20for=0D=0A>=20every=20suspen=
d/resume=20of=20the=20device.=20and=20whenever=20this=20function=20called,=
=20it=20is=0D=0A>=20reading=20the=20status=20of=20the=20key.=20And=20gpio_k=
eys_resume()=20API=20further=20calls=20the=0D=0A>=20below=20chain=20of=20AP=
I=20irrespective=20of=20key=20press=20event=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A=
>=20APIs=20call=20chain:=0D=0A>=20static=20void=20gpio_keys_report_state(st=
ruct=20gpio_keys_drvdata=20*ddata)=0D=0A>=20static=20void=20gpio_keys_gpio_=
report_event(struct=20gpio_button_data=20*bdata)=0D=0A>=20gpiod_get_value_c=
ansleep(bdata->gpiod);=0D=0A>=20input_event(input,=20type,=20*bdata->code,=
=20state);=0D=0A>=20input_sync(input);=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=20T=
he=20patch=20avoid=20the=20above=20APIs=20call=20chain=20if=20there=20is=20=
no=20key=20press=20event=20triggered.=0D=0A>=20It=20will=20save=20the=20dev=
ice=20computational=20resources,=20power=20resources=20and=20optimize=20the=
=20suspend/resume=20time=0D=0A=0D=0AUnfortunately=20it=20also=20breaks=20th=
e=20driver=20as=20button->value=20does=20not=20hold=0D=0Athe=20current=20st=
ate=20of=20the=20GPIO=20but=20rather=20set=20one=20via=20device=20tree=20so=
=20that=0D=0Athe=20driver=20can=20use=20that=20value=20when=20sending=20EV_=
ABS=20events.=20So=20with=0D=0Atypical=20GPIO-backed=20keys=20or=20buttons=
=20you=20change=20results=20in=20no=20events=0D=0Areported=20on=20resume.=
=0D=0A=0D=0AI=20also=20wonder=20what=20kind=20of=20measurements=20you=20did=
=20on=20improvements=20to=0D=0Asuspend/resume=20time=20with=20your=20change=
.=0D=0A=0D=0AThanks.=0D=0A=0D=0A--=C2=A0=0D=0ADmitry=0D=0A=0D=0A=C2=A0=0D=
=0AThanks=20and=20Regards,=0D=0A=C2=A0=C2=A0=0D=0A=C2=A0=0D=0AThanks=20and=
=20Regards,=0D=0A=C2=A0=C2=A0=0D=0A=C2=A0=0D=0AThanks=20and=20Regards,
