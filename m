Return-Path: <linux-kernel+bounces-110002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732278858C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C541C20957
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10976034;
	Thu, 21 Mar 2024 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKxq8ahm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA959151
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022780; cv=none; b=ITscU0yDbSHyUhYiHEZC/m7Iv6aH2uv5SadPy84c/D91GOYT3Vlske67BZtMw2W6iWGvNiI8o9N//OskChGyNDfFt2wOBIC4m2iax9bdczKrzcqtigHf1kaoIfLogGs+8Y5+IdF31clMUY3ptdo74vHRKWbucXEirSdkoUiyQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022780; c=relaxed/simple;
	bh=QASwfGdSuzy6EEPEnU+sY1VuYAfopJAlnTbZFdE4mMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ViMn2ypc5THR5Ev43AyMLCWfhw+fMLubGwfgkG0Sa6sp7ITWj/wnTmp97LCieAvTJPsLcmiS4uoFdNEvSxZ6CUPS77jD8CdYGRD0FNFOugkWUcJfSTBZ1qXK9f2kLZpUOrrzO1vr4n47JiLNZV01MS5BKhCbKkY6iEi/TCsT99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKxq8ahm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711022777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7c8SHX9PRl72d3TEoBTDUEjPkhyVNdn8tRoFEHvIMNk=;
	b=QKxq8ahmJJBAHIZk96yn2143/Jdo3X2aUct9XnLHM5DQn/cwB8BDSc+yVeBnUatkTlADGA
	LBuVZyH4FSghCCKLJzUXcuPEx/eIQVnqg1CAFKKvL7CLjMxt72xSKmpwfSWrzTMW9OI32J
	R07KMCZtgw+gLp/z7z5FpuqbPh2Nc7M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ztA-M2SFNwGg7YcBNfqvzA-1; Thu, 21 Mar 2024 08:06:15 -0400
X-MC-Unique: ztA-M2SFNwGg7YcBNfqvzA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1def3c93e28so5500555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022775; x=1711627575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c8SHX9PRl72d3TEoBTDUEjPkhyVNdn8tRoFEHvIMNk=;
        b=Ucszrd0t8PQawfeOIBpvEDAAnB/8Hs9AdHlfWI6eVIVdCKjd7mTvqcNcOBsjmmxzW6
         ALP9pOb0qfuycfKqJpUMNTD5GftrFDM8yeKjUXeIufEJJ5hvquna12/jY4lXDNsYojx6
         6cKtICXaxLNc8EVydjPGUSvnaD+LgGZ+CenXw33uEsabIbDOKO1UyKq20jjEb3lD3dCE
         /OeZILJ2jLuxmHuOpMb5xrRODOyl0gy634xO7YVMuySYuA3UlE4gNH0QnphVYpxK+6g2
         j6jQHbyNBn385GO5fInsup4P4qXtKBbqwqlSo6nxxmRVaJNg6tlm5bTYHQMJlOhtixCR
         B+1Q==
X-Gm-Message-State: AOJu0Yz7Wg/Q46PJUouqU5VMEasat94JbQy8T+1vv+R0i4S/fTI5Xr7a
	Suu29gw+5g2uC99zqAzgIQgkYoTyqHLD/BJ0eFF/ASDr1rem1ZgHg6Eu0vsFsrAD4DnhMMYle8p
	mtEDGyj5LEPTpIUXHRbWjdiQES4jnFc4d3krl/GRvyTTMFwUbTsIGupbEdsYAWQ==
X-Received: by 2002:a17:902:d2c4:b0:1de:fbc8:53af with SMTP id n4-20020a170902d2c400b001defbc853afmr21936221plc.25.1711022774695;
        Thu, 21 Mar 2024 05:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqoaUZurKlk6Wnf9uE+37UHv/MGHIPnA2ca16qGUyUI1ZZR8O7rIgCgFJgKWyvSp4NxsJaQ==
X-Received: by 2002:a17:902:d2c4:b0:1de:fbc8:53af with SMTP id n4-20020a170902d2c400b001defbc853afmr21936180plc.25.1711022774260;
        Thu, 21 Mar 2024 05:06:14 -0700 (PDT)
Received: from fc37-ani ([115.96.142.122])
        by smtp.googlemail.com with ESMTPSA id jb2-20020a170903258200b001dd74bc21a9sm8699277plb.291.2024.03.21.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:06:13 -0700 (PDT)
