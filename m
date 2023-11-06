Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089AB7E1979
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFE5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFE5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:57:03 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DCDB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:56:59 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231106045656epoutp04f1e298224696fb6dae42e786c474908a~U78uEsVvq0227402274epoutp04Q
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:56:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231106045656epoutp04f1e298224696fb6dae42e786c474908a~U78uEsVvq0227402274epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699246616;
        bh=U6dPunAvDzVzWi+zjo0PCpXXGdDnO7ZKG0lsfwYdOes=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=CDRqZkm+vtEy+Dx69rx0PJsUE8esHPWV1Ea8rYxOiy5DdI+QLXbdzAEC+vSzel4Om
         sGIcn6pi/WccrI42DmAxQ6c/ToPU53I9VztpmAgKgdZ05wnADbU6SFUWk0AuIBfOw7
         8q+DXaev7Ezm2bOjWswHjpzV6KF0ypCAURiiyUXQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231106045656epcas2p29f138f0ce57a4c06f0bd3c9fa73943e8~U78tgk2lz1969019690epcas2p2G;
        Mon,  6 Nov 2023 04:56:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SNzbW2jjqz4x9Pw; Mon,  6 Nov
        2023 04:56:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.93.09607.71278456; Mon,  6 Nov 2023 13:56:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231106045654epcas2p34971ed3410694e727c35d820bd9817b5~U78sORkPj2690626906epcas2p3J;
        Mon,  6 Nov 2023 04:56:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231106045654epsmtrp146b139409a50a27fd7b45bbca963ce44~U78sNdRnu3251632516epsmtrp1S;
        Mon,  6 Nov 2023 04:56:54 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-99-654872179d15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.70.08817.61278456; Mon,  6 Nov 2023 13:56:54 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231106045654epsmtip2d4fdad3f7ba3b45ff35315ac7860b26c~U78sArych1106411064epsmtip2q;
        Mon,  6 Nov 2023 04:56:54 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <kwangwon.min@samsung.com>,
        <kwmad.kim@samsung.com>, <sh425.lee@samsung.com>,
        <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
        <cpgs@samsung.com>
In-Reply-To: <633b3970-ddd4-4dc6-b586-96ecc5b86456@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: core: Process abort completed command in
 MCQ mode
