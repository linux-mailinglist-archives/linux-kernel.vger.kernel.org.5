Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5B7DB2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJ3FPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3FPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BEBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698642911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOIaKAX0ABCkjpkL5qEVgTbYedUADxo3ZoTcc0fB/Ks=;
        b=TdLZhkYV7nV0pzbAzgt0gvHmHMulbfxPyQ0oc2AgLkClgTw5qoLe9xKdSAxPg7Cr4jHz5s
        AgPywN2RKaNPiBm/x+nfpuBblB8q5Kr+QJtzl+LTa0IKfA/JLa4pNgmwxsDZ+cmjNt0AVL
        qwgcMKIoURlb1TO41/mCVwWJmPa+CDs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-lMFx4WzNN3CnzU9u8_WUPw-1; Mon, 30 Oct 2023 01:15:10 -0400
X-MC-Unique: lMFx4WzNN3CnzU9u8_WUPw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc56a9ece7so1166515ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698642908; x=1699247708;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOIaKAX0ABCkjpkL5qEVgTbYedUADxo3ZoTcc0fB/Ks=;
        b=q94XTNR253Fy6hYBof69ZMHy3HKoMYxR+aPClIKH0F4lTCAVlz2ib61beIj23c4byW
         eh7DBcgSrRTOiPf1yvWyphqCh+U21z8GNoSeeOWoOUzT9eedGZlv6AwPJe97rWwNK1xC
         Iw/qSiBr4giSJLebKSerN69jIaNwMH4zi4YIqGeQxW6TFbRG/7C2z+ef9JKEExQd/D0h
         xOA0XNnMIaEa+inEAev6bNaZblBOXe32zfniaiKn6WdBw6BMTF3sxzhenbXnFdtJ5eiW
         z5q8D1vOI9xOvq6Dt8qpwp4yabt1mJ5r7tdkH+T6+0SAg3WX0zdq9ReiOClshUGXB5QJ
         kZyg==
X-Gm-Message-State: AOJu0YxCW3eRnV7YVC9zmwad5fmPvSMc6n3eg91beGGzNlXcPnYaMANp
        G0ypJDvTkZJFQxKzpwh3ZbIiXp21fidJh4ZXv7SoQM7XZDv/2hzR1X7ZBDy02cPRA7gnv5SAnAi
        pnEcXx0D24UIvRg5uQxwbKHeLwtzY2fAF
X-Received: by 2002:a17:902:e811:b0:1cc:569b:1df4 with SMTP id u17-20020a170902e81100b001cc569b1df4mr321024plg.1.1698642908651;
        Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzlqUdIn5g7MGLHCMDIJpdHbeIdLsSCJM9vptMH/SAhrXE6OBafwlNSLQzjFajuDnuR2DpWw==
X-Received: by 2002:a17:902:e811:b0:1cc:569b:1df4 with SMTP id u17-20020a170902e81100b001cc569b1df4mr321010plg.1.1698642908347;
        Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
Received: from smtpclient.apple ([203.212.245.41])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001cc55bcd0c1sm313612plg.177.2023.10.29.22.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2023 22:15:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Mon, 30 Oct 2023 10:45:03 +0530
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>> Some small fixes:
>> - lets make sure we are not adding ipv4 addresses in ipv6 section in
>>   keyfile and vice versa.
>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
>>   checking the whole value of addr_family.
>> - Some trivial fixes in hv_set_ifconfig.sh.
>>=20
>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>=20
>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>> index 264eeb9c46a9..318e2dad27e0 100644
>> --- a/tools/hv/hv_kvp_daemon.c
>> +++ b/tools/hv/hv_kvp_daemon.c
>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>> +	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>> 		error =3D fprintf(nmfile, "\n[ipv6]\n");
>> 		if (error < 0)
>> 			goto setval_error;
>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	if (error < 0)
>> 		goto setval_error;
>>=20
>> -	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> -	if (error < 0)
>> -		goto setval_error;
>> -
>> -	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>> -	if (error < 0)
>> -		goto setval_error;
>> +	/* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>> +		error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>>=20
>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>> +		error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>> 	fclose(nmfile);
>> 	fclose(ifcfg_file);
>>=20
>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>> index ae5a7a8249a2..440a91b35823 100755
>> --- a/tools/hv/hv_set_ifconfig.sh
>> +++ b/tools/hv/hv_set_ifconfig.sh
>> @@ -53,7 +53,7 @@
>> #                       or "manual" if no boot-time protocol should =
be used)
>> #
>> # address1=3Dipaddr1/plen
>> -# address=3Dipaddr2/plen
>> +# address2=3Dipaddr2/plen
>> #
>> # gateway=3Dgateway1;gateway2
>> #
>> @@ -61,7 +61,7 @@
>> #
>> # [ipv6]
>> # address1=3Dipaddr1/plen
>> -# address2=3Dipaddr1/plen
>> +# address2=3Dipaddr2/plen
>> #
>> # gateway=3Dgateway1;gateway2
>> #
>> --=20
>> 2.39.2
> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>

Ping. Can anyone please queue this?
>=20