Date: Thu, 21 Mar 2024 17:36:05 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Olaf Hering <olaf@aepfle.de>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
In-Reply-To: <A940B76F-8409-4147-8C09-DB2B3FD2EAF5@redhat.com>
Message-ID: <0aef5a81-8b8c-6165-d05d-77c9cf639ebd@redhat.com>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com> <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com> <A940B76F-8409-4147-8C09-DB2B3FD2EAF5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463778935-701159659-1711022773=:180274"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463778935-701159659-1711022773=:180274
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 21 Mar 2024, Ani Sinha wrote:

>
>
> > On 21 Mar 2024, at 09:25, Ani Sinha <anisinha@redhat.com> wrote:
> >
> >
> >
> >> On 20 Mar 2024, at 16:47, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> >>
> >> If the network configuration strings are passed as a combination of IPv4
> >> and IPv6 addresses, the current KVP daemon does not handle processing for
> >> the keyfile configuration format.
> >> With these changes, the keyfile config generation logic scans through the
> >> list twice to generate IPv4 and IPv6 sections for the configuration files
> >> to handle this support.
> >>
> >> Testcases ran:Rhel 9, Hyper-V VMs
> >>             (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> >> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >> ---
> >> Changes in v4
> >> * Removed the unnecessary memset for addr in the start
> >> * Added a comment to describe how we erase the last comma character
> >> * Fixed some typos in the commit description
> >> * While using strncat, skip copying the '\0' character.
> >> ---
> >> tools/hv/hv_kvp_daemon.c | 181 ++++++++++++++++++++++++++++++---------
> >> 1 file changed, 140 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> >> index 318e2dad27e0..d64d548a802f 100644
> >> --- a/tools/hv/hv_kvp_daemon.c
> >> +++ b/tools/hv/hv_kvp_daemon.c
> >> @@ -76,6 +76,12 @@ enum {
> >> DNS
> >> };
> >>
> >> +enum {
> >> + IPV4 = 1,
> >> + IPV6,
> >> + IP_TYPE_MAX
> >> +};
> >> +
> >> static int in_hand_shake;
> >>
> >> static char *os_name = "";
> >> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
> >>
> >> #define MAX_FILE_NAME 100
> >> #define ENTRIES_PER_BLOCK 50
> >> +/*
> >> + * Change this entry if the number of addresses increases in future
> >> + */
> >> +#define MAX_IP_ENTRIES 64
> >> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
> >>
> >> struct kvp_record {
> >> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> >> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
> >> return 0;
> >> }
> >>
> >> +int ip_version_check(const char *input_addr)
> >> +{
> >> + struct in6_addr addr;
> >> +
> >> + if (inet_pton(AF_INET, input_addr, &addr))
> >> + return IPV4;
> >> + else if (inet_pton(AF_INET6, input_addr, &addr))
> >> + return IPV6;
> >> +
> >> + return -EINVAL;
> >> +}
> >> +
> >> /*
> >> * Only IPv4 subnet strings needs to be converted to plen
> >> * For IPv6 the subnet is already privided in plen format
> >> @@ -1197,14 +1220,75 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
> >> return plen;
> >> }
> >>
> >> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> >> +  int ip_sec)
> >> +{
> >> + char addr[INET6_ADDRSTRLEN], *output_str;
> >> + int ip_offset = 0, error = 0, ip_ver;
> >> + char *param_name;
> >> +
> >> + if (type == DNS)
> >> + param_name = "dns";
> >> + else if (type == GATEWAY)
> >> + param_name = "gateway";
> >> + else
> >> + return -EINVAL;
> >> +
> >> + output_str = (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
> >> + if (!output_str)
> >> + return -ENOMEM;
> >> +
> >> + while (1) {
> >> + memset(addr, 0, sizeof(addr));
> >> +
> >> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> >> + (MAX_IP_ADDR_SIZE * 2)))
> >> + break;
> >> +
> >> + ip_ver = ip_version_check(addr);
> >> + if (ip_ver < 0)
> >> + continue;
> >> +
> >> + if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> >> +    (ip_ver == IPV6 && ip_sec == IPV6)) {
> >> + /*
> >> + * do a bound check to avoid out-of bound writes
> >> + */
> >> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
> >> +    (strlen(addr) + 1)) {
> >> + strncat(output_str, addr,
> >> + OUTSTR_BUF_SIZE -
> >> + strlen(output_str) - 1);
> >> + strncat(output_str, ",",
> >> + OUTSTR_BUF_SIZE -
> >> + strlen(output_str) - 1);
> >> + }
> >> + } else {
> >> + continue;
> >> + }
> >> + }
> >> +
> >> + if (strlen(output_str)) {
> >> + /*
> >> + * This is to get rid of that extra comma character
> >> + * in the end of the string
> >> + */
> >> + output_str[strlen(output_str) - 1] = '\0';
> >> + error = fprintf(f, "%s=%s\n", param_name, output_str);
> >> + }
> >> +
> >> + free(output_str);
> >> + return error;
> >> +}
> >> +
> >> static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >> - int is_ipv6)
> >> + int ip_sec)
> >> {
> >> char addr[INET6_ADDRSTRLEN];
> >> char subnet_addr[INET6_ADDRSTRLEN];
> >> int error, i = 0;
> >> int ip_offset = 0, subnet_offset = 0;
> >> - int plen;
> >> + int plen, ip_ver;
> >>
> >> memset(addr, 0, sizeof(addr));
> >> memset(subnet_addr, 0, sizeof(subnet_addr));
> >> @@ -1216,10 +1300,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >>      subnet_addr,
> >>      (MAX_IP_ADDR_SIZE *
> >> 2))) {
> >> - if (!is_ipv6)
> >> + ip_ver = ip_version_check(addr);
> >> + if (ip_ver < 0)
> >> + continue;
> >> +
> >> + if (ip_ver == IPV4 && ip_sec == IPV4)
> >> plen = kvp_subnet_to_plen((char *)subnet_addr);
> >> - else
> >> + else if (ip_ver == IPV6 && ip_sec == IPV6)
> >> plen = atoi(subnet_addr);
> >> + else
> >> + continue;
> >>
> >> if (plen < 0)
> >> return plen;
> >> @@ -1238,12 +1328,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >>
> >> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> {
> >> - int error = 0;
> >> + int error = 0, ip_ver;
> >> char if_filename[PATH_MAX];
> >> char nm_filename[PATH_MAX];
> >> FILE *ifcfg_file, *nmfile;
> >> char cmd[PATH_MAX];
> >> - int is_ipv6 = 0;
> >> char *mac_addr;
> >> int str_len;
> >>
> >> @@ -1421,52 +1510,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> if (error)
> >> goto setval_error;
> >>
> >> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> >> - error = fprintf(nmfile, "\n[ipv6]\n");
> >> - if (error < 0)
> >> - goto setval_error;
> >> - is_ipv6 = 1;
> >> - } else {
> >> - error = fprintf(nmfile, "\n[ipv4]\n");
> >> - if (error < 0)
> >> - goto setval_error;
> >> - }
> >> -
> >> /*
> >> - * Now we populate the keyfile format
> >> + * The keyfile format expects the IPv6 and IPv4 configuration in
> >> + * different sections. Therefore we iterate through the list twice,
> >> + * once to populate the IPv4 section and the next time for IPv6
> >> */
> >> + ip_ver = IPV4;
> >> + do {
> >> + if (ip_ver == IPV4) {
> >> + error = fprintf(nmfile, "\n[ipv4]\n");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + } else {
> >> + error = fprintf(nmfile, "\n[ipv6]\n");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + }
> >>
> >> - if (new_val->dhcp_enabled) {
> >> - error = kvp_write_file(nmfile, "method", "", "auto");
> >> - if (error < 0)
> >> - goto setval_error;
> >> - } else {
> >> - error = kvp_write_file(nmfile, "method", "", "manual");
> >> + /*
> >> + * Now we populate the keyfile format
> >> + */
> >> +
> >> + if (new_val->dhcp_enabled) {
> >> + error = kvp_write_file(nmfile, "method", "", "auto");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + } else {
> >> + error = kvp_write_file(nmfile, "method", "", "manual");
> >> + if (error < 0)
> >> + goto setval_error;
> >
> > There is a problem with this code. dhcp_enabled is only valid for ipv4. From looking at ifcfg files that were generated before, I do not see IPV6_AUTOCONF related settings.
>
> So dhcp_enabled comes from running hv_get_shcp_info.sh which greps for “dhcp” in ifcfg files. If it is a hit, it sets dhcp_enabled to true.
> The ifcfg files will have “dhcp” only if it’s set in BOOTPROTO=dhcp. So it is indeed ipv4 specific.
>
> > So maybe we should set method only for ipv4 and not for ipv6.

After some internal testing, it seems we need to set some method for both,
otherwise, nm is complaining. Therefore, I propose the following patch

From e1c3f4ece2c4bd191369582d84b8b508db5b5510 Mon Sep 17 00:00:00 2001
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 21 Mar 2024 10:00:26 +0530
Subject: [PATCH] Handle dhcp configuration properly for ipv4 and ipv6

dhcp_enabled is only valid for ipv4. So do not set dhcp methods for ipv6 based
on dhcp_enabled flag. For ipv4, set method to manual only when dhcp_enabled is
false and specific ipv4 addresses are configured. If neither dhcp_enabled is
true and no ipv4 addresses are configured, set method to 'disabled'.

For ipv6, set method to manual when we configure ipv6 addresses. Otherwise set
method to 'auto' so that SLAAC from RA may be used.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hv_kvp_daemon.c | 57 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/hv_kvp_daemon.c b/hv_kvp_daemon.c
index b368d3d..a0e6e4a 100644
--- a/hv_kvp_daemon.c
+++ b/hv_kvp_daemon.c
@@ -1286,7 +1286,7 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
 {
 	char addr[INET6_ADDRSTRLEN];
 	char subnet_addr[INET6_ADDRSTRLEN];
-	int error, i = 0;
+	int error = 0, i = 0;
 	int ip_offset = 0, subnet_offset = 0;
 	int plen, ip_ver;

@@ -1323,7 +1323,7 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
 		memset(subnet_addr, 0, sizeof(subnet_addr));
 	}

-	return 0;
+	return error;
 }

 static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
@@ -1511,6 +1511,8 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		goto setval_error;

 	/*
+	 * Now we populate the keyfile format
+	 *
 	 * The keyfile format expects the IPv6 and IPv4 configuration in
 	 * different sections. Therefore we iterate through the list twice,
 	 * once to populate the IPv4 section and the next time for IPv6
@@ -1527,20 +1529,6 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 				goto setval_error;
 		}

-		/*
-		 * Now we populate the keyfile format
-		 */
-
-		if (new_val->dhcp_enabled) {
-			error = kvp_write_file(nmfile, "method", "", "auto");
-			if (error < 0)
-				goto setval_error;
-		} else {
-			error = kvp_write_file(nmfile, "method", "", "manual");
-			if (error < 0)
-				goto setval_error;
-		}
-
 		/*
 		 * Write the configuration for ipaddress, netmask, gateway and
 		 * name services
@@ -1551,6 +1539,43 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		if (error < 0)
 			goto setval_error;

+		if (ip_ver == IPV4) {
+			if (new_val->dhcp_enabled) {
+				error = kvp_write_file(nmfile, "method", "", "auto");
+				if (error < 0)
+					goto setval_error;
+			} else if (error) {
+				/* if ipv4 addresses were written, set method to 'manual' */
+				error = kvp_write_file(nmfile, "method", "", "manual");
+				if (error < 0)
+					goto setval_error;
+			} else {
+				/*
+				 * if no ipv4 addresses were set and dhcp was not enabled,
+				 * disable ipv4 configuration.
+				 */
+				error = kvp_write_file(nmfile, "method", "", "disabled");
+				if (error < 0)
+					goto setval_error;
+			}
+
+		} else if (ip_ver == IPV6) {
+			if (error) {
+				/* if ipv6 addresses were written, set method to 'manual' */
+				error = kvp_write_file(nmfile, "method", "", "manual");
+				if (error < 0)
+					goto setval_error;
+			} else {
+				/*
+				 * By default for ipv6, set method to 'auto' so that
+				 * SLAAC in RA can be used to configure the interface
+				 */
+				error = kvp_write_file(nmfile, "method", "", "auto");
+				if (error < 0)
+					goto setval_error;
+			}
+		}
+
 		error = process_dns_gateway_nm(nmfile,
 					       (char *)new_val->gate_way,
 					       GATEWAY, ip_ver);
-- 
2.39.2

---1463778935-701159659-1711022773=:180274--


