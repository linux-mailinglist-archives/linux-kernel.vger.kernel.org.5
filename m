Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF557C8491
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMLh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJMLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B93BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697197018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pF15XygFloOozryAGUo8TahP/F6mG8TLjwDT4KymxWk=;
        b=Qe5/HH/EZWDgLDS45798ieCULAuf/wSHXqnp/IGQk6B88lUf++a/6iSvrlw+jQk9nRwjrE
        uKLEDMPPdwzmhogt0TKfrHFBjEEZZQ1IdeRDQgsfgWh58WPsG+KM1ED+pj3FPlU4MNFopU
        Sg02DiueRkvKRY68+HNW6qle2ayAVQY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-nBd9omM9O-yhig3NC63b5Q-1; Fri, 13 Oct 2023 07:36:50 -0400
X-MC-Unique: nBd9omM9O-yhig3NC63b5Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-278f5b7a960so1782221a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197009; x=1697801809;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF15XygFloOozryAGUo8TahP/F6mG8TLjwDT4KymxWk=;
        b=J5IBaDzt9Cg7F88U7hVncm+AmgrntxP/2CpCalXKuR0LcvTg/c0Q9nxvEoOUqpW6Wk
         CO+1jGxK7b9Ru54nrZsKx4BsqdyhWCzq5Hx3j3q6QE/F7YhPKAelloybLEOa1PJW8P1M
         aB5FV9eeu5FgNtdaUOhoIBS/xsBWvYiXd0eWatvOHvHmF4mnuLO14+cKhMEWOoENzP4W
         40XriKYEEGXAqn7Thg+HZ5G6e7xTcRz5wlDhrt9YIqct+AWnBUZblHznV8+nVaB8lnYC
         i9OqmRVI83FTNz14ib5xWP8pwdYc3cVW9+1kf8KtrTR2j8vJiPZOBXrpvzQdnXFW9cuf
         iCGQ==
X-Gm-Message-State: AOJu0YzGQmxR7x3905EL2+N0PDxkWkOInMXtkYVzfmiIyPvZngYE5pcG
        721svL/1DxbFu6Mxk5ncFotbrE1KbOwNpFYjrXQOCKm2GzTkrft7s39z8Nc48JVq7QjNRnc5Za2
        8pbXz/V34YD4ctELw7DGetGSB
X-Received: by 2002:a17:902:f691:b0:1c6:1bf9:d88d with SMTP id l17-20020a170902f69100b001c61bf9d88dmr33937899plg.44.1697197009170;
        Fri, 13 Oct 2023 04:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDT56ZjyVURuxMXlJJkfipcPICYRHoXq1KPs69IFzTP4U9lLuTksWRIoEQ2o8VB4J4iEH8dw==
