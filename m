Return-Path: <linux-kernel+bounces-99256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E237F8785A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116541C21E13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE533482D1;
	Mon, 11 Mar 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KUHxIH7B"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E147F6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175476; cv=none; b=Nj2MjBHjN7szACbQNRr8+zEGgp6sHb0YQCH/UCMfOcPuvCgsN3nWkz/dme9gi1gj81zZHNxJl7xx14viqUY9dWkvEUHM5Ote5cW1O237kYxbG7YywLzxuj9AucSTKgtzV+csyfc2DkjSP1uyR8fib/xu5UW3Qy064j2IYdpaghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175476; c=relaxed/simple;
	bh=wn0Ab87jBO9FBfXotPayXSCcTMQFYUYVHXBhGR+V45I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CWfs2jjM9yiCMdeh428QRh6YD7OEUxrSR+QdhTEfJkM+fRiWi4j/FZ9qDycU2KQgsXyH2ji10JajB8NSM2ihafiS+Ss0GJ0/ytaaCLVT6n5v+3PaftRDbuVXtPPxl8rKpGTWh2+mSwO9SRh+x+NHf/kxyful8BsNgyLIRl9C0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KUHxIH7B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e676ea4e36so2302758b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710175474; x=1710780274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBoJvVf5erEJTx7bXeerABv2Y8BlFidva1ewEgzzucQ=;
        b=KUHxIH7BoQ3rZZGIRbpjtn8S2ReTBNfdmqfUUEiNr3+vNdBytr23y2m0xSDboMHE9B
         cpNouxloh2zT8nq/FJwNG68jLVZ3okS3VdoUrYFbMnqw36e3VWy+TXGSbtyzQ2BmNsQs
         PSGZG1xRw9e93NMTdTmGiX9rZKTb8xLozkY0ILfle3WhKwU/JeL20vjOxsoyMlATRjYU
         SudF/8UmEixsBcNH9Ok437x4EJ4Tt8FcgbMOFSZ/KcGCgSirPdW/3K4qEgfEs+7EN/d0
         hqjHx3WsbS/p+GWU1nikEoi3/8I7hYSj0uX12G1rBlgwGv0JRoKDfNrtVjhppF9pnf25
         Ib4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175474; x=1710780274;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBoJvVf5erEJTx7bXeerABv2Y8BlFidva1ewEgzzucQ=;
        b=H1nbm5ges8I5Dc3nKBHC/hn5FqgeRSf8JRObnAV56fwAO0K1SBoIRNQ7M0sQjdgawX
         /vwbcw0IxCyD37lbUEKeuL7+cxplRe4IfOyEZGXSK75PZec/pd8px30GPZlcg22lezZh
         FucYA1AiVNr1NKHEaFaaro5n+LnxafpA2MybGs2Zjzo2xcLVq23UTWcL0tfwop3DhLQK
         KD+M3IIOM/yPNfzqIc9rJIC25VXXvxZxvdwumCjiFhZhqcgvlxFLxIs6MZ+axC3X07Oj
         a+iOUOrHpdU9K4mQq6j0mtZMSU2ajgCJuuAaFSVrRtfjuUndpG9CepkOjHHBD2zvF8cF
         GnyQ==
X-Gm-Message-State: AOJu0YwsDjSLNE9XA3Ii5wb+QuqQ5cEwbZQSDJWY/WJ0Q/wV3k8rmjYc
	3PJ0mNhb00CO5KuhjQMQB/eZmfNuSYSiQF15yYWPLHI1al77ulwi0bHWhy9XjPOu3lCoSjOVFLh
	G
X-Google-Smtp-Source: AGHT+IGXDmMcwCIVX9FvBHiPZLWo+MEX5SLxnsrmntC+yQwtuKYUtiUkuJp+XdpyD0MsV9RMDJo4tg==
X-Received: by 2002:a05:6a20:1b2a:b0:1a1:52d5:d17 with SMTP id ch42-20020a056a201b2a00b001a152d50d17mr804343pzb.35.1710175473727;
        Mon, 11 Mar 2024 09:44:33 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z4-20020aa78884000000b006e680f60f25sm3694350pfe.211.2024.03.11.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:44:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:44:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.8 release