Date:   Mon, 6 Nov 2023 13:56:54 +0900
Message-ID: <028001da106d$a9ac9330$fd05b990$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/NadRec19V/jm3RVDFrtg0RqXhwIoHnBGAuFKLQkCpak+jQLnFFpSr0kiZdA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTdxj21zvLgZbcahk/m4U1p9kCFWiRwsFg6FbNBRhhOnUu2cqNXgr2
        69Irhm2Z1oUClkU+zFwsY5kkw404cBWRASZYGQwKWuOIDJDgNgjlawVjlw4xo7Ru/Pe8z/u8
        eZ/n94Ehwl6+GCs2mBmTgdYR/Ai0/XYsGR9tohiZ3x5JTn3dzic9/hE+eevRWZS84PUjpMcZ
        SzaOtvPI66M/oeRvbT+j5P3Or/hk1YMOPnm5/xmP/GK2P4y0PRwF5LfPFtF9kdT9X3OomsYe
        QP3dWsmnlqfHUKq2+xR1rq0ZUI8dMVRFTxUvH3tPm1HE0GrGJGEMhUZ1sUGTSeQcVr2pUqTI
        5PHyNDKVkBhoPZNJKHPz4w8W69ZdE5KTtK5kncqnOY5IfD3DZCwxM5IiI2fOJBhWrWNT2QSO
        1nMlBk2CgTGny2WyJMW6sEBbdObqp+xoQmnj46dhFvCX1AbCMYgnw6aRLxEbiMCEeAeA1pG7
        W4PFCoADHRVosPABuNA1hT4fWXIthFQ3ARy5eCOk8gD46KkfBFR8PA5WL7bxAw0RXobAuam2
        sEAjHH8Nrv6zhgTwDvwonPT38WwAw1B8N2xxHQrQAjwN/u68CoL4BThw8c+NzQguhU2X5pGg
        Cwn0TzdtDWARngedcxYQ1Ihg/dnyjUAQd2Nw1novNKCEfS3WEN4B5/qDfiAuhp7q8hDWwjPd
        P4RwKWy4dh4E8V5on6kAAZ8IHgtbOxMDEOK7YO9YyFokrLy9FpoUQMuPq2FBiQBWlguDNAGH
        GsZDNIS36nU1gLBvymjflNG+KYv9/7XfALQZvMiwnF7DcEls8n9XXWjUO8DGc46jOkD9ojfB
        CXgYcAKIIYRIsJZFMUKBmv7oY8ZkVJlKdAznBIr1Q69FxFGFxvX/YDCr5MlpsuSUFHlqkkKW
        SkQLJq0NaiGuoc2MlmFYxvR8joeFiy28Kkv0wBPPO3f1bPm4O0Nf8+6RY/Pam5NlbLpPnpfx
        veSBe9qbvcUrpyuUlzwOZatQDSLqZGzBYeU1d+TQuezlJ129H3oP1cmYldxOX9R1xWDpVBfu
        3rJ0px0Z9tkNJwqZVxzbVD3jZK3sdJ5rouHluivLD49OjEmThdLtnyzsLKo8vse9X1slsb+1
        dnwy59V7g0v7brRkDe4f1sy4Vj6b0LzRXHbh5Afv/2I44HPGLObtWVVUc/jbu9GZqEHxQMfB
        O+kF0bWOXdaXhh0HmmynFNkpfUOfD+SMbVMUd2s0q6L8Y7mnE/tjXJP9f8xerhbPfdeuy9qp
        237FJj1xZF60l0C5Iloeh5g4+l+Bo7MrVwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvK5YkUeqwZQDOhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYtGNbUwWW2/sZLG4ueUoi8XlXXPYLLqv72CzWH78H5PF1BfH2S26
        7t5gtFj67y2LA5/H5SveHhMWHWD0+L6+g83j49NbLB4T99R59G1ZxejxeZOcR/uBbqYAjigu
        m5TUnMyy1CJ9uwSujLv35rAVNCpX3F66nrmB8at0FyMnh4SAicS7029Yuxi5OIQEdjNKrOtc
        wA6RkJD4v7iJCcIWlrjfcgSq6DmjxJW5t1hBEmwCWhL9b7ewgSREBKYwS3xYuJ4Zomo6k0Tj
        pR1sIFWcAtYSv3/9ZQaxhQVCJLY2rgIay8HBIqAise50EEiYV8BS4tGhDYwQtqDEyZlPWEBs
        ZgFtiac3n8LZyxa+Zoa4SEHi59NlYEeICPhJHHrVwAhRIyIxu7ONeQKj0Cwko2YhGTULyahZ
        SFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkstrR2Me1Z90DvEyMTBeIhR
        goNZSYT3r71HqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTByc
        Ug1M2csz3rTsbju8m+HQjHNXJ7CenJ4cPz/3as/iCdFPu2XmS2ftCOGdvV/MP/q4B2OCUvqT
        Az4rzsR1Wi7w8v6isnlFTeUfpt1CdcLrtwXeD9isfaB55dbXvUm5+pKz4lnTRPLUjRKub5q0
        vWF3lmK/l8ysK68CE2ablhv+CZZVMf766F1+qonAsp0VN3XSMrQNrqvNtO0/ef60U95sju7o
        Pa28E8W4alh7NGbu116exjN98pf5bA9iH85l6VC471Q+d1f8tb58/gybn1tl9yYcOFsq3llS
        9uPstz09ykXFsmJbYyKnFu1LUZslyna8YFOs4LnouZflFVxv6WxOXKJmJNjyxl9/xURNqUkR
        U9iUWIozEg21mIuKEwFLPJLSOgMAAA==
X-CMS-MailID: 20231106045654epcas2p34971ed3410694e727c35d820bd9817b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519
References: <CGME20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519@epcas2p3.samsung.com>
        <20231101084504.79087-1-hy50.seo@samsung.com>
        <e1ed8776-d8ad-49f2-bf8f-2759256e33e9@acm.org>
        <000001da0d42$1a1c8410$4e558c30$@samsung.com>
        <633b3970-ddd4-4dc6-b586-96ecc5b86456@acm.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bart Van Assche <bvanassche=40acm.org>
