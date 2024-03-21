Return-Path: <linux-kernel+bounces-109645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AD881BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85841C21A11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BBC8DE;
	Thu, 21 Mar 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaEV6SHc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCDD533
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994880; cv=none; b=QVLRnMaU5DmDRbayyrmCRC5zQxgawvQedv/aspW+KfHvmmMPe9kZgxWn0bgQ3bzXEPjcOO+/+NIkpySke6IsBDqlI0bbzVnVCr1hu7Ew6mqrQADtfLE2llMvlRYvoZMg712Ahfuue3fCe9vTW7nnP6i352YIHzUqpdSUrlU7u5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994880; c=relaxed/simple;
	bh=99Qs0Gq7+ObEn4D3B5DZecNxuj9lxFMYRmuAERt6RvU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rbx0tw6RFOze11Tgsxw68vrMUSJU9f8OFPeb9p5uxcT/eHODueLg3WUOadsDweC4ngan8IpmUheud3FDyy2p9UzUSZrTLvU+0d/AX7A3fQdrIVOvH92xzBm8MG8I2/o7pvDgNJSLEqCTaq5ZTR3TTDijTmB7iBLjot257lmf0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaEV6SHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710994877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty30XTjIh3n5bDUqzMfqqx31y81RXq69tRqlBh2Jwcs=;
	b=TaEV6SHcJql+yn3IttNpN4Mmnhb9UPmaJn+jxygvco6KBW49m+PDGCfxWcr3ZPVlRHJUI0
	UEXc9cF2knVrBWJ20pZQSjPJD1kcMEYGDGDs6wZIOTOfzWmbnCIkHKBrrXf727gjjKUQP0
	6k6ujv5xOTiYm2Ujmvaaevcx09d2Kso=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-L8YcHz9eOvWI5p4ufDBmEw-1; Thu, 21 Mar 2024 00:21:14 -0400
X-MC-Unique: L8YcHz9eOvWI5p4ufDBmEw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e73833c7f6so397417b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710994873; x=1711599673;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty30XTjIh3n5bDUqzMfqqx31y81RXq69tRqlBh2Jwcs=;
        b=jCb5ogJsUfpo5t0T5iSsHXnP+0A15K9NYyXJIEKB18HXnsO2nbS7W7yOsybvb8c/hW
         FSjWdV60RQ3HnY9cIDoEWUbitAfGaz+/QuKMtU7Q/BlZpcfEH+1RuaAHIl6sU5JfHDaY
         ITdH/sT4qGFZs/PuSMLmmH5IytkQPjO17zDgSAO9ylvgZJops6xZzIUGLKiO8fYEjiIz
         OGjtOnqCYUd1emSImdITc4FP7jGbnhF214EXaWHQRfp6G6Yrmc1LqPuf+ojDLpfDRfrL
         uBzojn14NasZXlo5C+luPNMY4RJyeaY/Frnj7MpmFarjYhvJIjjxryP1FW7PIwRp5/AE
         hGcA==
X-Gm-Message-State: AOJu0YyJol/gy207ECLYHhk2Ki2mpLznr4nIQFgpLVqMPNYNzC/BJBHj
	4FxYdMCGpXP9oevM8JAWCY6shyqgMlrIXL5KNUX1B01FOUwA22SScBuVSDuRO3K4GoePl20ZOdw
	n4Xkp9aYRzRU+E9hFDkChqmyUIyaZ+BmsLMCnzyKA7I/xfP+0jfUeZAZOo8V5iA==
X-Received: by 2002:a17:902:7847:b0:1de:e473:55f1 with SMTP id e7-20020a170902784700b001dee47355f1mr875638pln.29.1710994873085;
        Wed, 20 Mar 2024 21:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE11fiJB4c3BsbYFVj2CreRKINlJb/vNNvZm72FxWyXHRqnBMPAMPuN9EiYqeOTK2uPcC7RPw==
X-Received: by 2002:a17:902:7847:b0:1de:e473:55f1 with SMTP id e7-20020a170902784700b001dee47355f1mr875629pln.29.1710994872715;
        Wed, 20 Mar 2024 21:21:12 -0700 (PDT)
