Return-Path: <linux-kernel+bounces-105698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F387E2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829B1281B47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD9208BB;
	Mon, 18 Mar 2024 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4Hjm3Aj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE8182B5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737830; cv=none; b=PKR0u1YRYBHwg/GiSkLZdWHzjpwPd6Sj4Eff5G7FIzNiqbjKcTYugDBAya8skbisFjp3YszGIlWEDW7QXyo+S9LkOmf4GUSKlOzNooNxYvI8hBZSWOnnTynEOKuhMP5TVFqWkRN2g577DR6/Osrf779lY2iidN0YWhWM++6HImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737830; c=relaxed/simple;
	bh=cG1vsxPol+JsVnTYAytUsNz2/iG1Vgw5HpnpQ8c5I0Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ahc7GtYTXyqdyHIBngaYOX1AlOihWB870iqNdnC0wvWLiBkBpLZcJizN2LJfMydXEQONT6SrpQlx+MI/2lXzJ7TAyHj83hTctfJw0pcEwpbw3m7UQqFp3mZSqycQkk1PyL1OwPkGfV24PQjyFKjWQL5zE46UN0g7AQ6+wpFynQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4Hjm3Aj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710737827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEg7Zb+FkBI3V+qxaXJGDm+0XnS8bP784mT4bHbhFF4=;
	b=f4Hjm3AjL5Uq/OAxIPQU89pLJJiLhybJDjYm2yLv488bftkqMe6FznwWyeCNn4jY8YZACT
	u238JZCi/vhFEh8vg1ru+LmKmz2gZx093IfRhiggUnFVDdwTJxST+ymg/D1ZlDh4V83HJp
	szcsuTTDnYvSNm8B97U+cozVutapwok=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-E3cMaKufP8q_wkG2JLbI1w-1; Mon, 18 Mar 2024 00:57:06 -0400
X-MC-Unique: E3cMaKufP8q_wkG2JLbI1w-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c388a9eae6so802976b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 21:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710737825; x=1711342625;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEg7Zb+FkBI3V+qxaXJGDm+0XnS8bP784mT4bHbhFF4=;
        b=QTDFWEz+tsc85jofCKKPY0EmxB6R5BOaQmdqahO8yyabp4UPBZO5M3QRbforNMMGtj
         N2oxmoUZflHqxrLtYgyccnMt0xGETx/1oerqfr7p5gt8RoEo9NNvewMcNX3j4G0ufUZ0
         cJHaQjZNGChplhGz/qkDL0pG3iiQf557OXwmgj1j6TSIl6Ge7YCGR20ZczXRbbZhTSdG
         l+ZdIe8GWQ53YGX9K8TSa8BIbbKnweZRAcQYauYaVKPb2OYmEAa2Dr8H9q1xvZmPYxyr
         VOE+56CQN9sZB6MWB2Rhra+gDl6e9U0F+YWlHCNc1Ks0DHR0QzDQixZjJV1cn3LeaZQh
         xJTQ==
X-Gm-Message-State: AOJu0YyAWFxSOJZDVw4Ugmb4BRcd8zHglIkinWiz9bdKEsY7T7gb6dYX
	qJgKJmwWq6mHhUI0zql6kWj01yH0ixngkzc7x4vUxIulP2FIQ0KQsJrHn5DMYLUxi9FNJCxceZi
	J+Lze3RkgoVJ103TnY3VXaNBKIj9DRoUFNGoxEL2r7zuqsebIOQhx1AUyO9XMWg==
X-Received: by 2002:a05:6808:1645:b0:3c3:7c53:d6bb with SMTP id az5-20020a056808164500b003c37c53d6bbmr8339400oib.29.1710737825553;
        Sun, 17 Mar 2024 21:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy+U/MX6WzWYYRg70X/ptmF126awCQn5EaRjr+FCALq/HDFe2xYfFT1bTwDXAnPfA2E2YQKA==
X-Received: by 2002:a05:6808:1645:b0:3c3:7c53:d6bb with SMTP id az5-20020a056808164500b003c37c53d6bbmr8339388oib.29.1710737825261;
        Sun, 17 Mar 2024 21:57:05 -0700 (PDT)
Received: from smtpclient.apple ([115.96.153.171])
        by smtp.gmail.com with ESMTPSA id t188-20020a625fc5000000b006e6f8e9ab6asm5343646pfb.15.2024.03.17.21.57.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2024 21:57:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <85394C37-16E1-4AA1-82D4-DEB3D58920A7@redhat.com>
Date: Mon, 18 Mar 2024 10:26:49 +0530
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
Message-Id: <56EA1869-5EFA-4515-AC39-965241C373BF@redhat.com>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
 <85394C37-16E1-4AA1-82D4-DEB3D58920A7@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On 18-Mar-2024, at 09:51, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 18-Mar-2024, at 08:15, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> If the network configuration strings are passed as a combination of =
IPv and
>> IPv6 addresses, the current KVP daemon doesnot handle it for the =
keyfile
>> configuration format.
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
>> * Only IPv4 subnet strings needs to be converted to plen
>> * For IPv6 the subnet is already privided in plen format
>> @@ -1197,14 +1220,71 @@ static int kvp_subnet_to_plen(char =
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
>> + memset(addr, 0, sizeof(addr));
>=20
> ^^^^^^^^^^^^^^^^^^^^^^^^
> Is this still needed?
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
>> + OUTSTR_BUF_SIZE - strlen(output_str));
>> + strncat(output_str, ",",
>=20
> Please see man page for strncat(). Why is the third parameter simply =
not strlen(addr)?=20

I see what you are trying to do. You are doing a bound check here. In =
that case, should this be
OUTSTR_BUF_SIZE - strlen(output_str) - 1 to accommodate the terminating =
NULL? Man page says

> it will use at most n bytes from src

So n bytes from addr and one extra at the end for NULL termination since =
strncat () will add a terminating NULL byte in the end.

>=20
>> + OUTSTR_BUF_SIZE - strlen(output_str));
>=20
>=20
>=20
>> + }
>> + } else {
>> + continue;
>> + }
>> + }
>> +
>> + if (strlen(output_str)) {
>=20
> Please add the comment I mentioned in the previous version as to why =
you are doing this.
>=20
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
>> @@ -1216,10 +1296,16 @@ static int process_ip_string_nm(FILE *f, char =
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
>> @@ -1238,12 +1324,11 @@ static int process_ip_string_nm(FILE *f, char =
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
>> @@ -1421,52 +1506,62 @@ static int kvp_set_ip_info(char *if_name, =
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



