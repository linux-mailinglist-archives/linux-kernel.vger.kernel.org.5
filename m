Return-Path: <linux-kernel+bounces-106429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2587EE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449F62835BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5355764;
	Mon, 18 Mar 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx61Pht+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3E54FA8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781996; cv=none; b=XGl3jGhXfF5nclg5DkRnPFp1w5yhIJXxOAe8LCVodB/bPxpdTAwR6pbc/ve3xVMGykQjK0xvsnEeVWuB4qgB2YY+Lk9cc0yuVHCEYUgCQZY05/WDu9AVRATGJphQtDixOK5FLaTtipklF3L5X5IC7AqZUfJNMI1FVcuzeTiYKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781996; c=relaxed/simple;
	bh=atSce0BATx2WSJIgnV5RLV56pVf4GyJpsofrxBtLZvM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K5TJopOC9lZ5qzEwnogHNGDo2xcT9Tu7423nCy+kVx+0N2l5Q+ea48TCh5Dbpy4JNu9vQra4xBvK4Q2iZvb241Zo+FXPFTRpFaQz6ZRXXe4ENqEw89DDsHSEHxqZz9kmt5Zg9f0bgOsN2GHGZ8LCXm0f6KboIoATSYYYM8GULCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hx61Pht+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710781992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngySX0rBz6ibokt0I+RXr/TOevxF7704Fc6nCk2+iFI=;
	b=Hx61Pht+JLljfQ7Ss1YOUGFN3RO/FcTNyr0qQzXN9VtQTHDB7YRuPmcQPnL1eqpjyzb0v+
	mkzeBTkmaBOGj05waJJGapQHBYoRn+pPgvzIgHdtk8/fQjali7oMtJZQUgl7fKlvGYmsiK
	MfFy8nfcIB3eLEmVyfT1Jbhx+npEynw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-sWomk1oqPYCHF_3lIYeyxg-1; Mon, 18 Mar 2024 13:13:10 -0400
X-MC-Unique: sWomk1oqPYCHF_3lIYeyxg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso3458434a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781989; x=1711386789;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngySX0rBz6ibokt0I+RXr/TOevxF7704Fc6nCk2+iFI=;
        b=VxMN5Z7nkpWGG14Abx2j9nJUeGVFRx4knaJpP1I+Ib20LWc2DRxjHWDFROY2wNOrNp
         5IMbOt2XTbULCL0gekt29QHPqLXjZS9VWYCiZK/L7ADPFrTGYajztPhvW0OatMnBZqb7
         SbsMlIxv70BZUWzA4jLDMW6xy1/Y8KI2Ld5mihq/CfFwzQG+mJi4MghD2jQ6+ZvwkROZ
         MeJoOyhWZts0iFmgs/aNeWnCE0I0MxQS3L30eW09YYEPlpCeER0+Jsgf4Gd2I/Z9Tj3r
         JsC1w/emy4vgt1399wR7+oK42oyjg51WllQMJSuBEytnxani8RFtKOsoZLE0BjDCB7sz
         AJyA==
X-Forwarded-Encrypted: i=1; AJvYcCXfQ71+/zmwOJXjVIQMZTaWfuDQyitwOfHVch/DdNBDHMvzXz/TOvT7iA7FY1xXdq+ic6xih1mz1yFnYoqWmkW/GQuCv/ueWEEeOlkG
X-Gm-Message-State: AOJu0YyXrXZlVqwB1zUYz0zZlaWFsTPRjartyQVWsg2K+lbhVYdzCBiP
	YGCc7F7FuEoRAaSusBrgPqoKQ43xvrUC0GaU6Pjh+yalG+Q5B2ZkfGO9PZ6QRuUulZNMy8X1eTa
	FikGplOJxdTIoQK3dtbLYI/8T/qbkNHT0eNFz7J+URiM2GxnXoYwovc+i34owLQ==
X-Received: by 2002:a17:90a:df10:b0:29c:579d:b599 with SMTP id gp16-20020a17090adf1000b0029c579db599mr10950112pjb.9.1710781989305;
        Mon, 18 Mar 2024 10:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5GjAfUQb32DZ6ChW5feLdOYpCucu/ZL8H9CsX0xDGkh8DVRFI3Hy7/Zw8SPAALWQL7VAbyA==
X-Received: by 2002:a17:90a:df10:b0:29c:579d:b599 with SMTP id gp16-20020a17090adf1000b0029c579db599mr10950087pjb.9.1710781988861;
        Mon, 18 Mar 2024 10:13:08 -0700 (PDT)
Received: from smtpclient.apple ([115.96.153.171])
        by smtp.gmail.com with ESMTPSA id sw6-20020a17090b2c8600b0029fb23166adsm1993920pjb.30.2024.03.18.10.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 10:13:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9d24633d-b2bf-4cbe-86f7-6df56ba14657@linux.microsoft.com>
