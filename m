Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E779C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjILDqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbjILDqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:46:42 -0400
X-Greylist: delayed 4191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 20:02:31 PDT
Received: from dd20004.kasserver.com (dd20004.kasserver.com [85.13.150.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D3D2F8DC;
        Mon, 11 Sep 2023 20:02:31 -0700 (PDT)
Received: from dd20004.kasserver.com (dd0806.kasserver.com [85.13.161.252])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id 5B4B663206F5;
        Mon, 11 Sep 2023 23:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202306171005; t=1694468270;
        bh=NprytfYbabiRAgw4VgPgFDS2yMnAjS7bJnBm+rC11GM=;
        h=Subject:To:Cc:From:Date:From;
        b=LaWtp9X4NRzCOkQCf+VjZg0Pm3AWhOfNYBvV+WE5Aft5nQoemJN6Hi3ryNpbUIHro
         bnL7IXM6YdQ7eLNaCxS1ZvXfdna0UDnnaYLtfLcgAKnWHOMuCjQHKcirQlAwQDaAW7
         g2doklLG1VJueOXfoAFd3v8PPPtjsHaPw1O8FDHiWnfFWz+bVpEcG8oS+7XNEv5D+9
         gX3kon0DppSSIMgpPOaC+8kR4A5F6kW0yOQkmyvUoYp6Un1veiCXaPrz5XgY+40GN+
         6xmx0U0r7L6eMnSDb8HHP2AE1fbiBdrBV0anwnnA6vl8WGTgi+v7DGYlkXnhAdk4Q1
         5TaGzoEU+S+pg==
Subject: Regression: Commit "netfilter: nf_tables: disallow rule addition to
 bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, sashal@kernel.org
Cc:     carnil@debian.org, 1051592@bugs.debian.org
From:   "Timo Sigurdsson" <public_timo.s@silentcreek.de>
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 89.246.185.131
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_344776ddfbe3fdbc8193f4a0f43d1d1c"
Message-Id: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
Date:   Mon, 11 Sep 2023 23:37:50 +0200 (CEST)
X-Spamd-Bar: ---
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format  --  Dies ist eine mehrteilige Nachricht im MIME-Format
--=_344776ddfbe3fdbc8193f4a0f43d1d1c
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8

Hi,

recently, Debian updated their stable kernel from 6.1.38 to 6.1.52 which broke nftables ruleset loading on one of my machines with lots of "Operation not supported" errors. I've reported this to the Debian project (see link below) and Salvatore Bonaccorso and I identified "netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit that introduced the regression. Salvatore also found that this issue affects the 5.10 stable tree as well (observed in 5.10.191), but he cannot reproduce it on 6.4.13 and 6.5.2.

The issue only occurs with some rulesets. While I can't trigger it with simple/minimal rulesets that I use on some machines, it does occur with a more complex ruleset that has been in use for months (if not years, for large parts of it). I'm attaching a somewhat stripped down version of the ruleset from the machine I originally observed this issue on. It's still not a small or simple ruleset, but I'll try to reduce it further when I have more time.

The error messages shown when trying to load the ruleset don't seem to be helpful. Just two simple examples:
Just to give two simple examples from the log when nftables fails to start:
/etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not supported
                        tcp option maxseg size 1-500 counter drop
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not supported
                        tcp dport sip-tls accept
                        ^^^^^^^^^^^^^^^^^^^^^^^^

Since the issue only affects some stable trees, Salvatore thought it might be an incomplete backport that causes this.

If you need further information, please let me know.


Thanks and kind regards,

Timo


#regzbot introduced: 0ebc1064e487
#regzbot monitor: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1051592
--=_344776ddfbe3fdbc8193f4a0f43d1d1c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name=nftables.conf
Content-Disposition: attachment;
 filename=nftables.conf

#!/usr/sbin/nft -f

flush ruleset

define public_if = eth0
define trusted_if = eth1
define voip_if = eth2.10
define guest_if = eth2.20
define home_if = { $trusted_if, $voip_if, $guest_if }
define home_ipv6_if = { $trusted_if, $voip_if, $guest_if }

define masq_ip = { 192.168.1.0/24, 192.168.2.0/24, 192.168.3.0/24, 192.168.4.0/24 }
define masq_if = $public_if

define host1_ip = 192.168.1.10
define host2_ip = 192.168.2.20
define host3_ip = 192.168.3.30
define host4_ip = 192.168.4.40

define proxy_port = 8443

define private_ip = { 192.168.0.0/16, 172.16.0.0/12, 10.0.0.0/8 }
define private_ip6 = { fe80::/64, fd00::/8 }
define bogons_ip = { 0.0.0.0/8, 10.0.0.0/8, 100.64.0.0/10, 127.0.0.0/8, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/3 }
define bogons_ip6 = { ::/3, 2001:0002::/48, 2001:0003::/32, 2001:10::/28, 2001:20::/28, 2001::/32, 2001:db8::/32, 2002::/16, 3000::/4, 4000::/2, 8000::/1 }

define sip_whitelist_ip6 = { 2001:db8::1/128, 2001:db8::2/128 }
define smtps_whitelist_ip = 10.0.0.1
define protocol_whitelist = { tcp, udp, icmp, ipv6-icmp }

table inet filter {
	map if_input {
		type ifname : verdict;
		elements = { $public_if : jump public_input, $trusted_if : jump home_input, $voip_if : jump home_input, $guest_if : jump home_input }
	}
	map if_forward {
		type ifname : verdict;
		elements = { $public_if : jump public_forward, $trusted_if : jump trusted_forward, $voip_if : jump voip_forward, $guest_if : jump guest_forward }
	}
	map if_output {
		type ifname : verdict;
		elements = { $public_if : jump public_output, $trusted_if : jump home_output, $voip_if : jump home_output, $guest_if : jump home_output }
	}

	set ipv4_blacklist { type ipv4_addr; flags interval; auto-merge; }
	set ipv6_blacklist { type ipv6_addr; flags interval; auto-merge; }
	set limit_src_ip { type ipv4_addr; flags dynamic, timeout; size 1024; }
	set limit_src_ip6 { type ipv6_addr; flags dynamic, timeout; size 1024; }

	chain PREROUTING_RAW {
		type filter hook prerouting priority raw;

		meta l4proto != $protocol_whitelist counter drop
		tcp flags syn jump {
			tcp option maxseg size 1-500 counter drop
			tcp sport 0 counter drop
		}
		rt type 0 counter drop
	}

	chain PREROUTING_MANGLE {
		type filter hook prerouting priority mangle;

		ct state vmap { invalid : jump ct_invalid_pre, untracked : jump ct_untracked_pre, new : jump ct_new_pre, related : jump rpfilter }
	}
	chain ct_invalid_pre {
		counter drop
	}
	chain ct_untracked_pre {
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, mld-listener-query, mld2-listener-report } return
		counter drop
	}
	chain ct_new_pre {
		jump rpfilter

		tcp flags & (fin|syn|rst|ack) != syn counter drop

		iifname $public_if meta nfproto vmap { ipv4 : jump blacklist_input_ipv4, ipv6 : jump blacklist_input_ipv6 }
	}
	chain rpfilter {
		ip saddr 0.0.0.0 ip daddr 255.255.255.255 udp sport bootpc udp dport bootps return
		ip6 saddr ::/128 ip6 daddr . icmpv6 type { ff02::1:ff00:0/104 . nd-neighbor-solicit, ff02::16 . mld2-listener-report } return

		fib saddr . iif oif eq 0 counter drop
	}
	chain blacklist_input_ipv4{
		ip saddr $bogons_ip counter drop
		ip saddr @ipv4_blacklist counter drop
	}
	chain blacklist_input_ipv6{
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } ip6 saddr fe80::/64 return
		udp sport dhcpv6-server ip6 saddr fe80::/64 return

		ip6 saddr $bogons_ip6 counter drop
		ip6 saddr @ipv6_blacklist counter drop
	}

	chain INPUT {
		type filter hook input priority filter; policy drop;

		iif lo accept

		ct state established,related accept

		iifname vmap @if_input

		log prefix "NFT REJECT IN " flags ether flags ip options limit rate 5/second burst 10 packets reject
	}
	chain public_input {
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } ip6 saddr fe80::/64 ip6 hoplimit 255 accept

		udp sport dhcpv6-server udp dport dhcpv6-client ip6 saddr fe80::/64 accept
		fib daddr type { broadcast, multicast, anycast } counter drop

		counter drop
	}
	chain home_input {
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } ip6 hoplimit 255 accept
		icmpv6 type { mld-listener-query, mld2-listener-report } ip6 hoplimit 1 accept

		udp sport bootpc udp dport bootps accept
		udp sport dhcpv6-client udp dport dhcpv6-server iifname $home_ipv6_if accept

		fib daddr type { broadcast, multicast, anycast } counter drop

		icmp type echo-request accept
		icmpv6 type echo-request accept

		tcp dport ssh iifname $trusted_if accept

		meta l4proto { tcp, udp } th dport domain jump {
			ip6 saddr != $private_ip6 counter reject
			accept
		}

		udp dport ntp accept

		tcp dport $proxy_port accept
	}

	chain FORWARD_MANGLE {
		type filter hook forward priority mangle;

		oifname $public_if jump {
			ct state new meta nfproto vmap { ipv4 : jump blacklist_output_ipv4, ipv6 : jump blacklist_output_ipv6 }
			tcp flags & (syn|rst) == syn tcp option maxseg size set rt mtu
		}
	}
	chain blacklist_output_ipv4 {
		ip daddr $bogons_ip goto log_blacklist
		ip daddr @ipv4_blacklist goto log_blacklist
	}
	chain blacklist_output_ipv6 {
		icmpv6 type . ip6 daddr { nd-router-solicit . ff02::2/128, nd-neighbor-solicit . ff02::1:ff00:0/104, nd-neighbor-advert . fe80::/64, nd-neighbor-advert . ff02::1/128, nd-neighbor-advert . ff02::1:ff00:0/104, mld2-listener-report . ff02::16/128 } return
		udp dport dhcpv6-server ip6 daddr ff02::1:2 return

		ip6 daddr $bogons_ip6 goto log_blacklist
		ip6 daddr @ipv6_blacklist goto log_blacklist
	}
	chain log_blacklist {
		log prefix "NFT BLACKLIST " flags ether flags ip options limit rate 5/minute burst 10 packets drop
		counter drop
	}

	chain FORWARD {
		type filter hook forward priority filter; policy drop;

		ct state established,related accept

		fib daddr type { broadcast, multicast, anycast } counter drop

		iifname vmap @if_forward

		log prefix "NFT REJECT FWD " flags ether flags ip options limit rate 5/second burst 10 packets reject
	}
	chain public_forward {
		udp dport { sip, 7078-7097 } oifname $voip_if jump {
			ip6 saddr $sip_whitelist_ip6 accept
			meta nfproto ipv6 log prefix "NFT DROP SIP " flags ether flags ip options limit rate 5/second burst 10 packets drop
		}

		counter drop
	}
	chain trusted_forward {
		oifname $public_if accept

		icmp type echo-request accept
		icmpv6 type echo-request accept

		ip daddr { $host3_ip, $host4_ip } tcp dport vmap { ssh : accept, https : accept, http : drop }

		ip daddr $host2_ip jump {
			tcp dport { http, https, printer, ipp, 9100 } accept
			udp dport snmp accept
		}
	}
	chain voip_forward {
		icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, echo-request } oifname $public_if accept

		ip6 daddr $sip_whitelist_ip6 jump {
			udp dport { 3478, sip } accept
			udp sport { 7078-7097 } accept
			tcp dport sip-tls accept
		}

		tcp dport submissions ip daddr $smtps_whitelist_ip accept
		tcp dport http oifname $public_if counter reject
	}
	chain guest_forward {
		oifname $public_if accept
	}

	chain OUTPUT {
		type filter hook output priority filter; policy drop;

		oif lo accept

		ct state vmap { established : accept, related : accept, invalid : jump ct_invalid_out, untracked : jump ct_untracked_out }

		oifname vmap @if_output

		log prefix "NFT REJECT OUT " flags ether flags ip options limit rate 5/second burst 10 packets reject
	}
	chain ct_invalid_out {
		counter drop
	}
	chain ct_untracked_out {
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, mld-listener-query, mld2-listener-report } return
		counter drop
	}
	chain public_output {
		ct state new meta nfproto vmap { ipv4 : jump blacklist_output_ipv4, ipv6 : jump blacklist_output_ipv6 }

		icmp type { destination-unreachable, time-exceeded, parameter-problem, echo-request } accept
		icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, echo-request } accept
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } ip6 hoplimit 255 accept
		icmpv6 type { mld-listener-query, mld2-listener-report } ip6 hoplimit 1 accept

		udp dport dhcpv6-server ip6 saddr fe80::/64 ip6 daddr ff02::1:2 accept

		udp dport { domain, ntp } accept
		tcp dport { https, submissions, domain-s } accept
	}
	chain home_output {
		icmp type { destination-unreachable, time-exceeded, parameter-problem, echo-request } accept
		icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, echo-request } accept
		icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } ip6 hoplimit 255 accept
		icmpv6 type { mld-listener-query, mld2-listener-report } ip6 hoplimit 1 accept

		udp sport dhcpv6-server udp dport dhcpv6-client ip6 saddr fe80::/64 oifname $home_ipv6_if accept
		udp sport bootps udp dport bootpc ip saddr $private_ip accept
		tcp dport ssh ip daddr $host1_ip accept
	}

	chain POSTROUTING_SRCNAT {
		type nat hook postrouting priority srcnat;

		meta nfproto ipv4 ip saddr $masq_ip oifname $masq_if masquerade
	}
}

--=_344776ddfbe3fdbc8193f4a0f43d1d1c--
