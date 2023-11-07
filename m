Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3927E3441
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjKGDlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F2C10C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699328457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/objqiOqc8rOZeftx45k4hz0QbDrfEnyUw5mk2OXW0=;
        b=g+4M7wWJMYK85vexchST82OP+Go0OFbtt0qTBoI3HVcDdLWA+QaeXek+RoTzO1Ih74vKE2
        Ppj62+YWOcb5NNC1AClU4ckODt39Ip1nakCNLYqJDKpsN5KHsIfwRqbeZ7awsF7K0luc3R
        4PquomYUtSn6Lf991OtuzUgJNi6xtXs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-HK0wgq5FNJuZbQcLGt5_YA-1; Mon, 06 Nov 2023 22:40:49 -0500
X-MC-Unique: HK0wgq5FNJuZbQcLGt5_YA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2ef9e4c25so7864586b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 19:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328449; x=1699933249;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/objqiOqc8rOZeftx45k4hz0QbDrfEnyUw5mk2OXW0=;
        b=uM4FYplkwmgJ0HBIqK8CzIqs2ZF6lVmInPLw/zq14OLjvboGNZu8o4GIm/3+9QNWI3
         kx9LU6EZ7bsnX11cYJEHSDHGJvl+GoA8DJA9MwFDQrL64xGlntisl3+CuEn0MePxnuo/
         5tis6EuYtdIrq800XQ1sxtnw+yqjLeE5niiwHw95GsY92AOgP0awnGNFOKgnR4kf5wdn
         oMGi70FZrx3A+7cGa5JFp3+SMmtisCrcnlFHwc7cqND9EO8zwbKI4BlKcw9xmodBN1jT
         hWZQBhJL049au5hMhBSKz7Qtf+qyywzH6QJQ1zThJCXxbqYu5TDH+uafhzue8D/+KrMC
         fcaQ==
X-Gm-Message-State: AOJu0YyY2mgm9lcBsTujfjXPsnsyq2pECK6iYlaoG2+M6xWPU9+TVpa0
        0+4NOj7W7DAyaE1a09StZAYNw8rY3txOoniXZai6TM9CEEdvDdQPnKaSDWh7QFry5euLMCPpysq
        vWJ/ilKMBu5MH2tCELXgeQh3A
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id f4-20020a05680814c400b003b5663c9b91mr25811114oiw.12.1699328449191;
        Mon, 06 Nov 2023 19:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMGTYxK/HZxGKY3L0S3GbNNZ/EC6n9a4m3WUGhPB5VEAdGD9voUf1lVcBOeJk2sYQMF/7lsg==
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id f4-20020a05680814c400b003b5663c9b91mr25811099oiw.12.1699328448914;
        Mon, 06 Nov 2023 19:40:48 -0800 (PST)
Received: from smtpclient.apple ([115.96.144.207])
        by smtp.gmail.com with ESMTPSA id h15-20020aa786cf000000b006c06779e593sm6480721pfo.16.2023.11.06.19.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 19:40:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
Date:   Tue, 7 Nov 2023 09:10:43 +0530
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 30-Oct-2023, at 10:45 AM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>>> Some small fixes:
>>> - lets make sure we are not adding ipv4 addresses in ipv6 section in
>>>  keyfile and vice versa.
>>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
>>>  checking the whole value of addr_family.
>>> - Some trivial fixes in hv_set_ifconfig.sh.
>>>=20
>>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>>=20
>>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>>> index 264eeb9c46a9..318e2dad27e0 100644
>>> --- a/tools/hv/hv_kvp_daemon.c
>>> +++ b/tools/hv/hv_kvp_daemon.c
>>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>> 	if (error)
>>> 		goto setval_error;
>>>=20
>>> -	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>>> +	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>>> 		error =3D fprintf(nmfile, "\n[ipv6]\n");
>>> 		if (error < 0)
>>> 			goto setval_error;
>>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>> 	if (error < 0)
>>> 		goto setval_error;
>>>=20
>>> -	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>> -	if (error < 0)
>>> -		goto setval_error;
>>> -
>>> -	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>> -	if (error < 0)
>>> -		goto setval_error;
>>> +	/* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>>> +		error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>> +		if (error < 0)
>>> +			goto setval_error;
>>> +	}
>>>=20
>>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>>> +		error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>> +		if (error < 0)
>>> +			goto setval_error;
>>> +	}
>>> 	fclose(nmfile);
>>> 	fclose(ifcfg_file);
>>>=20
>>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>>> index ae5a7a8249a2..440a91b35823 100755
>>> --- a/tools/hv/hv_set_ifconfig.sh
>>> +++ b/tools/hv/hv_set_ifconfig.sh
>>> @@ -53,7 +53,7 @@
>>> #                       or "manual" if no boot-time protocol should =
be used)
>>> #
>>> # address1=3Dipaddr1/plen
>>> -# address=3Dipaddr2/plen
>>> +# address2=3Dipaddr2/plen
>>> #
>>> # gateway=3Dgateway1;gateway2
>>> #
>>> @@ -61,7 +61,7 @@
>>> #
>>> # [ipv6]
>>> # address1=3Dipaddr1/plen
>>> -# address2=3Dipaddr1/plen
>>> +# address2=3Dipaddr2/plen
>>> #
>>> # gateway=3Dgateway1;gateway2
>>> #
>>> --=20
>>> 2.39.2
>> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>
>=20
> Ping. Can anyone please queue this?
>>=20

Ping again =E2=80=A6 Please pick this up.

>=20

