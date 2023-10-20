Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D57D11A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjJTOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377490AbjJTOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:34:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670219E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697812460; x=1698417260; i=efault@gmx.de;
        bh=QtJgWLvcgIWB43JrJ3u31jdplw3iBoNu/v4f26qo2fA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
         References;
        b=hpPXWP9T8mJAG6PJ8JeF406xbDL5oBtRmynvMhXqsl65rVZf2HeJ8gnff0Bfp+J4
         xj7PBJudw+7ip+edSiubEnig4n6uZ1Wq6XwvVGCWNQvt5+eXyUhUEXyXupuo97kZx
         2qPpcrTtnk/ARPJ2Xi8KgGyoy0PdSBl+kubaPREkCrX9l+OszyFkwwWdr1T3v+whn
         4+UyB3gGB5XpLZfIoQO9hpCgQs+U4w1UnSlbC7IpHfXaOG4Cth2AxWPik2d7qbMQK
         QLQVl+XrVJWc1Nuvw1oRDCHoic4athO3FztH8YuzKi4NUpqkaJhbY5wVUbawtfRUJ
         ksv7mlfOrmNPYwj+kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1qq0Z02qxC-0066nj; Fri, 20
 Oct 2023 16:34:20 +0200
Message-ID: <15e4768144a74b093ad5a43f6e5c263fd98775fb.camel@gmx.de>
Subject: Re: Runtime overhead of PREEMPT_DYNAMIC
From:   Mike Galbraith <efault@gmx.de>
To:     Emanuele Rocca <ema@debian.org>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date:   Fri, 20 Oct 2023 16:34:20 +0200
In-Reply-To: <c6259a1824e570ddb7aaf114656aa387e028b76d.camel@gmx.de>
References: <ZTJFA_Ac6nWawIHb@ariel>
         <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
         <ZTKDWnLrSnPs9VUi@ariel>
         <c6259a1824e570ddb7aaf114656aa387e028b76d.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8oyPL33s02edddKEsSveNr9iAosXPTOe/lzFTOVkDghMEJpBGNe
 dyCbS4IOHOWWMOHUWrcJG3OSkQoNh+w3+SBOCaJpeqOyFVzSTs5e8+mGadXDGoFFzTlOx8M
 0avAXVkB+5v6/Oty7M8BBQKVkO+uR4hKiDlwtclah2P5yBeBniYm1yLEXS9mDqOIxin9Ft0
 6Dst8iLYnjBnnzeoiNZxg==
UI-OutboundReport: notjunk:1;M01:P0:9R5zOUn2Nuo=;jq/QxVtimCoPk1ThZ8ObCzfVcLM
 iPexu0Om9A2Qnm3LBQebH4pcJb4GVyiXE5eRJc+33m0oTR79zoIKQZ3zffeCREOmXPJzIkr2N
 /gBnsk7H1voHZ0F2x1NnNcLV3Ni1xgRZT5MqDmRWVW2bm8WXibGKFBjBY76Ri0eX2En2oqnde
 4UEj96oonJN8e8k1Npj7uO8A4cP57blROEbnLcxAWseLFiyUfy353B95MqP7vjQMj+AKIHWx+
 w+S/TwjcCpEIddgHxYDeo5llcfRcEEG11pS6MIFvn2IhA87syWcaaVoj3rF82l3ez0CzwyVUd
 7lczBV57oR67tf7lXO4unFgq+m9h+TQG9KkkhOLgF+v49+GuBUKeAgZiuhg3A/UVpelPKHC+j
 ubbeSkOUAByopWG19accylqqt32/SGh+5HuYWzFdUWnF4DfMTmnL9nofiULLLuwjtOgnfgpz1
 KDa3FCWCl+VMDlsQx6CMd21UcmNOcOW/PdQiwzX88oPbjS2sirciBWcxGsf/dAs+7Ir0F5ybg
 LQBBmlWZRXiQOKFeq6UzVJOabxoDahyEl+m/sSec7sFoshWHEZUw/Xrvt6cM7TSkaIt+AEaxH
 ELM9hj+tmBrQNVFn/A3M56BiZbN4qAfltXo6lB99WJ6ACGXNntZsKY091N+6xK3i/np+43ZbJ
 QCAF5QMRrIyFWErcagADnTEl5GI1SHQzQ0LK2b8sOy/hSxK9K+t6hD0QUpmKOK+zC25NHer99
 fXRosbkSBh+Mv86dHELIZ+0w4zQT45l/gV4F4Qd74ymmFunnDSDX8qPiXnpCsCTM0FtFo3C6b
 4ml8WjwYk9bOhBWQMJ9AJDjxa5xdZXZ2HxOdCSNPRj7kgHbAFlHKSni8H8glCon3mTuqAO32r
 T2BwWj+oGmNuHUarplE82eNu+4Rukmizz97tejlchKUZljInZUVnGNzJ1guSuOrPCPMq3N4Lf
 pcMxhNI6lbwJOGlCbIrXDmFnEAQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 16:11 +0200, Mike Galbraith wrote:
> On Fri, 2023-10-20 at 15:40 +0200, Emanuele Rocca wrote:
> > Hi Mike,
> >
> > Here is the full diff between the kernel configurations I used. The on=
ly
> > change I made was setting CONFIG_PREEMPT_DYNAMIC=3Dn, everything else =
was
> > a consequence of that AFAICT, but please do let me know if you see
> > anything that shouldn't be there.
> >
> > --- config-6.5.0-0.preempt-dynamic-amd64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A02023-10-11 15:30:02.000000000 +0200
> > +++ config-6.5.0-0.a.test-amd64=C2=A02023-10-11 14:30:02.000000000 +02=
00
> >
> > @@ -10597,7 +10596,6 @@
> > =C2=A0# end of Scheduler Debugging
> > =C2=A0
> > =C2=A0# CONFIG_DEBUG_TIMEKEEPING is not set
> > -CONFIG_DEBUG_PREEMPT=3Dy
> > =C2=A0
> > =C2=A0#
> > =C2=A0# Lock Debugging (spinlocks, mutexes, etc...)
>
> Seems you had also turned on DEBUG_PREEMPT in the dynamic setup, which
> adds some overhead.. but not a metric ton.

Hm, I don't recall the overhead as being that bad, but thar she blows.

i7-4790                                       avg         cmdline
6.5.8-voluntary 3685.08 3679.93 3704.98   3689.99  1.000
6.5.8-dynamic   3571.62 3568.61 3550.55   3563.59   .965
                3052.06 3032.74 3019.93   3034.91   .822  +DEBUG_PREEMPT
                3651.37 3599.87 3615.18   3622.14   .981  preempt=3Dnone
                3459.58 3514.09 3539.88   3504.51   .949  preempt=3Dfull