Message-ID: <20240311094432.16bf9516@hermes.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is regular release of iproute2 corresponding to the 6.8 kernel.
In addition to the usual round of documentation fixes, many
small changes to ss utility. Most of the work to have full JSON
support in traffic control (TC) is done, only a few leftovers.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.8.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Andrea Claudi (4):
      iplink_xstats: spelling fix in error message
      genl: ctrl.c: spelling fix in error message
      treewide: fix typos in various comments
      docs, man: fix some typos

Daniel Borkmann (1):
      ip, link: Add support for netkit

David Ahern (2):
      Update kernel headers
      Update kernel headers

Denis Kirjanov (3):
      ifstat: make load_info() more verbose on error
      iptuntap: use TUNDEV macro
      ifstat: handle unlink return value

Eric Dumazet (5):
      ip route: add support for TCP usec TS
      ss: add report of TCPI_OPT_USEC_TS
      tc: fq: add TCA_FQ_PRIOMAP handling
      tc: fq: add TCA_FQ_WEIGHTS handling
      tc: fq: reports stats added in linux-6.7

Geliang Tang (1):
      ss: mptcp: print out subflows_total counter

Guillaume Nault (1):
      ss: Add support for dumping TCP bound-inactive sockets.

Ido Schimmel (1):
      bridge: mdb: Add flush support

Jiri Pirko (7):
      ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
      devlink: use snprintf instead of sprintf
      devlink: do conditional new line print in pr_out_port_handle_end()
      devlink: extend pr_out_nested_handle() to print object
      devlink: introduce support for netns id for nested handle
      devlink: print nested handle for port function
      devlink: print nested devlink handle for devlink dev

Lars Ellenberg (1):
      ss: fix output of MD5 signature keys configured on TCP sockets

Maks Mishin (2):
      ctrl: Fix fd leak in ctrl_list()
      ctrl: Fix fd leak in ctrl_listen()

Matthieu Baerts (NGI0) (1):
      ss: show extra info when '--processes' is not used

Pedro Tammela (1):
      bpf: include libgen.h for basename

Petr Machata (5):
      lib: utils: Switch matches() to returning int again
      lib: utils: Generalize parse_one_of()
      lib: utils: Convert parse_on_off() to strcmp()
      lib: utils: Introduce parse_one_of_deprecated()
      lib: utils: Have parse_one_of() warn about prefix matches

Sam James (1):
      configure: Add _GNU_SOURCE to strlcpy configure test

Simon Egli (1):
      man: correct double word in htb

Stephen Gallagher (1):
      iproute2: fix type incompatibility in ifstat.c

Stephen Hemminger (27):
      ip: require RTM_NEWLINK
      remove support for iptables action
      man: drop references to ifconfig
      Revert "ss: prevent "Process" column from being printed unless requested"
      uapi: update headers from 6.8-rc1
      Reapply "ss: prevent "Process" column from being printed unless requested"
      man: get rid of doc/actions/mirred-usage
      man/tc-gact: move generic action documentation to man page
      doc: remove ifb README
      doc: remove out dated actions-general
      uapi: remove tc_ipt.h
      tc: unify clockid handling
      tc: better clockid handling
      man: fix duplicate words in l2tp, sfb and tipc
      uapi: update virtio_config.h
      color: handle case where fmt is NULL
      spelling fixes
      bpf: fix warning from basename()
      ip: detect errors in netconf monitor mode
      ip: detect rtnl_listen errors while monitoring netns
      tc: u32: errors should be printed on stderr
      tc: bpf: fix extra newline in JSON output
      tc: print unknown action on stderr
      tc: drop no longer used prototype from tc_util.h
      tc: u32: check return value from snprintf
      uapi: update in6.h
      v6.8.0

Takanori Hirano (4):
      tc: Support json option in tc-fw.
      tc: Change of json format in tc-fw
      tc: Support json option in tc-cgroup, tc-flow and tc-route
      tc: Fix json output for f_u32

Xin Long (1):
      man: ip-link.8: add a note for gso_ipv4_max_size

Yedaya Katsman (5):
      ip: remove non-existent amt subcommand from usage
      ip: Add missing stats command to usage
      ip: Add missing -echo option to usage
      ip: Update command usage in man page
      ip: Add missing command exaplantions in man page