Received: from smtpclient.apple ([115.96.142.122])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b001e03f61a1cesm5187586plk.208.2024.03.20.21.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 21:21:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com>
Date: Thu, 21 Mar 2024 09:50:57 +0530
Cc: linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>,
 Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A940B76F-8409-4147-8C09-DB2B3FD2EAF5@redhat.com>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 21 Mar 2024, at 09:25, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 20 Mar 2024, at 16:47, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> If the network configuration strings are passed as a combination of =
IPv4
>> and IPv6 addresses, the current KVP daemon does not handle processing =
for
>> the keyfile configuration format.
>> With these changes, the keyfile config generation logic scans through =
the
>> list twice to generate IPv4 and IPv6 sections for the configuration =
files
>> to handle this support.
>>=20
>> Testcases ran:Rhel 9, Hyper-V VMs
>>             (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> ---
>> Changes in v4
>> * Removed the unnecessary memset for addr in the start
>> * Added a comment to describe how we erase the last comma character
>> * Fixed some typos in the commit description
>> * While using strncat, skip copying the '\0' character.
>> ---
>> tools/hv/hv_kvp_daemon.c | 181 =
++++++++++++++++++++++++++++++---------
>> 1 file changed, 140 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>> index 318e2dad27e0..d64d548a802f 100644
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
>> * Only IPv4 subnet strings needs to be converted to plen
>> * For IPv6 the subnet is already privided in plen format
>> @@ -1197,14 +1220,75 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
>> return plen;
>> }
>>=20
>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int =
type,
>> +  int ip_sec)
>> +{
>> + char addr[INET6_ADDRSTRLEN], *output_str;
>> + int ip_offset =3D 0, error =3D 0, ip_ver;
>> + char *param_name;
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
>> + (MAX_IP_ADDR_SIZE * 2)))
>> + break;
>> +
>> + ip_ver =3D ip_version_check(addr);
>> + if (ip_ver < 0)
>> + continue;
>> +
>> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
>> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
>> + /*
>> + * do a bound check to avoid out-of bound writes
>> + */
>> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
>> +    (strlen(addr) + 1)) {
>> + strncat(output_str, addr,
>> + OUTSTR_BUF_SIZE -
>> + strlen(output_str) - 1);
>> + strncat(output_str, ",",
>> + OUTSTR_BUF_SIZE -
>> + strlen(output_str) - 1);
>> + }
>> + } else {
>> + continue;
>> + }
>> + }
>> +
>> + if (strlen(output_str)) {
>> + /*
>> + * This is to get rid of that extra comma character
>> + * in the end of the string
>> + */
>> + output_str[strlen(output_str) - 1] =3D '\0';
>> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
>> + }
>> +
>> + free(output_str);
>> + return error;
>> +}
>> +
>> static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
>> - int is_ipv6)
>> + int ip_sec)
>> {
>> char addr[INET6_ADDRSTRLEN];
>> char subnet_addr[INET6_ADDRSTRLEN];
>> int error, i =3D 0;
>> int ip_offset =3D 0, subnet_offset =3D 0;
>> - int plen;
>> + int plen, ip_ver;
>>=20
>> memset(addr, 0, sizeof(addr));
>> memset(subnet_addr, 0, sizeof(subnet_addr));
>> @@ -1216,10 +1300,16 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>>      subnet_addr,
>>      (MAX_IP_ADDR_SIZE *
>> 2))) {
>> - if (!is_ipv6)
>> + ip_ver =3D ip_version_check(addr);
>> + if (ip_ver < 0)
>> + continue;
>> +
>> + if (ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4)
>> plen =3D kvp_subnet_to_plen((char *)subnet_addr);
>> - else
>> + else if (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)
>> plen =3D atoi(subnet_addr);
>> + else
>> + continue;
>>=20
>> if (plen < 0)
>> return plen;
>> @@ -1238,12 +1328,11 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>>=20
>> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
>> {
>> - int error =3D 0;
>> + int error =3D 0, ip_ver;
>> char if_filename[PATH_MAX];
>> char nm_filename[PATH_MAX];
>> FILE *ifcfg_file, *nmfile;
>> char cmd[PATH_MAX];
>> - int is_ipv6 =3D 0;
>> char *mac_addr;
>> int str_len;
>>=20
>> @@ -1421,52 +1510,62 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> if (error)
>> goto setval_error;
>>=20
>> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>> - error =3D fprintf(nmfile, "\n[ipv6]\n");
>> - if (error < 0)
>> - goto setval_error;
>> - is_ipv6 =3D 1;
>> - } else {
>> - error =3D fprintf(nmfile, "\n[ipv4]\n");
>> - if (error < 0)
>> - goto setval_error;
>> - }
>> -
>> /*
>> - * Now we populate the keyfile format
>> + * The keyfile format expects the IPv6 and IPv4 configuration in
>> + * different sections. Therefore we iterate through the list twice,
>> + * once to populate the IPv4 section and the next time for IPv6
>> */
>> + ip_ver =3D IPV4;
>> + do {
>> + if (ip_ver =3D=3D IPV4) {
>> + error =3D fprintf(nmfile, "\n[ipv4]\n");
>> + if (error < 0)
>> + goto setval_error;
>> + } else {
>> + error =3D fprintf(nmfile, "\n[ipv6]\n");
>> + if (error < 0)
>> + goto setval_error;
>> + }
>>=20
>> - if (new_val->dhcp_enabled) {
>> - error =3D kvp_write_file(nmfile, "method", "", "auto");
>> - if (error < 0)
>> - goto setval_error;
>> - } else {
>> - error =3D kvp_write_file(nmfile, "method", "", "manual");
>> + /*
>> + * Now we populate the keyfile format
>> + */
>> +
>> + if (new_val->dhcp_enabled) {
>> + error =3D kvp_write_file(nmfile, "method", "", "auto");
>> + if (error < 0)
>> + goto setval_error;
>> + } else {
>> + error =3D kvp_write_file(nmfile, "method", "", "manual");
>> + if (error < 0)
>> + goto setval_error;
>=20
> There is a problem with this code. dhcp_enabled is only valid for =
ipv4. =46rom looking at ifcfg files that were generated before, I do not =
see IPV6_AUTOCONF related settings.

So dhcp_enabled comes from running hv_get_shcp_info.sh which greps for =
=E2=80=9Cdhcp=E2=80=9D in ifcfg files. If it is a hit, it sets =
dhcp_enabled to true.
The ifcfg files will have =E2=80=9Cdhcp=E2=80=9D only if it=E2=80=99s =
set in BOOTPROTO=3Ddhcp. So it is indeed ipv4 specific. =20

> So maybe we should set method only for ipv4 and not for ipv6.
>=20
<snip>

>  I am not sure what happens when dhcp_enabled is True and the user =
provides specific IP addresses.

I think in this case, we can assert() or something. This is an invalid =
config.

>=20
>=20
>> + }
>> +
>> + /*
>> + * Write the configuration for ipaddress, netmask, gateway and
>> + * name services
>> + */
>> + error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
>> +     (char *)new_val->sub_net,
>> +     ip_ver);
>> if (error < 0)
>> goto setval_error;
>> - }
>>=20
>> - /*
>> - * Write the configuration for ipaddress, netmask, gateway and
>> - * name services
>> - */
>> - error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
>> -     (char *)new_val->sub_net, is_ipv6);
>> - if (error < 0)
>> - goto setval_error;
>> -
>> - /* we do not want ipv4 addresses in ipv6 section and vice versa */
>> - if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>> - error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> + error =3D process_dns_gateway_nm(nmfile,
>> +       (char *)new_val->gate_way,
>> +       GATEWAY, ip_ver);
>> if (error < 0)
>> goto setval_error;
>> - }
>>=20
>> - if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>> - error =3D fprintf(nmfile, "dns=3D%s\n", (char *)new_val->dns_addr);
>> + error =3D process_dns_gateway_nm(nmfile,
>> +       (char *)new_val->dns_addr, DNS,
>> +       ip_ver);
>> if (error < 0)
>> goto setval_error;
>> - }
>> +
>> + ip_ver++;
>> + } while (ip_ver < IP_TYPE_MAX);
>> +
>> fclose(nmfile);
>> fclose(ifcfg_file);
>>=20
>> --=20
>> 2.34.1



