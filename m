Return-Path: <linux-kernel+bounces-105694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3F87E2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FEB1F21C90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5A208CA;
	Mon, 18 Mar 2024 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzd5kiQ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBA208A4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710735727; cv=none; b=VvYIEOzYYsAHt1eTHFnan+j0Tw5rViPy3F4VPHWqGSmj2cITFu9MWWRocSmoCNmay3kpEipxCct86i8EGAW/cNiITvxLarkORPgcz1+rMHL9djjpEGA2A3ktd+6f3uMqh4D+PyHvMh/8fpn6xab21JoyltSJOPXdrpRN18gtDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710735727; c=relaxed/simple;
	bh=uHcp3WHxo/bMjTI79kNYT7VIMA6sKNtW12El5PFR5DI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eFNjTWqPsJcbmYoF6jQ+cILscNali4TPpjfy/KYNIqGd78RUrA6BLYgp8pOr+pRuCFx6g5O2ZY15gurJqZhOfx2twzwqn1AP9QOZ1+Lpo+VE6ipmCLM4jy9wBsf4rkaRvY3hlvwF9qf3RTKKRKgMZ8Z5ETwacHfHA/bigsWnpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tzd5kiQ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710735724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfXBkLOY+uVt0y3vrYC9c4D49cbJrWkB8BSi1VFD81E=;
	b=Tzd5kiQ0k5/Ep9fthNnyZix3GOfkqMdEVSWQmLP/0s32XsITGGEbsVA1DzA6+zsL8AKMDa
	ojPxAXCFcgKX6R33CUfOeTGIve8tZp0I56cPCn0iV3fwTaD5WHpoluVWAj+pkI69GZePPQ
	kyJwoMX3RzTzVSO4yjJOJaoAEJv8aIo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-JDGOTlvnOeCzofx65-wX2w-1; Mon, 18 Mar 2024 00:22:03 -0400
X-MC-Unique: JDGOTlvnOeCzofx65-wX2w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5dcab65d604so3295315a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 21:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710735722; x=1711340522;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfXBkLOY+uVt0y3vrYC9c4D49cbJrWkB8BSi1VFD81E=;
        b=IYT1j5+ndHn71tOSs9KV4zRsLnbyalyqP6FcWQrSp0/MsXnvXzLDVrBhuPmHJKflnd
         TcayKucXXP/nV6IyROF6bu9e3Qjnr++QwJy1UvxHoeP/Ml3/jnc2LuEZ3JmWMxDzjOxw
         OocFVdWSbssppf5jHOsPDsKFjhIyfDXBJen1m8rnAi1e2UDgHsQ/Yb1D0u5dwJ9vnw8X
         RPvpmp/bjlKbvPXsHv2Y+Nx/pZkEECFLOvCRjF8XtNdO9A9EFYZLliH0+++wE/vDqAg4
         DhfYLLrfqz9vWL7KC9p6kBIqcuk5KVf+jol+1j0a/mgVeIWXbvWQd/3vw5jy5Iwo5IW3
         L6qA==
X-Gm-Message-State: AOJu0Yw4H1rtIFEAeCoHpZtjbi5cZufmYkrRcumj8wXNpfPLdsdgB438
	LGI1FgpG0hl/l47NGavwDlz0crtC9vfZk0Nmidxg/aD0YJIf+nQz2Dvt2eByzhGO8ewJtkQl+Eu
	E2t3p/RmFFrXhYRcstTFAbLhjHkbnkWakcngdiiOQrydMqIudN5i+K3dZSRb5+g==
X-Received: by 2002:a05:6a20:3942:b0:1a1:4809:50d3 with SMTP id r2-20020a056a20394200b001a1480950d3mr14458877pzg.54.1710735722367;
        Sun, 17 Mar 2024 21:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9/YNpI33MedaYu8AcjFodmpwB6bmIfb+hHPn4i08Z4Xc9SaqEQhVnlZtbRwMUNcPqh662SA==
X-Received: by 2002:a05:6a20:3942:b0:1a1:4809:50d3 with SMTP id r2-20020a056a20394200b001a1480950d3mr14458870pzg.54.1710735721963;
        Sun, 17 Mar 2024 21:22:01 -0700 (PDT)