X-Received: by 2002:a17:902:f691:b0:1c6:1bf9:d88d with SMTP id l17-20020a170902f69100b001c61bf9d88dmr33937883plg.44.1697197008754;
        Fri, 13 Oct 2023 04:36:48 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.235])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001b8b2b95068sm3693951plc.204.2023.10.13.04.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2023 04:36:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection
 profile
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
Date:   Fri, 13 Oct 2023 17:06:39 +0530
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD6E2C28-FB03-4A3B-810D-98D70B6573AE@redhat.com>
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13-Oct-2023, at 3:06 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 09-Oct-2023, at 4:08 PM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> Ifcfg config file support in NetworkManger is deprecated. This patch
>> provides support for the new keyfile config format for connection
>> profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
>> to generate the new network configuration in keyfile
>> format(.ini-style format) along with a ifcfg format configuration.
>> The ifcfg format configuration is also retained to support easy
>> backward compatibility for distro vendors. These configurations are
>> stored in temp files which are further translated using the
>> hv_set_ifconfig.sh script. This script is implemented by individual
>> distros based on the network management commands supported.
>> For example, RHEL's implementation could be found here:
>> =
https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_s=
et_ifconfig.sh
>> Debian's implementation could be found here:
>> =
https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_if=
config
>>=20
>> The next part of this support is to let the Distro vendors consume
>> these modified implementations to the new configuration format.
>>=20
>> Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
>=20
> Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 =
addresses in ipv6 section:
>=20
> ]# cat eth0.nmconnection=20
>=20
> [connection]
> autoconnect=3Dyes
> interface-name=3Deth0
>=20
> [ethernet]
> mac-address=3D00:15:5D:C4:63:45
>=20
> [ipv6]
> method=3Dmanual
> address=3D1234:1234:1234:1234:0000:0000:0000:0113/120
> gateway=3D10.73.199.254
> dns=3D10.72.17.5
>=20
> Gateway and dns should be in ipv6.=20
>=20
> Ipv4 dns addresses comes from /etc/resolv.conf and in our system:
>=20
> # /usr/libexec/hypervkvpd/hv_get_dns_info
> 10.72.17.5
> 10.68.5.26
>=20
> [root@vm-197-248 ~]# cat /etc/resolv.conf=20
> # Generated by NetworkManager
> search lab.eng.pek2.redhat.com
> nameserver 10.72.17.5
> nameserver 10.68.5.26
>=20
> So we should check if the addresses are indeed ipv6 or not and should =
not print it if !is_ipv4(). Ipv6 addresses may not be provisioned.
>=20
> I will post a patch fix when we complete our internal testing.
>=20
>=20
>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> ---
>> Changes v7->v8
>> * Fix some filename variable names to avoid confusion
>> * Add initialization of is_ipv6 variable
>> * Add a few comments
>> ---
>> tools/hv/hv_kvp_daemon.c    | 233 =
+++++++++++++++++++++++++++++++-----
>> tools/hv/hv_set_ifconfig.sh |  39 +++++-
>> 2 files changed, 235 insertions(+), 37 deletions(-)
>>=20
>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>> index 27f5e7dfc2f7..264eeb9c46a9 100644
>> --- a/tools/hv/hv_kvp_daemon.c
>> +++ b/tools/hv/hv_kvp_daemon.c
>> @@ -1171,12 +1171,79 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
>> 	return 0;
>> }
>>=20
>> +/*
>> + * Only IPv4 subnet strings needs to be converted to plen
>> + * For IPv6 the subnet is already privided in plen format
>> + */
>> +static int kvp_subnet_to_plen(char *subnet_addr_str)
>> +{
>> +	int plen =3D 0;
>> +	struct in_addr subnet_addr4;
>> +
>> +	/*
>> +	 * Convert subnet address to binary representation
>> +	 */
>> +	if (inet_pton(AF_INET, subnet_addr_str, &subnet_addr4) =3D=3D 1) =
{
>> +		uint32_t subnet_mask =3D ntohl(subnet_addr4.s_addr);
>> +
>> +		while (subnet_mask & 0x80000000) {
>> +			plen++;
>> +			subnet_mask <<=3D 1;
>> +		}
>> +	} else {
>> +		return -1;
>> +	}
>> +
>> +	return plen;
>> +}
>> +
>> +static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
>> +				int is_ipv6)
>> +{
>> +	char addr[INET6_ADDRSTRLEN];
>> +	char subnet_addr[INET6_ADDRSTRLEN];
>> +	int error, i =3D 0;
>=20
> This should be initialised to 1

Sorry we already do a ++i and not i++ so it should be fine.

>=20
> =
https://developer-old.gnome.org/NetworkManager/stable/nm-settings-keyfile.=
html#:~:text=3DFile%20Format,%2Dsettings(5)).
>=20
> Also see below.
>=20
>> +	int ip_offset =3D 0, subnet_offset =3D 0;
>> +	int plen;
>> +
>> +	memset(addr, 0, sizeof(addr));
>> +	memset(subnet_addr, 0, sizeof(subnet_addr));
>> +
>> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
>> +				   (MAX_IP_ADDR_SIZE * 2)) &&
>> +				   parse_ip_val_buffer(subnet,
>> +						       &subnet_offset,
>> +						       subnet_addr,
>> +						       (MAX_IP_ADDR_SIZE =
*
>> +							2))) {
>> +		if (!is_ipv6)
>> +			plen =3D kvp_subnet_to_plen((char =
*)subnet_addr);
>> +		else
>> +			plen =3D atoi(subnet_addr);
>> +
>> +		if (plen < 0)
>> +			return plen;
>> +
>> +		error =3D fprintf(f, "address%d=3D%s/%d\n", ++i, (char =
*)addr,
>> +				plen);
>> +		if (error < 0)
>> +			return error;
>> +
>> +		memset(addr, 0, sizeof(addr));
>> +		memset(subnet_addr, 0, sizeof(subnet_addr));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
>> {
>> 	int error =3D 0;
>> -	char if_file[PATH_MAX];
>> -	FILE *file;
>> +	char if_filename[PATH_MAX];
>> +	char nm_filename[PATH_MAX];
>> +	FILE *ifcfg_file, *nmfile;
>> 	char cmd[PATH_MAX];
>> +	int is_ipv6 =3D 0;
>> 	char *mac_addr;
>> 	int str_len;
>>=20
>> @@ -1197,7 +1264,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	 * in a given distro to configure the interface and so are free
>> 	 * ignore information that may not be relevant.
>> 	 *
>> -	 * Here is the format of the ip configuration file:
>> +	 * Here is the ifcfg format of the ip configuration file:
>> 	 *
>> 	 * HWADDR=3Dmacaddr
>> 	 * DEVICE=3Dinterface name
>> @@ -1220,6 +1287,32 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	 * tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
>> 	 * IPV6NETMASK.
>> 	 *
>> +	 * Here is the keyfile format of the ip configuration file:
>> +	 *
>> +	 * [ethernet]
>> +	 * mac-address=3Dmacaddr
>> +	 * [connection]
>> +	 * interface-name=3Dinterface name
>> +	 *
>> +	 * [ipv4]
>> +	 * method=3D<protocol> (where <protocol> is "auto" if DHCP is =
configured
>> +	 *                       or "manual" if no boot-time protocol =
should be used)
>> +	 *
>> +	 * address1=3Dipaddr1/plen
>> +	 * address2=3Dipaddr2/plen
>> +	 *
>> +	 * gateway=3Dgateway1;gateway2
>> +	 *
>> +	 * dns=3Ddns1;dns2
>> +	 *
>> +	 * [ipv6]
>> +	 * address1=3Dipaddr1/plen
>> +	 * address2=3Dipaddr2/plen
>> +	 *
>> +	 * gateway=3Dgateway1;gateway2
>> +	 *
>> +	 * dns=3Ddns1;dns2
>> +	 *
>> 	 * The host can specify multiple ipv4 and ipv6 addresses to be
>> 	 * configured for the interface. Furthermore, the configuration
>> 	 * needs to be persistent. A subsequent GET call on the =
interface
>> @@ -1227,14 +1320,29 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	 * call.
>> 	 */
>>=20
>> -	snprintf(if_file, sizeof(if_file), "%s%s%s", KVP_CONFIG_LOC,
>> -		"/ifcfg-", if_name);
>> +	/*
>> +	 * We are populating both ifcfg and nmconnection files
>> +	 */
>> +	snprintf(if_filename, sizeof(if_filename), "%s%s%s", =
KVP_CONFIG_LOC,
>> +		 "/ifcfg-", if_name);
>>=20
>> -	file =3D fopen(if_file, "w");
>> +	ifcfg_file =3D fopen(if_filename, "w");
>>=20
>> -	if (file =3D=3D NULL) {
>> +	if (!ifcfg_file) {
>> 		syslog(LOG_ERR, "Failed to open config file; error: %d =
%s",
>> -				errno, strerror(errno));
>> +		       errno, strerror(errno));
>> +		return HV_E_FAIL;
>> +	}
>> +
>> +	snprintf(nm_filename, sizeof(nm_filename), "%s%s%s%s", =
KVP_CONFIG_LOC,
>> +		 "/", if_name, ".nmconnection");
>> +
>> +	nmfile =3D fopen(nm_filename, "w");
>> +
>> +	if (!nmfile) {
>> +		syslog(LOG_ERR, "Failed to open config file; error: %d =
%s",
>> +		       errno, strerror(errno));
>> +		fclose(ifcfg_file);
>> 		return HV_E_FAIL;
>> 	}
>>=20
>> @@ -1248,14 +1356,31 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 		goto setval_error;
>> 	}
>>=20
>> -	error =3D kvp_write_file(file, "HWADDR", "", mac_addr);
>> -	free(mac_addr);
>> +	error =3D kvp_write_file(ifcfg_file, "HWADDR", "", mac_addr);
>> +	if (error < 0)
>> +		goto setmac_error;
>> +
>> +	error =3D kvp_write_file(ifcfg_file, "DEVICE", "", if_name);
>> +	if (error < 0)
>> +		goto setmac_error;
>> +
>> +	error =3D fprintf(nmfile, "\n[connection]\n");
>> +	if (error < 0)
>> +		goto setmac_error;
>> +
>> +	error =3D kvp_write_file(nmfile, "interface-name", "", if_name);
>> 	if (error)
>> -		goto setval_error;
>> +		goto setmac_error;
>>=20
>> -	error =3D kvp_write_file(file, "DEVICE", "", if_name);
>> +	error =3D fprintf(nmfile, "\n[ethernet]\n");
>> +	if (error < 0)
>> +		goto setmac_error;
>> +
>> +	error =3D kvp_write_file(nmfile, "mac-address", "", mac_addr);
>> 	if (error)
>> -		goto setval_error;
>> +		goto setmac_error;
>> +
>> +	free(mac_addr);
>>=20
>> 	/*
>> 	 * The dhcp_enabled flag is only for IPv4. In the case the host =
only
>> @@ -1263,47 +1388,91 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	 * proceed to parse and pass the IPv6 information to the
>> 	 * disto-specific script hv_set_ifconfig.
>> 	 */
>> +
>> +	/*
>> +	 * First populate the ifcfg file format
>> +	 */
>> 	if (new_val->dhcp_enabled) {
>> -		error =3D kvp_write_file(file, "BOOTPROTO", "", "dhcp");
>> +		error =3D kvp_write_file(ifcfg_file, "BOOTPROTO", "", =
"dhcp");
>> 		if (error)
>> 			goto setval_error;
>> -
>> 	} else {
>> -		error =3D kvp_write_file(file, "BOOTPROTO", "", "none");
>> +		error =3D kvp_write_file(ifcfg_file, "BOOTPROTO", "", =
"none");
>> 		if (error)
>> 			goto setval_error;
>> 	}
>>=20
>> -	/*
>> -	 * Write the configuration for ipaddress, netmask, gateway and
>> -	 * name servers.
>> -	 */
>> -
>> -	error =3D process_ip_string(file, (char *)new_val->ip_addr, =
IPADDR);
>> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->ip_addr,
>> +				  IPADDR);
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	error =3D process_ip_string(file, (char *)new_val->sub_net, =
NETMASK);
>> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->sub_net,
>> +				  NETMASK);
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	error =3D process_ip_string(file, (char *)new_val->gate_way, =
GATEWAY);
>> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->gate_way,
>> +				  GATEWAY);
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	error =3D process_ip_string(file, (char *)new_val->dns_addr, =
DNS);
>> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->dns_addr, DNS);
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	fclose(file);
>> +	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>=20
> I think we should have done something like
>=20
> new_val->addr_family & ADDR_FAMILY_IPV6 here.
>=20
>> +		error =3D fprintf(nmfile, "\n[ipv6]\n");
>> +		if (error < 0)
>> +			goto setval_error;
>> +		is_ipv6 =3D 1;
>> +	} else {
>> +		error =3D fprintf(nmfile, "\n[ipv4]\n");
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>> +
>> +	/*
>> +	 * Now we populate the keyfile format
>> +	 */
>> +
>> +	if (new_val->dhcp_enabled) {
>> +		error =3D kvp_write_file(nmfile, "method", "", "auto");
>> +		if (error < 0)
>> +			goto setval_error;
>> +	} else {
>> +		error =3D kvp_write_file(nmfile, "method", "", =
"manual");
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>> +
>> +	/*
>> +	 * Write the configuration for ipaddress, netmask, gateway and
>> +	 * name services
>> +	 */
>> +	error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
>> +				     (char *)new_val->sub_net, is_ipv6);
>> +	if (error < 0)
>> +		goto setval_error;
>> +
>> +	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> +	if (error < 0)
>> +		goto setval_error;
>> +
>> +	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>> +	if (error < 0)
>> +		goto setval_error;
>> +
>> +	fclose(nmfile);
>> +	fclose(ifcfg_file);
>>=20
>> 	/*
>> 	 * Now that we have populated the configuration file,
>> 	 * invoke the external script to do its magic.
>> 	 */
>>=20
>> -	str_len =3D snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
>> -			   "hv_set_ifconfig", if_file);
>> +	str_len =3D snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s =
%s",
>> +			   "hv_set_ifconfig", if_filename, nm_filename);
>> 	/*
>> 	 * This is a little overcautious, but it's necessary to suppress =
some
>> 	 * false warnings from gcc 8.0.1.
>> @@ -1316,14 +1485,16 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>=20
>> 	if (system(cmd)) {
>> 		syslog(LOG_ERR, "Failed to execute cmd '%s'; error: %d =
%s",
>> -				cmd, errno, strerror(errno));
>> +		       cmd, errno, strerror(errno));
>> 		return HV_E_FAIL;
>> 	}
>> 	return 0;
>> -
>> +setmac_error:
>> +	free(mac_addr);
>> setval_error:
>> 	syslog(LOG_ERR, "Failed to write config file");
>> -	fclose(file);
>> +	fclose(ifcfg_file);
>> +	fclose(nmfile);
>> 	return error;
>> }
>>=20
>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>> index d10fe35b7f25..ae5a7a8249a2 100755
>> --- a/tools/hv/hv_set_ifconfig.sh
>> +++ b/tools/hv/hv_set_ifconfig.sh
>> @@ -18,12 +18,12 @@
>> #
>> # This example script is based on a RHEL environment.
>> #
>> -# Here is the format of the ip configuration file:
>> +# Here is the ifcfg format of the ip configuration file:
>> #
>> # HWADDR=3Dmacaddr
>> # DEVICE=3Dinterface name
>> # BOOTPROTO=3D<protocol> (where <protocol> is "dhcp" if DHCP is =
configured
>> -#                       or "none" if no boot-time protocol should be =
used)
>> +# 			or "none" if no boot-time protocol should be =
used)
>> #
>> # IPADDR0=3Dipaddr1
>> # IPADDR1=3Dipaddr2
>> @@ -41,6 +41,32 @@
>> # tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
>> # IPV6NETMASK.
>> #
>> +# Here is the keyfile format of the ip configuration file:
>> +#
>> +# [ethernet]
>> +# mac-address=3Dmacaddr
>> +# [connection]
>> +# interface-name=3Dinterface name
>> +#
>> +# [ipv4]
>> +# method=3D<protocol> (where <protocol> is "auto" if DHCP is =
configured
>> +#                       or "manual" if no boot-time protocol should =
be used)
>> +#
>> +# address1=3Dipaddr1/plen
>> +# address=3Dipaddr2/plen
>=20
> address2 here?
>=20
>> +#
>> +# gateway=3Dgateway1;gateway2
>> +#
>> +# dns=3Ddns1;
>> +#
>> +# [ipv6]
>> +# address1=3Dipaddr1/plen
>> +# address2=3Dipaddr1/plen
>=20
> ipaddr2 ?
>=20
>> +#
>> +# gateway=3Dgateway1;gateway2
>> +#
>> +# dns=3Ddns1;dns2
>> +#
>> # The host can specify multiple ipv4 and ipv6 addresses to be
>> # configured for the interface. Furthermore, the configuration
>> # needs to be persistent. A subsequent GET call on the interface
>> @@ -48,18 +74,19 @@
>> # call.
>> #
>>=20
>> -
>> -
>> echo "IPV6INIT=3Dyes" >> $1
>> echo "NM_CONTROLLED=3Dno" >> $1
>> echo "PEERDNS=3Dyes" >> $1
>> echo "ONBOOT=3Dyes" >> $1
>>=20
>> -
>> cp $1 /etc/sysconfig/network-scripts/
>>=20
>> +chmod 600 $2
>> +interface=3D$(echo $2 | awk -F - '{ print $2 }')
>> +filename=3D"${2##*/}"
>> +
>> +sed '/\[connection\]/a autoconnect=3Dtrue' $2 > =
/etc/NetworkManager/system-connections/${filename}
>>=20
>> -interface=3D$(echo $1 | awk -F - '{ print $2 }')
>>=20
>> /sbin/ifdown $interface 2>/dev/null
>> /sbin/ifup $interface 2>/dev/null
>> --=20
>> 2.34.1

