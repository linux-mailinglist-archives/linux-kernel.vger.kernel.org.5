Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DC7E8038
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjKJSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjKJSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33B59F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699596977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XggjIHp4vdoSOrTXOSQXEDRrxSR1328KQ7zU7pww/Uc=;
        b=TEqiQQIbqT0oNLAPMPxqRiCUX3mKO+/sY4xMMXqpcL3qq8Z93LD+oUw7PvXqIpXaPK1oso
        zE7vgndMZFcomwu6wSLeZwxc73amnwTr4mx0VZh7pIzAopac0gTldmI081o/iO2SLxpomQ
        ee4aCRYTo0iwYYqDeROgulH8JNZOxfE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-zjUw0VubN0CdkThmVTPQSQ-1; Thu, 09 Nov 2023 23:02:19 -0500
X-MC-Unique: zjUw0VubN0CdkThmVTPQSQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b99683eefbso1536325a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 20:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699588939; x=1700193739;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XggjIHp4vdoSOrTXOSQXEDRrxSR1328KQ7zU7pww/Uc=;
        b=uCTS3+PTFevHCn8y1rAnM75M+4sA4/Vfxws+HRydrb/keAz8XQVaN5R0sYC1s5/xfP
         6++M8YzhmiQddDxy87fONps5Lk0vCStWJkWhFQzH1o7drXqiSNpxiDJ/orYs3XK9vaVc
         uzHHiJFnV5L/uj5Xx8jDgkYr1CAWWZY8DH3jLj+a7RIv+EqbumU6WkHtcHhqKEywfRtS
         5t0qpPfEy4x7dmrT6zb3yCsBEmt60dKNMLjoqnmU0pA9xcV6lqcB2Qw1gx9lwKAlp9/Z
         IE2ADNSC2BqrRTzLe+yql9xPrCUlZqVVSdLpf/RJ7VqXUdcPrd/Gr/ILDZlZM0rgBeH5
         S1ug==
X-Gm-Message-State: AOJu0YwrJsvX6HG8tJTXeWImK2xfMGUA3IPlASciSfdVwC8CuMZyru6o
        xTvt0Mxsq4bHAWHhEIU8BrwCdTgATNd4z8hgp1z9vyf6ePU3oJVHkfidEPghvjmay3YAiRNQ1wV
        OW53mJjk9fmq37jRKdV5z42WQ
X-Received: by 2002:a05:6a21:71c7:b0:181:b044:44a4 with SMTP id ay7-20020a056a2171c700b00181b04444a4mr6547128pzc.56.1699588938838;
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+9lERQsAFmLd+Z6c2P3EzeChWGcKBVzTv5EsRL3ZyDe51TjlFWi1UE0nFOte7cklYcpUXkQ==
X-Received: by 2002:a05:6a21:71c7:b0:181:b044:44a4 with SMTP id ay7-20020a056a2171c700b00181b04444a4mr6547102pzc.56.1699588938394;
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
Received: from smtpclient.apple ([116.72.128.216])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aaa8500b0028031e87660sm573907pjq.16.2023.11.09.20.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
Date:   Fri, 10 Nov 2023 09:32:03 +0530
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D09E6F5-9120-40D4-A365-AF04E9AA5587@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
 <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 07-Nov-2023, at 9:10=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 30-Oct-2023, at 10:45 AM, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>>=20
>>> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>>>> Some small fixes:
>>>> - lets make sure we are not adding ipv4 addresses in ipv6 section =
in
>>>> keyfile and vice versa.
>>>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead =
of
>>>> checking the whole value of addr_family.
>>>> - Some trivial fixes in hv_set_ifconfig.sh.
>>>>=20
>>>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>>>=20
>>>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>>>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>>>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>>>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>>>=20
>>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>>>> index 264eeb9c46a9..318e2dad27e0 100644
>>>> --- a/tools/hv/hv_kvp_daemon.c
>>>> +++ b/tools/hv/hv_kvp_daemon.c
>>>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>>> if (error)
>>>> goto setval_error;
>>>>=20
>>>> - if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>>>> + if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>>>> error =3D fprintf(nmfile, "\n[ipv6]\n");
>>>> if (error < 0)
>>>> goto setval_error;
>>>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>>> if (error < 0)
>>>> goto setval_error;
>>>>=20
>>>> - error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>>> - if (error < 0)
>>>> - goto setval_error;
>>>> -
>>>> - error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>>> - if (error < 0)
>>>> - goto setval_error;
>>>> + /* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>>>> + if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>>>> + error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>>> + if (error < 0)
>>>> + goto setval_error;
>>>> + }
>>>>=20
>>>> + if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>>>> + error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>>> + if (error < 0)
>>>> + goto setval_error;
>>>> + }
>>>> fclose(nmfile);
>>>> fclose(ifcfg_file);
>>>>=20
>>>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>>>> index ae5a7a8249a2..440a91b35823 100755
>>>> --- a/tools/hv/hv_set_ifconfig.sh
>>>> +++ b/tools/hv/hv_set_ifconfig.sh
>>>> @@ -53,7 +53,7 @@
>>>> #                       or "manual" if no boot-time protocol should =
be used)
>>>> #
>>>> # address1=3Dipaddr1/plen
>>>> -# address=3Dipaddr2/plen
>>>> +# address2=3Dipaddr2/plen
>>>> #
>>>> # gateway=3Dgateway1;gateway2
>>>> #
>>>> @@ -61,7 +61,7 @@
>>>> #
>>>> # [ipv6]
>>>> # address1=3Dipaddr1/plen
>>>> -# address2=3Dipaddr1/plen
>>>> +# address2=3Dipaddr2/plen
>>>> #
>>>> # gateway=3Dgateway1;gateway2
>>>> #
>>>> --=20
>>>> 2.39.2
>>> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>
>>=20
>> Ping. Can anyone please queue this?
>>>=20
>=20
> Ping again =E2=80=A6 Please pick this up.

Ping =E2=80=A6