Received: from smtpclient.apple ([115.96.153.171])
        by smtp.gmail.com with ESMTPSA id sl4-20020a17090b2e0400b0029c71d2ed4asm6650339pjb.2.2024.03.17.21.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2024 21:22:01 -0700 (PDT)
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
In-Reply-To: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Mon, 18 Mar 2024 09:51:45 +0530
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
Message-Id: <85394C37-16E1-4AA1-82D4-DEB3D58920A7@redhat.com>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On 18-Mar-2024, at 08:15, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> If the network configuration strings are passed as a combination of =
IPv and
> IPv6 addresses, the current KVP daemon doesnot handle it for the =
keyfile
> configuration format.
> With these changes, the keyfile config generation logic scans through =
the
> list twice to generate IPv4 and IPv6 sections for the configuration =
files
> to handle this support.
>=20
> Testcases ran:Rhel 9, Hyper-V VMs
>              (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> Changes in v3
> * Introduced a macro for the output string size
> * Added cound checks and used strncpy instead of strncpy
> * Rearranged code to reduce total lines of code
> ---
> tools/hv/hv_kvp_daemon.c | 177 ++++++++++++++++++++++++++++++---------
> 1 file changed, 136 insertions(+), 41 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..156cef99d361 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,6 +76,12 @@ enum {
> DNS
> };
>=20
> +enum {
> + IPV4 =3D 1,
> + IPV6,
> + IP_TYPE_MAX
> +};
> +
> static int in_hand_shake;
>=20
> static char *os_name =3D "";
> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
>=20
> #define MAX_FILE_NAME 100
> #define ENTRIES_PER_BLOCK 50
> +/*
> + * Change this entry if the number of addresses increases in future
> + */
> +#define MAX_IP_ENTRIES 64
> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
>=20
> struct kvp_record {
> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
> return 0;
> }
>=20
> +int ip_version_check(const char *input_addr)
> +{
> + struct in6_addr addr;
> +
> + if (inet_pton(AF_INET, input_addr, &addr))
> + return IPV4;
> + else if (inet_pton(AF_INET6, input_addr, &addr))
> + return IPV6;
> +
> + return -EINVAL;
> +}
> +
> /*
>  * Only IPv4 subnet strings needs to be converted to plen
>  * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1220,71 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
> return plen;
> }
>=20
> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> +  int ip_sec)
> +{
> + char addr[INET6_ADDRSTRLEN], *output_str;
> + int ip_offset =3D 0, error =3D 0, ip_ver;
> + char *param_name;
> +
> + memset(addr, 0, sizeof(addr));

^^^^^^^^^^^^^^^^^^^^^^^^
Is this still needed?

> +
> + if (type =3D=3D DNS)
> + param_name =3D "dns";
> + else if (type =3D=3D GATEWAY)
> + param_name =3D "gateway";
> + else
> + return -EINVAL;
> +
> + output_str =3D (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
> + if (!output_str)
> + return -ENOMEM;
> +
> + while (1) {
> + memset(addr, 0, sizeof(addr));
> +
> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> + (MAX_IP_ADDR_SIZE * 2)))
> + break;
> +
> + ip_ver =3D ip_version_check(addr);
> + if (ip_ver < 0)
> + continue;
> +
> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
> + /*
> + * do a bound check to avoid out-of bound writes
> + */
> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
> +    (strlen(addr) + 1)) {
> + strncat(output_str, addr,
> + OUTSTR_BUF_SIZE - strlen(output_str));
> + strncat(output_str, ",",

Please see man page for strncat(). Why is the third parameter simply not =
strlen(addr)?=20

> + OUTSTR_BUF_SIZE - strlen(output_str));



> + }
> + } else {
> + continue;
> + }
> + }
> +
> + if (strlen(output_str)) {

Please add the comment I mentioned in the previous version as to why you =
are doing this.

> + output_str[strlen(output_str) - 1] =3D '\0';
> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
> + }
> +
> + free(output_str);
> + return error;
> +}
> +
> static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
> - int is_ipv6)
> + int ip_sec)
> {
> char addr[INET6_ADDRSTRLEN];
> char subnet_addr[INET6_ADDRSTRLEN];
> int error, i =3D 0;
> int ip_offset =3D 0, subnet_offset =3D 0;
> - int plen;
> + int plen, ip_ver;
>=20
> memset(addr, 0, sizeof(addr));
> memset(subnet_addr, 0, sizeof(subnet_addr));
> @@ -1216,10 +1296,16 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>       subnet_addr,
>       (MAX_IP_ADDR_SIZE *
> 2))) {
> - if (!is_ipv6)
> + ip_ver =3D ip_version_check(addr);
> + if (ip_ver < 0)
> + continue;
> +
> + if (ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4)
> plen =3D kvp_subnet_to_plen((char *)subnet_addr);
> - else
> + else if (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)
> plen =3D atoi(subnet_addr);
> + else
> + continue;
>=20
> if (plen < 0)
> return plen;
> @@ -1238,12 +1324,11 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>=20
> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
> {
> - int error =3D 0;
> + int error =3D 0, ip_ver;
> char if_filename[PATH_MAX];
> char nm_filename[PATH_MAX];
> FILE *ifcfg_file, *nmfile;
> char cmd[PATH_MAX];
> - int is_ipv6 =3D 0;
> char *mac_addr;
> int str_len;
>=20
> @@ -1421,52 +1506,62 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> if (error)
> goto setval_error;
>=20
> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> - error =3D fprintf(nmfile, "\n[ipv6]\n");
> - if (error < 0)
> - goto setval_error;
> - is_ipv6 =3D 1;
> - } else {
> - error =3D fprintf(nmfile, "\n[ipv4]\n");
> - if (error < 0)
> - goto setval_error;
> - }
> -
> /*
> - * Now we populate the keyfile format
> + * The keyfile format expects the IPv6 and IPv4 configuration in
> + * different sections. Therefore we iterate through the list twice,
> + * once to populate the IPv4 section and the next time for IPv6
> */
> + ip_ver =3D IPV4;
> + do {
> + if (ip_ver =3D=3D IPV4) {
> + error =3D fprintf(nmfile, "\n[ipv4]\n");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D fprintf(nmfile, "\n[ipv6]\n");
> + if (error < 0)
> + goto setval_error;
> + }
>=20
> - if (new_val->dhcp_enabled) {
> - error =3D kvp_write_file(nmfile, "method", "", "auto");
> - if (error < 0)
> - goto setval_error;
> - } else {
> - error =3D kvp_write_file(nmfile, "method", "", "manual");
> + /*
> + * Now we populate the keyfile format
> + */
> +
> + if (new_val->dhcp_enabled) {
> + error =3D kvp_write_file(nmfile, "method", "", "auto");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D kvp_write_file(nmfile, "method", "", "manual");
> + if (error < 0)
> + goto setval_error;
> + }
> +
> + /*
> + * Write the configuration for ipaddress, netmask, gateway and
> + * name services
> + */
> + error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +     (char *)new_val->sub_net,
> +     ip_ver);
> if (error < 0)
> goto setval_error;
> - }
>=20
> - /*
> - * Write the configuration for ipaddress, netmask, gateway and
> - * name services
> - */
> - error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> -     (char *)new_val->sub_net, is_ipv6);
> - if (error < 0)
> - goto setval_error;
> -
> - /* we do not want ipv4 addresses in ipv6 section and vice versa */
> - if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
> - error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
> + error =3D process_dns_gateway_nm(nmfile,
> +       (char *)new_val->gate_way,
> +       GATEWAY, ip_ver);
> if (error < 0)
> goto setval_error;
> - }
>=20
> - if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
> - error =3D fprintf(nmfile, "dns=3D%s\n", (char *)new_val->dns_addr);
> + error =3D process_dns_gateway_nm(nmfile,
> +       (char *)new_val->dns_addr, DNS,
> +       ip_ver);
> if (error < 0)
> goto setval_error;
> - }
> +
> + ip_ver++;
> + } while (ip_ver < IP_TYPE_MAX);
> +
> fclose(nmfile);
> fclose(ifcfg_file);
>=20
> --=20
> 2.34.1
>=20