> Sent: Friday, November 3, 2023 4:37 AM
> To: hoyoung seo <hy50.seo=40samsung.com>; linux-scsi=40vger.kernel.org; l=
inux-
> kernel=40vger.kernel.org; alim.akhtar=40samsung.com; avri.altman=40wdc.co=
m;
> jejb=40linux.ibm.com; martin.petersen=40oracle.com; beanhuo=40micron.com;
> kwangwon.min=40samsung.com; kwmad.kim=40samsung.com; sh425.lee=40samsung.=
com;
> sc.suh=40samsung.com; quic_nguyenb=40quicinc.com; cpgs=40samsung.com
> Subject: Re: =5BPATCH v1=5D scsi: ufs: core: Process abort completed comm=
and
> in MCQ mode
>=20
>=20
> On 11/1/23 21:07, hoyoung seo wrote:
> > when the ufs host receives any error, the ufs driver executes the error=
-
> hander.
> > If the error-hendler attempts re-init, it must abort and organize
> unprocessed
> >   requests.
> > The above operation is the same for both MCQ/legacy mode.
> > However, in the MCQ mode, if b or c is included in the following
> > specs, the OCS is updated to aborted, which is different from the legac=
y
> mode.
> >
> > B. If the command is in the Submission Queue and not issued to the
> > device yet, the host controller will mark the command to be skipped in
> the Submission Queue.
> > The host controller will post to the Completion Queue to update the
> > OCS field with =E2=80=98ABORTED=E2=80=99.=0D=0A>=20>=20C.=20If=20the=20=
command=20is=20issued=20to=20the=20device=20already=20but=20there=20is=20no=
=0D=0A>=20>=20response=20yet=20from=20the=20device,=20the=20host=20software=
=20driver=20issue=20the=20Abort=0D=0A>=20task=20management=20function=0D=0A=
>=20>=20=20=20to=20the=20device=20for=20that=20command.=0D=0A>=20>=20Then=
=20the=20host=20driver=20set=20SQRTCy.ICU=20as=20=E2=80=981=E2=80=99=20to=
=20initiate=20the=20clean=20up=0D=0A>=20>=20the=20hardware=20resources.=20T=
he=20host=20controller=20will=20post=20to=20the=20Completion=0D=0A>=20Queue=
=20to=20update=20the=20OCS=0D=0A>=20>=20=20=20field=20with=20=E2=80=98ABORT=
ED=E2=80=99.=0D=0A>=20>=0D=0A>=20>=20Unlike=20legacy=20mode,=20this=20pheno=
menon=20causes=20unintended=20behavior.=20(As=0D=0A>=20>=20shown=20in=20the=
=20log=20below)=0D=0A>=20>=0D=0A>=20>=20=5B1:=20=20kworker/u20:2:23157=5D=
=20ufshcd_try_to_abort_task:=20cmd=20pending=20in=20the=0D=0A>=20>=20device=
.=20tag=20=3D=209=0D=0A>=20>=20=5B3:=20=20kworker/u20:2:23157=5D=20Aborting=
=20tag=209=20/=20CDB=200x2a=20succeeded=0D=0A>=20>=20=5B4:=20=20=20=20=20=
=20swapper/4:=20=20=20=200=5D=20sd=200:0:0:0:=20=5Bsda=5D=20tag=239=20UNKNO=
WN(0x2003)=20Result:=0D=0A>=20hostbyte=3D0x05=20driverbyte=3DDRIVER_OK=20cm=
d_age=3D0s=20//=20DID_ABORT=0D=0A>=20>=20=5B4:=20=20=20=20=20=20swapper/4:=
=20=20=20=200=5D=20sd=200:0:0:0:=20=5Bsda=5D=20tag=239=20CDB:=20opcode=3D0x=
2a=202a=2000=0D=0A>=2000=20d3=2002=2000=2000=2001=2000=2000=0D=0A>=20>=20=
=5B4:=20=20=20=20=20=20swapper/4:=20=20=20=200=5D=20I/O=20error,=20dev=20sd=
a,=20sector=20110628864=20op=0D=0A>=200x1:(WRITE)=20flags=200x800=20phys_se=
g=20256=20prio=20class=202=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20For=20command=
s=20that=20have=20completed=20the=20abort=20operation=20in=20MCQ=20mode,=0D=
=0A>=20>=20since=20OCS=20has=20been=20updated=20to=20aborted,=20it=20seems=
=20that=20it=20will=20be=0D=0A>=20retransmitted=20only=0D=0A>=20>=20=20=20w=
hen=20it=20is=20made=20to=20REQUEUE.=0D=0A>=20=0D=0A>=20Hi=20Hoyoung,=0D=0A=
>=20=0D=0A>=20Thank=20you=20for=20having=20provided=20this=20clarification=
=20-=20this=20really=20helps.=0D=0A>=20=0D=0A>=20Regarding=20(B):=20I=20wou=
ld=20appreciate=20it=20if=20this=20patch=20would=20be=20reworked=20such=0D=
=0A>=20that=20no=20new=20'if=20(is_mcq_enabled(hba))'=20statements=20are=20=
introduced.=0D=0A>=20Has=20it=20been=20considered=20to=20modify=20ufshcd_mc=
q_sqe_search()=20such=20that=20it=20sets=0D=0A>=20the=20SCSI=20result=20to=
=20DID_REQUEUE=20<<=2016=20instead=20of=20modifying=0D=0A>=20ufshcd_transfe=
r_rsp_status()?=0D=0A>=20=0D=0A>=20Regarding=20(C):=20SQRTCy.ICU=20is=20onl=
y=20set=20by=20ufshcd_mcq_sq_cleanup()=20and=20the=0D=0A>=20only=20caller=
=20of=20that=20function=20is=20ufshcd_clear_cmd().=0D=0A>=20There=20is=20on=
ly=20one=20function=20that=20calls=20ufshcd_clear_cmd()=20for=20SCSI=20comm=
ands,=0D=0A>=20namely=20ufshcd_eh_device_reset_handler().=20The=20latter=20=
function=20should=20not=0D=0A>=20set=20the=20SCSI=20result=20code.=20All=20=
it=20should=20do=20is=20to=20abort=20all=20pending=0D=0A>=20commands.=20The=
=20SCSI=20error=20handler=20will=20resubmit=20all=20aborted=20commands.=0D=
=0A>=20=0D=0A>=20Thanks,=0D=0A>=20=0D=0A>=20Bart.=0D=0A=0D=0AHi,=0D=0A=0D=
=0AI=20do=20not=20understand=20what=20do=20you=20want.=0D=0A=0D=0ARegarding=
=20(B)->=20In=20the=20ufshcd_mcq_sqe_search(),=20just=20find=20desc_addr=20=
of=20the=20tag=20=0D=0Afor=20setting=20nullify=20in=20SQD.=20=0D=0AAfter=20=
that=20the=20host=20h/w=20checks=20the=20nullify=20during=20processes=20the=
=20SQD,=20=20=0D=0Aand=20sets=20the=20OCS=20to=20'aborted'.=0D=0A=0D=0ARega=
rding=20(C)->=20Also,=20when=20the=20ufs=20driver=20sets=20the=20SQRTCy.ICU=
=20to=201,=20=0D=0Athe=20host=20h/w=20updates=20the=20OCS=20to=20the=20Abor=
ted.=0D=0A=0D=0ASo=20the=20ufs=20driver=20s/w=20can't=20do=20anything=20unt=
il=20the=20OCS=20update.=0D=0Athe=20host=20h/w=20must=20update=20the=20OCS=
=20and=20then=20process=20the=20Aborted.=0D=0A=0D=0AWhat=20you=20want=20is=
=20not=20to=20arbitrarily=20modify=20the=20results=20for=20OCS?=0D=0ATheref=
ore,=20if=20we=20use=20the=20current=20MCQ,=20we=20will=20do=20something=20=
that=20=0D=0Awe=20do=20not=20intend=20to=20do.=0D=0ATherefore,=20the=20OCS=
=20processing=20code=20for=20mcq=20and=20legacy=20mode=20needs=20=0D=0Ato=
=20be=20disadvantageous.=0D=0A=0D=0AIf=20you=20do=20not=20want=20to=20use=
=20'if=20(is_mcq_enabled=20(hba)',=20=0D=0AI=20will=20upload=20the=20patch=
=20again=0D=0A=0D=0AThanks.=0D=0A=0D=0ABRs=20SEO.=0D=0A=0D=0A