Date: Mon, 18 Mar 2024 22:42:52 +0530
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>,
 Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C740F1C4-CA2A-425B-8E60-0EF5C2C15270@redhat.com>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9d24633d-b2bf-4cbe-86f7-6df56ba14657@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 18 Mar 2024, at 21:49, Easwar Hariharan =
<eahariha@linux.microsoft.com> wrote:
>=20
> On 3/17/2024 7:45 PM, Shradha Gupta wrote:
>> If the network configuration strings are passed as a combination of =
IPv and
>=20
> Repeating a few unaddressed comments from v2.
>=20
> Missing a 4 in the IPv4 string here
>=20
>> IPv6 addresses, the current KVP daemon doesnot handle it for the =
keyfile
>=20
> You probably want to add a space so it reads as *...KVP daemon does =
not*, or contract it to *doesn't*
>=20
>> configuration format.
>> With these changes, the keyfile config generation logic scans through =
the
>> list twice to generate IPv4 and IPv6 sections for the configuration =
files
>> to handle this support.
>>=20
>> Testcases ran:Rhel 9, Hyper-V VMs
>>              (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> ---
>> Changes in v3
>> * Introduced a macro for the output string size
>> * Added cound checks and used strncpy instead of strncpy
>> * Rearranged code to reduce total lines of code
>> ---
>> tools/hv/hv_kvp_daemon.c | 177 =
++++++++++++++++++++++++++++++---------
>> 1 file changed, 136 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>> index 318e2dad27e0..156cef99d361 100644
>> --- a/tools/hv/hv_kvp_daemon.c
>> +++ b/tools/hv/hv_kvp_daemon.c
>> @@ -76,6 +76,12 @@ enum {
>> DNS
>> };
>>=20
>> +enum {
>> + IPV4 =3D 1,
>> + IPV6,
>> + IP_TYPE_MAX
>> +};
>> +
>> static int in_hand_shake;
>>=20
>> static char *os_name =3D "";
>> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
>>=20
>> #define MAX_FILE_NAME 100
>> #define ENTRIES_PER_BLOCK 50
>> +/*
>> + * Change this entry if the number of addresses increases in future
>> + */
>> +#define MAX_IP_ENTRIES 64
>> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
>>=20
>> struct kvp_record {
>> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
>> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
>> return 0;
>> }
>>=20
>> +int ip_version_check(const char *input_addr)
>> +{
>> + struct in6_addr addr;
>> +
>> + if (inet_pton(AF_INET, input_addr, &addr))
>> + return IPV4;
>> + else if (inet_pton(AF_INET6, input_addr, &addr))
>> + return IPV6;
>> +
>> + return -EINVAL;
>> +}
>> +
>> /*
>>  * Only IPv4 subnet strings needs to be converted to plen
>>  * For IPv6 the subnet is already privided in plen format
>> @@ -1197,14 +1220,71 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
>> return plen;
>> }
>>=20
>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int =
type,
>> +   int ip_sec)
>> +{
>> + char addr[INET6_ADDRSTRLEN], *output_str;
>> + int ip_offset =3D 0, error =3D 0, ip_ver;
>> + char *param_name;
>> +
>> + memset(addr, 0, sizeof(addr));
>=20
> Echoing Ani, you don't need this memset here since your first step in =
the loop below is to
> memset(addr, 0).
>=20
>> +
>> + if (type =3D=3D DNS)
>> + param_name =3D "dns";
>> + else if (type =3D=3D GATEWAY)
>> + param_name =3D "gateway";
>> + else
>> + return -EINVAL;
>> +
>> + output_str =3D (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
>> + if (!output_str)
>> + return -ENOMEM;
>> +
>> + while (1) {
>> + memset(addr, 0, sizeof(addr));
>> +
>> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
>> +  (MAX_IP_ADDR_SIZE * 2)))
>> + break;
>> +
>> + ip_ver =3D ip_version_check(addr);
>> + if (ip_ver < 0)
>> + continue;
>> +
>> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
>> +     (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
>> + /*
>> +  * do a bound check to avoid out-of bound writes
>> +  */
>> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
>> +     (strlen(addr) + 1)) {
>> + strncat(output_str, addr,
>> + OUTSTR_BUF_SIZE - strlen(output_str));
>> + strncat(output_str, ",",
>> + OUTSTR_BUF_SIZE - strlen(output_str));
>> + }
>> + } else {
>> + continue;
>> + }
>> + }
>> +
>> + if (strlen(output_str)) {
>> + output_str[strlen(output_str) - 1] =3D '\0';
>=20
> You don't need this since you're using strncat which adds its own =
'\0'.

If I understand this correctly, this code simply eliminates the extra =
=E2=80=9C,=E2=80=9D character in the end. Therefore it is needed.
Since it is not obvious, in the previous review and before, I asked the =
author to add a comment to explain this clearly.

> I wasn't quite able to follow along=20
> on the discussion between Ani and you, so putting this in here in case =
it wasn't already mentioned.
>=20
>> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
>> + }
>> +
>> + free(output_str);
>> + return error;
>> +}
>=20
> <snip>



