Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA057D1140
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbjJTOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377419AbjJTOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:11:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F893
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697811104; x=1698415904; i=efault@gmx.de;
        bh=nmczSBI2pFFgwL6eKCEn0u5bcuiQ7coKuKAHrXHH3Ag=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
         References;
        b=XaVa51oGSBG0Qi/rS2iki0S1wle/NMdW7bV6ApC85XZCtq2OXZ7kC4RSPSZ6DECd
         OorcViNzE/cmd3pmTtiL+PIJkHvPGxjjYIlR7RlncMUPAQBkM2LXOJ7rUr6fqmbdc
         TdWs2pUptCzCfokxiLW98bnXrxKYMGVkVxiYF5IzlNt5k0MvvM+BUpc0fhHY+xwzF
         BCtlsesqiPLHu5DgOmjLMJkO+ys4N3NEQoLjgw1bHAed6zR/+LkPjHLh/dYfrzXgu
         ARW05SLnBKyjQL7XslQGyJp8LTDf0F57RBxNAyW88HUD68DttW+enFkP3Vk1VBN92
         LATD52cMPvUuI6eTdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.246]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1qyMTo0H0i-00UoPd; Fri, 20
 Oct 2023 16:11:44 +0200
Message-ID: <c6259a1824e570ddb7aaf114656aa387e028b76d.camel@gmx.de>
Subject: Re: Runtime overhead of PREEMPT_DYNAMIC
From:   Mike Galbraith <efault@gmx.de>
To:     Emanuele Rocca <ema@debian.org>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date:   Fri, 20 Oct 2023 16:11:43 +0200
In-Reply-To: <ZTKDWnLrSnPs9VUi@ariel>
References: <ZTJFA_Ac6nWawIHb@ariel>
         <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
         <ZTKDWnLrSnPs9VUi@ariel>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ya0oBRzIObLGOe+BtNukTIBsIM22KAKK56AC/28STBvj5o0sjAH
 kU7ZByjiaZs/uj0B485f5CLBFDUuvlwLertcIyx9tLOrEwYwYvROBnWqfRYKOY9abnPqubH
 vXvFaaWWr4ceUEb1+rvLdN36fhxhZVI8liw06134hJFEKQzn4MSZ5OODvxj/8srvod9KDzU
 cFctldGHKElu9ujrJ/K8Q==
UI-OutboundReport: notjunk:1;M01:P0:PG8iyFXqxXY=;1rorWEGKij9QHcZ1P/dWlS8eYH5
 BhtDg68wCtjWS8PugD7f1tfba+wqoAT86C+hf8lV0hhhelHvQz44jil4cL6NbE8Ic7eJqRDpx
 HuixhhthHTg5Q0g2rH8pzxSkFvSdLmfCPJfx8pElILNiwmRpDdvKhN07zNCvFc6QbiQVhXWLY
 tahOzBekeqOyr3Ijwc+nEyDm0IvazvDjc5TKH6iwZVbUCm70XKA+hurmX9I0E7BVerQtFltBl
 nfc8Df9iMe9xh1ccl2zLZfAPoVnpYZW9ZDYSQcTR3Zu64WUdVPb2k+1Eji6Qg9tdqgc9AHCGL
 ETcM1kIa7e7ZhQucd6+yp7Mjof/JHQMMMbNR9a/DKCwzIFkOINVmuA3ElvadtGWBeGqe//lPL
 Yr+K/4HagPXtw6BSGfXkqluzVUp9hbHDGY0+QgMJ42fdPgEIIRVjMDm8ZGSGZJF5RFdoRTO3l
 wbAFszmI/9+hUjXahxwNs/15g5DEBmNQhHLl+MCce441VOmdIc9H8MsBn/SN+i8bQMteQxYBX
 zjul5UkoKZ9Fy4y72ASaMK3bQ9m/fjpBABobWCRuk0sv2mTH8+8tb5+QS+Ee+6fV1FKDcbvqh
 ficDPpx6sd23kcCfBkEytLtxwSowbx11RzcbcQyQBy1J3X7CLp3sx2/jM1tsFTWOMa8xMbUyv
 zM7PKZuVpNRG218T8Ty0t6UJ5Ck9/2wDeMmaNxFRSIfGJdvdS+xAXV9YiiG09PQmswdX5kd1J
 I2IUdbtXhVpNs1zkS2OdMTZVZR0+VoLeHKlAYoACTCbv4Ong8azMgJlmLvY3rPI3Q6e8plZfG
 3lk1E5J7k6s2zMpvgDgtX+Or7ZJh2Yk91emkCTHRawvsO0/j02HaF/65Jqlq6sBicKFR31Mir
 CxaPcE6g9O8XQezPRVDew49co7YBo9+MfTcZUnlnDAIlJBgYWrm/FPwGWlNISFH1WJFoAXwA7
 pBKz75AoBKwSFo5aJ1QhDgO4TYE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 15:40 +0200, Emanuele Rocca wrote:
> Hi Mike,
>
> Here is the full diff between the kernel configurations I used. The only
> change I made was setting CONFIG_PREEMPT_DYNAMIC=3Dn, everything else wa=
s
> a consequence of that AFAICT, but please do let me know if you see
> anything that shouldn't be there.
>
> --- config-6.5.0-0.preempt-dynamic-amd64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A02023-10-11 15:30:02.000000000 +0200
> +++ config-6.5.0-0.a.test-amd64=C2=A02023-10-11 14:30:02.000000000 +0200
>
> @@ -10597,7 +10596,6 @@
> =C2=A0# end of Scheduler Debugging
> =C2=A0
> =C2=A0# CONFIG_DEBUG_TIMEKEEPING is not set
> -CONFIG_DEBUG_PREEMPT=3Dy
> =C2=A0
> =C2=A0#
> =C2=A0# Lock Debugging (spinlocks, mutexes, etc...)

Seems you had also turned on DEBUG_PREEMPT in the dynamic setup, which
adds some overhead.. but not a metric ton.

	-Mike
